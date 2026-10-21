.class public final Lio/lti/KeyboxImitationHooks;
.super Ljava/lang/Object;
.source "KeyboxImitationHooks.java"


# static fields
.field private static final blacklist DEBUG:Z = false

.field private static final blacklist TAG:Ljava/lang/String; = "KeyboxImitationHooks"

.field private static blacklist sSecurityLevel:Landroid/system/keystore2/IKeystoreSecurityLevel; = null

.field private static blacklist sSecurityLevelType:I = 0x1


# direct methods
.method private constructor blacklist <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static blacklist buildMetadata(Ljava/util/List;Lio/lti/KeyboxChainGenerator$KeyGenParameters;Landroid/system/keystore2/KeyDescriptor;II)Landroid/system/keystore2/KeyMetadata;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/security/cert/Certificate;",
            ">;",
            "Lio/lti/KeyboxChainGenerator$KeyGenParameters;",
            "Landroid/system/keystore2/KeyDescriptor;",
            "II)",
            "Landroid/system/keystore2/KeyMetadata;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Landroid/system/keystore2/KeyMetadata;

    invoke-direct {v0}, Landroid/system/keystore2/KeyMetadata;-><init>()V

    const/4 v1, 0x0

    if-eqz p0, :cond_0

    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    new-array v2, v1, [Ljava/security/cert/Certificate;

    invoke-interface {p0, v2}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [Ljava/security/cert/Certificate;

    invoke-static {v0, p0}, Lio/lti/KeyboxUtils;->putCertificateChain(Landroid/system/keystore2/KeyMetadata;[Ljava/security/cert/Certificate;)V

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iput-wide v2, v0, Landroid/system/keystore2/KeyMetadata;->modificationTimeMs:J

    iput p3, v0, Landroid/system/keystore2/KeyMetadata;->keySecurityLevel:I

    new-instance p0, Landroid/system/keystore2/KeyDescriptor;

    invoke-direct {p0}, Landroid/system/keystore2/KeyDescriptor;-><init>()V

    const/4 v2, 0x4

    iput v2, p0, Landroid/system/keystore2/KeyDescriptor;->domain:I

    iget-object p2, p2, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    invoke-virtual {p2}, Ljava/lang/String;->hashCode()I

    move-result p2

    int-to-long v2, p2

    iput-wide v2, p0, Landroid/system/keystore2/KeyDescriptor;->nspace:J

    iput-object p0, v0, Landroid/system/keystore2/KeyMetadata;->key:Landroid/system/keystore2/KeyDescriptor;

    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    iget-object p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    new-instance v3, Landroid/system/keystore2/Authorization;

    invoke-direct {v3}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v4, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v4}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v4, v3, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v4, v3, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v5, 0x20000001

    iput v5, v4, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v4, v3, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-static {v2}, Landroid/hardware/security/keymint/KeyParameterValue;->keyPurpose(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v2

    iput-object v2, v4, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, v3, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    const/4 v2, -0x1

    if-eq p2, v2, :cond_2

    new-instance p2, Landroid/system/keystore2/Authorization;

    invoke-direct {p2}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v3, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v3}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v4, 0x10000002

    iput v4, v3, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget v4, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    invoke-static {v4}, Landroid/hardware/security/keymint/KeyParameterValue;->algorithm(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v4

    iput-object v4, v3, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p2, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    iget p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->keySize:I

    if-eq p2, v2, :cond_3

    new-instance p2, Landroid/system/keystore2/Authorization;

    invoke-direct {p2}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v3, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v3}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v4, 0x30000003

    iput v4, v3, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget v4, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->keySize:I

    invoke-static {v4}, Landroid/hardware/security/keymint/KeyParameterValue;->integer(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v4

    iput-object v4, v3, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p2, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    iget-object p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->digest:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_1
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    new-instance v4, Landroid/system/keystore2/Authorization;

    invoke-direct {v4}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v5, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v5}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v5, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v5, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v6, 0x20000005

    iput v6, v5, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v5, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-static {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->digest(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v3

    iput-object v3, v5, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, v4, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_4
    iget-object p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->mgfDigest:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_2
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_5

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    new-instance v4, Landroid/system/keystore2/Authorization;

    invoke-direct {v4}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v5, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v5}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v5, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v5, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v6, 0x200000cb

    iput v6, v5, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v5, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-static {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->digest(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v3

    iput-object v3, v5, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, v4, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_5
    iget-object p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->padding:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_3
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_6

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    new-instance v4, Landroid/system/keystore2/Authorization;

    invoke-direct {v4}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v5, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v5}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v5, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v5, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v6, 0x20000006

    iput v6, v5, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v5, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-static {v3}, Landroid/hardware/security/keymint/KeyParameterValue;->paddingMode(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v3

    iput-object v3, v5, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, v4, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_6
    iget p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->ecCurve:I

    if-eq p2, v2, :cond_7

    new-instance p2, Landroid/system/keystore2/Authorization;

    invoke-direct {p2}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v3, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v3}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v4, 0x1000000a

    iput v4, v3, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget v4, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->ecCurve:I

    invoke-static {v4}, Landroid/hardware/security/keymint/KeyParameterValue;->ecCurve(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v4

    iput-object v4, v3, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p2, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_7
    iget-object p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->rsaPublicExponent:Ljava/math/BigInteger;

    if-eqz p2, :cond_8

    new-instance p2, Landroid/system/keystore2/Authorization;

    invoke-direct {p2}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v3, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v3}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v4, 0x500000c8

    iput v4, v3, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v4, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->rsaPublicExponent:Ljava/math/BigInteger;

    invoke-virtual {v4}, Ljava/math/BigInteger;->longValue()J

    move-result-wide v4

    invoke-static {v4, v5}, Landroid/hardware/security/keymint/KeyParameterValue;->longInteger(J)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v4

    iput-object v4, v3, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p2, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_8
    iget-object p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->activeDateTime:Ljava/util/Date;

    if-eqz p2, :cond_9

    new-instance p2, Landroid/system/keystore2/Authorization;

    invoke-direct {p2}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v3, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v3}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v4, 0x60000190

    iput v4, v3, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v4, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->activeDateTime:Ljava/util/Date;

    invoke-virtual {v4}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    invoke-static {v4, v5}, Landroid/hardware/security/keymint/KeyParameterValue;->dateTime(J)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v4

    iput-object v4, v3, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p2, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_9
    iget-object p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->originationExpireDateTime:Ljava/util/Date;

    if-eqz p2, :cond_a

    new-instance p2, Landroid/system/keystore2/Authorization;

    invoke-direct {p2}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v3, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v3}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v4, 0x60000191

    iput v4, v3, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v4, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->originationExpireDateTime:Ljava/util/Date;

    invoke-virtual {v4}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    invoke-static {v4, v5}, Landroid/hardware/security/keymint/KeyParameterValue;->dateTime(J)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v4

    iput-object v4, v3, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p2, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_a
    iget-object p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageExpireDateTime:Ljava/util/Date;

    if-eqz p2, :cond_b

    new-instance p2, Landroid/system/keystore2/Authorization;

    invoke-direct {p2}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v3, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v3}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v4, 0x60000192

    iput v4, v3, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v3, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v4, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageExpireDateTime:Ljava/util/Date;

    invoke-virtual {v4}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    invoke-static {v4, v5}, Landroid/hardware/security/keymint/KeyParameterValue;->dateTime(J)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v4

    iput-object v4, v3, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p2, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_b
    invoke-static {}, Lio/lti/KeyboxUtils;->getAttestationVersion()I

    move-result p2

    const/16 v3, 0x64

    if-lt p2, v3, :cond_c

    iget p2, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageCountLimit:I

    if-eq p2, v2, :cond_c

    new-instance p2, Landroid/system/keystore2/Authorization;

    invoke-direct {p2}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance v2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {v2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object v2, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v2, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v3, 0x30000195

    iput v3, v2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object v2, p2, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget p1, p1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->usageCountLimit:I

    invoke-static {p1}, Landroid/hardware/security/keymint/KeyParameterValue;->integer(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object p1

    iput-object p1, v2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p2, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_c
    new-instance p1, Landroid/system/keystore2/Authorization;

    invoke-direct {p1}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance p2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {p2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v2, 0x700001f7

    iput v2, p2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const/4 v2, 0x1

    invoke-static {v2}, Landroid/hardware/security/keymint/KeyParameterValue;->boolValue(Z)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v3

    iput-object v3, p2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p1, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p1, Landroid/system/keystore2/Authorization;

    invoke-direct {p1}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance p2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {p2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v3, 0x600002bd

    iput v3, p2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-static {v3, v4}, Landroid/hardware/security/keymint/KeyParameterValue;->dateTime(J)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object v3

    iput-object v3, p2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p1, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p1, Landroid/system/keystore2/Authorization;

    invoke-direct {p1}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance p2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {p2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const v3, 0x100002be

    iput v3, p2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-static {p4}, Landroid/hardware/security/keymint/KeyParameterValue;->origin(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object p4

    iput-object p4, p2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p1, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p1, Landroid/system/keystore2/Authorization;

    invoke-direct {p1}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance p2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {p2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const p4, 0x300002c1

    iput p4, p2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-static {}, Lio/lti/KeyboxUtils;->getOSVersion()I

    move-result p4

    invoke-static {p4}, Landroid/hardware/security/keymint/KeyParameterValue;->integer(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object p4

    iput-object p4, p2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p1, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p1, Landroid/system/keystore2/Authorization;

    invoke-direct {p1}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance p2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {p2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const p4, 0x300002c2

    iput p4, p2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-static {v1}, Lio/lti/KeyboxUtils;->getSecurityPatchLevel(Z)I

    move-result p4

    invoke-static {p4}, Landroid/hardware/security/keymint/KeyParameterValue;->integer(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object p4

    iput-object p4, p2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p1, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p1, Landroid/system/keystore2/Authorization;

    invoke-direct {p1}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance p2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {p2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const p4, 0x300002ce

    iput p4, p2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-static {v2}, Lio/lti/KeyboxUtils;->getSecurityPatchLevel(Z)I

    move-result p4

    invoke-static {p4}, Landroid/hardware/security/keymint/KeyParameterValue;->integer(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object p4

    iput-object p4, p2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p1, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p1, Landroid/system/keystore2/Authorization;

    invoke-direct {p1}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance p2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {p2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const p4, 0x300002cf

    iput p4, p2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-static {v2}, Lio/lti/KeyboxUtils;->getSecurityPatchLevel(Z)I

    move-result p4

    invoke-static {p4}, Landroid/hardware/security/keymint/KeyParameterValue;->integer(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object p4

    iput-object p4, p2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p1, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p1, Landroid/system/keystore2/Authorization;

    invoke-direct {p1}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance p2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {p2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const p4, 0x300001f5

    iput p4, p2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result p4

    const v2, 0x186a0

    div-int/2addr p4, v2

    invoke-static {p4}, Landroid/hardware/security/keymint/KeyParameterValue;->integer(I)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object p4

    iput-object p4, p2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p1, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static {}, Lio/lti/KeyboxUtils;->getAttestationVersion()I

    move-result p1

    const/16 p2, 0x190

    if-lt p1, p2, :cond_d

    new-instance p1, Landroid/system/keystore2/Authorization;

    invoke-direct {p1}, Landroid/system/keystore2/Authorization;-><init>()V

    new-instance p2, Landroid/hardware/security/keymint/KeyParameter;

    invoke-direct {p2}, Landroid/hardware/security/keymint/KeyParameter;-><init>()V

    iput-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    const p4, -0x6ffffd2c

    iput p4, p2, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    iget-object p2, p1, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    invoke-static {}, Lio/lti/KeyboxUtils;->getModuleHash()[B

    move-result-object p4

    invoke-static {p4}, Landroid/hardware/security/keymint/KeyParameterValue;->blob([B)Landroid/hardware/security/keymint/KeyParameterValue;

    move-result-object p4

    iput-object p4, p2, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    iput p3, p1, Landroid/system/keystore2/Authorization;->securityLevel:I

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_d
    new-array p1, v1, [Landroid/system/keystore2/Authorization;

    invoke-interface {p0, p1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [Landroid/system/keystore2/Authorization;

    iput-object p0, v0, Landroid/system/keystore2/KeyMetadata;->authorizations:[Landroid/system/keystore2/Authorization;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception p0

    const-string p1, "KeyboxImitationHooks"

    const-string p2, "Failed to build key metadata"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 p0, 0x0

    return-object p0
.end method

.method private static blacklist dlog(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public static blacklist onCreateOperation(Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;)Landroid/system/keystore2/CreateOperationResponse;
    .locals 17

    const-string v0, "Ed25519"

    invoke-static {}, Lio/lti/KeyProviderManager;->isKeyboxAvailable()Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    return-object v2

    :cond_0
    invoke-static/range {p0 .. p0}, Lio/lti/KeyboxUtils;->fetchKeyData(Landroid/system/keystore2/KeyDescriptor;)Landroid/util/Pair;

    move-result-object v1

    if-nez v1, :cond_1

    return-object v2

    :cond_1
    iget-object v3, v1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v3, Landroid/system/keystore2/KeyMetadata;

    iget-object v3, v3, Landroid/system/keystore2/KeyMetadata;->authorizations:[Landroid/system/keystore2/Authorization;

    invoke-static {v3}, Lio/lti/KeyboxUtils;->getAlgorithmFromAuthorizations([Landroid/system/keystore2/Authorization;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_2c

    new-instance v5, Lio/lti/KeyboxChainGenerator$KeyGenParameters;

    move-object/from16 v6, p1

    invoke-direct {v5, v6}, Lio/lti/KeyboxChainGenerator$KeyGenParameters;-><init>([Landroid/hardware/security/keymint/KeyParameter;)V

    iget-object v6, v5, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_2

    iget-object v6, v5, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->getFirst()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    goto :goto_0

    :cond_2
    move-object v6, v2

    :goto_0
    iget-object v7, v5, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->padding:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_3

    iget-object v7, v5, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->padding:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->getFirst()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Integer;

    goto :goto_1

    :cond_3
    move-object v7, v2

    :goto_1
    iget-object v8, v5, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->digest:Ljava/util/List;

    invoke-interface {v8}, Ljava/util/List;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_4

    iget-object v2, v5, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->digest:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->getFirst()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    :cond_4
    invoke-static {v2}, Lio/lti/KeyboxUtils;->getSignDigest(Ljava/lang/Integer;)Ljava/lang/String;

    move-result-object v8

    if-eqz v6, :cond_2b

    iget-object v9, v1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v9, Landroid/system/keystore2/KeyMetadata;

    iget-object v9, v9, Landroid/system/keystore2/KeyMetadata;->authorizations:[Landroid/system/keystore2/Authorization;

    array-length v10, v9

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    :goto_2
    if-ge v12, v10, :cond_8

    aget-object v4, v9, v12

    iget-object v11, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget v11, v11, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    move-object/from16 v16, v6

    const v6, 0x20000001

    if-ne v11, v6, :cond_5

    iget-object v4, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v4, v4, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    invoke-virtual {v4}, Landroid/hardware/security/keymint/KeyParameterValue;->getKeyPurpose()I

    move-result v4

    invoke-virtual/range {v16 .. v16}, Ljava/lang/Integer;->intValue()I

    move-result v6

    if-ne v4, v6, :cond_7

    const/4 v13, 0x1

    goto :goto_3

    :cond_5
    iget-object v6, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget v6, v6, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    const v11, 0x20000006

    if-ne v6, v11, :cond_6

    if-eqz v7, :cond_7

    iget-object v4, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v4, v4, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    invoke-virtual {v4}, Landroid/hardware/security/keymint/KeyParameterValue;->getPaddingMode()I

    move-result v4

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v6

    if-ne v4, v6, :cond_7

    const/4 v14, 0x1

    goto :goto_3

    :cond_6
    iget-object v6, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget v6, v6, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    const v11, 0x20000005

    if-ne v6, v11, :cond_7

    if-eqz v2, :cond_7

    iget-object v4, v4, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v4, v4, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    invoke-virtual {v4}, Landroid/hardware/security/keymint/KeyParameterValue;->getDigest()I

    move-result v4

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v6

    if-ne v4, v6, :cond_7

    const/4 v15, 0x1

    :cond_7
    :goto_3
    add-int/lit8 v12, v12, 0x1

    move-object/from16 v6, v16

    goto :goto_2

    :cond_8
    move-object/from16 v16, v6

    if-eqz v13, :cond_2a

    if-eqz v14, :cond_29

    const/16 v4, -0xd

    if-eqz v15, :cond_28

    :try_start_0
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v6

    const v9, -0x1073ed65

    const/16 v10, -0xc

    const/4 v11, -0x2

    const/4 v12, 0x2

    if-eq v6, v9, :cond_22

    const/16 v0, 0x89e

    if-eq v6, v0, :cond_1d

    const v0, 0x13e20

    if-ne v6, v0, :cond_27

    const-string v0, "RSA"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_27

    invoke-virtual/range {v16 .. v16}, Ljava/lang/Integer;->intValue()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v3, "Padding "

    const-string v6, "RSA/None/NoPadding"

    const/16 v9, -0xa

    const/4 v10, 0x1

    if-ne v0, v10, :cond_13

    if-eqz v7, :cond_12

    :try_start_1
    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ne v0, v10, :cond_9

    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/security/KeyPair;

    invoke-virtual {v0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    invoke-static {v0, v6}, Lio/lti/KeyboxOperationUtils;->getDecryptOperation(Ljava/security/PrivateKey;Ljava/lang/String;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object v0

    return-object v0

    :cond_9
    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ne v0, v12, :cond_10

    if-eqz v2, :cond_f

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-eqz v0, :cond_f

    iget-object v0, v5, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->mgfDigest:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_a

    iget-object v0, v5, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->mgfDigest:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->getFirst()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v12

    :cond_a
    if-eqz v12, :cond_e

    iget-object v0, v1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v0, Landroid/system/keystore2/KeyMetadata;

    iget-object v0, v0, Landroid/system/keystore2/KeyMetadata;->authorizations:[Landroid/system/keystore2/Authorization;

    array-length v3, v0

    const/4 v4, 0x0

    const/4 v11, 0x1

    :goto_4
    if-ge v4, v3, :cond_c

    aget-object v5, v0, v4

    iget-object v6, v5, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget v6, v6, Landroid/hardware/security/keymint/KeyParameter;->tag:I

    const v7, 0x200000cb

    if-ne v6, v7, :cond_b

    iget-object v5, v5, Landroid/system/keystore2/Authorization;->keyParameter:Landroid/hardware/security/keymint/KeyParameter;

    iget-object v5, v5, Landroid/hardware/security/keymint/KeyParameter;->value:Landroid/hardware/security/keymint/KeyParameterValue;

    invoke-virtual {v5}, Landroid/hardware/security/keymint/KeyParameterValue;->getDigest()I

    move-result v5

    if-eq v5, v12, :cond_b

    const/4 v11, 0x0

    :cond_b
    add-int/lit8 v4, v4, 0x1

    goto :goto_4

    :cond_c
    if-eqz v11, :cond_d

    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/security/KeyPair;

    invoke-virtual {v0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RSA/None/OAEPWith"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v2}, Lio/lti/KeyboxUtils;->getDecryptDigest(Ljava/lang/Integer;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "AndMGF1Padding"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v0, v1, v2, v3}, Lio/lti/KeyboxOperationUtils;->getDecryptOperation(Ljava/security/PrivateKey;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object v0

    return-object v0

    :cond_d
    new-instance v0, Landroid/os/ServiceSpecificException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MGF digest"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " not allowed by key characteristics"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/16 v2, -0x4e

    invoke-direct {v0, v2, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_e
    new-instance v0, Landroid/os/ServiceSpecificException;

    const-string v1, "MGF digest cannot be NONE for RSA-OAEP"

    const/16 v2, -0x4f

    invoke-direct {v0, v2, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_f
    new-instance v0, Landroid/os/ServiceSpecificException;

    const-string v1, "Digest required for RSA-OAEP"

    invoke-direct {v0, v4, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_10
    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v2, 0x4

    if-ne v0, v2, :cond_11

    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/security/KeyPair;

    invoke-virtual {v0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    const-string v1, "RSA/None/PKCS1Padding"

    invoke-static {v0, v1}, Lio/lti/KeyboxOperationUtils;->getDecryptOperation(Ljava/security/PrivateKey;Ljava/lang/String;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object v0

    return-object v0

    :cond_11
    new-instance v0, Landroid/os/ServiceSpecificException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " unsupported with KeyPurpose::DECRYPT"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v9, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_12
    new-instance v0, Landroid/os/ServiceSpecificException;

    invoke-direct {v0, v9}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0

    :cond_13
    invoke-virtual/range {v16 .. v16}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ne v0, v12, :cond_1c

    if-eqz v7, :cond_1b

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v10, 0x1

    if-ne v0, v10, :cond_16

    if-eqz v2, :cond_15

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-nez v0, :cond_14

    goto :goto_5

    :cond_14
    new-instance v0, Landroid/os/ServiceSpecificException;

    const-string v1, "Unpadded RSA sign requires Digest::None"

    invoke-direct {v0, v4, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_15
    :goto_5
    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/security/KeyPair;

    invoke-virtual {v0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    invoke-static {v0, v6}, Lio/lti/KeyboxOperationUtils;->getSignOperation(Ljava/security/PrivateKey;Ljava/lang/String;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object v0

    return-object v0

    :cond_16
    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v2, 0x3

    if-ne v0, v2, :cond_18

    if-eqz v8, :cond_17

    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/security/KeyPair;

    invoke-virtual {v0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "withRSA/PSS"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lio/lti/KeyboxOperationUtils;->getSignOperation(Ljava/security/PrivateKey;Ljava/lang/String;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object v0

    return-object v0

    :cond_17
    new-instance v0, Landroid/os/ServiceSpecificException;

    const-string v1, "Digest required for RSA-PSS"

    invoke-direct {v0, v4, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_18
    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v2, 0x5

    if-ne v0, v2, :cond_1a

    if-eqz v8, :cond_19

    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/security/KeyPair;

    invoke-virtual {v0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "withRSA"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lio/lti/KeyboxOperationUtils;->getSignOperation(Ljava/security/PrivateKey;Ljava/lang/String;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object v0

    return-object v0

    :cond_19
    new-instance v0, Landroid/os/ServiceSpecificException;

    const-string v1, "Digest required for RSA-PKCS_1_5_SIGN"

    invoke-direct {v0, v4, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_1a
    new-instance v0, Landroid/os/ServiceSpecificException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " unsupported with KeyPurpose::SIGN"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v9, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_1b
    new-instance v0, Landroid/os/ServiceSpecificException;

    invoke-direct {v0, v9}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0

    :cond_1c
    new-instance v0, Landroid/os/ServiceSpecificException;

    invoke-direct {v0, v11}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0

    :cond_1d
    const-string v0, "EC"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_27

    invoke-virtual/range {v16 .. v16}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ne v0, v12, :cond_20

    if-eqz v2, :cond_1f

    if-eqz v8, :cond_1f

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v2, 0x1

    if-eq v0, v2, :cond_1e

    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/security/KeyPair;

    invoke-virtual {v0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "withECDSA"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lio/lti/KeyboxOperationUtils;->getSignOperation(Ljava/security/PrivateKey;Ljava/lang/String;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object v0

    return-object v0

    :cond_1e
    new-instance v0, Landroid/os/ServiceSpecificException;

    const-string v1, "Digest::MD5 unsupported for EC signing"

    invoke-direct {v0, v10, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_1f
    new-instance v0, Landroid/os/ServiceSpecificException;

    invoke-direct {v0, v10}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0

    :cond_20
    invoke-virtual/range {v16 .. v16}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v2, 0x6

    if-ne v0, v2, :cond_21

    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/security/KeyPair;

    invoke-virtual {v0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    invoke-static {v0}, Lio/lti/KeyboxOperationUtils;->getKeyAgreementOperation(Ljava/security/PrivateKey;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object v0

    return-object v0

    :cond_21
    new-instance v0, Landroid/os/ServiceSpecificException;

    invoke-direct {v0, v11}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0

    :cond_22
    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_27

    invoke-virtual/range {v16 .. v16}, Ljava/lang/Integer;->intValue()I

    move-result v3

    if-ne v3, v12, :cond_25

    if-eqz v2, :cond_24

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-nez v2, :cond_23

    goto :goto_6

    :cond_23
    new-instance v0, Landroid/os/ServiceSpecificException;

    const-string v1, "Ed25519 only supports Digest::None"

    invoke-direct {v0, v10, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_24
    :goto_6
    iget-object v1, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v1, Ljava/security/KeyPair;

    invoke-virtual {v1}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v1

    invoke-static {v1, v0}, Lio/lti/KeyboxOperationUtils;->getSignOperation(Ljava/security/PrivateKey;Ljava/lang/String;)Landroid/system/keystore2/CreateOperationResponse;

    move-result-object v0

    return-object v0

    :cond_25
    new-instance v0, Landroid/os/ServiceSpecificException;

    invoke-direct {v0, v11}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    move-exception v0

    instance-of v1, v0, Landroid/os/ServiceSpecificException;

    if-eqz v1, :cond_26

    check-cast v0, Landroid/os/ServiceSpecificException;

    throw v0

    :cond_26
    const-string v1, "KeyboxImitationHooks"

    const-string v2, "Failed to createOperation"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_27
    new-instance v0, Landroid/os/ServiceSpecificException;

    const/4 v1, -0x4

    invoke-direct {v0, v1}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0

    :cond_28
    new-instance v0, Landroid/os/ServiceSpecificException;

    invoke-direct {v0, v4}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0

    :cond_29
    new-instance v0, Landroid/os/ServiceSpecificException;

    const/16 v1, -0xb

    invoke-direct {v0, v1}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0

    :cond_2a
    new-instance v0, Landroid/os/ServiceSpecificException;

    const/4 v1, -0x3

    invoke-direct {v0, v1}, Landroid/os/ServiceSpecificException;-><init>(I)V

    throw v0

    :cond_2b
    new-instance v0, Landroid/os/ServiceSpecificException;

    const/16 v1, -0x26

    const-string v2, "No operation purpose specified"

    invoke-direct {v0, v1, v2}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0

    :cond_2c
    new-instance v0, Landroid/os/ServiceSpecificException;

    const-string v1, "Key algorithm could not be obtained"

    const/4 v2, 0x4

    invoke-direct {v0, v2, v1}, Landroid/os/ServiceSpecificException;-><init>(ILjava/lang/String;)V

    throw v0
.end method

.method public static blacklist onDeleteKey(Landroid/system/keystore2/KeyDescriptor;)Z
    .locals 6

    invoke-static {}, Lio/lti/KeyProviderManager;->isKeyboxAvailable()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget v0, p0, Landroid/system/keystore2/KeyDescriptor;->domain:I

    const/4 v2, 0x4

    if-eqz v0, :cond_1

    iget v0, p0, Landroid/system/keystore2/KeyDescriptor;->domain:I

    if-eq v0, v2, :cond_1

    return v1

    :cond_1
    invoke-static {}, Lio/lti/KeyboxDbHelper;->getInstance()Lio/lti/KeyboxDbHelper;

    move-result-object v0

    if-nez v0, :cond_2

    return v1

    :cond_2
    iget-wide v3, p0, Landroid/system/keystore2/KeyDescriptor;->nspace:J

    iget v5, p0, Landroid/system/keystore2/KeyDescriptor;->domain:I

    if-eq v5, v2, :cond_3

    iget-object v2, p0, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    int-to-long v3, v2

    :cond_3
    invoke-virtual {v0, v3, v4}, Lio/lti/KeyboxDbHelper;->deleteKeyData(J)Z

    move-result v0

    if-eqz v0, :cond_4

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Deleted key with alias \""

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object p0, p0, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "\" for uid "

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lio/lti/KeyboxImitationHooks;->dlog(Ljava/lang/String;)V

    const/4 p0, 0x1

    return p0

    :cond_4
    return v1
.end method

.method public static blacklist onGenerateKey(Landroid/system/keystore2/KeyDescriptor;Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;)Landroid/system/keystore2/KeyMetadata;
    .locals 5

    const-string v0, "Generated key with alias \""

    invoke-static {}, Lio/lti/KeyProviderManager;->isKeyboxAvailable()Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    return-object v2

    :cond_0
    invoke-static {}, Lio/lti/KeyboxUtils;->isCallerSamsungKeystoreUtils()Z

    move-result v1

    if-eqz v1, :cond_1

    return-object v2

    :cond_1
    iget v1, p0, Landroid/system/keystore2/KeyDescriptor;->domain:I

    if-eqz v1, :cond_2

    return-object v2

    :cond_2
    new-instance v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;

    invoke-direct {v1, p2}, Lio/lti/KeyboxChainGenerator$KeyGenParameters;-><init>([Landroid/hardware/security/keymint/KeyParameter;)V

    iget p2, v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    const/4 v3, 0x3

    const/4 v4, 0x1

    if-eq p2, v3, :cond_3

    iget p2, v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    if-eq p2, v4, :cond_3

    return-object v2

    :cond_3
    iget-object p2, v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    const/4 v3, 0x7

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {p2, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_4

    iget-object p2, v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-le p2, v4, :cond_4

    return-object v2

    :cond_4
    :try_start_0
    invoke-static {v1}, Lio/lti/KeyboxUtils;->generateKeyPair(Lio/lti/KeyboxChainGenerator$KeyGenParameters;)Ljava/security/KeyPair;

    move-result-object p2

    sget v3, Lio/lti/KeyboxImitationHooks;->sSecurityLevelType:I

    invoke-static {p2, p1, v1, v3}, Lio/lti/KeyboxChainGenerator;->generateCertChain(Ljava/security/KeyPair;Landroid/system/keystore2/KeyDescriptor;Lio/lti/KeyboxChainGenerator$KeyGenParameters;I)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_8

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_5

    goto :goto_0

    :cond_5
    sget v3, Lio/lti/KeyboxImitationHooks;->sSecurityLevelType:I

    const/4 v4, 0x0

    invoke-static {p1, v1, p0, v3, v4}, Lio/lti/KeyboxImitationHooks;->buildMetadata(Ljava/util/List;Lio/lti/KeyboxChainGenerator$KeyGenParameters;Landroid/system/keystore2/KeyDescriptor;II)Landroid/system/keystore2/KeyMetadata;

    move-result-object p1

    if-nez p1, :cond_6

    return-object v2

    :cond_6
    invoke-static {}, Lio/lti/KeyboxDbHelper;->getInstance()Lio/lti/KeyboxDbHelper;

    move-result-object v1

    if-eqz v1, :cond_7

    iget-object v3, p0, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    invoke-virtual {v1, v3, p2, p1}, Lio/lti/KeyboxDbHelper;->storeKeyData(Ljava/lang/String;Ljava/security/KeyPair;Landroid/system/keystore2/KeyMetadata;)V

    :cond_7
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object p0, p0, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p2, "\" for uid "

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result p2

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lio/lti/KeyboxImitationHooks;->dlog(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :cond_8
    :goto_0
    return-object v2

    :catch_0
    move-exception p0

    const-string p1, "KeyboxImitationHooks"

    const-string p2, "Failed to generate key"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-object v2
.end method

.method public static blacklist onGetKeyEntry(Landroid/system/keystore2/KeyDescriptor;)Landroid/system/keystore2/KeyEntryResponse;
    .locals 3

    invoke-static {}, Lio/lti/KeyProviderManager;->isKeyboxAvailable()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    invoke-static {p0}, Lio/lti/KeyboxUtils;->fetchKeyData(Landroid/system/keystore2/KeyDescriptor;)Landroid/util/Pair;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v2, v0, Landroid/util/Pair;->second:Ljava/lang/Object;

    if-eqz v2, :cond_1

    new-instance v1, Landroid/system/keystore2/KeyEntryResponse;

    invoke-direct {v1}, Landroid/system/keystore2/KeyEntryResponse;-><init>()V

    iget-object v0, v0, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v0, Landroid/system/keystore2/KeyMetadata;

    iput-object v0, v1, Landroid/system/keystore2/KeyEntryResponse;->metadata:Landroid/system/keystore2/KeyMetadata;

    sget-object v0, Lio/lti/KeyboxImitationHooks;->sSecurityLevel:Landroid/system/keystore2/IKeystoreSecurityLevel;

    iput-object v0, v1, Landroid/system/keystore2/KeyEntryResponse;->iSecurityLevel:Landroid/system/keystore2/IKeystoreSecurityLevel;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "Retrieved key with alias \""

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object p0, p0, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "\" for uid "

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lio/lti/KeyboxImitationHooks;->dlog(Ljava/lang/String;)V

    :cond_1
    return-object v1
.end method

.method public static blacklist onGetNumberOfEntries(I)Ljava/lang/Integer;
    .locals 2

    invoke-static {}, Lio/lti/KeyProviderManager;->isKeyboxAvailable()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    if-eqz p0, :cond_1

    return-object v1

    :cond_1
    invoke-static {}, Lio/lti/KeyboxDbHelper;->getInstance()Lio/lti/KeyboxDbHelper;

    move-result-object p0

    if-nez p0, :cond_2

    return-object v1

    :cond_2
    invoke-virtual {p0, v1}, Lio/lti/KeyboxDbHelper;->fetchKeyEntries(Ljava/lang/String;)[Landroid/system/keystore2/KeyDescriptor;

    move-result-object p0

    if-eqz p0, :cond_3

    array-length v0, p0

    if-lez v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Fetched all key entries count for uid "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lio/lti/KeyboxImitationHooks;->dlog(Ljava/lang/String;)V

    array-length p0, p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    return-object p0

    :cond_3
    return-object v1
.end method

.method public static blacklist onImportKey(Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;[B)Landroid/system/keystore2/KeyMetadata;
    .locals 5

    const-string v0, "Imported key with alias \""

    invoke-static {}, Lio/lti/KeyProviderManager;->isKeyboxAvailable()Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    return-object v2

    :cond_0
    iget v1, p0, Landroid/system/keystore2/KeyDescriptor;->domain:I

    if-eqz v1, :cond_1

    return-object v2

    :cond_1
    new-instance v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;

    invoke-direct {v1, p1}, Lio/lti/KeyboxChainGenerator$KeyGenParameters;-><init>([Landroid/hardware/security/keymint/KeyParameter;)V

    iget p1, v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    const/4 v3, 0x3

    const/4 v4, 0x1

    if-eq p1, v3, :cond_2

    iget p1, v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->algorithm:I

    if-eq p1, v4, :cond_2

    return-object v2

    :cond_2
    iget-object p1, v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    const/4 v3, 0x7

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {p1, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, v1, Lio/lti/KeyboxChainGenerator$KeyGenParameters;->purpose:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-le p1, v4, :cond_3

    goto :goto_0

    :cond_3
    :try_start_0
    invoke-static {p2}, Lio/lti/KeyboxUtils;->generateKeyPairFromKeyData([B)Ljava/security/KeyPair;

    move-result-object p1

    sget p2, Lio/lti/KeyboxImitationHooks;->sSecurityLevelType:I

    const/4 v3, 0x2

    invoke-static {v2, v1, p0, p2, v3}, Lio/lti/KeyboxImitationHooks;->buildMetadata(Ljava/util/List;Lio/lti/KeyboxChainGenerator$KeyGenParameters;Landroid/system/keystore2/KeyDescriptor;II)Landroid/system/keystore2/KeyMetadata;

    move-result-object p2

    if-nez p2, :cond_4

    return-object v2

    :cond_4
    invoke-static {}, Lio/lti/KeyboxDbHelper;->getInstance()Lio/lti/KeyboxDbHelper;

    move-result-object v1

    if-eqz v1, :cond_5

    iget-object v3, p0, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    invoke-virtual {v1, v3, p1, p2}, Lio/lti/KeyboxDbHelper;->storeKeyData(Ljava/lang/String;Ljava/security/KeyPair;Landroid/system/keystore2/KeyMetadata;)V

    :cond_5
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object p0, p0, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "\" for uid "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lio/lti/KeyboxImitationHooks;->dlog(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    move-exception p0

    const-string p1, "KeyboxImitationHooks"

    const-string p2, "Failed to import key"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_6
    :goto_0
    return-object v2
.end method

.method public static blacklist onListEntries(I)[Landroid/system/keystore2/KeyDescriptor;
    .locals 2

    invoke-static {}, Lio/lti/KeyProviderManager;->isKeyboxAvailable()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    if-eqz p0, :cond_1

    return-object v1

    :cond_1
    invoke-static {}, Lio/lti/KeyboxDbHelper;->getInstance()Lio/lti/KeyboxDbHelper;

    move-result-object p0

    if-nez p0, :cond_2

    return-object v1

    :cond_2
    invoke-virtual {p0, v1}, Lio/lti/KeyboxDbHelper;->fetchKeyEntries(Ljava/lang/String;)[Landroid/system/keystore2/KeyDescriptor;

    move-result-object p0

    if-eqz p0, :cond_3

    array-length v0, p0

    if-lez v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Fetched all key entries for uid "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lio/lti/KeyboxImitationHooks;->dlog(Ljava/lang/String;)V

    return-object p0

    :cond_3
    return-object v1
.end method

.method public static blacklist onListEntriesBatched(ILjava/lang/String;)[Landroid/system/keystore2/KeyDescriptor;
    .locals 2

    invoke-static {}, Lio/lti/KeyProviderManager;->isKeyboxAvailable()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    if-eqz p0, :cond_1

    return-object v1

    :cond_1
    invoke-static {}, Lio/lti/KeyboxDbHelper;->getInstance()Lio/lti/KeyboxDbHelper;

    move-result-object p0

    if-nez p0, :cond_2

    return-object v1

    :cond_2
    invoke-virtual {p0, p1}, Lio/lti/KeyboxDbHelper;->fetchKeyEntries(Ljava/lang/String;)[Landroid/system/keystore2/KeyDescriptor;

    move-result-object p0

    if-eqz p0, :cond_3

    array-length v0, p0

    if-lez v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Fetched key entries with lastAlias \""

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\" for uid "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lio/lti/KeyboxImitationHooks;->dlog(Ljava/lang/String;)V

    return-object p0

    :cond_3
    return-object v1
.end method

.method public static blacklist onUpdateSubcomponent(Landroid/system/keystore2/KeyDescriptor;[B[B)Z
    .locals 5

    invoke-static {}, Lio/lti/KeyProviderManager;->isKeyboxAvailable()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    invoke-static {p0}, Lio/lti/KeyboxUtils;->fetchKeyData(Landroid/system/keystore2/KeyDescriptor;)Landroid/util/Pair;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v2, v0, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v2, Landroid/system/keystore2/KeyMetadata;

    if-eqz v2, :cond_1

    iput-object p1, v2, Landroid/system/keystore2/KeyMetadata;->certificate:[B

    iput-object p2, v2, Landroid/system/keystore2/KeyMetadata;->certificateChain:[B

    invoke-static {}, Lio/lti/KeyboxDbHelper;->getInstance()Lio/lti/KeyboxDbHelper;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-wide v3, p0, Landroid/system/keystore2/KeyDescriptor;->nspace:J

    iget-object p2, v0, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p2, Ljava/security/KeyPair;

    invoke-virtual {p1, v3, v4, p2, v2}, Lio/lti/KeyboxDbHelper;->updateKeyData(JLjava/security/KeyPair;Landroid/system/keystore2/KeyMetadata;)V

    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "Updated key with nspace \""

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v0, p0, Landroid/system/keystore2/KeyDescriptor;->nspace:J

    invoke-virtual {p1, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "\" for uid "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lio/lti/KeyboxImitationHooks;->dlog(Ljava/lang/String;)V

    const/4 p0, 0x1

    return p0

    :cond_1
    return v1
.end method

.method public static setSecurityLevel(Landroid/system/keystore2/IKeystoreSecurityLevel;I)V
    .locals 0

    sput-object p0, Lio/lti/KeyboxImitationHooks;->sSecurityLevel:Landroid/system/keystore2/IKeystoreSecurityLevel;

    sput p1, Lio/lti/KeyboxImitationHooks;->sSecurityLevelType:I

    return-void
.end method
