.class public final Lio/lti/CustomSignatureHelper;
.super Ljava/lang/Object;
.source "CustomSignatureHelper.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static apply(Lcom/android/server/pm/InstallPackageHelper;Lcom/android/internal/pm/parsing/pkg/ParsedPackage;)V
    .locals 7

    const-string v5, "LTI_CPS"

    const-string v6, "apply: entered"

    invoke-static {v5, v6}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/android/server/pm/InstallPackageHelper;->mPm:Lcom/android/server/pm/PackageManagerService;

    if-eqz v0, :cond_lti_cps_0

    iget-object v0, v0, Lcom/android/server/pm/PackageManagerService;->mPlatformPackage:Lcom/android/server/pm/pkg/AndroidPackage;

    if-eqz v0, :cond_lti_cps_0

    invoke-interface {p1}, Lcom/android/internal/pm/parsing/pkg/ParsedPackage;->getSigningDetails()Landroid/content/pm/SigningDetails;

    move-result-object v1

    if-eqz v1, :cond_lti_cps_0

    invoke-virtual {v1}, Landroid/content/pm/SigningDetails;->getSignatures()[Landroid/content/pm/Signature;

    move-result-object v1

    if-eqz v1, :cond_lti_cps_0

    const/4 v2, 0x1

    new-array v2, v2, [Landroid/content/pm/Signature;

    new-instance v3, Landroid/content/pm/Signature;

    const-string/jumbo v4, "{{platform.certificate}}"

    invoke-direct {v3, v4}, Landroid/content/pm/Signature;-><init>(Ljava/lang/String;)V

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Lcom/android/server/pm/PackageManagerServiceUtils;->compareSignatureArrays([Landroid/content/pm/Signature;[Landroid/content/pm/Signature;)I

    move-result v1

    if-nez v1, :cond_lti_cps_nomatch

    const-string v6, "apply: testkey match, overriding signingDetails"

    invoke-static {v5, v6}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v0}, Lcom/android/server/pm/pkg/AndroidPackage;->getSigningDetails()Landroid/content/pm/SigningDetails;

    move-result-object v0

    invoke-interface {p1, v0}, Lcom/android/internal/pm/parsing/pkg/ParsedPackage;->setSigningDetails(Landroid/content/pm/SigningDetails;)Lcom/android/internal/pm/parsing/pkg/ParsedPackage;

    const-string v6, "apply: override applied"

    invoke-static {v5, v6}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :cond_lti_cps_0

    :cond_lti_cps_nomatch
    const-string v6, "apply: testkey no match, skipping"

    invoke-static {v5, v6}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_lti_cps_0
    return-void
.end method
