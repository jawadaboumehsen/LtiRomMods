.class final Lio/lti/KeyboxChainGenerator;
.super Ljava/lang/Object;
.source "KeyboxChainGenerator.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/lti/KeyboxChainGenerator$KeyGenParameters;,
        Lio/lti/KeyboxChainGenerator$Digest;
    }
.end annotation


# static fields
.field private static final blacklist TAG:Ljava/lang/String; = "KeyboxChainGenerator"


# direct methods
.method private constructor blacklist <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static blacklist createApplicationId()Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;
    .locals 15
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;

    move-result-object v0

    if-eqz v0, :cond_6

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getPackagesForUid(I)[Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_4

    array-length v3, v2

    if-eqz v3, :cond_4

    array-length v1, v2

    new-array v3, v1, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    new-instance v4, Ljava/util/HashSet;

    invoke-direct {v4}, Ljava/util/HashSet;-><init>()V

    const-string v5, "SHA-256"

    invoke-static {v5}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v5

    const/4 v6, 0x0

    move v7, v6

    :goto_0
    const/4 v8, 0x2

    const/4 v9, 0x1

    if-ge v7, v1, :cond_2

    aget-object v10, v2, v7

    const/high16 v11, 0x8000000

    invoke-virtual {v0, v10, v11}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v11

    new-instance v12, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;

    new-array v8, v8, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    new-instance v13, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    sget-object v14, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v10, v14}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v10

    invoke-direct {v13, v10}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    aput-object v13, v8, v6

    new-instance v10, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    invoke-virtual {v11}, Landroid/content/pm/PackageInfo;->getLongVersionCode()J

    move-result-wide v13

    invoke-direct {v10, v13, v14}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    aput-object v10, v8, v9

    invoke-direct {v12, v8}, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    aput-object v12, v3, v7

    iget-object v8, v11, Landroid/content/pm/PackageInfo;->signingInfo:Landroid/content/pm/SigningInfo;

    invoke-virtual {v8}, Landroid/content/pm/SigningInfo;->hasMultipleSigners()Z

    move-result v8

    if-eqz v8, :cond_0

    iget-object v8, v11, Landroid/content/pm/PackageInfo;->signingInfo:Landroid/content/pm/SigningInfo;

    invoke-virtual {v8}, Landroid/content/pm/SigningInfo;->getApkContentsSigners()[Landroid/content/pm/Signature;

    move-result-object v8

    array-length v9, v8

    move v10, v6

    :goto_1
    if-ge v10, v9, :cond_1

    aget-object v11, v8, v10

    new-instance v12, Lio/lti/KeyboxChainGenerator$Digest;

    invoke-virtual {v11}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v11

    invoke-virtual {v5, v11}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v11

    invoke-direct {v12, v11}, Lio/lti/KeyboxChainGenerator$Digest;-><init>([B)V

    invoke-interface {v4, v12}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    add-int/lit8 v10, v10, 0x1

    goto :goto_1

    :cond_0
    iget-object v8, v11, Landroid/content/pm/PackageInfo;->signingInfo:Landroid/content/pm/SigningInfo;

    invoke-virtual {v8}, Landroid/content/pm/SigningInfo;->getSigningCertificateHistory()[Landroid/content/pm/Signature;

    move-result-object v8

    array-length v9, v8

    move v10, v6

    :goto_2
    if-ge v10, v9, :cond_1

    aget-object v11, v8, v10

    new-instance v12, Lio/lti/KeyboxChainGenerator$Digest;

    invoke-virtual {v11}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v11

    invoke-virtual {v5, v11}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v11

    invoke-direct {v12, v11}, Lio/lti/KeyboxChainGenerator$Digest;-><init>([B)V

    invoke-interface {v4, v12}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    add-int/lit8 v10, v10, 0x1

    goto :goto_2

    :cond_1
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    :cond_2
    invoke-interface {v4}, Ljava/util/Set;->size()I

    move-result v0

    new-array v0, v0, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    move v2, v6

    :goto_3
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lio/lti/KeyboxChainGenerator$Digest;

    add-int/lit8 v5, v2, 0x1

    new-instance v7, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    invoke-static {v4}, Lio/lti/KeyboxChainGenerator$Digest;->-$$Nest$fgetdigest(Lio/lti/KeyboxChainGenerator$Digest;)[B

    move-result-object v4

    invoke-direct {v7, v4}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    aput-object v7, v0, v2

    move v2, v5

    goto :goto_3

    :cond_3
    new-instance v1, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;

    new-array v4, v8, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    new-instance v5, Lcom/android/internal/org/bouncycastle/asn1/DERSet;

    invoke-direct {v5, v3}, Lcom/android/internal/org/bouncycastle/asn1/DERSet;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    aput-object v5, v4, v6

    new-instance v3, Lcom/android/internal/org/bouncycastle/asn1/DERSet;

    invoke-direct {v3, v0}, Lcom/android/internal/org/bouncycastle/asn1/DERSet;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    aput-object v3, v4, v9

    invoke-direct {v2, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-virtual {v2}, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;->getEncoded()[B

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    return-object v1

    :cond_4
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "No packages found for UID "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_5
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "createApplicationId: PackageManager not found!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_6
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "createApplicationId: context not available from ActivityThread!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static blacklist createExtension(Lio/lti/KeyboxChainGenerator$KeyGenParameters;I)Lcom/android/internal/org/bouncycastle/asn1/x509/Extension;
    .locals 12

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    const/4 v3, 0x1

    if-nez v2, :cond_0

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/DERSet;

    iget-object v5, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    invoke-static {v5}, Lio/lti/KeyboxChainGenerator;->fromIntList(Ljava/util/List;)[Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    move-result-object v5

    invoke-direct {v4, v5}, Lcom/android/internal/org/bouncycastle/asn1/DERSet;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-direct {v2, v3, v3, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    iget v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    const/4 v4, 0x2

    const/4 v5, -0x1

    if-eq v2, v5, :cond_1

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v6, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    iget v7, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    int-to-long v7, v7

    invoke-direct {v6, v7, v8}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    invoke-direct {v2, v3, v4, v6}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    iget v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->keySize:I

    const/4 v6, 0x3

    if-eq v2, v5, :cond_2

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v7, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    iget v8, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->keySize:I

    int-to-long v8, v8

    invoke-direct {v7, v8, v9}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    invoke-direct {v2, v3, v6, v7}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->digest:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_3

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v7, Lcom/android/internal/org/bouncycastle/asn1/DERSet;

    iget-object v8, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->digest:Ljava/util/List;

    invoke-static {v8}, Lio/lti/KeyboxChainGenerator;->fromIntList(Ljava/util/List;)[Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    move-result-object v8

    invoke-direct {v7, v8}, Lcom/android/internal/org/bouncycastle/asn1/DERSet;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    const/4 v8, 0x5

    invoke-direct {v2, v3, v8, v7}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->padding:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_4

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v7, Lcom/android/internal/org/bouncycastle/asn1/DERSet;

    iget-object v8, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->padding:Ljava/util/List;

    invoke-static {v8}, Lio/lti/KeyboxChainGenerator;->fromIntList(Ljava/util/List;)[Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    move-result-object v8

    invoke-direct {v7, v8}, Lcom/android/internal/org/bouncycastle/asn1/DERSet;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    const/4 v8, 0x6

    invoke-direct {v2, v3, v8, v7}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    iget v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->ecCurve:I

    if-eq v2, v5, :cond_5

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v7, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    iget v8, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->ecCurve:I

    int-to-long v8, v8

    invoke-direct {v7, v8, v9}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v8, 0xa

    invoke-direct {v2, v3, v8, v7}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_5
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->rsaPublicExponent:Ljava/math/BigInteger;

    if-eqz v2, :cond_6

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v7, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    iget-object v8, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->rsaPublicExponent:Ljava/math/BigInteger;

    invoke-direct {v7, v8}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(Ljava/math/BigInteger;)V

    const/16 v8, 0xc8

    invoke-direct {v2, v3, v8, v7}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_6
    invoke-static {}, Lio/lti/KeyboxUtils;->getAttestationVersion()I

    move-result v2

    const/16 v7, 0x64

    if-lt v2, v7, :cond_7

    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->mgfDigest:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_7

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v8, Lcom/android/internal/org/bouncycastle/asn1/DERSet;

    iget-object v9, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->mgfDigest:Ljava/util/List;

    invoke-static {v9}, Lio/lti/KeyboxChainGenerator;->fromIntList(Ljava/util/List;)[Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    move-result-object v9

    invoke-direct {v8, v9}, Lcom/android/internal/org/bouncycastle/asn1/DERSet;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    const/16 v9, 0xcb

    invoke-direct {v2, v3, v9, v8}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_7
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->activeDateTime:Ljava/util/Date;

    const/16 v8, 0x190

    if-eqz v2, :cond_8

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v9, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    iget-object v10, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->activeDateTime:Ljava/util/Date;

    invoke-virtual {v10}, Ljava/util/Date;->getTime()J

    move-result-wide v10

    invoke-direct {v9, v10, v11}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    invoke-direct {v2, v3, v8, v9}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_8
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->originationExpireDateTime:Ljava/util/Date;

    if-eqz v2, :cond_9

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v9, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    iget-object v10, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->originationExpireDateTime:Ljava/util/Date;

    invoke-virtual {v10}, Ljava/util/Date;->getTime()J

    move-result-wide v10

    invoke-direct {v9, v10, v11}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v10, 0x191

    invoke-direct {v2, v3, v10, v9}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_9
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageExpireDateTime:Ljava/util/Date;

    if-eqz v2, :cond_a

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v9, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    iget-object v10, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageExpireDateTime:Ljava/util/Date;

    invoke-virtual {v10}, Ljava/util/Date;->getTime()J

    move-result-wide v10

    invoke-direct {v9, v10, v11}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v10, 0x192

    invoke-direct {v2, v3, v10, v9}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_a
    invoke-static {}, Lio/lti/KeyboxUtils;->getAttestationVersion()I

    move-result v2

    if-lt v2, v7, :cond_b

    iget v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageCountLimit:I

    if-eq v2, v5, :cond_b

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v5, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    iget v7, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageCountLimit:I

    int-to-long v9, v7

    invoke-direct {v5, v9, v10}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v7, 0x195

    invoke-direct {v2, v3, v7, v5}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_b
    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    sget-object v5, Lcom/android/internal/org/bouncycastle/asn1/DERNull;->INSTANCE:Lcom/android/internal/org/bouncycastle/asn1/DERNull;

    const/16 v7, 0x1f7

    invoke-direct {v2, v3, v7, v5}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v5, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    invoke-direct {v5, v9, v10}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v7, 0x2bd

    invoke-direct {v2, v3, v7, v5}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v5, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    const-wide/16 v9, 0x0

    invoke-direct {v5, v9, v10}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v7, 0x2be

    invoke-direct {v2, v3, v7, v5}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v5, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;

    const/4 v7, 0x4

    new-array v7, v7, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    new-instance v9, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    invoke-static {}, Lio/lti/KeyboxUtils;->getVerifiedBootKey()[B

    move-result-object v10

    invoke-direct {v9, v10}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    const/4 v10, 0x0

    aput-object v9, v7, v10

    sget-object v9, Lcom/android/internal/org/bouncycastle/asn1/ASN1Boolean;->TRUE:Lcom/android/internal/org/bouncycastle/asn1/ASN1Boolean;

    aput-object v9, v7, v3

    new-instance v9, Lcom/android/internal/org/bouncycastle/asn1/ASN1Enumerated;

    invoke-direct {v9, v10}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Enumerated;-><init>(I)V

    aput-object v9, v7, v4

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    invoke-static {}, Lio/lti/KeyboxUtils;->getVerifiedBootHash()[B

    move-result-object v9

    invoke-direct {v4, v9}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    aput-object v4, v7, v6

    invoke-direct {v5, v7}, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    const/16 v4, 0x2c0

    invoke-direct {v2, v3, v4, v5}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    invoke-static {}, Lio/lti/KeyboxUtils;->getOSVersion()I

    move-result v5

    int-to-long v5, v5

    invoke-direct {v4, v5, v6}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v5, 0x2c1

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    invoke-static {v10}, Lio/lti/KeyboxUtils;->getSecurityPatchLevel(Z)I

    move-result v5

    int-to-long v5, v5

    invoke-direct {v4, v5, v6}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v5, 0x2c2

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    invoke-static {}, Lio/lti/KeyboxChainGenerator;->createApplicationId()Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    move-result-object v4

    const/16 v5, 0x2c5

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->brand:[B

    if-eqz v2, :cond_c

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    iget-object v5, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->brand:[B

    invoke-direct {v4, v5}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    const/16 v5, 0x2c6

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_c
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->device:[B

    if-eqz v2, :cond_d

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    iget-object v5, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->device:[B

    invoke-direct {v4, v5}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    const/16 v5, 0x2c7

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_d
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->product:[B

    if-eqz v2, :cond_e

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    iget-object v5, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->product:[B

    invoke-direct {v4, v5}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    const/16 v5, 0x2c8

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_e
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->manufacturer:[B

    if-eqz v2, :cond_f

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    iget-object v5, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->manufacturer:[B

    invoke-direct {v4, v5}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    const/16 v5, 0x2cc

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_f
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->model:[B

    if-eqz v2, :cond_10

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    iget-object v5, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->model:[B

    invoke-direct {v4, v5}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    const/16 v5, 0x2cd

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_10
    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    invoke-static {v3}, Lio/lti/KeyboxUtils;->getSecurityPatchLevel(Z)I

    move-result v5

    int-to-long v5, v5

    invoke-direct {v4, v5, v6}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v5, 0x2ce

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    invoke-static {v3}, Lio/lti/KeyboxUtils;->getSecurityPatchLevel(Z)I

    move-result v5

    int-to-long v5, v5

    invoke-direct {v4, v5, v6}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    const/16 v5, 0x2cf

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static {}, Lio/lti/KeyboxUtils;->getAttestationVersion()I

    move-result v2

    if-lt v2, v8, :cond_11

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    invoke-static {}, Lio/lti/KeyboxUtils;->getModuleHash()[B

    move-result-object v5

    invoke-direct {v4, v5}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    const/16 v5, 0x2d4

    invoke-direct {v2, v3, v5, v4}, Lcom/android/internal/org/bouncycastle/asn1/DERTaggedObject;-><init>(ZILcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_11
    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/x509/Extension;

    new-instance v3, Lcom/android/internal/org/bouncycastle/asn1/ASN1ObjectIdentifier;

    const-string v4, "1.3.6.1.4.1.11129.2.1.17"

    invoke-direct {v3, v4}, Lcom/android/internal/org/bouncycastle/asn1/ASN1ObjectIdentifier;-><init>(Ljava/lang/String;)V

    new-array v4, v10, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    invoke-interface {v0, v4}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    new-array v4, v10, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    invoke-interface {v1, v4}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    invoke-static {v0, v1, p0, p1}, Lio/lti/KeyboxChainGenerator;->getAsn1OctetString([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;[Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;Lio/lti/KeyboxChainGenerator$KeyGenParameters;I)Lcom/android/internal/org/bouncycastle/asn1/ASN1OctetString;

    move-result-object p0

    invoke-direct {v2, v3, v10, p0}, Lcom/android/internal/org/bouncycastle/asn1/x509/Extension;-><init>(Lcom/android/internal/org/bouncycastle/asn1/ASN1ObjectIdentifier;ZLcom/android/internal/org/bouncycastle/asn1/ASN1OctetString;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v2

    :catchall_0
    move-exception p0

    const-string p1, "KeyboxChainGenerator"

    invoke-static {p0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p0, 0x0

    return-object p0
.end method

.method private static blacklist fromIntList(Ljava/util/List;)[Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;)[",
            "Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;"
        }
    .end annotation

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    const/4 v1, 0x0

    :goto_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_0

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    int-to-long v3, v3

    invoke-direct {v2, v3, v4}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method static blacklist generateCertChain(Ljava/security/KeyPair;Landroid/system/keystore2/KeyDescriptor;Lio/lti/KeyboxChainGenerator$KeyGenParameters;I)Ljava/util/List;
    .locals 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/security/KeyPair;",
            "Landroid/system/keystore2/KeyDescriptor;",
            "Lio/lti/KeyboxChainGenerator$KeyGenParameters;",
            "I)",
            "Ljava/util/List<",
            "Ljava/security/cert/Certificate;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p2

    move/from16 v1, p3

    iget-object v2, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->attestationChallenge:[B

    const/4 v3, 0x0

    const/4 v4, 0x1

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    if-eqz v2, :cond_0

    iget-object v2, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->attestationChallenge:[B

    array-length v2, v2

    if-eqz v2, :cond_0

    move v2, v4

    goto :goto_0

    :cond_0
    move v2, v3

    :goto_0
    if-eqz p1, :cond_1

    move v3, v4

    :cond_1
    const/4 v6, 0x0

    if-nez v2, :cond_2

    if-eqz v3, :cond_2

    return-object v6

    :cond_2
    iget-object v7, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSubject:Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    if-nez v7, :cond_3

    new-instance v7, Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    const-string v8, "CN=Android Keystore Key"

    invoke-static {}, Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;->getDefaultStyle()Lcom/android/internal/org/bouncycastle/asn1/x500/X500NameStyle;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/android/internal/org/bouncycastle/asn1/x500/style/IETFUtils;->rDNsFromString(Ljava/lang/String;Lcom/android/internal/org/bouncycastle/asn1/x500/X500NameStyle;)[Lcom/android/internal/org/bouncycastle/asn1/x500/RDN;

    move-result-object v8

    invoke-direct {v7, v8}, Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;-><init>([Lcom/android/internal/org/bouncycastle/asn1/x500/RDN;)V

    iput-object v7, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSubject:Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    :cond_3
    iget-object v7, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSerial:Ljava/math/BigInteger;

    if-nez v7, :cond_4

    sget-object v7, Ljava/math/BigInteger;->ONE:Ljava/math/BigInteger;

    iput-object v7, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSerial:Ljava/math/BigInteger;

    :cond_4
    iget-object v7, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotBefore:Ljava/util/Date;

    if-nez v7, :cond_6

    new-instance v7, Ljava/util/Date;

    if-ne v1, v4, :cond_5

    const-wide/16 v8, 0x0

    goto :goto_1

    :cond_5
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    :goto_1
    invoke-direct {v7, v8, v9}, Ljava/util/Date;-><init>(J)V

    iput-object v7, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotBefore:Ljava/util/Date;

    :cond_6
    iget-object v7, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotAfter:Ljava/util/Date;

    if-nez v7, :cond_8

    if-ne v1, v4, :cond_7

    const/16 v12, 0x1c

    const/16 v13, 0xf

    const/16 v8, 0x83a

    const/4 v9, 0x2

    const/4 v10, 0x7

    const/4 v11, 0x6

    invoke-static/range {v8 .. v13}, Ljava/time/LocalDateTime;->of(IIIIII)Ljava/time/LocalDateTime;

    move-result-object v7

    sget-object v8, Ljava/time/ZoneOffset;->UTC:Ljava/time/ZoneOffset;

    invoke-virtual {v7, v8}, Ljava/time/LocalDateTime;->toInstant(Ljava/time/ZoneOffset;)Ljava/time/Instant;

    move-result-object v7

    goto :goto_2

    :cond_7
    const/16 v12, 0x3b

    const/16 v13, 0x3b

    const/16 v8, 0x7ec

    const/4 v9, 0x5

    const/16 v10, 0x17

    const/16 v11, 0x17

    invoke-static/range {v8 .. v13}, Ljava/time/LocalDateTime;->of(IIIIII)Ljava/time/LocalDateTime;

    move-result-object v7

    sget-object v8, Ljava/time/ZoneOffset;->UTC:Ljava/time/ZoneOffset;

    invoke-virtual {v7, v8}, Ljava/time/LocalDateTime;->toInstant(Ljava/time/ZoneOffset;)Ljava/time/Instant;

    move-result-object v7

    :goto_2
    invoke-static {v7}, Ljava/util/Date;->from(Ljava/time/Instant;)Ljava/util/Date;

    move-result-object v7

    iput-object v7, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotAfter:Ljava/util/Date;

    :cond_8
    const-string v7, "RSA"

    const-string v8, "EC"

    if-eqz v2, :cond_b

    if-eqz v3, :cond_9

    :try_start_0
    new-instance v9, Lcom/android/internal/org/bouncycastle/cert/X509CertificateHolder;

    invoke-static/range {p1 .. p1}, Lio/lti/KeyboxUtils;->fetchKeyData(Landroid/system/keystore2/KeyDescriptor;)Landroid/util/Pair;

    move-result-object v10

    iget-object v10, v10, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v10, Landroid/system/keystore2/KeyMetadata;

    iget-object v10, v10, Landroid/system/keystore2/KeyMetadata;->certificate:[B

    invoke-direct {v9, v10}, Lcom/android/internal/org/bouncycastle/cert/X509CertificateHolder;-><init>([B)V

    invoke-virtual {v9}, Lcom/android/internal/org/bouncycastle/cert/X509CertificateHolder;->getSubject()Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    move-result-object v9

    goto :goto_4

    :cond_9
    iget v9, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v9, v5}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_a

    move-object v9, v7

    goto :goto_3

    :cond_a
    move-object v9, v8

    :goto_3
    invoke-static {v9}, Lio/lti/KeyboxUtils;->fetchCertificateHolderFromKeybox(Ljava/lang/String;)Lcom/android/internal/org/bouncycastle/cert/X509CertificateHolder;

    move-result-object v9

    invoke-virtual {v9}, Lcom/android/internal/org/bouncycastle/cert/X509CertificateHolder;->getSubject()Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    move-result-object v9

    goto :goto_4

    :cond_b
    iget-object v9, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSubject:Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    :goto_4
    move-object v11, v9

    new-instance v10, Lcom/android/internal/org/bouncycastle/cert/X509v3CertificateBuilder;

    iget-object v12, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSerial:Ljava/math/BigInteger;

    new-instance v13, Lcom/android/internal/org/bouncycastle/asn1/x509/Time;

    iget-object v9, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotBefore:Ljava/util/Date;

    invoke-direct {v13, v9}, Lcom/android/internal/org/bouncycastle/asn1/x509/Time;-><init>(Ljava/util/Date;)V

    new-instance v14, Lcom/android/internal/org/bouncycastle/asn1/x509/Time;

    iget-object v9, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotAfter:Ljava/util/Date;

    invoke-direct {v14, v9}, Lcom/android/internal/org/bouncycastle/asn1/x509/Time;-><init>(Ljava/util/Date;)V

    iget-object v15, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSubject:Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    invoke-virtual/range {p0 .. p0}, Ljava/security/KeyPair;->getPublic()Ljava/security/PublicKey;

    move-result-object v9

    invoke-interface {v9}, Ljava/security/PublicKey;->getEncoded()[B

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/org/bouncycastle/asn1/x509/SubjectPublicKeyInfo;->getInstance(Ljava/lang/Object;)Lcom/android/internal/org/bouncycastle/asn1/x509/SubjectPublicKeyInfo;

    move-result-object v16

    invoke-direct/range {v10 .. v16}, Lcom/android/internal/org/bouncycastle/cert/X509v3CertificateBuilder;-><init>(Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;Ljava/math/BigInteger;Lcom/android/internal/org/bouncycastle/asn1/x509/Time;Lcom/android/internal/org/bouncycastle/asn1/x509/Time;Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;Lcom/android/internal/org/bouncycastle/asn1/x509/SubjectPublicKeyInfo;)V

    if-eqz v2, :cond_c

    invoke-static/range {p2 .. p3}, Lio/lti/KeyboxChainGenerator;->createExtension(Lio/lti/KeyboxChainGenerator$KeyGenParameters;I)Lcom/android/internal/org/bouncycastle/asn1/x509/Extension;

    move-result-object v1

    invoke-virtual {v10, v1}, Lcom/android/internal/org/bouncycastle/cert/X509v3CertificateBuilder;->addExtension(Lcom/android/internal/org/bouncycastle/asn1/x509/Extension;)Lcom/android/internal/org/bouncycastle/cert/X509v3CertificateBuilder;

    :cond_c
    sget-object v1, Lcom/android/internal/org/bouncycastle/asn1/x509/Extension;->keyUsage:Lcom/android/internal/org/bouncycastle/asn1/ASN1ObjectIdentifier;

    new-instance v9, Lcom/android/internal/org/bouncycastle/asn1/x509/KeyUsage;

    invoke-static {v0}, Lio/lti/KeyboxUtils;->getKeyUsage(Lio/lti/KeyboxChainGenerator$KeyGenParameters;)I

    move-result v11

    invoke-direct {v9, v11}, Lcom/android/internal/org/bouncycastle/asn1/x509/KeyUsage;-><init>(I)V

    invoke-virtual {v10, v1, v4, v9}, Lcom/android/internal/org/bouncycastle/cert/X509v3CertificateBuilder;->addExtension(Lcom/android/internal/org/bouncycastle/asn1/ASN1ObjectIdentifier;ZLcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)Lcom/android/internal/org/bouncycastle/cert/X509v3CertificateBuilder;

    iget v0, v0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v0, v5}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_f

    new-instance v0, Lcom/android/internal/org/bouncycastle/operator/jcajce/JcaContentSignerBuilder;

    const-string v1, "SHA256withRSA"

    invoke-direct {v0, v1}, Lcom/android/internal/org/bouncycastle/operator/jcajce/JcaContentSignerBuilder;-><init>(Ljava/lang/String;)V

    if-nez v2, :cond_d

    invoke-virtual/range {p0 .. p0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v1

    goto :goto_5

    :cond_d
    if-eqz v3, :cond_e

    invoke-static/range {p1 .. p1}, Lio/lti/KeyboxUtils;->fetchKeyData(Landroid/system/keystore2/KeyDescriptor;)Landroid/util/Pair;

    move-result-object v1

    iget-object v1, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v1, Ljava/security/KeyPair;

    invoke-virtual {v1}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v1

    goto :goto_5

    :cond_e
    invoke-static {v7}, Lio/lti/KeyboxUtils;->fetchPrivateKeyFromKeybox(Ljava/lang/String;)Ljava/security/PrivateKey;

    move-result-object v1

    :goto_5
    invoke-virtual {v0, v1}, Lcom/android/internal/org/bouncycastle/operator/jcajce/JcaContentSignerBuilder;->build(Ljava/security/PrivateKey;)Lcom/android/internal/org/bouncycastle/operator/ContentSigner;

    move-result-object v0

    goto :goto_7

    :cond_f
    new-instance v0, Lcom/android/internal/org/bouncycastle/operator/jcajce/JcaContentSignerBuilder;

    const-string v1, "SHA256withECDSA"

    invoke-direct {v0, v1}, Lcom/android/internal/org/bouncycastle/operator/jcajce/JcaContentSignerBuilder;-><init>(Ljava/lang/String;)V

    if-nez v2, :cond_10

    invoke-virtual/range {p0 .. p0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v1

    goto :goto_6

    :cond_10
    if-eqz v3, :cond_11

    invoke-static/range {p1 .. p1}, Lio/lti/KeyboxUtils;->fetchKeyData(Landroid/system/keystore2/KeyDescriptor;)Landroid/util/Pair;

    move-result-object v1

    iget-object v1, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v1, Ljava/security/KeyPair;

    invoke-virtual {v1}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v1

    goto :goto_6

    :cond_11
    invoke-static {v8}, Lio/lti/KeyboxUtils;->fetchPrivateKeyFromKeybox(Ljava/lang/String;)Ljava/security/PrivateKey;

    move-result-object v1

    :goto_6
    invoke-virtual {v0, v1}, Lcom/android/internal/org/bouncycastle/operator/jcajce/JcaContentSignerBuilder;->build(Ljava/security/PrivateKey;)Lcom/android/internal/org/bouncycastle/operator/ContentSigner;

    move-result-object v0

    :goto_7
    invoke-virtual {v10, v0}, Lcom/android/internal/org/bouncycastle/cert/X509v3CertificateBuilder;->build(Lcom/android/internal/org/bouncycastle/operator/ContentSigner;)Lcom/android/internal/org/bouncycastle/cert/X509CertificateHolder;

    move-result-object v0

    invoke-static {v0}, Lio/lti/KeyboxUtils;->getCertificateFromHolder(Lcom/android/internal/org/bouncycastle/cert/X509CertificateHolder;)Ljava/security/cert/X509Certificate;

    move-result-object v0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    if-eqz v2, :cond_12

    if-nez v3, :cond_12

    invoke-virtual {v0}, Ljava/security/cert/Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v0

    invoke-interface {v0}, Ljava/security/PublicKey;->getAlgorithm()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lio/lti/KeyboxUtils;->fetchCertificateChainFromKeybox(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_12
    return-object v1

    :catchall_0
    move-exception v0

    const-string v1, "KeyboxChainGenerator"

    invoke-static {v0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v6
.end method

.method private static blacklist getAsn1OctetString([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;[Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;Lio/lti/KeyboxChainGenerator$KeyGenParameters;I)Lcom/android/internal/org/bouncycastle/asn1/ASN1OctetString;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    new-instance v0, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    invoke-static {}, Lio/lti/KeyboxUtils;->getAttestationVersion()I

    move-result v1

    int-to-long v1, v1

    invoke-direct {v0, v1, v2}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    new-instance v1, Lcom/android/internal/org/bouncycastle/asn1/ASN1Enumerated;

    invoke-direct {v1, p3}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Enumerated;-><init>(I)V

    new-instance v2, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;

    invoke-static {}, Lio/lti/KeyboxUtils;->getKeymasterVersion()I

    move-result v3

    int-to-long v3, v3

    invoke-direct {v2, v3, v4}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Integer;-><init>(J)V

    new-instance v3, Lcom/android/internal/org/bouncycastle/asn1/ASN1Enumerated;

    invoke-direct {v3, p3}, Lcom/android/internal/org/bouncycastle/asn1/ASN1Enumerated;-><init>(I)V

    new-instance p3, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    iget-object p2, p2, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->attestationChallenge:[B

    invoke-direct {p3, p2}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    new-instance p2, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    const-string v4, ""

    invoke-virtual {v4}, Ljava/lang/String;->getBytes()[B

    move-result-object v4

    invoke-direct {p2, v4}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>([B)V

    new-instance v4, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;

    invoke-direct {v4, p1}, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    new-instance p1, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;

    invoke-direct {p1, p0}, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    new-instance p0, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;

    new-instance v5, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;

    const/16 v6, 0x8

    new-array v6, v6, [Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    const/4 v7, 0x0

    aput-object v0, v6, v7

    const/4 v0, 0x1

    aput-object v1, v6, v0

    const/4 v0, 0x2

    aput-object v2, v6, v0

    const/4 v0, 0x3

    aput-object v3, v6, v0

    const/4 v0, 0x4

    aput-object p3, v6, v0

    const/4 p3, 0x5

    aput-object p2, v6, p3

    const/4 p2, 0x6

    aput-object v4, v6, p2

    const/4 p2, 0x7

    aput-object p1, v6, p2

    invoke-direct {v5, v6}, Lcom/android/internal/org/bouncycastle/asn1/DERSequence;-><init>([Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    invoke-direct {p0, v5}, Lcom/android/internal/org/bouncycastle/asn1/DEROctetString;-><init>(Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;)V

    return-object p0
.end method
