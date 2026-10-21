package io.ltirom.mods

import io.ltirom.mods.changes.hmaFramework
import io.ltirom.mods.changes.hmaServices
import io.ltirom.mods.changes.keyboxFramework
import io.ltirom.mods.changes.nubiaGameAssist
import io.ltirom.mods.changes.nubiaGameSpace
import io.ltirom.mods.changes.pifFramework
import io.ltirom.mods.changes.pifServices
import io.ltirom.mods.changes.settingsFramework
import io.ltirom.mods.changes.settingsServices
import io.ltirom.mods.changes.settingsSettingsApk
import io.ltirom.mods.changes.updaterSettingsApk
import org.ide.lti.core.model.plugin.FileMetadata
import org.ide.lti.sdk.patchmod.literal
import org.ide.lti.sdk.patchmod.Partition
import java.io.File

// LtiRom's mods. Their smali and resource changes are in changes/; this file says which component each goes to.

private const val FRAMEWORK = "system/framework/framework.jar"
private const val GAME_ASSIST = "system/app/GameAssist15_5/GameAssist15_5.apk"
private const val GAME_SPACE = "system/priv-app/GameSpace/GameSpace.apk"
private const val SETTINGS_APK = "priv-app/Settings_MFV_abroad_tablet/Settings_MFV_abroad_tablet.apk"
private const val OTACERTS = "system/etc/security/otacerts.zip"
private const val OTACERTS_SHA256 = "6f2ffe71ca9373fc1d724be6bd54633801a6cc546821b587edcae1fe63c7cfd9"

fun hmaMod(files: File): Mod = Mod(
    displayName = "Hide My Applist",
    description = "Adds optional package-list filtering controlled by the Lti Settings interface.",
    template = ltiMod("hma") {
        operations {
            apkJarPatch("hma-framework.jar", Partition.SYSTEM, FRAMEWORK) { hmaFramework(files) }
            apkJarPatch("hma-services.jar", Partition.SYSTEM, SERVICES) { hmaServices(files) }
        }
    },
)

fun keyboxMod(files: File): Mod = Mod(
    displayName = "Keybox imitation",
    description = "Adds the optional software-backed keybox provider and Android Keystore interception hooks.",
    template = ltiMod("keybox") {
        operations { apkJarPatch("keybox-framework.jar", Partition.SYSTEM, FRAMEWORK) { keyboxFramework(files) } }
    },
)

fun nubiaGameAssistMod(files: File): Mod = Mod(
    displayName = "Nubia GameAssist/GameSpace Patches",
    description = "NubiaToolkit's GameAssist/GameSpace features as build-time patches, toggled from LTI Settings.",
    template = ltiMod("nubia-gameassist") {
        operations {
            apkJarPatch("nubia-gameassist-GameAssist15_5.apk", Partition.SYSTEM, GAME_ASSIST) { nubiaGameAssist(files) }
            apkJarPatch("nubia-gameassist-GameSpace.apk", Partition.SYSTEM, GAME_SPACE) { nubiaGameSpace(files) }
        }
    },
)

// ponytail: pif calls keybox's KeyProviderManager, so it requires keybox; the bash module instead stubbed
// shouldBlockKeyAttestation() to false when keybox was off. Add that branch if pif must work alone.
fun pifMod(files: File): Mod = Mod(
    displayName = "Play Integrity fixes",
    description = "Adds optional per-process property spoofing and task-permission compatibility hooks.",
    dependsOn = listOf("keybox"),
    template = ltiMod("pif") {
        operations {
            apkJarPatch("pif-framework", Partition.SYSTEM, FRAMEWORK) { pifFramework(files) }
            apkJarPatch("pif-services", Partition.SYSTEM, SERVICES) { pifServices(files) }
        }
    },
)

