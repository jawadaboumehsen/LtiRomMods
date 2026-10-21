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

// `./gradlew checkMods -Pdecoded=<dir>`: applies every mod's APK/JAR edits, in order, to a firmware decoded with
// `apktool d` into <dir>/<component file name>/ (services.jar, framework.jar, …), without building anything.
tasks.register<JavaExec>("checkMods") {
    group = "mods"
    description = "Checks every mod's APK/JAR edits against a decoded firmware (-Pdecoded=<dir>)"
    classpath = sourceSets.main.get().runtimeClasspath
    mainClass.set("io.ltirom.mods.MainKt")
    val decoded = providers.gradleProperty("decoded")
    argumentProviders.add(CommandLineArgumentProvider { listOf("check", projectDir.absolutePath, decoded.get()) })
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
