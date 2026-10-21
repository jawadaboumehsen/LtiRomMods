.class final Lio/lti/KeyboxOperationUtils$SignOperation;
.super Landroid/system/keystore2/IKeystoreOperation$Stub;
.source "KeyboxOperationUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/lti/KeyboxOperationUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "SignOperation"
.end annotation


# instance fields
.field private final blacklist cipher:Ljavax/crypto/Cipher;

.field private final blacklist signature:Ljava/security/Signature;


# direct methods
.method constructor blacklist <init>(Ljava/security/PrivateKey;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    invoke-direct {p0}, Landroid/system/keystore2/IKeystoreOperation$Stub;-><init>()V

    const-string v0, "RSA/None/Padding"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    new-instance v0, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;

    invoke-direct {v0}, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;-><init>()V

    invoke-static {p2, v0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljavax/crypto/Cipher;

    move-result-object p2

    iput-object p2, p0, Lio/lti/KeyboxOperationUtils$SignOperation;->cipher:Ljavax/crypto/Cipher;

    const/4 v0, 0x1

    invoke-virtual {p2, v0, p1}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    iput-object v1, p0, Lio/lti/KeyboxOperationUtils$SignOperation;->signature:Ljava/security/Signature;

    return-void

    :cond_0
    iput-object v1, p0, Lio/lti/KeyboxOperationUtils$SignOperation;->cipher:Ljavax/crypto/Cipher;

    new-instance v0, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;

    invoke-direct {v0}, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;-><init>()V

    invoke-static {p2, v0}, Ljava/security/Signature;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljava/security/Signature;

    move-result-object p2

    iput-object p2, p0, Lio/lti/KeyboxOperationUtils$SignOperation;->signature:Ljava/security/Signature;

    invoke-virtual {p2, p1}, Ljava/security/Signature;->initSign(Ljava/security/PrivateKey;)V

    return-void
.end method


# virtual methods
.method public blacklist abort()V
    .locals 0

    return-void
.end method

.method public blacklist finish([B[B)[B
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    :try_start_0
    iget-object p2, p0, Lio/lti/KeyboxOperationUtils$SignOperation;->cipher:Ljavax/crypto/Cipher;

    if-eqz p2, :cond_1

    if-nez p1, :cond_0

    invoke-virtual {p2}, Ljavax/crypto/Cipher;->doFinal()[B

    move-result-object p0

    return-object p0

    :cond_0
    invoke-virtual {p2, p1}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object p0

    return-object p0

    :cond_1
    iget-object p2, p0, Lio/lti/KeyboxOperationUtils$SignOperation;->signature:Ljava/security/Signature;

    if-eqz p2, :cond_2

    invoke-virtual {p2, p1}, Ljava/security/Signature;->update([B)V

    iget-object p0, p0, Lio/lti/KeyboxOperationUtils$SignOperation;->signature:Ljava/security/Signature;

    invoke-virtual {p0}, Ljava/security/Signature;->sign()[B

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :cond_2
    const/4 p0, 0x0

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
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lio/lti/KeyboxOperationUtils$SignOperation;->cipher:Ljavax/crypto/Cipher;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Ljavax/crypto/Cipher;->update([B)[B

    goto :goto_0

    :cond_0
    iget-object p0, p0, Lio/lti/KeyboxOperationUtils$SignOperation;->signature:Ljava/security/Signature;

    if-eqz p0, :cond_1

    invoke-virtual {p0, p1}, Ljava/security/Signature;->update([B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_0
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
