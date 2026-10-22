package io.ltirom.mods

import org.ide.lti.core.model.plugin.DependencyRef
import org.ide.lti.core.model.plugin.PluginManifest
import org.ide.lti.core.model.plugin.PluginPlanTemplate
import org.ide.lti.sdk.patchmod.ApkJarScope
import org.ide.lti.sdk.patchmod.ModCheck
import org.ide.lti.sdk.patchmod.PackageWriter
import org.ide.lti.sdk.patchmod.RomModScope
import org.ide.lti.sdk.patchmod.hooks.HookCompiler
import org.ide.lti.sdk.patchmod.romMod
import java.io.File
import kotlin.system.exitProcess

const val PUBLISHER: String = "io.ltirom"
const val DEVICE: String = "PQ84P01"

/** One mod: its plan, and where each packaged `assets/…` file comes from (under the project). */
class Mod(
    val template: PluginPlanTemplate,
    val displayName: String,
    val description: String,
    val assets: Map<String, String> = emptyMap(),
    val dependsOn: List<String> = emptyList(),
)

/** One of LtiRom's mods: made for [DEVICE], whatever its firmware (its changes find their own places). */
fun ltiMod(id: String, block: RomModScope.() -> Unit): PluginPlanTemplate = romMod(PUBLISHER, id, VERSION) {
    compatibleWith(DEVICE)
    block()
}

/** A source file of the project, under `files/` (new smali classes, added resources). */
fun File.text(path: String): String = resolve(path).readText()

/**
 * Adds every hook class compiled into `files/<modComponent>/` (its `smali…` folders) to the component. The classes are written
 * in Java under `hooks/<modComponent>/` and compiled by `./gradlew compileHooks`; the smali is never edited by hand.
 */
fun ApkJarScope.addHooks(files: File, modComponent: String) {
    val root = File(files, modComponent)
    root.walkTopDown().filter { it.isFile && it.extension == "smali" }.sortedBy { it.invariantSeparatorsPath }
        .forEach { addFile(it.relativeTo(root).invariantSeparatorsPath, it.readText()) }
}

/** Every mod, in the order they are meant to apply. */
fun mods(project: File): List<Mod> {
    val files = File(project, "files")
    return listOf(
        adbMod(),
        propertyOverridesMod(),
        selinuxMod(),
        logpersistMod(),
        miscsMod(),
        signatureMod(files),
        hmaMod(files),
        keyboxMod(files),
        nubiaGameAssistMod(files),
        pifMod(files),
        prophideMod(),
        settingsMod(files),
        updaterMod(files),
    )
}

/**
 * `packageMods <project dir> <out dir>`: writes `<out>/<publisher>-<id>-<version>.lti-mod.zip` per mod.
 * `check <project dir> <decoded dir> [work tree]`: [ModCheck] of every mod, in order: APK/JAR edits against a
 * decoded firmware, file operations against an assembled work tree (skipped without one).
 * `hooks <project dir> <firmware dir> [android.jar]`: compiles the `.java` files under
 * `hooks/<mod>/<component>/<smali dir>` into the same folders under `files/`, against the firmware's own
 * `<firmware dir>/<component>` files.
 */
fun main(args: Array<String>) {
    if (args.firstOrNull() == "check") return check(File(args[1]), File(args[2]), args.getOrNull(3)?.let(::File))
    if (args.firstOrNull() == "hooks") return hooks(File(args[1]), File(args[2]), args.getOrNull(3)?.let(::File))
    val project = File(args[0])
    val out = File(args[1]).apply { mkdirs() }
    mods(project).forEach { mod ->
        val t = mod.template
        val zip = File(out, "${t.publisher}-${t.id}-${t.version}.lti-mod.zip")
        val manifest = PackageWriter.writePackage(
            manifest = PluginManifest(
                sdkApiRange = "1.x",
                publisher = t.publisher,
                id = t.id,
                version = t.version,
                displayName = mod.displayName,
                license = "MPL-2.0",
                compatibleTargets = emptyList(), // the plan's compatibleWith(…) devices
                dependencies = mod.dependsOn.map { DependencyRef(PUBLISHER, it, t.version) },
            ),
            template = t,
            readme = "# ${mod.displayName}\n\n${mod.description}\n",
            license = "Mozilla Public License 2.0 (https://mozilla.org/MPL/2.0/)\n",
            assets = mod.assets.mapValues { (_, source) -> File(project, source).toPath() },
            out = zip.toPath(),
        )
        println("${zip.name}: ${t.operations.size} operations, ${manifest.payloads.size} assets")
    }
}

private fun check(project: File, decoded: File, tree: File?) {
    val all = mods(project)
    val checks = ModCheck.check(
        all.map { it.template },
        tree = tree,
        assetExists = { template, asset ->
            all.first { it.template.id == template.id }.assets[asset.path]?.let { File(project, it).isFile } == true
        },
        decoded = { target -> File(decoded, target.relativePath.substringAfterLast('/')).takeIf { it.isDirectory } },
    )
    checks.forEach { c ->
        val mark = if (c.failed) "FAIL " else if (c.notChecked) "skip " else "ok   "
        println("$mark${c.mod}: ${c.changed}  ${c.failure.orEmpty()}")
    }
    val failed = checks.count { it.failed }
    val skipped = checks.count { it.notChecked }
    val applied = checks.size - failed - skipped
    println(if (failed == 0) "All $applied edits apply ($skipped not checked)" else "$failed of ${checks.size} do not apply")
    if (failed > 0) exitProcess(1)
}

/** [androidJar]: the SDK's android.jar, for libraries the firmware keeps outside its framework (org.xmlpull). */
private fun hooks(project: File, firmware: File, androidJar: File?) {
    val hooks = File(project, "hooks")
    // hooks/<mod>/<component>/<smali dir>: three levels down.
    val roots = hooks.listFiles().orEmpty().flatMap { it.listFiles().orEmpty().toList() }
        .flatMap { it.listFiles().orEmpty().toList() }.filter { it.isDirectory }
        .map { HookCompiler.Root(it, File(project, "files/" + it.relativeTo(hooks).invariantSeparatorsPath)) }
    val components = roots.map { it.sources.parentFile.name }.distinct()
    val firmwareFiles = components.map { File(firmware, it) }.filter { it.isFile }
    // Hooks for an app also use the framework's classes.
    val classpath = (firmwareFiles + File(firmware, "framework.jar") + listOfNotNull(androidJar))
        .filter { it.isFile }.distinct()
    val problems = HookCompiler.compile(roots, classpath, File(project, "build/hooks"))
    problems.forEach { System.err.println("ERROR $it") }
    if (problems.isNotEmpty()) exitProcess(1)
    println("Compiled ${roots.size} hook folder(s) against ${classpath.map { it.name }}")
}
