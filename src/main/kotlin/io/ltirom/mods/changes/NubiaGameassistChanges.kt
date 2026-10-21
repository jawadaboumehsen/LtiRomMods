package io.ltirom.mods.changes

import org.ide.lti.sdk.patchmod.ApkJarScope
import java.io.File

// The smali and resource changes, as exact text. Converted from the bash module's git patches;
// method(…) changes are placed by their method and lines, so the rest of a class may change.

/** nubia-gameassist: its changes to GameAssist15_5.apk. */
internal fun ApkJarScope.nubiaGameAssist(files: File) {
    method("Lcom/zte/gameassist/common/GameCheck;", "isGameSpaceListApp(Ljava/lang/String;)Z") {
        replace(
            """
            |.method public static isGameSpaceListApp(Ljava/lang/String;)Z
            |    .locals 1
            """.trimMargin(),
            """
            |.method public static isGameSpaceListApp(Ljava/lang/String;)Z
            |    .locals 4
            """.trimMargin(),
        )
        insertBefore(
            """
            |    sget v0, Lcom/zte/gameassist/common/SystemMgr;->sResumedTaskHashcode:I
            """.trimMargin(),
            """
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v0
            |
            |    if-eqz v0, :cond_lti_global_game_mode_1arg
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_nubia_global_game_mode"
            |
            |    const/4 v3, 0x0
            |
            |    invoke-static {v1, v2, v3}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v3
            |
            |    if-eqz v3, :cond_lti_global_game_mode_1arg
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_global_game_mode_1arg
            """.trimMargin(),
        )
    }
    method("Lcom/zte/gameassist/common/GameCheck;", "isGameSpaceListApp(Ljava/lang/String;I)Z") {
        replace(
            """
            |.method public static isGameSpaceListApp(Ljava/lang/String;I)Z
            |    .locals 4
            """.trimMargin(),
            """
            |.method public static isGameSpaceListApp(Ljava/lang/String;I)Z
            |    .locals 7
            """.trimMargin(),
        )
        insertBefore(
            """
            |    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
            """.trimMargin(),
            """
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v4
            |
            |    if-eqz v4, :cond_lti_global_game_mode_2arg
            |
            |    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v5
            |
            |    const-string v6, "lti_nubia_global_game_mode"
            |
            |    const/4 v4, 0x0
            |
            |    invoke-static {v5, v6, v4}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v4
            |
            |    if-eqz v4, :cond_lti_global_game_mode_2arg
            |
            |    const/4 v4, 0x1
            |
            |    return v4
            |
            |    :cond_lti_global_game_mode_2arg
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/dessert/policy/clean/CleanAnimationController;", "startClean") {
        replace(
            """
            |.method public startClean()V
            |    .locals 2
            """.trimMargin(),
            """
            |.method public startClean()V
            |    .locals 5
            """.trimMargin(),
        )
        insertAfter(
            """
            |    .locals 5
            |
            """.trimMargin(),
            """
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v2
            |
            |    if-eqz v2, :cond_lti_no_kill_clean
            |
            |    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v3
            |
            |    const-string v4, "lti_nubia_no_kill"
            |
            |    const/4 v2, 0x0
            |
            |    invoke-static {v3, v4, v2}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_lti_no_kill_clean
            |
            |    return-void
            |
            |    :cond_lti_no_kill_clean
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/onemorething/OneMoreThingManager;", "linkOMTProvider") {
        replace(
            """
            |.method public linkOMTProvider(Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;
            |    .locals 2
            """.trimMargin(),
            """
            |.method public linkOMTProvider(Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;
            |    .locals 6
            """.trimMargin(),
        )
        insertAfter(
            """
            |    .locals 6
            |
            """.trimMargin(),
            """
            |    const-string v2, "kill"
            |
            |    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_lti_no_kill_omt
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v3
            |
            |    if-eqz v3, :cond_lti_no_kill_omt
            |
            |    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v4
            |
            |    const-string v5, "lti_nubia_no_kill"
            |
            |    const/4 v3, 0x0
            |
            |    invoke-static {v4, v5, v3}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v3
            |
            |    if-eqz v3, :cond_lti_no_kill_omt
            |
            |    const/4 v3, 0x0
            |
            |    return-object v3
            |
            |    :cond_lti_no_kill_omt
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/tips/GameAssistLaunchTips;", "createAndShowTips") {
        insertBefore(
            """
            |    new-instance v9, Lcn/nubia/gameassist/tips/GameAssistLaunchTips;
            |
            |    move-object v0, v9
            """.trimMargin(),
            """
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v0
            |
            |    if-eqz v0, :cond_lti_hide_energy_cube
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_nubia_hide_energy_cube"
            |
            |    const/4 v0, 0x0
            |
            |    invoke-static {v1, v2, v0}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v0
            |
            |    if-eqz v0, :cond_lti_hide_energy_cube
            |
            |    const/4 v0, 0x0
            |
            |    return-object v0
            |
            |    :cond_lti_hide_energy_cube
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/tips/GameAssistLaunchTips;", "createTips") {
        insertBefore(
            """
            |    new-instance v9, Lcn/nubia/gameassist/tips/GameAssistLaunchTips;
            |
            |    const/4 v8, 0x0
            """.trimMargin(),
            """
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v0
            |
            |    if-eqz v0, :cond_lti_hide_energy_cube
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_nubia_hide_energy_cube"
            |
            |    const/4 v0, 0x0
            |
            |    invoke-static {v1, v2, v0}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v0
            |
            |    if-eqz v0, :cond_lti_hide_energy_cube
            |
            |    const/4 v0, 0x0
            |
            |    return-object v0
            |
            |    :cond_lti_hide_energy_cube
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/dessert/tiles/SmallWindowTile;", "handleUpdateState") {
        insertAfter(
            """
            |    :goto_1
            """.trimMargin(),
            """
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v2
            |
            |    if-eqz v2, :cond_lti_small_window_tile_return
            |
            |    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v3
            |
            |    const-string v4, "lti_nubia_small_window"
            |
            |    const/4 v2, 0x0
            |
            |    invoke-static {v3, v4, v2}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_lti_small_window_tile_return
            |
            |    const/4 v2, 0x1
            |
            |    iput-boolean v2, p1, Lcn/nubia/gameassist/common/QSTile${'$'}State;->value:Z
            |
            |    iput-boolean v2, p1, Lcn/nubia/gameassist/common/QSTile${'$'}State;->visible:Z
            |
            |    :cond_lti_small_window_tile_return
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/plugin/PluginUtils;", "getGfrcCapByPkg") {
        replace(
            """
            |.method public getGfrcCapByPkg(Ljava/lang/String;)I
            |    .locals 6
            """.trimMargin(),
            """
            |.method public getGfrcCapByPkg(Ljava/lang/String;)I
            |    .locals 9
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v6
            |
            |    if-eqz v6, :cond_lti_super_resolution_gfrc
            |
            |    invoke-virtual {v6}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v7
            |
            |    const-string v8, "lti_nubia_super_resolution"
            |
            |    const/4 v6, 0x0
            |
            |    invoke-static {v7, v8, v6}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v6
            |
            |    if-eqz v6, :cond_lti_super_resolution_gfrc
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_super_resolution_gfrc
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/plugin/PluginUtils;", "isSupportResolutionOld") {
        replace(
            """
            |.method public isSupportResolutionOld()Z
            |    .locals 1
            """.trimMargin(),
            """
            |.method public isSupportResolutionOld()Z
            |    .locals 4
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v1
            |
            |    if-eqz v1, :cond_lti_super_resolution_old
            |
            |    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v2
            |
            |    const-string v3, "lti_nubia_super_resolution"
            |
            |    const/4 v1, 0x0
            |
            |    invoke-static {v2, v3, v1}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v1
            |
            |    if-eqz v1, :cond_lti_super_resolution_old
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_super_resolution_old
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/plugin/PluginUtils;", "isSupportResolutionSettingsInXml") {
        replace(
            """
            |.method public isSupportResolutionSettingsInXml()Z
            |    .locals 1
            """.trimMargin(),
            """
            |.method public isSupportResolutionSettingsInXml()Z
            |    .locals 4
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v1
            |
            |    if-eqz v1, :cond_lti_super_resolution_settings
            |
            |    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v2
            |
            |    const-string v3, "lti_nubia_super_resolution"
            |
            |    const/4 v1, 0x0
            |
            |    invoke-static {v2, v3, v1}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v1
            |
            |    if-eqz v1, :cond_lti_super_resolution_settings
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_super_resolution_settings
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/plugin/PluginUtils;", "supportResolution") {
        replace(
            """
            |.method public supportResolution(Ljava/lang/String;)Z
            |    .locals 0
            """.trimMargin(),
            """
            |.method public supportResolution(Ljava/lang/String;)Z
            |    .locals 3
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v0
            |
            |    if-eqz v0, :cond_lti_super_resolution_support
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_nubia_super_resolution"
            |
            |    const/4 v0, 0x0
            |
            |    invoke-static {v1, v2, v0}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v0
            |
            |    if-eqz v0, :cond_lti_super_resolution_support
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_super_resolution_support
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/plugin/config/PluginConfig;", "isPluginEnable(Landroid/content/Context;Ljava/lang/String;)Z") {
        replace(
            """
            |.method public static isPluginEnable(Landroid/content/Context;Ljava/lang/String;)Z
            |    .locals 2
            """.trimMargin(),
            """
            |.method public static isPluginEnable(Landroid/content/Context;Ljava/lang/String;)Z
            |    .locals 5
            |
            |    const-string v0, "super_resolution"
            |
            |    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
            |
            |    move-result v0
            |
            |    if-nez v0, :cond_lti_super_resolution_plugin
            |
            |    const-string v0, "super_resolution_old"
            |
            |    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
            |
            |    move-result v0
            |
            |    if-eqz v0, :cond_lti_plugin_original
            |
            |    :cond_lti_super_resolution_plugin
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v0
            |
            |    if-eqz v0, :cond_lti_plugin_original
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_nubia_super_resolution"
            |
            |    const/4 v3, 0x0
            |
            |    invoke-static {v1, v2, v3}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v3
            |
            |    if-eqz v3, :cond_lti_plugin_original
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_plugin_original
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/utils/TilesUtil;", "getHideAppList") {
        replace(
            """
            |.method public static getHideAppList(Landroid/content/Context;)Ljava/util/ArrayList;
            |    .locals 5
            """.trimMargin(),
            """
            |.method public static getHideAppList(Landroid/content/Context;)Ljava/util/ArrayList;
            |    .locals 8
            """.trimMargin(),
        )
        insertBefore(
            """
            |
            |    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            """.trimMargin(),
            """
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v5
            |
            |    if-eqz v5, :cond_lti_small_window
            |
            |    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v6
            |
            |    const-string v7, "lti_nubia_small_window"
            |
            |    const/4 v5, 0x0
            |
            |    invoke-static {v6, v7, v5}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v5
            |
            |    if-eqz v5, :cond_lti_small_window
            |
            |    new-instance v5, Ljava/util/ArrayList;
            |
            |    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V
            |
            |    return-object v5
            |
            |    :cond_lti_small_window
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gameassist/utils/Utils;", "isSmallWindowOpen") {
        replace(
            """
            |.method public static isSmallWindowOpen(Landroid/content/Context;)Z
            |    .locals 1
            """.trimMargin(),
            """
            |.method public static isSmallWindowOpen(Landroid/content/Context;)Z
            |    .locals 4
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v0
            |
            |    if-eqz v0, :cond_lti_small_window_original
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_nubia_small_window"
            |
            |    const/4 v3, 0x0
            |
            |    invoke-static {v1, v2, v3}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v3
            |
            |    if-eqz v3, :cond_lti_super_resolution
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_super_resolution
            |    const-string v2, "lti_nubia_super_resolution"
            |
            |    const/4 v3, 0x0
            |
            |    invoke-static {v1, v2, v3}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v3
            |
            |    if-eqz v3, :cond_lti_small_window_original
            |
            |    const/4 v0, 0x0
            |
            |    return v0
            |
            |    :cond_lti_small_window_original
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/plugin/superresolution/SuperResolutionTypeDataManager;", "getItem") {
        replace(
            """
            |    invoke-virtual {p0}, Lcn/nubia/plugin/superresolution/SuperResolutionTypeItemData;->getImageQualityItem()Ljava/lang/String;
            |
            |    move-result-object p0
            """.trimMargin(),
            """
            |    invoke-virtual {p0}, Lcn/nubia/plugin/superresolution/SuperResolutionTypeItemData;->getImageQualityItem()Ljava/lang/String;
            |
            |    move-result-object v0
            """.trimMargin(),
        )
        replace(
            """
            |    move-result-object v0
            |
            |    return-object p0
            """.trimMargin(),
            """
            |    move-result-object v0
            |
            |    goto :goto_lti_result
            """.trimMargin(),
        )
        replace(
            """
            |    invoke-virtual {p0}, Lcn/nubia/plugin/superresolution/SuperResolutionTypeItemData;->getFrameRateItem()Ljava/lang/String;
            |
            |    move-result-object p0
            """.trimMargin(),
            """
            |    invoke-virtual {p0}, Lcn/nubia/plugin/superresolution/SuperResolutionTypeItemData;->getFrameRateItem()Ljava/lang/String;
            |
            |    move-result-object v0
            """.trimMargin(),
        )
        replace(
            """
            |    move-result-object v0
            |
            |    return-object p0
            """.trimMargin(),
            """
            |    move-result-object v0
            |
            |    goto :goto_lti_result
            """.trimMargin(),
        )
        replace(
            """
            |    const-string p0, "origin"
            """.trimMargin(),
            """
            |    const-string v0, "origin"
            """.trimMargin(),
        )
        insertBefore(
            """
            |    const-string p0, "frameRate_origin"
            """.trimMargin(),
            """
            |    const-string v0, "frameRate_origin"
            |
            |    :goto_1
            |    :goto_lti_result
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object p0
            |
            |    if-eqz p0, :cond_lti_return_original
            |
            |    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object p1
            |
            |    const-string v1, "lti_nubia_super_resolution"
            |
            |    const/4 p0, 0x0
            |
            |    invoke-static {p1, v1, p0}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result p0
            |
            |    if-eqz p0, :cond_lti_return_original
            |
            |    const-string p0, "imageQuality"
            |
            |    invoke-virtual {p0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
            |
            |    move-result p0
            |
            |    if-eqz p0, :cond_lti_frame_rate
            |
            |    if-eqz v0, :cond_lti_force_enabled
            |
            |    const-string p0, "origin"
            |
            |    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
            |
            |    move-result p0
            |
            |    if-eqz p0, :cond_lti_return_original
            |
            |    goto :goto_lti_force_enabled
            |
            |    :cond_lti_frame_rate
            |    const-string p0, "frameRate"
            |
            |    invoke-virtual {p0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
            |
            |    move-result p0
            |
            |    if-eqz p0, :cond_lti_return_original
            |
            |    if-eqz v0, :cond_lti_force_enabled
            |
            """.trimMargin(),
        )
        replace(
            """
            |    :goto_1
            |    return-object p0
            """.trimMargin(),
            """
            |    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
            |
            |    move-result p0
            |
            |    if-eqz p0, :cond_lti_return_original
            |
            |    :goto_lti_force_enabled
            |    :cond_lti_force_enabled
            |    const-string v0, "1"
            |
            |    :cond_lti_return_original
            |    return-object v0
            """.trimMargin(),
        )
    }
    method("Lcom/zte/gameassist/config/ZteFeature;", "isSupportSuperResolution") {
        replace(
            """
            |.method public static isSupportSuperResolution()Z
            |    .locals 2
            """.trimMargin(),
            """
            |.method public static isSupportSuperResolution()Z
            |    .locals 5
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v2
            |
            |    if-eqz v2, :cond_lti_super_resolution
            |
            |    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v3
            |
            |    const-string v4, "lti_nubia_super_resolution"
            |
            |    const/4 v2, 0x0
            |
            |    invoke-static {v3, v4, v2}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_lti_super_resolution
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_super_resolution
            """.trimMargin(),
        )
    }
    method("Lcom/zte/gameassist/config/ZteFeature;", "isSupportSuperResolutionOld") {
        replace(
            """
            |.method public static isSupportSuperResolutionOld()Z
            |    .locals 2
            """.trimMargin(),
            """
            |.method public static isSupportSuperResolutionOld()Z
            |    .locals 5
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v2
            |
            |    if-eqz v2, :cond_lti_super_resolution_old
            |
            |    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v3
            |
            |    const-string v4, "lti_nubia_super_resolution"
            |
            |    const/4 v2, 0x0
            |
            |    invoke-static {v3, v4, v2}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_lti_super_resolution_old
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_super_resolution_old
            """.trimMargin(),
        )
    }
    method("Lcom/zte/shared/wrapper/ActivityManagerWrapper;", "checkTaskSupportWr(Ljava/lang/String;)Z") {
        replace(
            """
            |.method public static checkTaskSupportWr(Ljava/lang/String;)Z
            |    .locals 1
            """.trimMargin(),
            """
            |.method public static checkTaskSupportWr(Ljava/lang/String;)Z
            |    .locals 4
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v0
            |
            |    if-eqz v0, :cond_lti_small_window
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_nubia_small_window"
            |
            |    const/4 v3, 0x0
            |
            |    invoke-static {v1, v2, v3}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v3
            |
            |    if-eqz v3, :cond_lti_small_window
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_small_window
            """.trimMargin(),
        )
    }
}

/** nubia-gameassist: its changes to GameSpace.apk. */
internal fun ApkJarScope.nubiaGameSpace(files: File) {
    method("Lcn/nubia/gamecenter/settings/watermark/WaterMarkWatcher;", "<init>") {
        replace(
            """
            |.method public constructor <init>(Landroid/widget/EditText;I)V
            |    .locals 0
            """.trimMargin(),
            """
            |.method public constructor <init>(Landroid/widget/EditText;I)V
            |    .locals 4
            """.trimMargin(),
        )
        insertBefore(
            """
            |    iput p2, p0, Lcn/nubia/gamecenter/settings/watermark/WaterMarkWatcher;->maxLength:I
            """.trimMargin(),
            """
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v0
            |
            |    if-eqz v0, :cond_lti_nubia_watermark_store
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_nubia_watermark_unlimited"
            |
            |    const/4 v3, 0x0
            |
            |    invoke-static {v1, v2, v3}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v3
            |
            |    if-eqz v3, :cond_lti_nubia_watermark_store
            |
            |    const/16 p2, 0x3e8
            |
            |    :cond_lti_nubia_watermark_store
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gamelauncher/gamecontrolpanel/superresolution/SuperResolutionHelper;", "supportSuperResolutionByPkgName") {
        replace(
            """
            |.method public static supportSuperResolutionByPkgName(Ljava/lang/String;)Z
            |    .locals 2
            """.trimMargin(),
            """
            |.method public static supportSuperResolutionByPkgName(Ljava/lang/String;)Z
            |    .locals 5
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v2
            |
            |    if-eqz v2, :cond_lti_super_resolution
            |
            |    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v3
            |
            |    const-string v4, "lti_nubia_super_resolution"
            |
            |    const/4 v2, 0x0
            |
            |    invoke-static {v3, v4, v2}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_lti_super_resolution
            |
            |    const/4 v0, 0x1
            |
            |    return v0
            |
            |    :cond_lti_super_resolution
            """.trimMargin(),
        )
    }
    method("Lcn/nubia/gamelauncher/gamecontrolpanel/utils/ControlPanelFeatureHelper;", "getZteFeatureMagicSuperResolution") {
        replace(
            """
            |.method public static getZteFeatureMagicSuperResolution()Ljava/lang/Boolean;
            |    .locals 2
            """.trimMargin(),
            """
            |.method public static getZteFeatureMagicSuperResolution()Ljava/lang/Boolean;
            |    .locals 5
            |
            |    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;
            |
            |    move-result-object v2
            |
            |    if-eqz v2, :cond_lti_super_resolution
            |
            |    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
            |
            |    move-result-object v3
            |
            |    const-string v4, "lti_nubia_super_resolution"
            |
            |    const/4 v2, 0x0
            |
            |    invoke-static {v3, v4, v2}, Landroid/provider/Settings${'$'}Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_lti_super_resolution
            |
            |    const/4 v0, 0x1
            |
            |    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;
            |
            |    move-result-object v0
            |
            |    return-object v0
            |
            |    :cond_lti_super_resolution
            """.trimMargin(),
        )
    }
}
