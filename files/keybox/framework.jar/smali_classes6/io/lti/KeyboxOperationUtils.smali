.class final Lio/lti/KeyboxOperationUtils;
.super Ljava/lang/Object;
.source "KeyboxOperationUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/lti/KeyboxOperationUtils$DecryptOperation;,
        Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;,
        Lio/lti/KeyboxOperationUtils$SignOperation;
    }
.end annotation


# static fields
.field private static final blacklist DEBUG:Z = false

.field private static final blacklist TAG:Ljava/lang/String; = "KeyboxOperationUtils"


# direct methods
.method private constructor blacklist <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static blacklist dlog(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method static blacklist getDecryptOperation(Ljava/security/PrivateKey;Ljava/lang/String;)Landroid/system/keystore2/CreateOperationResponse;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x0

    invoke-static {p0, p1, v0, v0}, Lio/lti/KeyboxOperationUtils;->getDecryptOperation(Ljava/security/PrivateKey;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object p0

    return-object p0
.end method

.method static blacklist getDecryptOperation(Ljava/security/PrivateKey;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;)Landroid/system/keystore2/CreateOperationResponse;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    new-instance v0, Landroid/system/keystore2/CreateOperationResponse;

    invoke-direct {v0}, Landroid/system/keystore2/CreateOperationResponse;-><init>()V

    new-instance v1, Lio/lti/KeyboxOperationUtils$DecryptOperation;

    invoke-direct {v1, p0, p1, p2, p3}, Lio/lti/KeyboxOperationUtils$DecryptOperation;-><init>(Ljava/security/PrivateKey;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;)V

    iput-object v1, v0, Landroid/system/keystore2/CreateOperationResponse;->iOperation:Landroid/system/keystore2/IKeystoreOperation;

    const-string p0, "Called createOperation with purpose DECRYPT"

    invoke-static {p0}, Lio/lti/KeyboxOperationUtils;->dlog(Ljava/lang/String;)V

    return-object v0
.end method

.method static blacklist getKeyAgreementOperation(Ljava/security/PrivateKey;)Landroid/system/keystore2/CreateOperationResponse;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    new-instance v0, Landroid/system/keystore2/CreateOperationResponse;

    invoke-direct {v0}, Landroid/system/keystore2/CreateOperationResponse;-><init>()V

    new-instance v1, Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;

    invoke-direct {v1, p0}, Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;-><init>(Ljava/security/PrivateKey;)V

    iput-object v1, v0, Landroid/system/keystore2/CreateOperationResponse;->iOperation:Landroid/system/keystore2/IKeystoreOperation;

    const-string p0, "Called createOperation with purpose AGREE_KEY"

    invoke-static {p0}, Lio/lti/KeyboxOperationUtils;->dlog(Ljava/lang/String;)V

    return-object v0
.end method

.method static blacklist getSignOperation(Ljava/security/PrivateKey;Ljava/lang/String;)Landroid/system/keystore2/CreateOperationResponse;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    new-instance v0, Landroid/system/keystore2/CreateOperationResponse;

    invoke-direct {v0}, Landroid/system/keystore2/CreateOperationResponse;-><init>()V

    new-instance v1, Lio/lti/KeyboxOperationUtils$SignOperation;

    invoke-direct {v1, p0, p1}, Lio/lti/KeyboxOperationUtils$SignOperation;-><init>(Ljava/security/PrivateKey;Ljava/lang/String;)V

    iput-object v1, v0, Landroid/system/keystore2/CreateOperationResponse;->iOperation:Landroid/system/keystore2/IKeystoreOperation;

    const-string p0, "Called createOperation with purpose SIGN"

    invoke-static {p0}, Lio/lti/KeyboxOperationUtils;->dlog(Ljava/lang/String;)V

    return-object v0
.end method
