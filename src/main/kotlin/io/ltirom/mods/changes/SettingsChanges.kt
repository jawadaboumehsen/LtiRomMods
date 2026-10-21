package io.ltirom.mods.changes

import io.ltirom.mods.addHooks
import io.ltirom.mods.text
import org.ide.lti.sdk.patchmod.ApkJarScope
import org.ide.lti.sdk.patchmod.element
import java.io.File

// The smali and resource changes, as exact text. Converted from the bash module's git patches;
// method(…) changes are placed by their method and lines, so the rest of a class may change.

/** settings: its changes to framework.jar. */
internal fun ApkJarScope.settingsFramework(files: File) {
    method("Landroid/provider/Settings${'$'}Global;", "getStringForUser") {
        replace(
            """
            |.method public static greylist-max-r getStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;I)Ljava/lang/String;
            |    .locals 3
            """.trimMargin(),
            """
            |.method public static greylist-max-r getStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;I)Ljava/lang/String;
            |    .locals 4
            """.trimMargin(),
        )
        insertBefore(
            """
            |    sget-object v0, Landroid/provider/Settings${'$'}Global;->sNameValueCache:Landroid/provider/Settings${'$'}NameValueCache;
            |
            |    invoke-virtual {v0, p0, p1, p2}, Landroid/provider/Settings${'$'}NameValueCache;->getStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;I)Ljava/lang/String;
            """.trimMargin(),
            """
            |    invoke-virtual {p0}, Landroid/content/ContentResolver;->getPackageName()Ljava/lang/String;
            |    
            |    move-result-object v3
            |    
            |    invoke-static {p0, v3, p1}, Lio/lti/HideDevStatusUtils;->shouldHideDevStatus(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z
            |    
            |    move-result v3
            |    
            |    if-eqz v3, :cond_hidedev_skip
            |    
            |    const-string v0, "0"
            |    
            |    return-object v0
            |    
            |    :cond_hidedev_skip
            |    
            """.trimMargin(),
        )
    }
    addHooks(files, "settings/framework.jar")
    method("Landroid/app/ApplicationPackageManager;", "hasSystemFeature(Ljava/lang/String;I)Z") {
        insertAfter(
            """
            |.method public whitelist hasSystemFeature(Ljava/lang/String;I)Z
            |    .locals 2
            |
            """.trimMargin(),
            """
            |    invoke-static {p1}, Lio/lti/GPhotosUtils;->hasSystemFeature(Ljava/lang/String;)Z
            |
            |    move-result v0
            |
            |    if-eqz v0, :cond_gphotos_skip
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_gphotos_skip
            """.trimMargin(),
        )
    }
}

