package io.ltirom.mods

import io.ltirom.mods.changes.signatureServices
import org.ide.lti.core.model.plugin.FileMetadata
import org.ide.lti.sdk.patchmod.OperationsScope
import org.ide.lti.sdk.patchmod.Facts
import org.ide.lti.sdk.patchmod.inOptions
import org.ide.lti.sdk.patchmod.literal
import org.ide.lti.sdk.patchmod.Partition
import java.io.File

const val VERSION: String = "1.4.0"

// Paths inside work/<partition>/; system is system-as-root, so its files are under "system/".
private const val SYSTEM_PROP = "system/build.prop"
private const val VENDOR_PROP = "build.prop"
internal const val SEPOLICY = "system/etc/selinux/plat_sepolicy.cil"
private const val SEPOLICY_HASH = "system/etc/selinux/plat_sepolicy_and_mapping.sha256"
private const val SEAPP = "system/etc/selinux/plat_seapp_contexts"
internal const val SERVICES = "system/framework/services.jar"

/** The last line of PQ84P01's plat_sepolicy.cil (unique): rules are appended after it. */
private const val SEPOLICY_LAST_LINE =
    "(typeattributeset system_and_vendor_property_type ((and (system_property_type) (vendor_property_type))))"

/** PQ84P01's plat_sepolicy_and_mapping.sha256, emptied so init compiles the edited policy. */
private const val SEPOLICY_HASH_SHA256 = "001ed166d3e1aaf46ba592d586aa6d4c0a9597648773b462e87202bd04cc6d6c"

private val debugBuild = Facts.BUILD_TYPE.inOptions(literal("userdebug"), literal("eng"))

/** ADB without authorisation and full debug logging on userdebug/eng builds. */
fun adbMod(): Mod = Mod(
    displayName = "Debug USB",
    description = "Enables ADB access and full-debug logging on userdebug/eng builds (from UN1CA's adb module).",
    template = ltiMod("adb") {
        operations {
            propertyPatch("adb-secure-system", Partition.SYSTEM, SYSTEM_PROP, "ro.adb.secure", literal("0"), debugBuild)
            propertyPatch("adb-secure-vendor", Partition.VENDOR, VENDOR_PROP, "ro.adb.secure", literal("0"), debugBuild)
            propertyPatch("logd-kernel", Partition.SYSTEM, SYSTEM_PROP, "ro.logd.kernel", literal("true"), debugBuild)
            propertyPatch("ztelog", Partition.VENDOR, VENDOR_PROP, "persist.sys.ztelog.enable", literal("1"), debugBuild)
        }
    },
)

/** The device's build.prop overrides. `ro.config.low_ram`, which the bash module deletes, is not in this firmware. */
fun propertyOverridesMod(): Mod = Mod(
    displayName = "Property overrides",
    description = "Applies the device's build.prop overrides.",
    template = ltiMod("property-overrides") {
        operations {
            propertyPatch("debuggable", Partition.SYSTEM, SYSTEM_PROP, "ro.debuggable", literal("1"))
            propertyPatch("usb-config", Partition.VENDOR, VENDOR_PROP, "persist.sys.usb.config", literal("adb,mtp"))
        }
    },
)

