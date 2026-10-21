package io.lti;

import android.hardware.security.keymint.KeyParameter;
import android.hardware.security.keymint.KeyParameterValue;
import android.os.Binder;
import android.os.ServiceSpecificException;
import android.system.keystore2.Authorization;
import android.system.keystore2.CreateOperationResponse;
import android.system.keystore2.IKeystoreSecurityLevel;
import android.system.keystore2.KeyDescriptor;
import android.system.keystore2.KeyEntryResponse;
import android.system.keystore2.KeyMetadata;
import android.util.Log;
import android.util.Pair;
import java.security.KeyPair;
import java.security.cert.Certificate;
import java.util.ArrayList;
import java.util.List;

public final class KeyboxImitationHooks {
    private static final boolean DEBUG = false;
    private static final String TAG = "KeyboxImitationHooks";
    private static IKeystoreSecurityLevel sSecurityLevel = null;
    private static int sSecurityLevelType = 1;

    private KeyboxImitationHooks() {
    }

    private static KeyMetadata buildMetadata(List<Certificate> list, KeyboxChainGenerator.KeyGenParameters keyGenParameters, KeyDescriptor keyDescriptor, int i, int i2) {
        try {
            KeyMetadata keyMetadata = new KeyMetadata();
            if (list != null && !list.isEmpty()) {
                KeyboxUtils.putCertificateChain(keyMetadata, (Certificate[]) list.toArray(new Certificate[0]));
            }
            keyMetadata.modificationTimeMs = System.currentTimeMillis();
            keyMetadata.keySecurityLevel = i;
            KeyDescriptor keyDescriptor2 = new KeyDescriptor();
            keyDescriptor2.domain = 4;
            keyDescriptor2.nspace = keyDescriptor.alias.hashCode();
            keyMetadata.key = keyDescriptor2;
            ArrayList arrayList = new ArrayList();
            for (Integer num : keyGenParameters.purpose) {
                Authorization authorization = new Authorization();
                authorization.keyParameter = new KeyParameter();
                authorization.keyParameter.tag = 536870913;
                authorization.keyParameter.value = KeyParameterValue.keyPurpose(num.intValue());
                authorization.securityLevel = i;
                arrayList.add(authorization);
            }
            if (keyGenParameters.algorithm != -1) {
                Authorization authorization2 = new Authorization();
                authorization2.keyParameter = new KeyParameter();
                authorization2.keyParameter.tag = 268435458;
                authorization2.keyParameter.value = KeyParameterValue.algorithm(keyGenParameters.algorithm);
                authorization2.securityLevel = i;
                arrayList.add(authorization2);
            }
            if (keyGenParameters.keySize != -1) {
                Authorization authorization3 = new Authorization();
                authorization3.keyParameter = new KeyParameter();
                authorization3.keyParameter.tag = 805306371;
                authorization3.keyParameter.value = KeyParameterValue.integer(keyGenParameters.keySize);
                authorization3.securityLevel = i;
                arrayList.add(authorization3);
            }
            for (Integer num2 : keyGenParameters.digest) {
                Authorization authorization4 = new Authorization();
                authorization4.keyParameter = new KeyParameter();
                authorization4.keyParameter.tag = 536870917;
                authorization4.keyParameter.value = KeyParameterValue.digest(num2.intValue());
                authorization4.securityLevel = i;
                arrayList.add(authorization4);
            }
            for (Integer num3 : keyGenParameters.mgfDigest) {
                Authorization authorization5 = new Authorization();
                authorization5.keyParameter = new KeyParameter();
                authorization5.keyParameter.tag = 536871115;
                authorization5.keyParameter.value = KeyParameterValue.digest(num3.intValue());
                authorization5.securityLevel = i;
                arrayList.add(authorization5);
            }
            for (Integer num4 : keyGenParameters.padding) {
                Authorization authorization6 = new Authorization();
                authorization6.keyParameter = new KeyParameter();
                authorization6.keyParameter.tag = 536870918;
                authorization6.keyParameter.value = KeyParameterValue.paddingMode(num4.intValue());
                authorization6.securityLevel = i;
                arrayList.add(authorization6);
            }
            if (keyGenParameters.ecCurve != -1) {
                Authorization authorization7 = new Authorization();
                authorization7.keyParameter = new KeyParameter();
                authorization7.keyParameter.tag = 268435466;
                authorization7.keyParameter.value = KeyParameterValue.ecCurve(keyGenParameters.ecCurve);
                authorization7.securityLevel = i;
                arrayList.add(authorization7);
            }
            if (keyGenParameters.rsaPublicExponent != null) {
                Authorization authorization8 = new Authorization();
                authorization8.keyParameter = new KeyParameter();
                authorization8.keyParameter.tag = 1342177480;
                authorization8.keyParameter.value = KeyParameterValue.longInteger(keyGenParameters.rsaPublicExponent.longValue());
                authorization8.securityLevel = i;
                arrayList.add(authorization8);
            }
            if (keyGenParameters.activeDateTime != null) {
                Authorization authorization9 = new Authorization();
                authorization9.keyParameter = new KeyParameter();
                authorization9.keyParameter.tag = 1610613136;
                authorization9.keyParameter.value = KeyParameterValue.dateTime(keyGenParameters.activeDateTime.getTime());
                authorization9.securityLevel = i;
                arrayList.add(authorization9);
            }
            if (keyGenParameters.originationExpireDateTime != null) {
                Authorization authorization10 = new Authorization();
                authorization10.keyParameter = new KeyParameter();
                authorization10.keyParameter.tag = 1610613137;
                authorization10.keyParameter.value = KeyParameterValue.dateTime(keyGenParameters.originationExpireDateTime.getTime());
                authorization10.securityLevel = i;
                arrayList.add(authorization10);
            }
            if (keyGenParameters.usageExpireDateTime != null) {
                Authorization authorization11 = new Authorization();
                authorization11.keyParameter = new KeyParameter();
                authorization11.keyParameter.tag = 1610613138;
                authorization11.keyParameter.value = KeyParameterValue.dateTime(keyGenParameters.usageExpireDateTime.getTime());
                authorization11.securityLevel = i;
                arrayList.add(authorization11);
            }
            if (KeyboxUtils.getAttestationVersion() >= 100 && keyGenParameters.usageCountLimit != -1) {
                Authorization authorization12 = new Authorization();
                authorization12.keyParameter = new KeyParameter();
                authorization12.keyParameter.tag = 805306773;
                authorization12.keyParameter.value = KeyParameterValue.integer(keyGenParameters.usageCountLimit);
                authorization12.securityLevel = i;
                arrayList.add(authorization12);
            }
            Authorization authorization13 = new Authorization();
            authorization13.keyParameter = new KeyParameter();
            authorization13.keyParameter.tag = 1879048695;
            authorization13.keyParameter.value = KeyParameterValue.boolValue(true);
            authorization13.securityLevel = i;
            arrayList.add(authorization13);
            Authorization authorization14 = new Authorization();
            authorization14.keyParameter = new KeyParameter();
            authorization14.keyParameter.tag = 1610613437;
            authorization14.keyParameter.value = KeyParameterValue.dateTime(System.currentTimeMillis());
            authorization14.securityLevel = i;
            arrayList.add(authorization14);
            Authorization authorization15 = new Authorization();
            authorization15.keyParameter = new KeyParameter();
            authorization15.keyParameter.tag = 268436158;
            authorization15.keyParameter.value = KeyParameterValue.origin(i2);
            authorization15.securityLevel = i;
            arrayList.add(authorization15);
            Authorization authorization16 = new Authorization();
            authorization16.keyParameter = new KeyParameter();
            authorization16.keyParameter.tag = 805307073;
            authorization16.keyParameter.value = KeyParameterValue.integer(KeyboxUtils.getOSVersion());
            authorization16.securityLevel = i;
            arrayList.add(authorization16);
            Authorization authorization17 = new Authorization();
            authorization17.keyParameter = new KeyParameter();
            authorization17.keyParameter.tag = 805307074;
            authorization17.keyParameter.value = KeyParameterValue.integer(KeyboxUtils.getSecurityPatchLevel(DEBUG));
            authorization17.securityLevel = i;
            arrayList.add(authorization17);
            Authorization authorization18 = new Authorization();
            authorization18.keyParameter = new KeyParameter();
            authorization18.keyParameter.tag = 805307086;
            authorization18.keyParameter.value = KeyParameterValue.integer(KeyboxUtils.getSecurityPatchLevel(true));
            authorization18.securityLevel = i;
            arrayList.add(authorization18);
            Authorization authorization19 = new Authorization();
            authorization19.keyParameter = new KeyParameter();
            authorization19.keyParameter.tag = 805307087;
            authorization19.keyParameter.value = KeyParameterValue.integer(KeyboxUtils.getSecurityPatchLevel(true));
            authorization19.securityLevel = i;
            arrayList.add(authorization19);
            Authorization authorization20 = new Authorization();
            authorization20.keyParameter = new KeyParameter();
            authorization20.keyParameter.tag = 805306869;
            authorization20.keyParameter.value = KeyParameterValue.integer(Binder.getCallingUid() / 100000);
            authorization20.securityLevel = i;
            arrayList.add(authorization20);
            if (KeyboxUtils.getAttestationVersion() >= 400) {
                Authorization authorization21 = new Authorization();
                authorization21.keyParameter = new KeyParameter();
                authorization21.keyParameter.tag = -1879047468;
                authorization21.keyParameter.value = KeyParameterValue.blob(KeyboxUtils.getModuleHash());
                authorization21.securityLevel = i;
                arrayList.add(authorization21);
            }
            keyMetadata.authorizations = (Authorization[]) arrayList.toArray(new Authorization[0]);
            return keyMetadata;
        } catch (Exception e) {
            Log.e(TAG, "Failed to build key metadata", e);
            return null;
        }
    }

