package io.lti;

import android.app.ActivityThread;
import android.app.Application;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.hardware.security.keymint.KeyParameter;
import android.hardware.security.keymint.KeyParameterValue;
import android.os.Binder;
import android.system.keystore2.KeyDescriptor;
import android.system.keystore2.KeyMetadata;
import android.util.Log;
import com.android.internal.org.bouncycastle.asn1.ASN1Boolean;
import com.android.internal.org.bouncycastle.asn1.ASN1Encodable;
import com.android.internal.org.bouncycastle.asn1.ASN1Enumerated;
import com.android.internal.org.bouncycastle.asn1.ASN1Integer;
import com.android.internal.org.bouncycastle.asn1.ASN1ObjectIdentifier;
import com.android.internal.org.bouncycastle.asn1.ASN1OctetString;
import com.android.internal.org.bouncycastle.asn1.DERNull;
import com.android.internal.org.bouncycastle.asn1.DEROctetString;
import com.android.internal.org.bouncycastle.asn1.DERSequence;
import com.android.internal.org.bouncycastle.asn1.DERSet;
import com.android.internal.org.bouncycastle.asn1.DERTaggedObject;
import com.android.internal.org.bouncycastle.asn1.x500.AttributeTypeAndValue;
import com.android.internal.org.bouncycastle.asn1.x500.RDN;
import com.android.internal.org.bouncycastle.asn1.x500.X500Name;
import com.android.internal.org.bouncycastle.asn1.x500.X500NameBuilder;
import com.android.internal.org.bouncycastle.asn1.x500.style.IETFUtils;
import com.android.internal.org.bouncycastle.asn1.x509.Extension;
import com.android.internal.org.bouncycastle.asn1.x509.KeyUsage;
import com.android.internal.org.bouncycastle.asn1.x509.SubjectPublicKeyInfo;
import com.android.internal.org.bouncycastle.asn1.x509.Time;
import com.android.internal.org.bouncycastle.cert.X509CertificateHolder;
import com.android.internal.org.bouncycastle.cert.X509v3CertificateBuilder;
import com.android.internal.org.bouncycastle.operator.ContentSigner;
import com.android.internal.org.bouncycastle.operator.jcajce.JcaContentSignerBuilder;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.cert.Certificate;
import java.security.cert.X509Certificate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;

final class KeyboxChainGenerator {
    private static final String TAG = "KeyboxChainGenerator";

    /** A SHA-256 digest; equal by content. (Not a record: d8 would add its own RecordTag class to the component.) */
    static final class Digest {
        private final byte[] digest;

        Digest(byte[] digest) {
            this.digest = digest;
        }

        public byte[] digest() {
            return this.digest;
        }

        @Override
        public boolean equals(Object obj) {
            return obj instanceof Digest other && Arrays.equals(digest, other.digest);
        }

        @Override
        public int hashCode() {
            return Arrays.hashCode(digest);
        }

        @Override
        public String toString() {
            return "Digest[digest=" + Arrays.toString(digest) + "]";
        }
    }

    static final class KeyGenParameters {
        public Date activeDateTime;
        public int algorithm;
        public byte[] attestationChallenge;
        public byte[] brand;
        public Date certificateNotAfter;
        public Date certificateNotBefore;
        public BigInteger certificateSerial;
        public X500Name certificateSubject;
        public byte[] device;
        public int ecCurve;
        public String ecCurveName;
        public int keySize;
        public byte[] manufacturer;
        public byte[] model;
        public Date originationExpireDateTime;
        public byte[] product;
        public BigInteger rsaPublicExponent;
        public int usageCountLimit;
        public Date usageExpireDateTime;
        public List<Integer> purpose = new ArrayList();
        public List<Integer> digest = new ArrayList();
        public List<Integer> padding = new ArrayList();
        public List<Integer> mgfDigest = new ArrayList();

