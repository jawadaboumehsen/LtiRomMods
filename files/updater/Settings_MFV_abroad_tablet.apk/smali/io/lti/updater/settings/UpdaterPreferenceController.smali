.class public Lio/lti/updater/settings/UpdaterPreferenceController;
.super Lcom/android/settingslib/core/AbstractPreferenceController;
.source "UpdaterPreferenceController.java"

# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0
    invoke-direct {p0, p1, p2}, Lcom/android/settingslib/core/AbstractPreferenceController;-><init>(Landroid/content/Context;Ljava/lang/String;)V
    return-void
.end method

# virtual methods
.method public getAvailabilityStatus()I
    .locals 1
    iget-object v0, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;
    const-string p0, "com.zte.zdm"
    invoke-static {v0, p0}, Lcom/android/settings/Utils;->isPackageEnabled(Landroid/content/Context;Ljava/lang/String;)Z
    move-result p0
    if-nez p0, :cond_0
    const/4 p0, 0x3
    return p0
    :cond_0
    const/4 p0, 0x0
    return p0
.end method

.method public getSummary()Ljava/lang/CharSequence;
    .locals 3
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    iget-object v1, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;
    const v2, 0x7f142502
    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I
    move-result v1
    iget-object p0, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;
    invoke-static {p0}, Lcom/android/settings/Utils;->getTopLevelSummarySeparator(Landroid/content/Context;)Ljava/lang/String;
    move-result-object p0
    invoke-static {p0, v0, v1}, Lcom/android/settings/Utils;->buildSummaryString(Ljava/lang/String;Ljava/util/List;I)Ljava/lang/String;
    move-result-object p0
    return-object p0
.end method

.method public updateState(Landroidx/preference/Preference;)V
    .locals 4
    iget-object v0, p0, Lcom/android/settingslib/core/AbstractPreferenceController;->mContext:Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v0
    const-string v1, "lti_update_available"
    const/4 v2, 0x0
    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
    move-result v0
    if-lez v0, :cond_0
    const-string v0, "Update available"
    invoke-virtual {p1, v0}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    goto :goto_0
    :cond_0
    invoke-super {p0, p1}, Lcom/android/settingslib/core/AbstractPreferenceController;->updateState(Landroidx/preference/Preference;)V
    :goto_0
    return-void
.end method
