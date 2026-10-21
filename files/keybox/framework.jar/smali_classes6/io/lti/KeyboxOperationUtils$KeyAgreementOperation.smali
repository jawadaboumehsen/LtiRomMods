.class final Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;
.super Landroid/system/keystore2/IKeystoreOperation$Stub;
.source "KeyboxOperationUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/lti/KeyboxOperationUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "KeyAgreementOperation"
.end annotation


# instance fields
.field private final blacklist keyAgreement:Ljavax/crypto/KeyAgreement;

.field private final blacklist output:Ljava/io/ByteArrayOutputStream;


# direct methods
.method constructor blacklist <init>(Ljava/security/PrivateKey;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    invoke-direct {p0}, Landroid/system/keystore2/IKeystoreOperation$Stub;-><init>()V

    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    iput-object v0, p0, Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;->output:Ljava/io/ByteArrayOutputStream;

    new-instance v0, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;

    invoke-direct {v0}, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;-><init>()V

    const-string v1, "ECDH"

    invoke-static {v1, v0}, Ljavax/crypto/KeyAgreement;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljavax/crypto/KeyAgreement;

    move-result-object v0

    iput-object v0, p0, Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;->keyAgreement:Ljavax/crypto/KeyAgreement;

    invoke-virtual {v0, p1}, Ljavax/crypto/KeyAgreement;->init(Ljava/security/Key;)V

    return-void
.end method


# virtual methods
.method public blacklist abort()V
    .locals 0

    return-void
.end method

.method public blacklist finish([B[B)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    :try_start_0
    iget-object p2, p0, Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;->output:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {p2, p1}, Ljava/io/ByteArrayOutputStream;->write([B)V

    const-string p1, "EC"

    new-instance p2, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;

    invoke-direct {p2}, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;-><init>()V

    invoke-static {p1, p2}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljava/security/KeyFactory;

    move-result-object p1

    new-instance p2, Ljava/security/spec/X509EncodedKeySpec;

    iget-object v0, p0, Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;->output:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    invoke-direct {p2, v0}, Ljava/security/spec/X509EncodedKeySpec;-><init>([B)V

    invoke-virtual {p1, p2}, Ljava/security/KeyFactory;->generatePublic(Ljava/security/spec/KeySpec;)Ljava/security/PublicKey;

    move-result-object p1

    iget-object p2, p0, Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;->keyAgreement:Ljavax/crypto/KeyAgreement;

    const/4 v0, 0x1

    invoke-virtual {p2, p1, v0}, Ljavax/crypto/KeyAgreement;->doPhase(Ljava/security/Key;Z)Ljava/security/Key;

    iget-object p0, p0, Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;->keyAgreement:Ljavax/crypto/KeyAgreement;

    invoke-virtual {p0}, Ljavax/crypto/KeyAgreement;->generateSecret()[B

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    new-instance p1, Landroid/os/RemoteException;

    invoke-direct {p1, p0}, Landroid/os/RemoteException;-><init>(Ljava/lang/Throwable;)V

    throw p1
.end method

.method public blacklist getInterfaceHash()Ljava/lang/String;
    .locals 0

    const-string p0, "98d815116c190250e9e5a1d9182cea8126fd0e97"

    return-object p0
.end method

.method public blacklist getInterfaceVersion()I
    .locals 0

    const/4 p0, 0x5

    return p0
.end method

.method public blacklist update([B)[B
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    :try_start_0
    iget-object p0, p0, Lio/lti/KeyboxOperationUtils$KeyAgreementOperation;->output:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {p0, p1}, Ljava/io/ByteArrayOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p0, 0x0

    return-object p0

    :catch_0
    move-exception p0

    new-instance p1, Landroid/os/RemoteException;

    invoke-direct {p1, p0}, Landroid/os/RemoteException;-><init>(Ljava/lang/Throwable;)V

    throw p1
.end method

.method public blacklist updateAad([B)V
    .locals 0

    return-void
.end method