    private static void dlog(String str) {
    }

    public static CreateOperationResponse onCreateOperation(KeyDescriptor keyDescriptor, KeyParameter[] keyParameterArr) throws ServiceSpecificException {
        Pair<KeyPair, KeyMetadata> pairFetchKeyData;
        if (!KeyProviderManager.isKeyboxAvailable() || (pairFetchKeyData = KeyboxUtils.fetchKeyData(keyDescriptor)) == null) {
            return null;
        }
        String algorithmFromAuthorizations = KeyboxUtils.getAlgorithmFromAuthorizations(((KeyMetadata) pairFetchKeyData.second).authorizations);
        if (algorithmFromAuthorizations == null) {
            throw new ServiceSpecificException(4, "Key algorithm could not be obtained");
        }
        KeyboxChainGenerator.KeyGenParameters keyGenParameters = new KeyboxChainGenerator.KeyGenParameters(keyParameterArr);
        Integer num = !keyGenParameters.purpose.isEmpty() ? (Integer) keyGenParameters.purpose.get(0) : null;
        Integer num2 = !keyGenParameters.padding.isEmpty() ? (Integer) keyGenParameters.padding.get(0) : null;
        Integer num3 = keyGenParameters.digest.isEmpty() ? null : (Integer) keyGenParameters.digest.get(0);
        String signDigest = KeyboxUtils.getSignDigest(num3);
        if (num == null) {
            throw new ServiceSpecificException(-38, "No operation purpose specified");
        }
        Authorization[] authorizationArr = ((KeyMetadata) pairFetchKeyData.second).authorizations;
        int length = authorizationArr.length;
        int i = 0;
        boolean z = DEBUG;
        boolean z2 = DEBUG;
        boolean z3 = DEBUG;
        while (i < length) {
            Authorization authorization = authorizationArr[i];
            Integer num4 = num;
            if (authorization.keyParameter.tag == 536870913) {
                if (authorization.keyParameter.value.getKeyPurpose() == num4.intValue()) {
                    z = true;
                }
            } else if (authorization.keyParameter.tag == 536870918) {
                if (num2 != null && authorization.keyParameter.value.getPaddingMode() == num2.intValue()) {
                    z2 = true;
                }
            } else if (authorization.keyParameter.tag == 536870917 && num3 != null && authorization.keyParameter.value.getDigest() == num3.intValue()) {
                z3 = true;
            }
            i++;
            num = num4;
        }
        Integer num5 = num;
        if (!z) {
            throw new ServiceSpecificException(-3);
        }
        if (!z2) {
            throw new ServiceSpecificException(-11);
        }
        if (!z3) {
            throw new ServiceSpecificException(-13);
        }
        try {
            int iHashCode = algorithmFromAuthorizations.hashCode();
            if (iHashCode != -276032869) {
                if (iHashCode != 2206) {
                    if (iHashCode == 81440 && algorithmFromAuthorizations.equals("RSA")) {
                        if (num5.intValue() != 1) {
                            if (num5.intValue() != 2) {
                                throw new ServiceSpecificException(-2);
                            }
                            if (num2 == null) {
                                throw new ServiceSpecificException(-10);
                            }
                            if (num2.intValue() == 1) {
                                if (num3 != null && num3.intValue() != 0) {
                                    throw new ServiceSpecificException(-13, "Unpadded RSA sign requires Digest::None");
                                }
                                return KeyboxOperationUtils.getSignOperation(((KeyPair) pairFetchKeyData.first).getPrivate(), "RSA/None/NoPadding");
                            }
                            if (num2.intValue() == 3) {
                                if (signDigest != null) {
                                    return KeyboxOperationUtils.getSignOperation(((KeyPair) pairFetchKeyData.first).getPrivate(), signDigest + "withRSA/PSS");
                                }
                                throw new ServiceSpecificException(-13, "Digest required for RSA-PSS");
                            }
                            if (num2.intValue() != 5) {
                                throw new ServiceSpecificException(-10, "Padding " + num2 + " unsupported with KeyPurpose::SIGN");
                            }
                            if (signDigest != null) {
                                return KeyboxOperationUtils.getSignOperation(((KeyPair) pairFetchKeyData.first).getPrivate(), signDigest + "withRSA");
                            }
                            throw new ServiceSpecificException(-13, "Digest required for RSA-PKCS_1_5_SIGN");
                        }
                        if (num2 == null) {
                            throw new ServiceSpecificException(-10);
                        }
                        if (num2.intValue() == 1) {
                            return KeyboxOperationUtils.getDecryptOperation(((KeyPair) pairFetchKeyData.first).getPrivate(), "RSA/None/NoPadding");
                        }
                        if (num2.intValue() != 2) {
                            if (num2.intValue() == 4) {
                                return KeyboxOperationUtils.getDecryptOperation(((KeyPair) pairFetchKeyData.first).getPrivate(), "RSA/None/PKCS1Padding");
                            }
                            throw new ServiceSpecificException(-10, "Padding " + num2 + " unsupported with KeyPurpose::DECRYPT");
                        }
                        if (num3 == null || num3.intValue() == 0) {
                            throw new ServiceSpecificException(-13, "Digest required for RSA-OAEP");
                        }
                        int iIntValue = keyGenParameters.mgfDigest.isEmpty() ? 2 : ((Integer) keyGenParameters.mgfDigest.get(0)).intValue();
                        if (iIntValue == 0) {
                            throw new ServiceSpecificException(-79, "MGF digest cannot be NONE for RSA-OAEP");
                        }
                        boolean z4 = true;
                        for (Authorization authorization2 : ((KeyMetadata) pairFetchKeyData.second).authorizations) {
                            if (authorization2.keyParameter.tag == 536871115 && authorization2.keyParameter.value.getDigest() != iIntValue) {
                                z4 = DEBUG;
                            }
                        }
                        if (z4) {
                            return KeyboxOperationUtils.getDecryptOperation(((KeyPair) pairFetchKeyData.first).getPrivate(), "RSA/None/OAEPWith" + KeyboxUtils.getDecryptDigest(num3) + "AndMGF1Padding", num3, Integer.valueOf(iIntValue));
                        }
                        throw new ServiceSpecificException(-78, "MGF digest" + iIntValue + " not allowed by key characteristics");
                    }
                } else if (algorithmFromAuthorizations.equals("EC")) {
                    if (num5.intValue() != 2) {
                        if (num5.intValue() == 6) {
                            return KeyboxOperationUtils.getKeyAgreementOperation(((KeyPair) pairFetchKeyData.first).getPrivate());
                        }
                        throw new ServiceSpecificException(-2);
                    }
                    if (num3 == null || signDigest == null) {
                        throw new ServiceSpecificException(-12);
                    }
                    if (num3.intValue() != 1) {
                        return KeyboxOperationUtils.getSignOperation(((KeyPair) pairFetchKeyData.first).getPrivate(), signDigest + "withECDSA");
                    }
                    throw new ServiceSpecificException(-12, "Digest::MD5 unsupported for EC signing");
                }
            } else if (algorithmFromAuthorizations.equals("Ed25519")) {
                if (num5.intValue() != 2) {
                    throw new ServiceSpecificException(-2);
                }
                if (num3 != null && num3.intValue() != 0) {
                    throw new ServiceSpecificException(-12, "Ed25519 only supports Digest::None");
                }
                return KeyboxOperationUtils.getSignOperation(((KeyPair) pairFetchKeyData.first).getPrivate(), "Ed25519");
            }
        } catch (Exception e) {
            if (e instanceof ServiceSpecificException serviceError) {
                throw serviceError;
            }
            Log.e(TAG, "Failed to createOperation", e);
        }
        throw new ServiceSpecificException(-4);
    }