/** Platform policy for the Settings logpersist switch and the LtiRom updater. */
fun selinuxMod(): Mod {
    val updater = "lti_updater_app"
    val dirPerms = "(ioctl read write create getattr setattr lock rename open watch watch_reads add_name remove_name " +
        "reparent search rmdir)"
    val filePerms = "(ioctl read write create getattr setattr lock append map unlink rename open watch watch_reads)"
    val roDir = "(ioctl read getattr lock open watch watch_reads search)"
    val roFile = "(ioctl read getattr lock map open watch watch_reads)"
    val rules = listOf(
        "(allow system_app logpersistd_logging_prop (file (read getattr map open)))",
        "(allow system_app logpersistd_logging_prop (property_service (set)))",
        "(type $updater)",
        "(roletype object_r $updater)",
    ) + listOf("domain", "appdomain", "netdomain", "coredomain").map { "(typeattributeset $it ($updater))" } + listOf(
        "(type ${updater}_userfaultfd)",
        "(roletype object_r ${updater}_userfaultfd)",
        "(typetransition $updater $updater anon_inode \"[userfaultfd]\" ${updater}_userfaultfd)",
        "(allow $updater ${updater}_userfaultfd (anon_inode (ioctl read create)))",
        "(typetransition $updater tmpfs file appdomain_tmpfs)",
        "(allow $updater appdomain_tmpfs (file (read write getattr map execute)))",
    ) + listOf("ota_package_file", "cache_recovery_file", "cache_file").flatMap {
        listOf("(allow $updater $it (dir $dirPerms))", "(allow $updater $it (file $filePerms))")
    } + listOf(
        "(allow $updater app_api_service (service_manager (find)))",
        "(allow $updater recovery_service (service_manager (find)))",
        "(allow $updater system_api_service (service_manager (find)))",
        "(allow $updater vendor_feature_prop (file (read getattr map open)))",
        "(allow $updater shell_data_file (dir $roDir))",
        "(allow $updater shell_data_file (file $roFile))",
        "(allow $updater fuse_device (chr_file (read write)))",
        "(allow $updater proc_vmstat (file $roFile))",
        "(allow $updater sysfs_type (dir (search)))",
        "(allow $updater sysfs_zram (dir $roDir))",
        "(allow $updater sysfs_zram (file $roFile))",
        "(allow $updater rootfs (dir $roDir))",
        "(allow $updater rootfs (file $roFile))",
    )
    val platformApp = "user=_app seinfo=platform domain=platform_app type=app_data_file levelFrom=user"
    val zteUpdater = "user=_app seinfo=platform isPrivApp=true name=com.zte.zdm domain=$updater " +
        "type=privapp_data_file levelFrom=user"
    return Mod(
        displayName = "SELinux fix",
        description = "Platform SELinux policy for the Settings logpersist switch and the LtiRom updater " +
            "(com.zte.zdm runs as lti_updater_app). Other policy mods depend on it: it empties the policy hash so " +
            "init compiles the edited policy.",
        assets = mapOf("assets/empty" to "assets/selinux/empty"),
        template = ltiMod("selinux") {
            operations {
                appendPolicy("policy", rules)
                // The updater selector must come before the generic platform_app one to win.
                textPatch("seapp-updater", Partition.SYSTEM, SEAPP, platformApp, literal("$zteUpdater\n$platformApp"), "")
                replace("policy-hash", "assets/empty", Partition.SYSTEM, SEPOLICY_HASH, SEPOLICY_HASH_SHA256)
            }
        },
    )
}

/** AOSP's logpersist service (logcatd) and its policy, for user builds too. */
fun logpersistMod(): Mod {
    val logpersistFile = "(getattr open read ioctl lock map watch watch_reads)"
    val logpersistDir = "(open getattr read search ioctl lock watch watch_reads)"
    val policy = listOf(
        "(allow init logcat_exec (file (getattr open read execute map)))",
        "(allow init logpersist (process (transition)))",
        "(allow logpersist logcat_exec (file (entrypoint open read execute getattr map)))",
        "(dontaudit init logpersist (process (noatsecure)))",
        "(allow init logpersist (process (siginh rlimitinh)))",
        "(typetransition init logcat_exec process logpersist)",
    ) + listOf("cgroup", "cgroup_v2").flatMap {
        listOf(
            "(allow logpersist $it (dir $logpersistDir))",
            "(allow logpersist $it (file $logpersistFile))",
            "(allow logpersist $it (lnk_file $logpersistFile))",
        )
    } + listOf(
        "(allow logpersist misc_logd_file (file (create rename setattr unlink ioctl read getattr lock map open " +
            "watch watch_reads append write)))",
        "(allow logpersist misc_logd_file (dir (open getattr read search ioctl lock watch watch_reads write " +
            "add_name remove_name)))",
        "(allow logpersist self (capability (sys_nice)))",
        "(allow logpersist self (cap_userns (sys_nice)))",
        "(allow logpersist pstorefs (dir (search)))",
        "(allow logpersist pstorefs (file $logpersistFile))",
        "(allow logpersist logd_socket (sock_file (write)))",
        "(allow logpersist logdr_socket (sock_file (write)))",
        "(allow logpersist logd (unix_stream_socket (connectto)))",
        "(allow logpersist logd_prop (file (getattr open read map)))",
        "(allow logpersist runtime_event_log_tags_file (file $logpersistFile))",
    )
    // PQ84P01's neverallow attributes that must let logd/logpersist write misc_logd_file and read log tags.
    val widen = listOf(
        "(typeattributeset base_typeattr_765 (and (domain ) (not (dumpstate incidentd init ))))" to
            "(typeattributeset base_typeattr_765 (and (domain ) (not (dumpstate incidentd init logd logpersist ))))",
        "(typeattributeset base_typeattr_229 (and (domain ) (not (init ))))" to
            "(typeattributeset base_typeattr_229 (and (domain ) (not (init logd logpersist ))))",
        "(typeattributeset base_typeattr_760 (and (domain ) (not (appdomain bootstat dumpstate init logd " +
            "servicemanager surfaceflinger system_server zygote ))))" to
            "(typeattributeset base_typeattr_760 (and (domain ) (not (appdomain bootstat dumpstate init logd " +
            "logpersist servicemanager surfaceflinger system_server zygote ))))",
        "(neverallow logpersist file_type (file (write create append)))" to
            "(neverallow logpersist lti_logpersist_forbidden_file_type (file (write create append)))",
    )
    val forbidden = listOf(
        "(typeattribute lti_logpersist_forbidden_file_type)",
        "(typeattributeset lti_logpersist_forbidden_file_type " +
            "(and (file_type ) (not (coredump_file misc_logd_file ))))",
    )
    val exec = FileMetadata(uid = 0, gid = 2000, mode = "0755", label = "u:object_r:system_file:s0")
    return Mod(
        displayName = "LogPersist",
        description = "Installs AOSP's logpersist service (logcatd, logpersist.start/stop/cat) with its SELinux " +
            "policy, so persistent logs work on user builds.",
        assets = mapOf(
            "assets/logcatd" to "assets/logpersist/logcatd",
            "assets/logpersist.start" to "assets/logpersist/logpersist.start",
            "assets/logcatd.rc" to "assets/logpersist/logcatd.rc",
        ),
        dependsOn = listOf("selinux"),
        template = ltiMod("logpersist") {
            operations {
                widen.forEachIndexed { i, (old, new) ->
                    textPatch("widen-$i", Partition.SYSTEM, SEPOLICY, old, literal(new), expectedSha256 = "")
                }
                appendPolicy("policy", forbidden + policy)
                val logcatExec = exec.copy(label = "u:object_r:logcat_exec:s0")
                systemFile("logcatd", "assets/logcatd", "system/bin/logcatd", logcatExec)
                // logpersist.stop/.cat are the same script (it acts on its own name); the bash module symlinks them.
                listOf("start", "stop", "cat").forEach {
                    systemFile("logpersist-$it", "assets/logpersist.start", "system/bin/logpersist.$it", exec)
                }
                systemFile(
                    id = "logcatd-rc",
                    source = "assets/logcatd.rc",
                    path = "system/etc/init/logcatd.rc",
                    metadata = FileMetadata(mode = "0644", label = "u:object_r:system_file:s0"),
                )
            }
        },
    )
}