        KeyGenParameters(KeyParameter[] keyParameterArr) {
            this.keySize = -1;
            this.algorithm = -1;
            this.certificateSerial = null;
            this.certificateNotBefore = null;
            this.certificateNotAfter = null;
            this.certificateSubject = null;
            this.activeDateTime = null;
            this.originationExpireDateTime = null;
            this.usageExpireDateTime = null;
            this.usageCountLimit = -1;
            this.rsaPublicExponent = null;
            this.ecCurve = -1;
            this.ecCurveName = null;
            this.attestationChallenge = null;
            this.brand = null;
            this.device = null;
            this.product = null;
            this.manufacturer = null;
            this.model = null;
            for (KeyParameter keyParameter : keyParameterArr) {
                KeyParameterValue keyParameterValue = keyParameter.value;
                switch (keyParameter.tag) {
                    case -2147482642:
                        this.certificateSerial = new BigInteger(keyParameterValue.getBlob());
                        break;
                    case -1879047484:
                        this.attestationChallenge = keyParameterValue.getBlob();
                        break;
                    case -1879047482:
                        this.brand = keyParameterValue.getBlob();
                        break;
                    case -1879047481:
                        this.device = keyParameterValue.getBlob();
                        break;
                    case -1879047480:
                        this.product = keyParameterValue.getBlob();
                        break;
                    case -1879047476:
                        this.manufacturer = keyParameterValue.getBlob();
                        break;
                    case -1879047475:
                        this.model = keyParameterValue.getBlob();
                        break;
                    case -1879047185:
                        this.certificateSubject = getCertificateSubject(X500Name.getInstance(keyParameterValue.getBlob()));
                        break;
                    case 268435458:
                        this.algorithm = keyParameterValue.getAlgorithm();
                        break;
                    case 268435466:
                        int ecCurve = keyParameterValue.getEcCurve();
                        this.ecCurve = ecCurve;
                        this.ecCurveName = getEcCurveName(ecCurve);
                        break;
                    case 536870913:
                        this.purpose.add(Integer.valueOf(keyParameterValue.getKeyPurpose()));
                        break;
                    case 536870917:
                        this.digest.add(Integer.valueOf(keyParameterValue.getDigest()));
                        break;
                    case 536870918:
                        this.padding.add(Integer.valueOf(keyParameterValue.getPaddingMode()));
                        break;
                    case 536871115:
                        this.mgfDigest.add(Integer.valueOf(keyParameterValue.getDigest()));
                        break;
                    case 805306371:
                        this.keySize = keyParameterValue.getInteger();
                        break;
                    case 805306773:
                        this.usageCountLimit = keyParameterValue.getInteger();
                        break;
                    case 1342177480:
                        long longInteger = keyParameterValue.getLongInteger();
                        BigInteger bigIntegerValueOf = BigInteger.valueOf(Long.MAX_VALUE & longInteger);
                        this.rsaPublicExponent = longInteger < 0 ? bigIntegerValueOf.setBit(63) : bigIntegerValueOf;
                        break;
                    case 1610613136:
                        this.activeDateTime = new Date(keyParameterValue.getDateTime());
                        break;
                    case 1610613137:
                        this.originationExpireDateTime = new Date(keyParameterValue.getDateTime());
                        break;
                    case 1610613138:
                        this.usageExpireDateTime = new Date(keyParameterValue.getDateTime());
                        break;
                    case 1610613744:
                        this.certificateNotBefore = new Date(keyParameterValue.getDateTime());
                        break;
                    case 1610613745:
                        this.certificateNotAfter = new Date(keyParameterValue.getDateTime());
                        break;
                }
            }
        }

        private static X500Name getCertificateSubject(X500Name x500Name) {
            if (KeyboxUtils.getKeymasterVersion() >= 100) {
                return x500Name;
            }
            X500NameBuilder x500NameBuilder = new X500NameBuilder();
            for (RDN rdn : x500Name.getRDNs()) {
                for (AttributeTypeAndValue attributeTypeAndValue : rdn.getTypesAndValues()) {
                    x500NameBuilder.addRDN(attributeTypeAndValue.getType(), attributeTypeAndValue.getValue().toString());
                }
            }
            return x500NameBuilder.build();
        }

        private static String getEcCurveName(int i) {
            if (i == 0) {
                return "secp224r1";
            }
            if (i == 1) {
                return "secp256r1";
            }
            if (i == 2) {
                return "secp384r1";
            }
            if (i == 3) {
                return "secp521r1";
            }
            if (i == 4) {
                return "CURVE_25519";
            }
            throw new IllegalArgumentException("Unknown EC curve type: " + i);
        }
    }

    private KeyboxChainGenerator() {
    }