    public static boolean onDeleteKey(KeyDescriptor keyDescriptor) {
        KeyboxDbHelper keyboxDbHelper;
        if (!KeyProviderManager.isKeyboxAvailable()) {
            return DEBUG;
        }
        if ((keyDescriptor.domain != 0 && keyDescriptor.domain != 4) || (keyboxDbHelper = KeyboxDbHelper.getInstance()) == null) {
            return DEBUG;
        }
        long jHashCode = keyDescriptor.nspace;
        if (keyDescriptor.domain != 4) {
            jHashCode = keyDescriptor.alias.hashCode();
        }
        if (!keyboxDbHelper.deleteKeyData(jHashCode)) {
            return DEBUG;
        }
        dlog("Deleted key with alias \"" + keyDescriptor.alias + "\" for uid " + Binder.getCallingUid());
        return true;
    }

    public static KeyMetadata onGenerateKey(KeyDescriptor keyDescriptor, KeyDescriptor keyDescriptor2, KeyParameter[] keyParameterArr) {
        KeyMetadata keyMetadataBuildMetadata;
        if (!KeyProviderManager.isKeyboxAvailable() || KeyboxUtils.isCallerSamsungKeystoreUtils() || keyDescriptor.domain != 0) {
            return null;
        }
        KeyboxChainGenerator.KeyGenParameters keyGenParameters = new KeyboxChainGenerator.KeyGenParameters(keyParameterArr);
        if (keyGenParameters.algorithm != 3 && keyGenParameters.algorithm != 1) {
            return null;
        }
        if (keyGenParameters.purpose.contains(7) && keyGenParameters.purpose.size() > 1) {
            return null;
        }
        try {
            KeyPair keyPairGenerateKeyPair = KeyboxUtils.generateKeyPair(keyGenParameters);
            List<Certificate> listGenerateCertChain = KeyboxChainGenerator.generateCertChain(keyPairGenerateKeyPair, keyDescriptor2, keyGenParameters, sSecurityLevelType);
            if (listGenerateCertChain == null || listGenerateCertChain.isEmpty() || (keyMetadataBuildMetadata = buildMetadata(listGenerateCertChain, keyGenParameters, keyDescriptor, sSecurityLevelType, 0)) == null) {
                return null;
            }
            KeyboxDbHelper keyboxDbHelper = KeyboxDbHelper.getInstance();
            if (keyboxDbHelper != null) {
                keyboxDbHelper.storeKeyData(keyDescriptor.alias, keyPairGenerateKeyPair, keyMetadataBuildMetadata);
            }
            dlog("Generated key with alias \"" + keyDescriptor.alias + "\" for uid " + Binder.getCallingUid());
            return keyMetadataBuildMetadata;
        } catch (Exception e) {
            Log.e(TAG, "Failed to generate key", e);
            return null;
        }
    }

