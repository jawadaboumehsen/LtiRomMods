package io.ltirom.mods.changes

import io.ltirom.mods.text
import org.ide.lti.sdk.patchmod.ApkJarScope
import java.io.File

// The smali and resource changes, as exact text. Converted from the bash module's git patches;
// method(…) changes are placed by their method and lines, so the rest of a class may change.

/** hma: its changes to framework.jar. */
internal fun ApkJarScope.hmaFramework(files: File) {
    addFile("smali_classes6/io/lti/HideAppListUtils.smali", files.text("hma/framework.jar/smali_classes6/io/lti/HideAppListUtils.smali"))
    change("smali_classes6/io/lti/HideAppListUtils.smali") {
        insertBefore(
            """
            |.end method
            |
            |.method private static blacklist getHiddenPackages()Ljava/util/Set;
            """.trimMargin(),
            """
            |.end method
            |
            |.method public static greylist getApps(Landroid/content/ContentResolver;)Ljava/util/Set;
            |    .locals 6
            |    .annotation system Ldalvik/annotation/Signature;
            |        value = {
            |            "(",
            |            "Landroid/content/ContentResolver;",
            |            ")",
            |            "Ljava/util/Set<",
            |            "Ljava/lang/String;",
            |            ">;"
            |        }
            |    .end annotation
            |
            |    new-instance v0, Ljava/util/HashSet;
            |
            |    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V
            |
            |    :try_start_0
            |    const-string v1, "lti_hma_list"
            |
            |    invoke-static {p0, v1}, Landroid/provider/Settings${'$'}Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
            |
            |    move-result-object v1
            |
            |    if-eqz v1, :cond_1
            |
            |    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z
            |
            |    move-result v2
            |
            |    if-nez v2, :cond_1
            |
            |    const-string v2, ","
            |
            |    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
            |
            |    move-result-object v1
            |
            |    array-length v2, v1
            |
            |    const/4 v3, 0x0
            |
            |    :goto_0
            |    if-ge v3, v2, :cond_1
            |
            |    aget-object v4, v1, v3
            |
            |    invoke-virtual {v4}, Ljava/lang/String;->trim()Ljava/lang/String;
            |
            |    move-result-object v4
            |
            |    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z
            |
            |    move-result v5
            |
            |    if-nez v5, :cond_0
            |
            |    invoke-interface {v0, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
            |
            |    :cond_0
            |    add-int/lit8 v3, v3, 0x1
            |
            |    goto :goto_0
            |
            |    :cond_1
            |    return-object v0
            |    :try_end_0
            |    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
            |
            |    :catch_0
            |    move-exception v1
            |
            |    return-object v0
            |.end method
            |
            |.method public static greylist addApp(Landroid/content/ContentResolver;Ljava/lang/String;)V
            |    .locals 3
            |
            |    if-nez p1, :cond_0
            |
            |    return-void
            |
            |    :cond_0
            |    :try_start_0
            |    invoke-static {p0}, Lio/lti/HideAppListUtils;->getApps(Landroid/content/ContentResolver;)Ljava/util/Set;
            |
            |    move-result-object v0
            |
            |    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
            |
            |    const-string v1, ","
            |
            |    invoke-static {v1, v0}, Landroid/text/TextUtils;->join(Ljava/lang/CharSequence;Ljava/lang/Iterable;)Ljava/lang/String;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_hma_list"
            |
            |    invoke-static {p0, v2, v1}, Landroid/provider/Settings${'$'}Secure;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z
            |    :try_end_0
            |    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
            |
            |    goto :goto_0
            |
            |    :catch_0
            |    move-exception p0
            |
            |    :goto_0
            |    return-void
            |.end method
            |
            |.method public static greylist removeApp(Landroid/content/ContentResolver;Ljava/lang/String;)V
            |    .locals 3
            |
            |    if-nez p1, :cond_0
            |
            |    return-void
            |
            |    :cond_0
            |    :try_start_0
            |    invoke-static {p0}, Lio/lti/HideAppListUtils;->getApps(Landroid/content/ContentResolver;)Ljava/util/Set;
            |
            |    move-result-object v0
            |
            |    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
            |
            |    const-string v1, ","
            |
            |    invoke-static {v1, v0}, Landroid/text/TextUtils;->join(Ljava/lang/CharSequence;Ljava/lang/Iterable;)Ljava/lang/String;
            |
            |    move-result-object v1
            |
            |    const-string v2, "lti_hma_list"
            |
            |    invoke-static {p0, v2, v1}, Landroid/provider/Settings${'$'}Secure;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z
            |    :try_end_0
            |    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
            |
            |    goto :goto_0
            |
            |    :catch_0
            |    move-exception p0
            |
            |    :goto_0
            |    return-void
            """.trimMargin(),
        )
    }
}

