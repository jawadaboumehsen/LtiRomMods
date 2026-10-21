.class public interface abstract Lio/lti/IKeyboxProvider;
.super Ljava/lang/Object;
.source "IKeyboxProvider.java"


# virtual methods
.method public abstract blacklist getEcCertificateChain()[Ljava/lang/String;
.end method

.method public abstract blacklist getEcPrivateKey()Ljava/lang/String;
.end method

.method public abstract blacklist getRsaCertificateChain()[Ljava/lang/String;
.end method

.method public abstract blacklist getRsaPrivateKey()Ljava/lang/String;
.end method

.method public abstract blacklist hasKeybox()Z
.end method