    public static KeyEntryResponse onGetKeyEntry(KeyDescriptor keyDescriptor) {
        Pair<KeyPair, KeyMetadata> pairFetchKeyData;
        if (!KeyProviderManager.isKeyboxAvailable() || (pairFetchKeyData = KeyboxUtils.fetchKeyData(keyDescriptor)) == null || pairFetchKeyData.second == null) {
            return null;
        }
        KeyEntryResponse keyEntryResponse = new KeyEntryResponse();
        keyEntryResponse.metadata = (KeyMetadata) pairFetchKeyData.second;
        keyEntryResponse.iSecurityLevel = sSecurityLevel;
        dlog("Retrieved key with alias \"" + keyDescriptor.alias + "\" for uid " + Binder.getCallingUid());
        return keyEntryResponse;
    }

    public static Integer onGetNumberOfEntries(int i) {
        KeyboxDbHelper keyboxDbHelper;
        KeyDescriptor[] keyDescriptorArrFetchKeyEntries;
        if (!KeyProviderManager.isKeyboxAvailable() || i != 0 || (keyboxDbHelper = KeyboxDbHelper.getInstance()) == null || (keyDescriptorArrFetchKeyEntries = keyboxDbHelper.fetchKeyEntries(null)) == null || keyDescriptorArrFetchKeyEntries.length <= 0) {
            return null;
        }
        dlog("Fetched all key entries count for uid " + Binder.getCallingUid());
        return Integer.valueOf(keyDescriptorArrFetchKeyEntries.length);
    }

