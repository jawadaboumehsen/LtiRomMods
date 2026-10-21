package io.ltirom.mods.changes

import io.ltirom.mods.text
import org.ide.lti.sdk.patchmod.ApkJarScope
import java.io.File

// The smali and resource changes, as exact text. Converted from the bash module's git patches;
// method(…) changes are placed by their method and lines, so the rest of a class may change.

/** pif: its changes to framework.jar. */
internal fun ApkJarScope.pifFramework(files: File) {
    method("Landroid/app/Instrumentation;", "newApplication(Ljava/lang/Class;Landroid/content/Context;)Landroid/app/Application;") {
        insertAfter(
            """
            |    invoke-virtual {@{app}, @{context}}, Landroid/app/Application;->attach(Landroid/content/Context;)V
            |
            """.trimMargin(),
            """
            |    invoke-static {@{context}}, Lio/lti/PlayIntegrityHooks;->setProps(Landroid/content/Context;)V
            |    
            """.trimMargin(),
        )
    }
    method("Landroid/app/Instrumentation;", "newApplication(Ljava/lang/ClassLoader;Ljava/lang/String;Landroid/content/Context;)Landroid/app/Application;") {
        insertAfter(
            """
            |    invoke-virtual {@{app}, @{context}}, Landroid/app/Application;->attach(Landroid/content/Context;)V
            |
            """.trimMargin(),
            """
            |    invoke-static {@{context}}, Lio/lti/PlayIntegrityHooks;->setProps(Landroid/content/Context;)V
            |    
            """.trimMargin(),
        )
    }
    method("Landroid/security/keystore2/AndroidKeyStoreSpi;", "engineGetCertificateChain") {
        insertAfter(
            """
            |    .locals 9
            |
            """.trimMargin(),
            """
            |    invoke-static {}, Lio/lti/PlayIntegrityHooks;->onEngineGetCertificateChain()V
            |    
            """.trimMargin(),
        )
    }
    addFile("smali_classes6/io/lti/PlayIntegrityHooks$${'$'}ExternalSyntheticLambda0.smali", files.text("pif/framework.jar/smali_classes6/io/lti/PlayIntegrityHooks$${'$'}ExternalSyntheticLambda0.smali"))
    addFile("smali_classes6/io/lti/PlayIntegrityHooks$1.smali", files.text("pif/framework.jar/smali_classes6/io/lti/PlayIntegrityHooks$1.smali"))
    addFile("smali_classes6/io/lti/PlayIntegrityHooks.smali", files.text("pif/framework.jar/smali_classes6/io/lti/PlayIntegrityHooks.smali"))
}

/** pif: its changes to services.jar. */
internal fun ApkJarScope.pifServices(files: File) {
    method("Lcom/android/server/wm/ActivityTaskManagerService;", "getFocusedRootTaskInfo") {
        insertAfter(
            """
            |    const-string v0, "getFocusedRootTaskInfo()"
            |
            """.trimMargin(),
            """
            |    iget-object v1, p0, Lcom/android/server/wm/ActivityTaskManagerService;->mContext:Landroid/content/Context;
            |    
            |    invoke-static {v1}, Lio/lti/PlayIntegrityHooks;->shouldBypassTaskPermission(Landroid/content/Context;)Z
            |    
            |    move-result v1
            |    
            |    if-nez v1, :cond_lti_pif_0
            |    
            """.trimMargin(),
        )
        insertAfter(
            """
            |    
            |    invoke-static {v0}, Lcom/android/server/wm/ActivityTaskManagerService;->enforceTaskPermission(Ljava/lang/String;)V
            """.trimMargin(),
            """
            |    
            |    :cond_lti_pif_0
            """.trimMargin(),
        )
    }
    method("Lcom/android/server/wm/ActivityTaskManagerService;", "registerTaskStackListener") {
        insertAfter(
            """
            |    const-string v0, "registerTaskStackListener()"
            |
            """.trimMargin(),
            """
            |    iget-object v0, p0, Lcom/android/server/wm/ActivityTaskManagerService;->mContext:Landroid/content/Context;
            |    
            |    invoke-static {v0}, Lio/lti/PlayIntegrityHooks;->shouldBypassTaskPermission(Landroid/content/Context;)Z
            |    
            |    move-result v0
            |    
            |    if-nez v0, :cond_lti_pif_1
            |    
            |    const-string v0, "registerTaskStackListener()"
            |    
            """.trimMargin(),
        )
        insertAfter(
            """
            |    const-string v0, "registerTaskStackListener()"
            |    
            |    invoke-static {v0}, Lcom/android/server/wm/ActivityTaskManagerService;->enforceTaskPermission(Ljava/lang/String;)V
            """.trimMargin(),
            """
            |    
            |    :cond_lti_pif_1
            """.trimMargin(),
        )
    }
}
