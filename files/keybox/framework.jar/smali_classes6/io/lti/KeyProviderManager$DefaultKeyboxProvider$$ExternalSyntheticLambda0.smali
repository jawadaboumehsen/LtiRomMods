.class public final synthetic Lio/lti/KeyProviderManager$DefaultKeyboxProvider$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/IntFunction;


# direct methods
.method public synthetic constructor blacklist <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final whitelist test-api apply(I)Ljava/lang/Object;
    .locals 0

    invoke-static {p1}, Lio/lti/KeyProviderManager$DefaultKeyboxProvider;->lambda$getCertificateChain$0(I)[Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
