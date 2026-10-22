// LtiRom's own patches and mods, written with the patch-mod SDK. `./gradlew packageMods` writes one
// .lti-mod.zip per mod to build/mods/; install them on LtiRom Studio's Plugins page.
plugins {
    kotlin("jvm") version "2.4.10"
}

kotlin {
    jvmToolchain(21)
}

dependencies {
    implementation("org.ide.lti:patch-mod-sdk:1.0.0-SNAPSHOT")
    implementation("org.ide.lti:patch-mod-hooks:1.0.0-SNAPSHOT")
}

tasks.register<JavaExec>("packageMods") {
    group = "mods"
    description = "Packages every mod into build/mods/*.lti-mod.zip"
    classpath = sourceSets.main.get().runtimeClasspath
    mainClass.set("io.ltirom.mods.MainKt")
    args(projectDir.absolutePath, layout.buildDirectory.dir("mods").get().asFile.absolutePath)
}

// `./gradlew checkMods -Pdecoded=<dir> [-Ptree=<work dir>]`: applies every mod's edits, in order, in memory, without
// building anything: APK/JAR edits to a firmware decoded with `apktool d` into <dir>/<component file name>/
// (services.jar, framework.jar, …), and file operations (copy, replace, delete, property and text patches) to an
// assembled work tree (a folder per partition: run the Studio through Assemble, then use that workspace's work/).
tasks.register<JavaExec>("checkMods") {
    group = "mods"
    description = "Checks every mod's edits against a decoded firmware (-Pdecoded) and a work tree (-Ptree)"
    classpath = sourceSets.main.get().runtimeClasspath
    mainClass.set("io.ltirom.mods.MainKt")
    val decoded = providers.gradleProperty("decoded")
    val tree = providers.gradleProperty("tree")
    argumentProviders.add(
        CommandLineArgumentProvider { listOfNotNull("check", projectDir.absolutePath, decoded.get(), tree.orNull) },
    )
}

// `./gradlew compileHooks -Pfirmware=<dir>`: compiles the Java hook classes under hooks/<mod>/<component>/<smali dir>/
// into files/ (the smali the mods add), against the firmware's own <dir>/<component> files (framework.jar, …).
tasks.register<JavaExec>("compileHooks") {
    group = "mods"
    description = "Compiles hooks/**/*.java into files/**/*.smali against a firmware (-Pfirmware=<dir>)"
    classpath = sourceSets.main.get().runtimeClasspath
    mainClass.set("io.ltirom.mods.MainKt")
    val firmware = providers.gradleProperty("firmware")
    // The SDK's android.jar (org.xmlpull and other libraries a firmware keeps outside framework.jar).
    val androidJar = providers.gradleProperty("androidJar")
    argumentProviders.add(
        CommandLineArgumentProvider {
            listOfNotNull("hooks", projectDir.absolutePath, firmware.get(), androidJar.orNull)
        },
    )
}
