rootProject.name = "LtiRomMods"

dependencyResolutionManagement {
    repositories {
        // The patch-mod SDK: `./gradlew publishSdkToMavenLocal` in LtiRomGui.
        mavenLocal()
        mavenCentral()
        google()
    }
}