    public static KeyMetadata onImportKey(KeyDescriptor keyDescriptor, KeyParameter[] keyParameterArr, byte[] bArr) {
        if (!KeyProviderManager.isKeyboxAvailable() || keyDescriptor.domain != 0) {
            return null;
        }
        KeyboxChainGenerator.KeyGenParameters keyGenParameters = new KeyboxChainGenerator.KeyGenParameters(keyParameterArr);
        if ((keyGenParameters.algorithm == 3 || keyGenParameters.algorithm == 1) && keyGenParameters.purpose.contains(7) && keyGenParameters.purpose.size() <= 1) {
            try {
                KeyPair keyPairGenerateKeyPairFromKeyData = KeyboxUtils.generateKeyPairFromKeyData(bArr);
                KeyMetadata keyMetadataBuildMetadata = buildMetadata(null, keyGenParameters, keyDescriptor, sSecurityLevelType, 2);
                if (keyMetadataBuildMetadata == null) {
                    return null;
                }
                KeyboxDbHelper keyboxDbHelper = KeyboxDbHelper.getInstance();
                if (keyboxDbHelper != null) {
                    keyboxDbHelper.storeKeyData(keyDescriptor.alias, keyPairGenerateKeyPairFromKeyData, keyMetadataBuildMetadata);
                }
                dlog("Imported key with alias \"" + keyDescriptor.alias + "\" for uid " + Binder.getCallingUid());
                return keyMetadataBuildMetadata;
            } catch (Exception e) {
                Log.e(TAG, "Failed to import key", e);
            }
        }
        return null;
    }

