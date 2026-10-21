package io.ltirom.mods.changes

import io.ltirom.mods.text
import org.ide.lti.sdk.patchmod.ApkJarScope
import java.io.File

// The smali and resource changes, as exact text. Converted from the bash module's git patches;
// method(…) changes are placed by their method and lines, so the rest of a class may change.

/** keybox: its changes to framework.jar. */
internal fun ApkJarScope.keyboxFramework(files: File) {
    method("Landroid/security/KeyStore2;", "lambda${'$'}getSecurityLevel${'$'}6") {
        insertAfter(
            """
            |    invoke-direct {v0, v1}, Landroid/security/KeyStoreSecurityLevel;-><init>(Landroid/system/keystore2/IKeystoreSecurityLevel;)V
            """.trimMargin(),
            """
            |    
            |    invoke-static {v1, p0}, Lio/lti/KeyboxImitationHooks;->setSecurityLevel(Landroid/system/keystore2/IKeystoreSecurityLevel;I)V
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;", "createOperation") {
        replace(
            """
            |.method public blacklist createOperation(Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;Z)Landroid/system/keystore2/CreateOperationResponse;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist createOperation(Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;Z)Landroid/system/keystore2/CreateOperationResponse;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1, p2}, Lio/lti/KeyboxImitationHooks;->onCreateOperation(Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;)Landroid/system/keystore2/CreateOperationResponse;
            |    
            |        move-result-object v0
            |    
            |        if-eqz v0, :cond_lti_createoperation
            |    
            |        return-object v0
            |    
            |        :cond_lti_createoperation
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;", "deleteKey") {
        replace(
            """
            |.method public blacklist deleteKey(Landroid/system/keystore2/KeyDescriptor;)V
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist deleteKey(Landroid/system/keystore2/KeyDescriptor;)V
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1}, Lio/lti/KeyboxImitationHooks;->onDeleteKey(Landroid/system/keystore2/KeyDescriptor;)Z
            |    
            |        move-result v0
            |    
            |        if-eqz v0, :cond_lti_deletekey_isl
            |    
            |        return-void
            |    
            |        :cond_lti_deletekey_isl
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;", "generateKey") {
        replace(
            """
            |.method public blacklist generateKey(Landroid/system/keystore2/KeyDescriptor;Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;I[B)Landroid/system/keystore2/KeyMetadata;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist generateKey(Landroid/system/keystore2/KeyDescriptor;Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;I[B)Landroid/system/keystore2/KeyMetadata;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1, p2, p3}, Lio/lti/KeyboxImitationHooks;->onGenerateKey(Landroid/system/keystore2/KeyDescriptor;Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;)Landroid/system/keystore2/KeyMetadata;
            |    
            |        move-result-object v0
            |    
            |        if-eqz v0, :cond_lti_generatekey
            |    
            |        return-object v0
            |    
            |        :cond_lti_generatekey
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;", "importKey") {
        replace(
            """
            |.method public blacklist importKey(Landroid/system/keystore2/KeyDescriptor;Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;I[B)Landroid/system/keystore2/KeyMetadata;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist importKey(Landroid/system/keystore2/KeyDescriptor;Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;I[B)Landroid/system/keystore2/KeyMetadata;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1, p3, p5}, Lio/lti/KeyboxImitationHooks;->onImportKey(Landroid/system/keystore2/KeyDescriptor;[Landroid/hardware/security/keymint/KeyParameter;[B)Landroid/system/keystore2/KeyMetadata;
            |    
            |        move-result-object v0
            |    
            |        if-eqz v0, :cond_lti_importkey
            |    
            |        return-object v0
            |    
            |        :cond_lti_importkey
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreSecurityLevel${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;", "deleteKey") {
        replace(
            """
            |.method public blacklist deleteKey(Landroid/system/keystore2/KeyDescriptor;)V
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist deleteKey(Landroid/system/keystore2/KeyDescriptor;)V
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1}, Lio/lti/KeyboxImitationHooks;->onDeleteKey(Landroid/system/keystore2/KeyDescriptor;)Z
            |    
            |        move-result v0
            |    
            |        if-eqz v0, :cond_lti_deletekey_iks
            |    
            |        return-void
            |    
            |        :cond_lti_deletekey_iks
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;", "getKeyEntry") {
        replace(
            """
            |.method public blacklist getKeyEntry(Landroid/system/keystore2/KeyDescriptor;)Landroid/system/keystore2/KeyEntryResponse;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist getKeyEntry(Landroid/system/keystore2/KeyDescriptor;)Landroid/system/keystore2/KeyEntryResponse;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1}, Lio/lti/KeyboxImitationHooks;->onGetKeyEntry(Landroid/system/keystore2/KeyDescriptor;)Landroid/system/keystore2/KeyEntryResponse;
            |    
            |        move-result-object v0
            |    
            |        if-eqz v0, :cond_lti_getkeyentry
            |    
            |        return-object v0
            |    
            |        :cond_lti_getkeyentry
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;", "getNumberOfEntries") {
        replace(
            """
            |.method public blacklist getNumberOfEntries(IJ)I
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist getNumberOfEntries(IJ)I
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1}, Lio/lti/KeyboxImitationHooks;->onGetNumberOfEntries(I)Ljava/lang/Integer;
            |    
            |        move-result-object v0
            |    
            |        if-eqz v0, :cond_lti_getnumberofentries
            |    
            |        invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
            |    
            |        move-result v0
            |    
            |        return v0
            |    
            |        :cond_lti_getnumberofentries
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;", "listEntries") {
        replace(
            """
            |.method public blacklist listEntries(IJ)[Landroid/system/keystore2/KeyDescriptor;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist listEntries(IJ)[Landroid/system/keystore2/KeyDescriptor;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1}, Lio/lti/KeyboxImitationHooks;->onListEntries(I)[Landroid/system/keystore2/KeyDescriptor;
            |    
            |        move-result-object v0
            |    
            |        if-eqz v0, :cond_lti_listentries
            |    
            |        return-object v0
            |    
            |        :cond_lti_listentries
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;", "listEntriesBatched") {
        replace(
            """
            |.method public blacklist listEntriesBatched(IJLjava/lang/String;)[Landroid/system/keystore2/KeyDescriptor;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist listEntriesBatched(IJLjava/lang/String;)[Landroid/system/keystore2/KeyDescriptor;
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1, p4}, Lio/lti/KeyboxImitationHooks;->onListEntriesBatched(ILjava/lang/String;)[Landroid/system/keystore2/KeyDescriptor;
            |    
            |        move-result-object v0
            |    
            |        if-eqz v0, :cond_lti_listentriesbatched
            |    
            |        return-object v0
            |    
            |        :cond_lti_listentriesbatched
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;", "updateSubcomponent") {
        replace(
            """
            |.method public blacklist updateSubcomponent(Landroid/system/keystore2/KeyDescriptor;[B[B)V
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
            """
            |.method public blacklist updateSubcomponent(Landroid/system/keystore2/KeyDescriptor;[B[B)V
            |    .locals 5
            |    .annotation system Ldalvik/annotation/Throws;
            |        value = {
            |            Landroid/os/RemoteException;
            |        }
            |    .end annotation
            |
            |    invoke-static {p1, p2, p3}, Lio/lti/KeyboxImitationHooks;->onUpdateSubcomponent(Landroid/system/keystore2/KeyDescriptor;[B[B)Z
            |    
            |        move-result v0
            |    
            |        if-eqz v0, :cond_lti_updatesubcomponent
            |    
            |        return-void
            |    
            |        :cond_lti_updatesubcomponent
            |        invoke-virtual {p0}, Landroid/system/keystore2/IKeystoreService${'$'}Stub${'$'}Proxy;->asBinder()Landroid/os/IBinder;
            """.trimMargin(),
        )
    }
    method("Lcom/android/internal/org/bouncycastle/jcajce/provider/asymmetric/EC${'$'}Mappings;", "configure") {
        replace(
            """
            |.method public blacklist configure(Lcom/android/internal/org/bouncycastle/jcajce/provider/config/ConfigurableProvider;)V
            |    .locals 0
            """.trimMargin(),
            """
            |.method public blacklist configure(Lcom/android/internal/org/bouncycastle/jcajce/provider/config/ConfigurableProvider;)V
            |    .locals 2
            |    
            |        const-string v0, "KeyPairGenerator.EC"
            |    
            |        const-string v1, "com.android.internal.org.bouncycastle.jcajce.provider.asymmetric.ec.KeyPairGeneratorSpi${'$'}EC"
            |    
            |        invoke-interface {p1, v0, v1}, Lcom/android/internal/org/bouncycastle/jcajce/provider/config/ConfigurableProvider;->addAlgorithm(Ljava/lang/String;Ljava/lang/String;)V
            |    
            |        const-string v0, "KeyPairGenerator.ECDSA"
            |    
            |        const-string v1, "com.android.internal.org.bouncycastle.jcajce.provider.asymmetric.ec.KeyPairGeneratorSpi${'$'}ECDSA"
            |    
            |        invoke-interface {p1, v0, v1}, Lcom/android/internal/org/bouncycastle/jcajce/provider/config/ConfigurableProvider;->addAlgorithm(Ljava/lang/String;Ljava/lang/String;)V
            """.trimMargin(),
        )
    }
    addFile("smali_classes6/io/lti/IKeyboxProvider.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/IKeyboxProvider.smali"))
    addFile("smali_classes6/io/lti/KeyProviderManager${'$'}DefaultKeyboxProvider$${'$'}ExternalSyntheticLambda0.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyProviderManager${'$'}DefaultKeyboxProvider$${'$'}ExternalSyntheticLambda0.smali"))
    addFile("smali_classes6/io/lti/KeyProviderManager${'$'}DefaultKeyboxProvider.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyProviderManager${'$'}DefaultKeyboxProvider.smali"))
    addFile("smali_classes6/io/lti/KeyProviderManager-IA.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyProviderManager-IA.smali"))
    addFile("smali_classes6/io/lti/KeyProviderManager.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyProviderManager.smali"))
    addFile("smali_classes6/io/lti/KeyboxChainGenerator${'$'}Digest.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxChainGenerator${'$'}Digest.smali"))
    addFile("smali_classes6/io/lti/KeyboxChainGenerator${'$'}KeyGenParameters.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxChainGenerator${'$'}KeyGenParameters.smali"))
    addFile("smali_classes6/io/lti/KeyboxChainGenerator.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxChainGenerator.smali"))
    addFile("smali_classes6/io/lti/KeyboxDbHelper.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxDbHelper.smali"))
    addFile("smali_classes6/io/lti/KeyboxImitationHooks.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxImitationHooks.smali"))
    addFile("smali_classes6/io/lti/KeyboxOperationUtils${'$'}DecryptOperation.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxOperationUtils${'$'}DecryptOperation.smali"))
    addFile("smali_classes6/io/lti/KeyboxOperationUtils${'$'}KeyAgreementOperation.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxOperationUtils${'$'}KeyAgreementOperation.smali"))
    addFile("smali_classes6/io/lti/KeyboxOperationUtils${'$'}SignOperation.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxOperationUtils${'$'}SignOperation.smali"))
    addFile("smali_classes6/io/lti/KeyboxOperationUtils.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxOperationUtils.smali"))
    addFile("smali_classes6/io/lti/KeyboxUtils$${'$'}ExternalSyntheticLambda0.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxUtils$${'$'}ExternalSyntheticLambda0.smali"))
    addFile("smali_classes6/io/lti/KeyboxUtils.smali", files.text("keybox/framework.jar/smali_classes6/io/lti/KeyboxUtils.smali"))
}
