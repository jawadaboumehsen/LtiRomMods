.class final Lio/lti/KeyboxOperationUtils$DecryptOperation;
.super Landroid/system/keystore2/IKeystoreOperation$Stub;
.source "KeyboxOperationUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/lti/KeyboxOperationUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "DecryptOperation"
.end annotation


# instance fields
.field private final blacklist cipher:Ljavax/crypto/Cipher;


# direct methods
.method constructor blacklist <init>(Ljava/security/PrivateKey;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    invoke-direct {p0}, Landroid/system/keystore2/IKeystoreOperation$Stub;-><init>()V

    new-instance v0, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;

    invoke-direct {v0}, Lcom/android/internal/org/bouncycastle/jce/provider/BouncyCastleProvider;-><init>()V

    invoke-static {p2, v0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljavax/crypto/Cipher;

    move-result-object p2

    iput-object p2, p0, Lio/lti/KeyboxOperationUtils$DecryptOperation;->cipher:Ljavax/crypto/Cipher;

    const/4 p0, 0x2

    if-nez p4, :cond_0

    invoke-virtual {p2, p0, p1}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    return-void

    :cond_0
    invoke-virtual {p3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {p3}, Lio/lti/KeyboxUtils;->getDecryptDigest(Ljava/lang/Integer;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {p3}, Ljava/lang/Integer;->intValue()I

    move-result p3

    const-string v1, "MGF1"

    if-eq p3, p0, :cond_5

    const/4 v2, 0x3

    if-eq p3, v2, :cond_4

    const/4 v2, 0x4

    if-eq p3, v2, :cond_3

    const/4 v2, 0x5

    if-eq p3, v2, :cond_2

    const/4 v2, 0x6

    if-eq p3, v2, :cond_1

    const/4 p3, 0x0

    goto :goto_0

    :cond_1
    new-instance p3, Ljavax/crypto/spec/OAEPParameterSpec;

    sget-object v2, Ljava/security/spec/MGF1ParameterSpec;->SHA512:Ljava/security/spec/MGF1ParameterSpec;

    sget-object v3, Ljavax/crypto/spec/PSource$PSpecified;->DEFAULT:Ljavax/crypto/spec/PSource$PSpecified;

    invoke-direct {p3, v0, v1, v2, v3}, Ljavax/crypto/spec/OAEPParameterSpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/security/spec/AlgorithmParameterSpec;Ljavax/crypto/spec/PSource;)V

    goto :goto_0

    :cond_2
    new-instance p3, Ljavax/crypto/spec/OAEPParameterSpec;

    sget-object v2, Ljava/security/spec/MGF1ParameterSpec;->SHA384:Ljava/security/spec/MGF1ParameterSpec;

    sget-object v3, Ljavax/crypto/spec/PSource$PSpecified;->DEFAULT:Ljavax/crypto/spec/PSource$PSpecified;

    invoke-direct {p3, v0, v1, v2, v3}, Ljavax/crypto/spec/OAEPParameterSpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/security/spec/AlgorithmParameterSpec;Ljavax/crypto/spec/PSource;)V

    goto :goto_0

    :cond_3
    new-instance p3, Ljavax/crypto/spec/OAEPParameterSpec;

    sget-object v2, Ljava/security/spec/MGF1ParameterSpec;->SHA256:Ljava/security/spec/MGF1ParameterSpec;

    sget-object v3, Ljavax/crypto/spec/PSource$PSpecified;->DEFAULT:Ljavax/crypto/spec/PSource$PSpecified;

    invoke-direct {p3, v0, v1, v2, v3}, Ljavax/crypto/spec/OAEPParameterSpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/security/spec/AlgorithmParameterSpec;Ljavax/crypto/spec/PSource;)V

    goto :goto_0

    :cond_4
    new-instance p3, Ljavax/crypto/spec/OAEPParameterSpec;

    sget-object v2, Ljava/security/spec/MGF1ParameterSpec;->SHA224:Ljava/security/spec/MGF1ParameterSpec;

    sget-object v3, Ljavax/crypto/spec/PSource$PSpecified;->DEFAULT:Ljavax/crypto/spec/PSource$PSpecified;

    invoke-direct {p3, v0, v1, v2, v3}, Ljavax/crypto/spec/OAEPParameterSpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/security/spec/AlgorithmParameterSpec;Ljavax/crypto/spec/PSource;)V

    goto :goto_0

    :cond_5
    new-instance p3, Ljavax/crypto/spec/OAEPParameterSpec;

    sget-object v2, Ljava/security/spec/MGF1ParameterSpec;->SHA1:Ljava/security/spec/MGF1ParameterSpec;

    sget-object v3, Ljavax/crypto/spec/PSource$PSpecified;->DEFAULT:Ljavax/crypto/spec/PSource$PSpecified;

    invoke-direct {p3, v0, v1, v2, v3}, Ljavax/crypto/spec/OAEPParameterSpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/security/spec/AlgorithmParameterSpec;Ljavax/crypto/spec/PSource;)V

    :goto_0
    if-eqz p3, :cond_6

    invoke-virtual {p2, p0, p1, p3}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    return-void

    :cond_6
    new-instance p0, Ljava/security/NoSuchAlgorithmException;

    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "Unsupported mgfDigest: "

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/security/NoSuchAlgorithmException;-><init>(Ljava/lang/String;)V

    throw p0
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

    if-nez p1, :cond_0

    :try_start_0
    iget-object p0, p0, Lio/lti/KeyboxOperationUtils$DecryptOperation;->cipher:Ljavax/crypto/Cipher;

    invoke-virtual {p0}, Ljavax/crypto/Cipher;->doFinal()[B

    move-result-object p0

    return-object p0

    :cond_0
    iget-object p0, p0, Lio/lti/KeyboxOperationUtils$DecryptOperation;->cipher:Ljavax/crypto/Cipher;

    invoke-virtual {p0, p1}, Ljavax/crypto/Cipher;->doFinal([B)[B

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

    iget-object p0, p0, Lio/lti/KeyboxOperationUtils$DecryptOperation;->cipher:Ljavax/crypto/Cipher;

    invoke-virtual {p0, p1}, Ljavax/crypto/Cipher;->update([B)[B

    const/4 p0, 0x0

    return-object p0
.end method

.method public blacklist updateAad([B)V
    .locals 0

    return-void
.end method