/** settings: its changes to services.jar. */
internal fun ApkJarScope.settingsServices(files: File) {
    method("Lcom/android/server/pm/InstallPackageHelper;", "preparePackageLI") {
        insertBefore(
            """
            |    sget v12, Lcom/android/server/pm/PackageManagerService;->MIN_INSTALLABLE_TARGET_SDK:I
            """.trimMargin(),
            """
            |    const-string v30, "persist.sys.lti.target_sdk_bypass"
            |    
            |    const/16 v31, 0x0
            |    
            |    invoke-static/range {v30 .. v31}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z
            |    
            |    move-result v30
            |    
            |    if-eqz v30, :cond_lti_sdkbypass_0
            |    
            |    goto/16 :cond_16
            |    
            |    :cond_lti_sdkbypass_0
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/pm/InstallPackageHelper;", "scanSystemPackageLI") {
        replace(
            """
            |    invoke-static/range {v1 .. v6}, Lcom/android/server/pm/ScanPackageUtils;->collectCertificatesLI(Lcom/android/server/pm/PackageSetting;Lcom/android/internal/pm/parsing/pkg/ParsedPackage;Lcom/android/server/pm/Settings${'$'}VersionInfo;ZZZ)V
            |
            """.trimMargin(),
            """
            |    invoke-static/range {v1 .. v6}, Lcom/android/server/pm/ScanPackageUtils;->collectCertificatesLI(Lcom/android/server/pm/PackageSetting;Lcom/android/internal/pm/parsing/pkg/ParsedPackage;Lcom/android/server/pm/Settings${'$'}VersionInfo;ZZZ)V
            |    
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/pm/PackageManagerServiceUtils;", "isDowngradePermitted") {
        insertBefore(
            """
            |    and-int/lit16 v0, p0, 0x80
            """.trimMargin(),
            """
            |    const-string v0, "persist.sys.lti.allow_downgrade"
            |    
            |    const/4 v1, 0x0
            |    
            |    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z
            |    
            |    move-result v0
            |    
            |    if-eqz v0, :cond_lti_downgrade_0
            |    
            |    const/4 v0, 0x1
            |    
            |    return v0
            |    
            |    :cond_lti_downgrade_0
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/wm/ScreenRecordingCallbackController;", "dispatchCallbacks") {
        insertBefore(
            """
            |    invoke-virtual {p1}, Landroid/util/ArraySet;->isEmpty()Z
            """.trimMargin(),
            """
            |    const-string v0, "persist.sys.lti.ss_detection_disable"
            |    
            |    const/4 v1, 0x0
            |    
            |    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z
            |    
            |    move-result v0
            |    
            |    if-eqz v0, :cond_lti_ssdet_0
            |    
            |    return-void
            |    
            |    :cond_lti_ssdet_0
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/wm/WindowManagerService${'$'}SettingsObserver;", "updateDisableSecureWindows") {
        replace(
            """
            |
            |    const-string v0, "ro.debuggable"
            |
            """.trimMargin(),
            """
            |
            """.trimMargin(),
        )
        replace(
            """
            |
            |    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z
            |
            |    move-result v0
            |
            |    if-nez v0, :cond_0
            |
            |    return-void
            |
            |    :cond_0
            """.trimMargin(),
            """
            |
            """.trimMargin(),
        )
    }
}

/** settings: its changes to Settings_MFV_abroad_tablet.apk. */
internal fun ApkJarScope.settingsSettingsApk(files: File) {
    addFile("res/drawable/ic_lti_top_level.xml", files.text("settings/Settings_MFV_abroad_tablet.apk/res/drawable/ic_lti_top_level.xml"))
    xml("res/values/colors.xml") {
        append(
            """
            |    <color name="lti_settings_ic_layer_color">@android:color/transparent</color>
            |    <color name="lti_settings_ic_top_level_color">#95b9db</color>
            """.trimMargin(),
        )
    }
    xml("res/values/public.xml") {
        append(
            """
            |    <public type="drawable" name="ic_lti_top_level" id="0x7f081d94" />
            |    <public type="string" name="menu_key_lti" id="0x7f15283b" />
            |    <public type="string" name="lti_settings_title" id="0x7f15283c" />
            """.trimMargin(),
        )
    }
    xml("res/values/strings.xml") {
        append(
            """
            |    <string name="menu_key_lti">top_level_lti</string>
            |    <string name="lti_settings_title">LTI Settings</string>
            """.trimMargin(),
        )
    }
    xml("res/xml/zte_top_level_settings_abroad.xml") {
        insertAfter(
            element(null, "android:key" to "top_level_featured"),
            """
            |    <com.zte.settings.preference.IconPreference android:icon="@drawable/ic_lti_top_level" android:title="@string/lti_settings_title" android:key="top_level_lti" android:order="-154">
            |        <intent android:targetPackage="io.lti.settings" android:targetClass="io.lti.settings.UpdatesActivity" />
            |    </com.zte.settings.preference.IconPreference>
            """.trimMargin(),
        )
    }
    method("Lcom/zte/mifavor/androidx/preference/PreferenceGroupAdapter;", "getPostVisiblePreference") {
        replace(
            """
            |    invoke-virtual {p1}, Landroidx/preference/Preference;->getParent()Landroidx/preference/PreferenceGroup;
            |
            |    move-result-object p0
            |
            |    if-eqz p0, :cond_6
            |
            |    invoke-virtual {p0, v3}, Landroidx/preference/PreferenceGroup;->getPreference(I)Landroidx/preference/Preference;
            |
            |    move-result-object v0
            """.trimMargin(),
            """
            |    const/4 v0, 0x0
            """.trimMargin(),
        )
    }
}