    private static DEROctetString createApplicationId() throws Throwable {
        Application applicationCurrentApplication = ActivityThread.currentApplication();
        if (applicationCurrentApplication == null) {
            throw new IllegalStateException("createApplicationId: context not available from ActivityThread!");
        }
        PackageManager packageManager = applicationCurrentApplication.getPackageManager();
        if (packageManager == null) {
            throw new IllegalStateException("createApplicationId: PackageManager not found!");
        }
        int callingUid = Binder.getCallingUid();
        String[] packagesForUid = packageManager.getPackagesForUid(callingUid);
        if (packagesForUid == null || packagesForUid.length == 0) {
            throw new IllegalStateException("No packages found for UID " + callingUid);
        }
        int length = packagesForUid.length;
        ASN1Encodable[] aSN1EncodableArr = new ASN1Encodable[length];
        HashSet hashSet = new HashSet();
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        for (int i = 0; i < length; i++) {
            String str = packagesForUid[i];
            PackageInfo packageInfo = packageManager.getPackageInfo(str, 134217728);
            aSN1EncodableArr[i] = new DERSequence(new ASN1Encodable[]{new DEROctetString(str.getBytes(StandardCharsets.UTF_8)), new ASN1Integer(packageInfo.getLongVersionCode())});
            if (packageInfo.signingInfo.hasMultipleSigners()) {
                for (Signature signature : packageInfo.signingInfo.getApkContentsSigners()) {
                    hashSet.add(new Digest(messageDigest.digest(signature.toByteArray())));
                }
            } else {
                for (Signature signature2 : packageInfo.signingInfo.getSigningCertificateHistory()) {
                    hashSet.add(new Digest(messageDigest.digest(signature2.toByteArray())));
                }
            }
        }
        ASN1Encodable[] aSN1EncodableArr2 = new ASN1Encodable[hashSet.size()];
        Iterator it = hashSet.iterator();
        int i2 = 0;
        while (it.hasNext()) {
            aSN1EncodableArr2[i2] = new DEROctetString(((Digest) it.next()).digest);
            i2++;
        }
        return new DEROctetString(new DERSequence(new ASN1Encodable[]{new DERSet(aSN1EncodableArr), new DERSet(aSN1EncodableArr2)}).getEncoded());
    }

