.class Lio/lti/PlayIntegrityHooks$1;
.super Landroid/app/TaskStackListener;
.source "PlayIntegrityHooks.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/lti/PlayIntegrityHooks;->shouldTryToCertifyDevice()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic blacklist val$was:Z


# direct methods
.method constructor blacklist <init>(Z)V
    .locals 0

    iput-boolean p1, p0, Lio/lti/PlayIntegrityHooks$1;->val$was:Z

    invoke-direct {p0}, Landroid/app/TaskStackListener;-><init>()V

    return-void
.end method


# virtual methods
.method public blacklist onTaskStackChanged()V
    .locals 2

    invoke-static {}, Lio/lti/PlayIntegrityHooks;->-$$Nest$smisGmsAddAccountActivityOnTop()Z

    move-result v0

    iget-boolean v1, p0, Lio/lti/PlayIntegrityHooks$1;->val$was:Z

    xor-int/2addr v1, v0

    if-eqz v1, :cond_0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iget-boolean p0, p0, Lio/lti/PlayIntegrityHooks$1;->val$was:Z

    invoke-static {p0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    const-string v1, "GmsAddAccountActivityOnTop"

    filled-new-array {v1, v0, p0}, [Ljava/lang/Object;

    move-result-object p0

    const-string v0, "%s changed: isNow=%b, was=%b, killing myself!"

    invoke-static {v0, p0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lio/lti/PlayIntegrityHooks;->-$$Nest$smdlog(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result p0

    invoke-static {p0}, Landroid/os/Process;->killProcess(I)V

    :cond_0
    return-void
.end method
