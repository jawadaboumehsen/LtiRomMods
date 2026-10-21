package io.ltirom.mods.changes

import io.ltirom.mods.text
import org.ide.lti.sdk.patchmod.ApkJarScope
import java.io.File

// The smali and resource changes, as exact text. Converted from the bash module's git patches;
// method(…) changes are placed by their method and lines, so the rest of a class may change.

/** signature: its changes to services.jar. */
internal fun ApkJarScope.signatureServices(files: File) {
    method("Lcom/android/server/pm/InstallPackageHelper;", "scanSystemPackageLI") {
        insertBefore(
            """
            |    invoke-virtual {v0, v1, v15}, Lcom/android/server/pm/InstallPackageHelper;->maybeClearProfilesForUpgradesLI(Lcom/android/server/pm/PackageSetting;Lcom/android/server/pm/pkg/AndroidPackage;)V
            """.trimMargin(),
            """
            |    invoke-static {v0, v2}, Lio/lti/CustomSignatureHelper;->apply(Lcom/android/server/pm/InstallPackageHelper;Lcom/android/internal/pm/parsing/pkg/ParsedPackage;)V
            |
            """.trimMargin(),
        )
    }
    addFile("smali_classes2/io/lti/CustomSignatureHelper.smali", files.text("signature/services.jar/smali_classes2/io/lti/CustomSignatureHelper.smali"))
}