    private static Extension createExtension(KeyGenParameters keyGenParameters, int i) {
        try {
            ArrayList arrayList = new ArrayList();
            ArrayList arrayList2 = new ArrayList();
            if (!keyGenParameters.purpose.isEmpty()) {
                arrayList.add(new DERTaggedObject(true, 1, new DERSet(fromIntList(keyGenParameters.purpose))));
            }
            if (keyGenParameters.algorithm != -1) {
                arrayList.add(new DERTaggedObject(true, 2, new ASN1Integer(keyGenParameters.algorithm)));
            }
            if (keyGenParameters.keySize != -1) {
                arrayList.add(new DERTaggedObject(true, 3, new ASN1Integer(keyGenParameters.keySize)));
            }
            if (!keyGenParameters.digest.isEmpty()) {
                arrayList.add(new DERTaggedObject(true, 5, new DERSet(fromIntList(keyGenParameters.digest))));
            }
            if (!keyGenParameters.padding.isEmpty()) {
                arrayList.add(new DERTaggedObject(true, 6, new DERSet(fromIntList(keyGenParameters.padding))));
            }
            if (keyGenParameters.ecCurve != -1) {
                arrayList.add(new DERTaggedObject(true, 10, new ASN1Integer(keyGenParameters.ecCurve)));
            }
            if (keyGenParameters.rsaPublicExponent != null) {
                arrayList.add(new DERTaggedObject(true, 200, new ASN1Integer(keyGenParameters.rsaPublicExponent)));
            }
            if (KeyboxUtils.getAttestationVersion() >= 100 && !keyGenParameters.mgfDigest.isEmpty()) {
                arrayList.add(new DERTaggedObject(true, 203, new DERSet(fromIntList(keyGenParameters.mgfDigest))));
            }
            if (keyGenParameters.activeDateTime != null) {
                arrayList.add(new DERTaggedObject(true, 400, new ASN1Integer(keyGenParameters.activeDateTime.getTime())));
            }
            if (keyGenParameters.originationExpireDateTime != null) {
                arrayList.add(new DERTaggedObject(true, 401, new ASN1Integer(keyGenParameters.originationExpireDateTime.getTime())));
            }
            if (keyGenParameters.usageExpireDateTime != null) {
                arrayList.add(new DERTaggedObject(true, 402, new ASN1Integer(keyGenParameters.usageExpireDateTime.getTime())));
            }
            if (KeyboxUtils.getAttestationVersion() >= 100 && keyGenParameters.usageCountLimit != -1) {
                arrayList.add(new DERTaggedObject(true, 405, new ASN1Integer(keyGenParameters.usageCountLimit)));
            }
            arrayList.add(new DERTaggedObject(true, 503, DERNull.INSTANCE));
            arrayList2.add(new DERTaggedObject(true, 701, new ASN1Integer(System.currentTimeMillis())));
            arrayList.add(new DERTaggedObject(true, 702, new ASN1Integer(0L)));
            arrayList.add(new DERTaggedObject(true, 704, new DERSequence(new ASN1Encodable[]{new DEROctetString(KeyboxUtils.getVerifiedBootKey()), ASN1Boolean.TRUE, new ASN1Enumerated(0), new DEROctetString(KeyboxUtils.getVerifiedBootHash())})));
            arrayList.add(new DERTaggedObject(true, 705, new ASN1Integer(KeyboxUtils.getOSVersion())));
            arrayList.add(new DERTaggedObject(true, 706, new ASN1Integer(KeyboxUtils.getSecurityPatchLevel(false))));
            arrayList2.add(new DERTaggedObject(true, 709, createApplicationId()));
            if (keyGenParameters.brand != null) {
                arrayList.add(new DERTaggedObject(true, 710, new DEROctetString(keyGenParameters.brand)));
            }
            if (keyGenParameters.device != null) {
                arrayList.add(new DERTaggedObject(true, 711, new DEROctetString(keyGenParameters.device)));
            }
            if (keyGenParameters.product != null) {
                arrayList.add(new DERTaggedObject(true, 712, new DEROctetString(keyGenParameters.product)));
            }
            if (keyGenParameters.manufacturer != null) {
                arrayList.add(new DERTaggedObject(true, 716, new DEROctetString(keyGenParameters.manufacturer)));
            }
            if (keyGenParameters.model != null) {
                arrayList.add(new DERTaggedObject(true, 717, new DEROctetString(keyGenParameters.model)));
            }
            arrayList.add(new DERTaggedObject(true, 718, new ASN1Integer(KeyboxUtils.getSecurityPatchLevel(true))));
            arrayList.add(new DERTaggedObject(true, 719, new ASN1Integer(KeyboxUtils.getSecurityPatchLevel(true))));
            if (KeyboxUtils.getAttestationVersion() >= 400) {
                arrayList2.add(new DERTaggedObject(true, 724, new DEROctetString(KeyboxUtils.getModuleHash())));
            }
            return new Extension(new ASN1ObjectIdentifier("1.3.6.1.4.1.11129.2.1.17"), false, getAsn1OctetString((ASN1Encodable[]) arrayList.toArray(new ASN1Encodable[0]), (ASN1Encodable[]) arrayList2.toArray(new ASN1Encodable[0]), keyGenParameters, i));
        } catch (Throwable th) {
            Log.e(TAG, Log.getStackTraceString(th));
            return null;
        }
    }

    private static ASN1Encodable[] fromIntList(List<Integer> list) {
        ASN1Encodable[] aSN1EncodableArr = new ASN1Encodable[list.size()];
        for (int i = 0; i < list.size(); i++) {
            aSN1EncodableArr[i] = new ASN1Integer(list.get(i).intValue());
        }
        return aSN1EncodableArr;
    }

