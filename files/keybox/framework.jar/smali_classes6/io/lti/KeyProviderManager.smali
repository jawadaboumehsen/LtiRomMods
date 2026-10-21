.class public final Lio/lti/KeyProviderManager;
.super Ljava/lang/Object;
.source "KeyProviderManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/lti/KeyProviderManager$DefaultKeyboxProvider;
    }
.end annotation


# static fields
.field private static final blacklist DEBUG:Z = false

.field private static final blacklist TAG:Ljava/lang/String; = "KeyProviderManager"

.field private static blacklist sInstance:Lio/lti/IKeyboxProvider;


# direct methods
.method static bridge synthetic blacklist -$$Nest$smdlog(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Lio/lti/KeyProviderManager;->dlog(Ljava/lang/String;)V

    return-void
.end method

.method private constructor blacklist <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static blacklist dlog(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public static blacklist getProvider()Lio/lti/IKeyboxProvider;
    .locals 2

    sget-object v0, Lio/lti/KeyProviderManager;->sInstance:Lio/lti/IKeyboxProvider;

    if-nez v0, :cond_0

    new-instance v0, Lio/lti/KeyProviderManager$DefaultKeyboxProvider;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lio/lti/KeyProviderManager$DefaultKeyboxProvider;-><init>(Lio/lti/KeyProviderManager-IA;)V

    sput-object v0, Lio/lti/KeyProviderManager;->sInstance:Lio/lti/IKeyboxProvider;

    :cond_0
    sget-object v0, Lio/lti/KeyProviderManager;->sInstance:Lio/lti/IKeyboxProvider;

    return-object v0
.end method

.method public static blacklist isKeyboxAvailable()Z
    .locals 2

    const-string v0, "persist.sys.lti.keybox"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_0

    return v1

    :cond_0
    invoke-static {}, Lio/lti/KeyProviderManager;->getProvider()Lio/lti/IKeyboxProvider;

    move-result-object v0

    invoke-interface {v0}, Lio/lti/IKeyboxProvider;->hasKeybox()Z

    move-result v0

    return v0
.end method
