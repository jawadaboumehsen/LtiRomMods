package io.lti;

import android.content.pm.Signature;
import android.content.pm.SigningDetails;
import android.util.Slog;
import com.android.internal.pm.parsing.pkg.ParsedPackage;
import com.android.server.pm.InstallPackageHelper;
import com.android.server.pm.PackageManagerService;
import com.android.server.pm.PackageManagerServiceUtils;
import com.android.server.pm.pkg.AndroidPackage;

public final class CustomSignatureHelper {
    public static void apply(InstallPackageHelper installPackageHelper, ParsedPackage parsedPackage) {
        AndroidPackage androidPackage;
        SigningDetails signingDetails;
        Signature[] signatures;
        Slog.i("LTI_CPS", "apply: entered");
        PackageManagerService packageManagerService = installPackageHelper.mPm;
        if (packageManagerService == null || (androidPackage = packageManagerService.mPlatformPackage) == null || (signingDetails = parsedPackage.getSigningDetails()) == null || (signatures = signingDetails.getSignatures()) == null) {
            return;
        }
        if (PackageManagerServiceUtils.compareSignatureArrays(signatures, new Signature[]{new Signature("{{platform.certificate}}")}) != 0) {
            Slog.i("LTI_CPS", "apply: testkey no match, skipping");
            return;
        }
        Slog.i("LTI_CPS", "apply: testkey match, overriding signingDetails");
        parsedPackage.setSigningDetails(androidPackage.getSigningDetails());
        Slog.i("LTI_CPS", "apply: override applied");
    }
}