    static List<Certificate> generateCertChain(KeyPair keyPair, KeyDescriptor keyDescriptor, KeyGenParameters keyGenParameters, int i) {
        X500Name subject;
        PrivateKey privateKey;
        ContentSigner contentSignerBuild;
        PrivateKey privateKey2;
        boolean z = (keyGenParameters.attestationChallenge == null || keyGenParameters.attestationChallenge.length == 0) ? false : true;
        boolean z2 = keyDescriptor != null;
        if (!z && z2) {
            return null;
        }
        if (keyGenParameters.certificateSubject == null) {
            keyGenParameters.certificateSubject = new X500Name(IETFUtils.rDNsFromString("CN=Android Keystore Key", X500Name.getDefaultStyle()));
        }
        if (keyGenParameters.certificateSerial == null) {
            keyGenParameters.certificateSerial = BigInteger.ONE;
        }
        if (keyGenParameters.certificateNotBefore == null) {
            keyGenParameters.certificateNotBefore = new Date(i == 1 ? 0L : System.currentTimeMillis());
        }
        if (keyGenParameters.certificateNotAfter == null) {
            keyGenParameters.certificateNotAfter = Date.from(i == 1 ? LocalDateTime.of(2106, 2, 7, 6, 28, 15).toInstant(ZoneOffset.UTC) : LocalDateTime.of(2028, 5, 23, 23, 59, 59).toInstant(ZoneOffset.UTC));
        }
        try {
            if (!z) {
                subject = keyGenParameters.certificateSubject;
            } else if (z2) {
                subject = new X509CertificateHolder(((KeyMetadata) KeyboxUtils.fetchKeyData(keyDescriptor).second).certificate).getSubject();
            } else {
                subject = KeyboxUtils.fetchCertificateHolderFromKeybox(Objects.equals(Integer.valueOf(keyGenParameters.algorithm), 1) ? "RSA" : "EC").getSubject();
            }
            X509v3CertificateBuilder x509v3CertificateBuilder = new X509v3CertificateBuilder(subject, keyGenParameters.certificateSerial, new Time(keyGenParameters.certificateNotBefore), new Time(keyGenParameters.certificateNotAfter), keyGenParameters.certificateSubject, SubjectPublicKeyInfo.getInstance(keyPair.getPublic().getEncoded()));
            if (z) {
                x509v3CertificateBuilder.addExtension(createExtension(keyGenParameters, i));
            }
            x509v3CertificateBuilder.addExtension(Extension.keyUsage, true, new KeyUsage(KeyboxUtils.getKeyUsage(keyGenParameters)));
            if (Objects.equals(Integer.valueOf(keyGenParameters.algorithm), 1)) {
                JcaContentSignerBuilder jcaContentSignerBuilder = new JcaContentSignerBuilder("SHA256withRSA");
                if (z) {
                    privateKey2 = z2 ? ((KeyPair) KeyboxUtils.fetchKeyData(keyDescriptor).first).getPrivate() : KeyboxUtils.fetchPrivateKeyFromKeybox("RSA");
                } else {
                    privateKey2 = keyPair.getPrivate();
                }
                contentSignerBuild = jcaContentSignerBuilder.build(privateKey2);
            } else {
                JcaContentSignerBuilder jcaContentSignerBuilder2 = new JcaContentSignerBuilder("SHA256withECDSA");
                if (z) {
                    privateKey = z2 ? ((KeyPair) KeyboxUtils.fetchKeyData(keyDescriptor).first).getPrivate() : KeyboxUtils.fetchPrivateKeyFromKeybox("EC");
                } else {
                    privateKey = keyPair.getPrivate();
                }
                contentSignerBuild = jcaContentSignerBuilder2.build(privateKey);
            }
            X509Certificate certificateFromHolder = KeyboxUtils.getCertificateFromHolder(x509v3CertificateBuilder.build(contentSignerBuild));
            ArrayList arrayList = new ArrayList();
            arrayList.add(certificateFromHolder);
            if (z && !z2) {
                arrayList.addAll(KeyboxUtils.fetchCertificateChainFromKeybox(certificateFromHolder.getPublicKey().getAlgorithm()));
            }
            return arrayList;
        } catch (Throwable th) {
            Log.e(TAG, Log.getStackTraceString(th));
            return null;
        }
    }

    private static ASN1OctetString getAsn1OctetString(ASN1Encodable[] aSN1EncodableArr, ASN1Encodable[] aSN1EncodableArr2, KeyGenParameters keyGenParameters, int i) throws IOException {
        return new DEROctetString(new DERSequence(new ASN1Encodable[]{new ASN1Integer(KeyboxUtils.getAttestationVersion()), new ASN1Enumerated(i), new ASN1Integer(KeyboxUtils.getKeymasterVersion()), new ASN1Enumerated(i), new DEROctetString(keyGenParameters.attestationChallenge), new DEROctetString("".getBytes()), new DERSequence(aSN1EncodableArr2), new DERSequence(aSN1EncodableArr)}));
    }
}
