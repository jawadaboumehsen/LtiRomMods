package io.ltirom.mods.changes

import io.ltirom.mods.addHooks
import org.ide.lti.sdk.patchmod.ApkJarScope
import org.ide.lti.sdk.patchmod.element
import java.io.File

// The smali and resource changes, as exact text. Converted from the bash module's git patches;
// method(…) changes are placed by their method and lines, so the rest of a class may change.

/** updater: its changes to Settings_MFV_abroad_tablet.apk. */
internal fun ApkJarScope.updaterSettingsApk(files: File) {
    xml("res/xml/system_dashboard_fragment.xml") {
        replace(
            element("intent", "android:action" to "android.settings.SYSTEM_UPDATE_SETTINGS"),
            """
            |        <intent android:targetPackage="com.zte.zdm" android:targetClass="com.zte.zdm.UpdatesActivity" />
            """.trimMargin(),
        )
    }
    xml("res/xml/mfvui_system_dashboard_fragment.xml") {
        replace(
            element("intent", "android:action" to "android.settings.SYSTEM_UPDATE_SETTINGS"),
            """
            |        <intent android:targetPackage="com.zte.zdm" android:targetClass="com.zte.zdm.UpdatesActivity" />
            """.trimMargin(),
        )
    }
    addHooks(files, "updater/Settings_MFV_abroad_tablet.apk")
    method("Lcom/android/settings/system/SystemUpdateRepository;", "getSystemUpdateIntent") {
        replace(
            """
            |    .locals 2
            |
            |    new-instance v0, Landroid/content/Intent;
            |
            |    const-string v1, "android.settings.SYSTEM_UPDATE_SETTINGS"
            |
            |    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
            |
            |    iget-object p0, p0, Lcom/android/settings/system/SystemUpdateRepository;->packageManager:Landroid/content/pm/PackageManager;
            |
            |    const/high16 v1, 0x100000
            |
            |    invoke-virtual {p0, v0, v1}, Landroid/content/pm/PackageManager;->resolveActivity(Landroid/content/Intent;I)Landroid/content/pm/ResolveInfo;
            |
            |    move-result-object p0
            |
            |    if-eqz p0, :cond_0
            |
            |    iget-object p0, p0, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;
            |
            |    if-eqz p0, :cond_0
            """.trimMargin(),
            """
            |    .locals 3
            """.trimMargin(),
        )
        replace(
            """
            |    iget-object v1, p0, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;
            """.trimMargin(),
            """
            |    const-string v1, "com.zte.zdm"
            """.trimMargin(),
        )
        replace(
            """
            |    iget-object p0, p0, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;
            """.trimMargin(),
            """
            |    const-string v2, "com.zte.zdm.UpdatesActivity"
            """.trimMargin(),
        )
        replace(
            """
            |    invoke-virtual {v0, v1, p0}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
            """.trimMargin(),
            """
            |    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
            """.trimMargin(),
        )
        replace(
            """
            |    move-result-object p0
            |
            |    goto :goto_0
            |
            |    :cond_0
            |    const/4 p0, 0x0
            |
            |    :goto_0
            |    return-object p0
            """.trimMargin(),
            """
            |    return-object v0
            """.trimMargin(),
        )
    }
    xml("res/values/strings.xml") {
        append(
            """
            |    <string name="menu_key_lti_updater">top_level_lti_updater</string>
            |    <string name="softupdate_settings_title">Software Update</string>
            |    <string name="keywords_software_update">software,update,fota,lti</string>
            """.trimMargin(),
        )
    }
    xml("res/xml/zte_top_level_settings_abroad.xml") {
        insertBefore(
            element(null, "android:key" to "top_level_last_category"),
            """
            |    <com.zte.settings.preference.IconPreference android:icon="@drawable/ic_ota_update_available" android:title="@string/softupdate_settings_title" android:key="top_level_lti_updater" android:order="5" android:summary="@string/summary_placeholder" preference:controller="io.lti.updater.settings.UpdaterPreferenceController" preference:highlightableMenuKey="@string/menu_key_lti_updater" preference:keywords="@string/keywords_software_update">
            |        <intent android:targetPackage="com.zte.zdm" android:targetClass="com.zte.zdm.UpdatesActivity">
            |            <extra android:name="from_settings" android:value="true" />
            |        </intent>
            |    </com.zte.settings.preference.IconPreference>
            """.trimMargin(),
        )
    }
    method("Lcom/zte/settings/deviceinfo/FotaUpgradeController;", "handlePreferenceTreeClick") {
        replace(
            """
            |    const-string v2, "com.zte.zdm.application.mmi.MainActivity"
            """.trimMargin(),
            """
            |    const-string v2, "com.zte.zdm.UpdatesActivity"
            """.trimMargin(),
        )
    }
    method("Lcom/zte/settings/deviceinfo/FotaUpgradeController;", "isAvailable") {
        replace(
            """
            |    invoke-static {p0}, Lcom/zte/settings/system/SystemUtils;->isSupportZteFotaOrVertuFota(Landroid/content/Context;)Z
            """.trimMargin(),
            """
            |    const-string v0, "com.zte.zdm"
            |
            |    invoke-static {p0, v0}, Lcom/android/settings/Utils;->isPackageEnabled(Landroid/content/Context;Ljava/lang/String;)Z
            """.trimMargin(),
        )
    }
    method("Lcom/android/settings/system/SystemUpdatePreferenceController;", "getAvailabilityStatus") {
        replace(
            """
            |.method public getAvailabilityStatus()I
            |    .locals 2
            """.trimMargin(),
            """
            |.method public getAvailabilityStatus()I
            |    .locals 1
            """.trimMargin(),
        )
        replace(
            """
            |    iget-object v0, p0, Lcom/android/settings/system/SystemUpdatePreferenceController;->mContext:Landroid/content/Context;
            """.trimMargin(),
            """
            |    const/4 v0, 0x3
            """.trimMargin(),
        )
        replace(
            """
            |    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
            |
            |    move-result-object v0
            |
            |    const v1, 0x7f05008c
            |
            |    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getBoolean(I)Z
            |
            |    move-result v0
            |
            |    if-eqz v0, :cond_0
            |
            |    iget-object v0, p0, Lcom/android/settings/system/SystemUpdatePreferenceController;->userManager:Landroid/os/UserManager;
            |
            |    invoke-virtual {v0}, Landroid/os/UserManager;->isAdminUser()Z
            |
            |    move-result v0
            |
            |    if-eqz v0, :cond_0
            |
            |    iget-boolean p0, p0, Lcom/android/settings/system/SystemUpdatePreferenceController;->isInstallZteUpdate:Z
            |
            |    if-nez p0, :cond_0
            |
            |    const/4 p0, 0x0
            |
            |    goto :goto_0
            |
            |    :cond_0
            |    const/4 p0, 0x3
            |
            |    :goto_0
            |    return p0
            """.trimMargin(),
            """
            |    return v0
            """.trimMargin(),
        )
    }
}
