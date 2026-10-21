.class final Lio/lti/KeyboxChainGenerator$KeyGenParameters;
.super Ljava/lang/Object;
.source "KeyboxChainGenerator.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/lti/KeyboxChainGenerator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "KeyGenParameters"
.end annotation


# instance fields
.field public blacklist activeDateTime:Ljava/util/Date;

.field public blacklist algorithm:I

.field public blacklist attestationChallenge:[B

.field public blacklist brand:[B

.field public blacklist certificateNotAfter:Ljava/util/Date;

.field public blacklist certificateNotBefore:Ljava/util/Date;

.field public blacklist certificateSerial:Ljava/math/BigInteger;

.field public blacklist certificateSubject:Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

.field public blacklist device:[B

.field public blacklist digest:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field public blacklist ecCurve:I

.field public blacklist ecCurveName:Ljava/lang/String;

.field public blacklist keySize:I

.field public blacklist manufacturer:[B

.field public blacklist mgfDigest:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field public blacklist model:[B

.field public blacklist originationExpireDateTime:Ljava/util/Date;

.field public blacklist padding:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field public blacklist product:[B

.field public blacklist purpose:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field public blacklist rsaPublicExponent:Ljava/math/BigInteger;

.field public blacklist usageCountLimit:I

.field public blacklist usageExpireDateTime:Ljava/util/Date;


# direct methods
.method constructor blacklist <init>([Landroid/hardware/security/keymint/KeyParameter;)V
    .locals 7

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->keySize:I

    iput v0, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    const/4 v1, 0x0

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSerial:Ljava/math/BigInteger;

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotBefore:Ljava/util/Date;

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotAfter:Ljava/util/Date;

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSubject:Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->activeDateTime:Ljava/util/Date;

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->originationExpireDateTime:Ljava/util/Date;

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageExpireDateTime:Ljava/util/Date;

    iput v0, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageCountLimit:I

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->rsaPublicExponent:Ljava/math/BigInteger;

    iput v0, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->ecCurve:I

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->ecCurveName:Ljava/lang/String;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->digest:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->padding:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->mgfDigest:Ljava/util/List;

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->attestationChallenge:[B

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->brand:[B

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->device:[B

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->product:[B

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->manufacturer:[B

    iput-object v1, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->model:[B

    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    iget-object v3, v2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iget v2, v2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    sparse-switch v2, :sswitch_data_0

    goto/16 :goto_1

    :sswitch_0
    new-instance v2, Ljava/util/Date;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getDateTime()J

    move-result-wide v3

    invoke-direct {v2, v3, v4}, Ljava/util/Date;-><init>(J)V

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotAfter:Ljava/util/Date;

    goto/16 :goto_1

    :sswitch_1
    new-instance v2, Ljava/util/Date;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getDateTime()J

    move-result-wide v3

    invoke-direct {v2, v3, v4}, Ljava/util/Date;-><init>(J)V

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateNotBefore:Ljava/util/Date;

    goto/16 :goto_1

    :sswitch_2
    new-instance v2, Ljava/util/Date;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getDateTime()J

    move-result-wide v3

    invoke-direct {v2, v3, v4}, Ljava/util/Date;-><init>(J)V

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageExpireDateTime:Ljava/util/Date;

    goto/16 :goto_1

    :sswitch_3
    new-instance v2, Ljava/util/Date;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getDateTime()J

    move-result-wide v3

    invoke-direct {v2, v3, v4}, Ljava/util/Date;-><init>(J)V

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->originationExpireDateTime:Ljava/util/Date;

    goto/16 :goto_1

    :sswitch_4
    new-instance v2, Ljava/util/Date;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getDateTime()J

    move-result-wide v3

    invoke-direct {v2, v3, v4}, Ljava/util/Date;-><init>(J)V

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->activeDateTime:Ljava/util/Date;

    goto/16 :goto_1

    :sswitch_5
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getLongInteger()J

    move-result-wide v2

    const-wide v4, 0x7fffffffffffffffL

    and-long/2addr v4, v2

    invoke-static {v4, v5}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v4

    const-wide/16 v5, 0x0

    cmp-long v2, v2, v5

    if-gez v2, :cond_0

    const/16 v2, 0x3f

    invoke-virtual {v4, v2}, Ljava/math/BigInteger;->setBit(I)Ljava/math/BigInteger;

    move-result-object v4

    :cond_0
    iput-object v4, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->rsaPublicExponent:Ljava/math/BigInteger;

    goto/16 :goto_1

    :sswitch_6
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getInteger()I

    move-result v2

    iput v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageCountLimit:I

    goto/16 :goto_1

    :sswitch_7
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getInteger()I

    move-result v2

    iput v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->keySize:I

    goto/16 :goto_1

    :sswitch_8
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->mgfDigest:Ljava/util/List;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getDigest()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_1

    :sswitch_9
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->padding:Ljava/util/List;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getPaddingMode()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_1

    :sswitch_a
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->digest:Ljava/util/List;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getDigest()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :sswitch_b
    iget-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getKeyPurpose()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :sswitch_c
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getEcCurve()I

    move-result v2

    iput v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->ecCurve:I

    invoke-static {v2}, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->getEcCurveName(I)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->ecCurveName:Ljava/lang/String;

    goto :goto_1

    :sswitch_d
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getAlgorithm()I

    move-result v2

    iput v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    goto :goto_1

    :sswitch_e
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getBlob()[B

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;->getInstance(Ljava/lang/Object;)Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    move-result-object v2

    invoke-static {v2}, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->getCertificateSubject(Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;)Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    move-result-object v2

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSubject:Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    goto :goto_1

    :sswitch_f
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getBlob()[B

    move-result-object v2

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->model:[B

    goto :goto_1

    :sswitch_10
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getBlob()[B

    move-result-object v2

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->manufacturer:[B

    goto :goto_1

    :sswitch_11
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getBlob()[B

    move-result-object v2

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->product:[B

    goto :goto_1

    :sswitch_12
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getBlob()[B

    move-result-object v2

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->device:[B

    goto :goto_1

    :sswitch_13
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getBlob()[B

    move-result-object v2

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->brand:[B

    goto :goto_1

    :sswitch_14
    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getBlob()[B

    move-result-object v2

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->attestationChallenge:[B

    goto :goto_1

    :sswitch_15
    new-instance v2, Ljava/math/BigInteger;

    invoke-virtual {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->getBlob()[B

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/math/BigInteger;-><init>([B)V

    iput-object v2, p0, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->certificateSerial:Ljava/math/BigInteger;

    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_0

    :cond_1
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x7ffffc12 -> :sswitch_15
        -0x6ffffd3c -> :sswitch_14
        -0x6ffffd3a -> :sswitch_13
        -0x6ffffd39 -> :sswitch_12
        -0x6ffffd38 -> :sswitch_11
        -0x6ffffd34 -> :sswitch_10
        -0x6ffffd33 -> :sswitch_f
        -0x6ffffc11 -> :sswitch_e
        0x10000002 -> :sswitch_d
        0x1000000a -> :sswitch_c
        0x20000001 -> :sswitch_b
        0x20000005 -> :sswitch_a
        0x20000006 -> :sswitch_9
        0x200000cb -> :sswitch_8
        0x30000003 -> :sswitch_7
        0x30000195 -> :sswitch_6
        0x500000c8 -> :sswitch_5
        0x60000190 -> :sswitch_4
        0x60000191 -> :sswitch_3
        0x60000192 -> :sswitch_2
        0x600003f0 -> :sswitch_1
        0x600003f1 -> :sswitch_0
    .end sparse-switch
.end method

.method private static blacklist getCertificateSubject(Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;)Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;
    .locals 9

    invoke-static {}, Lio/lti/KeyboxUtils;->getKeymasterVersion()I

    move-result v0

    const/16 v1, 0x64

    if-lt v0, v1, :cond_0

    return-object p0

    :cond_0
    new-instance v0, Lcom/android/internal/org/bouncycastle/asn1/x500/X500NameBuilder;

    invoke-direct {v0}, Lcom/android/internal/org/bouncycastle/asn1/x500/X500NameBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;->getRDNs()[Lcom/android/internal/org/bouncycastle/asn1/x500/RDN;

    move-result-object p0

    array-length v1, p0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_2

    aget-object v4, p0, v3

    invoke-virtual {v4}, Lcom/android/internal/org/bouncycastle/asn1/x500/RDN;->getTypesAndValues()[Lcom/android/internal/org/bouncycastle/asn1/x500/AttributeTypeAndValue;

    move-result-object v4

    array-length v5, v4

    move v6, v2

    :goto_1
    if-ge v6, v5, :cond_1

    aget-object v7, v4, v6

    invoke-virtual {v7}, Lcom/android/internal/org/bouncycastle/asn1/x500/AttributeTypeAndValue;->getType()Lcom/android/internal/org/bouncycastle/asn1/ASN1ObjectIdentifier;

    move-result-object v8

    invoke-virtual {v7}, Lcom/android/internal/org/bouncycastle/asn1/x500/AttributeTypeAndValue;->getValue()Lcom/android/internal/org/bouncycastle/asn1/ASN1Encodable;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v8, v7}, Lcom/android/internal/org/bouncycastle/asn1/x500/X500NameBuilder;->addRDN(Lcom/android/internal/org/bouncycastle/asn1/ASN1ObjectIdentifier;Ljava/lang/String;)Lcom/android/internal/org/bouncycastle/asn1/x500/X500NameBuilder;

    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    invoke-virtual {v0}, Lcom/android/internal/org/bouncycastle/asn1/x500/X500NameBuilder;->build()Lcom/android/internal/org/bouncycastle/asn1/x500/X500Name;

    move-result-object p0

    return-object p0
.end method

.method private static blacklist getEcCurveName(I)Ljava/lang/String;
    .locals 3

    if-eqz p0, :cond_4

    const/4 v0, 0x1

    if-eq p0, v0, :cond_3

    const/4 v0, 0x2

    if-eq p0, v0, :cond_2

    const/4 v0, 0x3

    if-eq p0, v0, :cond_1

    const/4 v0, 0x4

    if-ne p0, v0, :cond_0

    const-string p0, "CURVE_25519"

    return-object p0

    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Unknown EC curve type: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    const-string p0, "secp521r1"

    return-object p0

    :cond_2
    const-string p0, "secp384r1"

    return-object p0

    :cond_3
    const-string p0, "secp256r1"

    return-object p0

    :cond_4
    const-string p0, "secp224r1"

    return-object p0
.end method