/** RescueParty never disables the system: `-$$Nest$smisDisabled()Z` returns true. */
fun miscsMod(): Mod = Mod(
    displayName = "Miscellaneous Patches",
    description = "Miscellaneous framework patches (disable RescueParty).",
    template = ltiMod("miscs") {
        operations {
            apkJarPatch("rescue-party", Partition.SYSTEM, SERVICES) {
                // The method is found by name, wherever RescueParty lives and whatever else changes in it.
                method("Lcom/android/server/RescueParty;", "-${'$'}${'$'}Nest${'$'}smisDisabled") {
                    replace(
                        find = """
                            |.method public static bridge synthetic -${'$'}${'$'}Nest${'$'}smisDisabled()Z
                            |    .locals 1
                            |
                            |    invoke-static {}, Lcom/android/server/RescueParty;->isDisabled()Z
                            |
                            |    move-result v0
                        """.trimMargin(),
                        with = """
                            |.method public static bridge synthetic -${'$'}${'$'}Nest${'$'}smisDisabled()Z
                            |    .locals 1
                            |
                            |    const/4 v0, 0x1
                        """.trimMargin(),
                    )
                }
            }
        }
    },
)

/**
 * Packages signed with the workspace's platform key are treated as platform-signed (services.jar). The
 * certificate is written in when the plan is applied (`{{platform.certificate}}`).
 */
fun signatureMod(files: File): Mod = Mod(
    displayName = "Custom platform signature",
    description = "Lets packages signed with this workspace's platform key run as platform-signed apps.",
    template = ltiMod("signature") {
        operations {
            apkJarPatch("services-signature", Partition.SYSTEM, SERVICES) { signatureServices(files) }
        }
    },
)

/** Appends [rules] to the platform policy, after its (unique) last line; other mods can append too. */
internal fun OperationsScope.appendPolicy(id: String, rules: List<String>) {
    val appended = (listOf(SEPOLICY_LAST_LINE) + rules).joinToString("\n")
    textPatch(id, Partition.SYSTEM, SEPOLICY, SEPOLICY_LAST_LINE, literal(appended), expectedSha256 = "")
}

/** Installs [source] as `work/system/[path]` with [metadata]. */
private fun OperationsScope.systemFile(id: String, source: String, path: String, metadata: FileMetadata) =
    copy(id = id, source = source, partition = Partition.SYSTEM, path = path, metadata = metadata)