fun prophideMod(): Mod {
    // prophide's types join four stock attribute sets; a set's order does not matter, so each goes first.
    val joins = listOf(
        "(typeattributeset exec_type (adbd_exec " to "prophide_exec",
        "(typeattributeset file_type (adbd_exec " to "prophide_exec",
        "(typeattributeset system_file_type (adbd_exec " to "prophide_exec",
        "(typeattributeset domain (adbd " to "prophide",
    )
    val policy = listOf(
        "(type prophide)",
        "(roletype object_r prophide)",
        "(type prophide_exec)",
        "(roletype object_r prophide_exec)",
        // init -> prophide_exec -> prophide
        "(typetransition init prophide_exec process prophide)",
        "(allow init prophide (process (transition)))",
        "(allow init prophide (fd (use)))",
        // /dev/block/by-name/<part> is a block_device-labeled symlink to the real vendor_custom_ab_block_device
        // node (RedMagic UFS): opening it needs dir search and lnk_file perms besides blk_file on the target.
        "(allow prophide block_device (dir (search)))",
        "(allow prophide block_device (lnk_file (read getattr)))",
        "(allow prophide vendor_custom_ab_block_device (blk_file (read open getattr ioctl)))",
        // system binaries without a domain change
        "(allow prophide shell_exec (file (read open execute getattr map execute_no_trans)))",
        "(allow prophide toolbox_exec (file (read open execute getattr map execute_no_trans)))",
    )
    val exec = FileMetadata(uid = 0, gid = 2000, mode = "0755", label = "u:object_r:prophide_exec:s0")
    return Mod(
        displayName = "Bootloader State Spoofing (PropHide)",
        description = "Spoofs bootloader state and verified boot properties to locked/green using rezetprop at " +
            "boot. The vbmeta digest values come from this firmware's vbmeta.img.",
        dependsOn = listOf("selinux"),
        assets = mapOf(
            "assets/prophide.sh" to "assets/prophide/prophide.sh",
            "assets/rezetprop" to "assets/prophide/rezetprop",
            "assets/prophide.rc" to "assets/prophide/prophide.rc",
        ),
        template = ltiMod("prophide") {
            operations {
                joins.forEachIndexed { i, (set, type) ->
                    textPatch("join-$i", Partition.SYSTEM, SEPOLICY, set, literal(set.replace(" (", " ($type ")), "")
                }
                appendPolicy("policy", policy)
                copy("prophide-sh", "assets/prophide.sh", Partition.SYSTEM, "system/bin/prophide.sh", metadata = exec)
                val toolbox = exec.copy(label = "u:object_r:toolbox_exec:s0")
                copy("rezetprop", "assets/rezetprop", Partition.SYSTEM, "system/bin/rezetprop", metadata = toolbox)
                val config = FileMetadata(uid = 0, gid = 0, mode = "0644", label = "u:object_r:system_file:s0")
                copy("prophide-rc", "assets/prophide.rc", Partition.SYSTEM, "system/etc/init/prophide.rc", metadata = config)
            }
        },
    )
}

fun settingsMod(files: File): Mod = Mod(
    displayName = "LTI Settings",
    description = "Adds the optional LTI Settings UI with spoof, compatibility, screenshot, and app-list controls.",
    // services.jar's InstallPackageHelper change is written against the signature mod's.
    dependsOn = listOf("signature"),
    assets = mapOf(
        "assets/LtiSettings.apk" to "assets/settings/LtiSettings.apk",
        "assets/privapp-permissions-io.lti.settings.xml" to "assets/settings/privapp-permissions-io.lti.settings.xml",
    ),
    template = ltiMod("settings") {
        operations {
            copy("app", "assets/LtiSettings.apk", Partition.SYSTEM, "system/priv-app/LtiSettings/LtiSettings.apk")
            val permissions = "privapp-permissions-io.lti.settings.xml"
            copy("permissions", "assets/$permissions", Partition.SYSTEM, "system/etc/permissions/$permissions")
            apkJarPatch("settings-framework.jar", Partition.SYSTEM, FRAMEWORK) { settingsFramework(files) }
            apkJarPatch("settings-services.jar", Partition.SYSTEM, SERVICES) { settingsServices(files) }
            apkJarPatch("settings-apk", Partition.SYSTEM_EXT, SETTINGS_APK) { settingsSettingsApk(files) }
        }
    },
)

fun updaterMod(files: File): Mod {
    val apps = listOf(
        "priv-app/LtiUpdater/LtiUpdater.apk",
        "etc/permissions/privapp-permissions-com.zte.zdm.xml",
        "etc/default-permissions/default-permissions-com.zte.zdm.xml",
    )
    return Mod(
        displayName = "Lti OTA Updater",
        description = "Adds the privileged Lti Updater application, routes Settings' System Update to it and trusts " +
            "this workspace's platform key for OTA packages.",
        dependsOn = listOf("selinux"),
        assets = apps.associate { "assets/${it.substringAfterLast('/')}" to "assets/updater/${it.substringAfterLast('/')}" } +
            ("assets/otacerts.zip" to "assets/updater/otacerts.zip"),
        template = ltiMod("updater") {
            operations {
                apps.forEach {
                    val name = it.substringAfterLast('/')
                    copy(name, "assets/$name", Partition.SYSTEM, "system/$it")
                }
                replace("otacerts", "assets/otacerts.zip", Partition.SYSTEM, OTACERTS, OTACERTS_SHA256)
                apkJarPatch("settings-apk", Partition.SYSTEM_EXT, SETTINGS_APK) { updaterSettingsApk(files) }
            }
        },
    )
}
