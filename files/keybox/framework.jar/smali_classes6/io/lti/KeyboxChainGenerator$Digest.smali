.class final Lio/lti/KeyboxChainGenerator$Digest;
.super Ljava/lang/Record;
.source "KeyboxChainGenerator.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/lti/KeyboxChainGenerator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Digest"
.end annotation

.annotation system Ldalvik/annotation/Record;
    componentAnnotationVisibilities = {
        {}
    }
    componentAnnotations = {
        {}
    }
    componentNames = {
        "digest"
    }
    componentSignatures = {
        null
    }
    componentTypes = {
        [B
    }
.end annotation


# instance fields
.field private final blacklist digest:[B


# direct methods
.method private synthetic blacklist $record$getFieldsAsObjects()[Ljava/lang/Object;
    .locals 0

    iget-object p0, p0, Lio/lti/KeyboxChainGenerator$Digest;->digest:[B

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic blacklist -$$Nest$fgetdigest(Lio/lti/KeyboxChainGenerator$Digest;)[B
    .locals 0

    iget-object p0, p0, Lio/lti/KeyboxChainGenerator$Digest;->digest:[B

    return-object p0
.end method

.method constructor blacklist <init>([B)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "digest"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Record;-><init>()V

    iput-object p1, p0, Lio/lti/KeyboxChainGenerator$Digest;->digest:[B

    return-void
.end method


# virtual methods
.method public blacklist digest()[B
    .locals 0

    iget-object p0, p0, Lio/lti/KeyboxChainGenerator$Digest;->digest:[B

    return-object p0
.end method

.method public whitelist test-api equals(Ljava/lang/Object;)Z
    .locals 1

    instance-of v0, p1, Lio/lti/KeyboxChainGenerator$Digest;

    if-eqz v0, :cond_0

    check-cast p1, Lio/lti/KeyboxChainGenerator$Digest;

    iget-object p0, p0, Lio/lti/KeyboxChainGenerator$Digest;->digest:[B

    iget-object p1, p1, Lio/lti/KeyboxChainGenerator$Digest;->digest:[B

    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result p0

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public whitelist test-api hashCode()I
    .locals 0

    iget-object p0, p0, Lio/lti/KeyboxChainGenerator$Digest;->digest:[B

    invoke-static {p0}, Ljava/util/Arrays;->hashCode([B)I

    move-result p0

    return p0
.end method

.method public final whitelist test-api toString()Ljava/lang/String;
    .locals 2

    invoke-direct {p0}, Lio/lti/KeyboxChainGenerator$Digest;->$record$getFieldsAsObjects()[Ljava/lang/Object;

    move-result-object p0

    const-class v0, Lio/lti/KeyboxChainGenerator$Digest;

    const-string v1, "digest"

    invoke-static {p0, v0, v1}, Landroid/app/PropertyInvalidatedCache$Args$$ExternalSyntheticRecord0;->m([Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