/** hma: its changes to services.jar. */
internal fun ApkJarScope.hmaServices(files: File) {
    method("Lcom/android/server/pm/ComputerEngine;", "canPackageQuery") {
        insertAfter(
            """
            |    aput-boolean p2, v1, v5
            """.trimMargin(),
            """
            |    
            |    if-eqz p2, :cond_lti_hma_1
            |    
            |    aget-object v2, v4, v5
            |    
            |    invoke-interface {v2}, Lcom/android/server/pm/pkg/PackageState;->getPackageName()Ljava/lang/String;
            |    
            |    move-result-object v2
            |    
            |    invoke-static {v2}, Lio/lti/HideAppListUtils;->shouldHideAppList(Ljava/lang/String;)Z
            |    
            |    move-result v2
            |    
            |    if-eqz v2, :cond_lti_hma_1
            |    
            |    const/4 v2, 0x0
            |    
            |    aput-boolean v2, v1, v5
            |    
            |    :cond_lti_hma_1
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/pm/ComputerEngine;", "getInstalledPackages") {
        insertAfter(
            """
            |    invoke-virtual {p0, p1, p2, p3, v6}, Lcom/android/server/pm/ComputerEngine;->getInstalledPackagesBody(JII)Landroid/content/pm/ParceledListSlice;
            """.trimMargin(),
            """
            |    
            |    move-result-object v0
            |    
            |    invoke-static {v0}, Lio/lti/HideAppListUtils;->filterInstalledPackages(Landroid/content/pm/ParceledListSlice;)Landroid/content/pm/ParceledListSlice;
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/pm/ComputerEngine;", "getPackageInfo") {
        insertAfter(
            """
            |    const-wide/16 v2, -0x1
            """.trimMargin(),
            """
            |    
            |    invoke-static {p1}, Lio/lti/HideAppListUtils;->shouldHideAppList(Ljava/lang/String;)Z
            |    
            |    move-result v0
            |    
            |    if-eqz v0, :cond_lti_hma_0
            |    
            |    const/4 v0, 0x0
            |    
            |    return-object v0
            |    
            |    :cond_lti_hma_0
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/pm/ComputerEngine;", "canPackageQuery") {
        replace(
            """
            |    if-eqz p2, :cond_lti_hma_1
            |    
            """.trimMargin(),
            """
            |    if-eqz p2, :cond_lti_hma_1
            |
            """.trimMargin(),
        )
        replace(
            """
            |    aget-object v2, v4, v5
            |    
            """.trimMargin(),
            """
            |    aget-object v2, v4, v5
            |
            """.trimMargin(),
        )
        replace(
            """
            |    invoke-interface {v2}, Lcom/android/server/pm/pkg/PackageState;->getPackageName()Ljava/lang/String;
            |    
            """.trimMargin(),
            """
            |    invoke-interface {v2}, Lcom/android/server/pm/pkg/PackageState;->getPackageName()Ljava/lang/String;
            |
            """.trimMargin(),
        )
        replace(
            """
            |    move-result-object v2
            |    
            """.trimMargin(),
            """
            |    move-result-object v2
            |
            |    invoke-virtual {p0, p1, v2}, Lcom/android/server/pm/ComputerEngine;->canHideApp(ILjava/lang/String;)Z
            |
            |    move-result v3
            |
            |    if-eqz v3, :cond_lti_hma_1
            |
            """.trimMargin(),
        )
        replace(
            """
            |    invoke-static {v2}, Lio/lti/HideAppListUtils;->shouldHideAppList(Ljava/lang/String;)Z
            |    
            """.trimMargin(),
            """
            |    invoke-static {v2}, Lio/lti/HideAppListUtils;->shouldHideAppList(Ljava/lang/String;)Z
            |
            """.trimMargin(),
        )
        replace(
            """
            |    invoke-static {v2}, Lio/lti/HideAppListUtils;->shouldHideAppList(Ljava/lang/String;)Z
            |    move-result v2
            |    
            """.trimMargin(),
            """
            |    invoke-static {v2}, Lio/lti/HideAppListUtils;->shouldHideAppList(Ljava/lang/String;)Z
            |    move-result v2
            |
            """.trimMargin(),
        )
        replace(
            """
            |    if-eqz v2, :cond_lti_hma_1
            |    
            """.trimMargin(),
            """
            |    if-eqz v2, :cond_lti_hma_1
            |
            """.trimMargin(),
        )
        replace(
            """
            |    const/4 v2, 0x0
            |    
            """.trimMargin(),
            """
            |    const/4 v2, 0x0
            |
            """.trimMargin(),
        )
        replace(
            """
            |    aput-boolean v2, v1, v5
            |    
            """.trimMargin(),
            """
            |    aput-boolean v2, v1, v5
            |
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/pm/ComputerEngine;", "getInstalledPackages") {
        replace(
            """
            |    invoke-virtual {p0, p1, p2, p3, v6}, Lcom/android/server/pm/ComputerEngine;->getInstalledPackagesBody(JII)Landroid/content/pm/ParceledListSlice;
            |    
            """.trimMargin(),
            """
            |    invoke-virtual {p0, p1, p2, p3, v6}, Lcom/android/server/pm/ComputerEngine;->getInstalledPackagesBody(JII)Landroid/content/pm/ParceledListSlice;
            |
            """.trimMargin(),
        )
        replace(
            """
            |    invoke-virtual {p0, p1, p2, p3, v6}, Lcom/android/server/pm/ComputerEngine;->getInstalledPackagesBody(JII)Landroid/content/pm/ParceledListSlice;
            |    move-result-object v0
            |    
            """.trimMargin(),
            """
            |    invoke-virtual {p0, p1, p2, p3, v6}, Lcom/android/server/pm/ComputerEngine;->getInstalledPackagesBody(JII)Landroid/content/pm/ParceledListSlice;
            |    move-result-object v0
            |
            |    const/4 v2, 0x0
            |
            |    invoke-virtual {p0, v6, v2}, Lcom/android/server/pm/ComputerEngine;->canHideApp(ILjava/lang/String;)Z
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_lti_hma_2
            |
            """.trimMargin(),
        )
        replace(
            """
            |    invoke-static {v0}, Lio/lti/HideAppListUtils;->filterInstalledPackages(Landroid/content/pm/ParceledListSlice;)Landroid/content/pm/ParceledListSlice;
            |
            |    move-result-object p0
            """.trimMargin(),
            """
            |    invoke-static {v0}, Lio/lti/HideAppListUtils;->filterInstalledPackages(Landroid/content/pm/ParceledListSlice;)Landroid/content/pm/ParceledListSlice;
            |
            |    move-result-object v0
            |
            |    :cond_lti_hma_2
            |    move-object p0, v0
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/pm/ComputerEngine;", "getPackageInfo") {
        insertBefore(
            """
            |.method public final getPackageInfo(Ljava/lang/String;JI)Landroid/content/pm/PackageInfo;
            """.trimMargin(),
            """
            |.method public static isBootCompleted()Z
            |    .locals 2
            |
            |    const-string/jumbo v0, "sys.boot_completed"
            |
            |    const/4 v1, 0x0
            |
            |    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z
            |
            |    move-result v0
            |
            |    return v0
            |.end method
            |
            |.method public final isCallerSystem(I)Z
            |    .locals 2
            |
            |    invoke-static {p1}, Lcom/android/server/pm/PackageManagerServiceUtils;->isSystemOrRootOrShell(I)Z
            |
            |    move-result v0
            |
            |    const/4 v1, 0x1
            |
            |    if-eqz v0, :cond_0
            |
            |    return v1
            |
            |    :cond_0
            |    iget-object p0, p0, Lcom/android/server/pm/ComputerEngine;->mSettings:Lcom/android/server/pm/ComputerEngine${'$'}Settings;
            |
            |    invoke-static {p1}, Landroid/os/UserHandle;->getAppId(I)I
            |
            |    move-result p1
            |
            |    iget-object p0, p0, Lcom/android/server/pm/ComputerEngine${'$'}Settings;->mSettings:Lcom/android/server/pm/Settings;
            |
            |    invoke-virtual {p0, p1}, Lcom/android/server/pm/Settings;->getSettingLPr(I)Lcom/android/server/pm/SettingBase;
            |
            |    move-result-object p0
            |
            |    const/4 p1, 0x0
            |
            |    if-nez p0, :cond_1
            |
            |    return p1
            |
            |    :cond_1
            |    invoke-virtual {p0}, Lcom/android/server/pm/SettingBase;->getFlags()I
            |
            |    move-result p0
            |
            |    and-int/lit8 v0, p0, 0x1
            |
            |    if-eq v0, v1, :cond_3
            |
            |    const/16 v0, 0x80
            |
            |    and-int/2addr p0, v0
            |
            |    if-ne p0, v0, :cond_2
            |
            |    goto :goto_0
            |
            |    :cond_2
            |    return p1
            |
            |    :cond_3
            |    :goto_0
            |    return v1
            |.end method
            |
            |.method public final canHideApp(ILjava/lang/String;)Z
            |    .locals 4
            |
            |    invoke-static {}, Lcom/android/server/pm/ComputerEngine;->isBootCompleted()Z
            |
            |    move-result v0
            |
            |    const/4 v1, 0x0
            |
            |    if-eqz v0, :cond_6
            |
            |    iget-object v0, p0, Lcom/android/server/pm/ComputerEngine;->mContext:Landroid/content/Context;
            |
            |    if-eqz v0, :cond_6
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;
            |
            |    move-result-object v0
            |
            |    if-nez v0, :cond_0
            |
            |    goto :goto_0
            |
            |    :cond_0
            |    iget-object v0, p0, Lcom/android/server/pm/ComputerEngine;->mContext:Landroid/content/Context;
            |
            |    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;
            |
            |    move-result-object v0
            |
            |    invoke-virtual {v0, p1}, Landroid/content/pm/PackageManager;->getNameForUid(I)Ljava/lang/String;
            |
            |    move-result-object v0
            |
            |    if-eqz v0, :cond_6
            |
            |    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_1
            |
            |    goto :goto_0
            |
            |    :cond_1
            |    const-string v2, "com.android.vending"
            |
            |    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
            |
            |    move-result v2
            |
            |    const/4 v3, 0x1
            |
            |    if-eqz v2, :cond_2
            |
            |    return v3
            |
            |    :cond_2
            |    if-eqz p2, :cond_6
            |
            |    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
            |
            |    move-result v2
            |
            |    if-eqz v2, :cond_3
            |
            |    goto :goto_0
            |
            |    :cond_3
            |    invoke-virtual {v0, p2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
            |
            |    move-result v0
            |
            |    if-eqz v0, :cond_4
            |
            |    return v1
            |
            |    :cond_4
            |    const-string/jumbo v0, "youtube"
            |
            |    invoke-virtual {p2, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
            |
            |    move-result v0
            |
            |    if-nez v0, :cond_6
            |
            |    const-string/jumbo v0, "microg"
            |
            |    invoke-virtual {p2, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
            |
            |    move-result v0
            |
            |    if-nez v0, :cond_6
            |
            |    const-string/jumbo v0, "revanced"
            |
            |    invoke-virtual {p2, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
            |
            |    move-result v0
            |
            |    if-nez v0, :cond_6
            |
            |    const-string v0, "gms"
            |
            |    invoke-virtual {p2, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
            |
            |    move-result p2
            |
            |    if-eqz p2, :cond_5
            |
            |    goto :goto_0
            |
            |    :cond_5
            |    invoke-virtual {p0, p1}, Lcom/android/server/pm/ComputerEngine;->isCallerSystem(I)Z
            |
            |    move-result p0
            |
            |    if-nez p0, :cond_6
            |
            |    invoke-static {p1}, Landroid/os/Process;->isIsolated(I)Z
            |
            |    move-result p0
            |
            |    if-nez p0, :cond_6
            |
            |    invoke-static {p1}, Landroid/os/Process;->isSdkSandboxUid(I)Z
            |
            |    move-result p0
            |
            |    if-nez p0, :cond_6
            |
            |    return v3
            |
            |    :cond_6
            |    :goto_0
            |    return v1
            |.end method
            |
            """.trimMargin(),
        )
        replace(
            """
            |    const-wide/16 v2, -0x1
            |    
            """.trimMargin(),
            """
            |    const-wide/16 v2, -0x1
            |
            |    invoke-static {}, Landroid/os/Binder;->getCallingUid()I
            |
            |    move-result v0
            |
            |    invoke-virtual {p0, v0, p1}, Lcom/android/server/pm/ComputerEngine;->canHideApp(ILjava/lang/String;)Z
            |
            |    move-result v1
            |
            |    if-eqz v1, :cond_lti_hma_0
            |
            """.trimMargin(),
        )
        replace(
            """
            |    
            |    move-result v0
            |    
            |    if-eqz v0, :cond_lti_hma_0
            |    
            |    const/4 v0, 0x0
            |    
            |    return-object v0
            |    
            """.trimMargin(),
            """
            |
            |    move-result v1
            |
            |    if-eqz v1, :cond_lti_hma_0
            |
            |    const/4 v1, 0x0
            |
            |    return-object v1
            |
            """.trimMargin(),
        )
    }
}