    public static KeyDescriptor[] onListEntries(int i) {
        KeyboxDbHelper keyboxDbHelper;
        KeyDescriptor[] keyDescriptorArrFetchKeyEntries;
        if (!KeyProviderManager.isKeyboxAvailable() || i != 0 || (keyboxDbHelper = KeyboxDbHelper.getInstance()) == null || (keyDescriptorArrFetchKeyEntries = keyboxDbHelper.fetchKeyEntries(null)) == null || keyDescriptorArrFetchKeyEntries.length <= 0) {
            return null;
        }
        dlog("Fetched all key entries for uid " + Binder.getCallingUid());
        return keyDescriptorArrFetchKeyEntries;
    }

    public static KeyDescriptor[] onListEntriesBatched(int i, String str) {
        KeyboxDbHelper keyboxDbHelper;
        KeyDescriptor[] keyDescriptorArrFetchKeyEntries;
        if (!KeyProviderManager.isKeyboxAvailable() || i != 0 || (keyboxDbHelper = KeyboxDbHelper.getInstance()) == null || (keyDescriptorArrFetchKeyEntries = keyboxDbHelper.fetchKeyEntries(str)) == null || keyDescriptorArrFetchKeyEntries.length <= 0) {
            return null;
        }
        dlog("Fetched key entries with lastAlias \"" + str + "\" for uid " + Binder.getCallingUid());
        return keyDescriptorArrFetchKeyEntries;
    }

    public static boolean onUpdateSubcomponent(KeyDescriptor keyDescriptor, byte[] bArr, byte[] bArr2) {
        Pair<KeyPair, KeyMetadata> pairFetchKeyData;
        KeyMetadata keyMetadata;
        if (KeyProviderManager.isKeyboxAvailable() && (pairFetchKeyData = KeyboxUtils.fetchKeyData(keyDescriptor)) != null && (keyMetadata = (KeyMetadata) pairFetchKeyData.second) != null) {
            keyMetadata.certificate = bArr;
            keyMetadata.certificateChain = bArr2;
            KeyboxDbHelper keyboxDbHelper = KeyboxDbHelper.getInstance();
            if (keyboxDbHelper != null) {
                keyboxDbHelper.updateKeyData(keyDescriptor.nspace, (KeyPair) pairFetchKeyData.first, keyMetadata);
                dlog("Updated key with nspace \"" + keyDescriptor.nspace + "\" for uid " + Binder.getCallingUid());
                return true;
            }
        }
        return DEBUG;
    }

    public static void setSecurityLevel(IKeystoreSecurityLevel iKeystoreSecurityLevel, int i) {
        sSecurityLevel = iKeystoreSecurityLevel;
        sSecurityLevelType = i;
    }
}
