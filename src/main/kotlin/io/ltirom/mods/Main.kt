package io.ltirom.mods

import org.ide.lti.core.model.plugin.DependencyRef
import org.ide.lti.core.model.plugin.PluginManifest
import org.ide.lti.core.model.plugin.PluginPlanTemplate
import org.ide.lti.sdk.patchmod.ModCheck
import org.ide.lti.sdk.patchmod.PackageWriter
import org.ide.lti.sdk.patchmod.RomModScope
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
 * `check <project dir> <decoded dir>`: [ModCheck] of every mod, in order, against a decoded firmware.
 */
fun main(args: Array<String>) {
    if (args.firstOrNull() == "check") return check(File(args[1]), File(args[2]))
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

private fun check(project: File, decoded: File) {
    val checks = ModCheck.check(mods(project).map { it.template }) { target ->
        File(decoded, target.relativePath.substringAfterLast('/')).takeIf { it.isDirectory }
    }
    checks.forEach { c -> println((if (c.failure == null) "ok   " else "FAIL ") + "${c.mod}: ${c.changed}  ${c.failure.orEmpty()}") }
    val failed = checks.count { it.failure != null }
    println(if (failed == 0) "All ${checks.size} edits apply" else "$failed of ${checks.size} edits do not apply")
    if (failed > 0) exitProcess(1)
}
