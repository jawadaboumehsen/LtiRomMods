package io.lti;

import android.app.ActivityThread;
import android.content.Context;
import android.os.Build;
import android.os.SystemProperties;
import android.system.keystore2.Authorization;
import android.system.keystore2.KeyDescriptor;
import android.system.keystore2.KeyMetadata;
import android.text.TextUtils;
import android.util.Log;
import android.util.Pair;
import com.android.internal.org.bouncycastle.asn1.ASN1Primitive;
import com.android.internal.org.bouncycastle.asn1.ASN1Sequence;
import com.android.internal.org.bouncycastle.asn1.ASN1Set;
import com.android.internal.org.bouncycastle.asn1.DERNull;
import com.android.internal.org.bouncycastle.asn1.pkcs.PKCSObjectIdentifiers;
import com.android.internal.org.bouncycastle.asn1.pkcs.PrivateKeyInfo;
import com.android.internal.org.bouncycastle.asn1.pkcs.RSAPrivateKey;
import com.android.internal.org.bouncycastle.asn1.pkcs.RSAPublicKey;
import com.android.internal.org.bouncycastle.asn1.sec.ECPrivateKey;
import com.android.internal.org.bouncycastle.asn1.x509.AlgorithmIdentifier;
import com.android.internal.org.bouncycastle.asn1.x509.SubjectPublicKeyInfo;
import com.android.internal.org.bouncycastle.asn1.x9.ECNamedCurveTable;
import com.android.internal.org.bouncycastle.asn1.x9.X9ECParameters;
import com.android.internal.org.bouncycastle.asn1.x9.X9ObjectIdentifiers;
import com.android.internal.org.bouncycastle.cert.X509CertificateHolder;
import com.android.internal.org.bouncycastle.crypto.params.AsymmetricKeyParameter;
import com.android.internal.org.bouncycastle.crypto.params.ECDomainParameters;
import com.android.internal.org.bouncycastle.crypto.params.ECPrivateKeyParameters;
import com.android.internal.org.bouncycastle.crypto.params.RSAPrivateCrtKeyParameters;
import com.android.internal.org.bouncycastle.crypto.util.PrivateKeyFactory;
import com.android.internal.org.bouncycastle.jce.provider.BouncyCastleProvider;
import com.android.internal.org.bouncycastle.jce.spec.ECNamedCurveSpec;
import com.android.internal.org.bouncycastle.math.ec.ECPoint;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.Provider;
import java.security.SecureRandom;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.ECFieldFp;
import java.security.spec.ECGenParameterSpec;
import java.security.spec.ECPrivateKeySpec;
import java.security.spec.ECPublicKeySpec;
import java.security.spec.EllipticCurve;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.RSAKeyGenParameterSpec;
import java.security.spec.RSAPrivateCrtKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Enumeration;
import java.util.HexFormat;
import java.util.List;
import java.util.Objects;
import java.util.function.Predicate;

final class KeyboxUtils {
    private static final boolean DEBUG = false;
    private static final String TAG = "KeyboxUtils";

    private KeyboxUtils() {
    }

    private static byte[] decodePemOrBase64(String str) {
        return Base64.getDecoder().decode(str.replaceAll("-----BEGIN [^-]+-----", "").replaceAll("-----END [^-]+-----", "").replaceAll("\\s+", ""));
    }

    private static void dlog(String str) {
    }

    static List<Certificate> fetchCertificateChainFromKeybox(String str) throws Exception {
        IKeyboxProvider provider = KeyProviderManager.getProvider();
        String[] ecCertificateChain = "EC".equals(str) ? provider.getEcCertificateChain() : provider.getRsaCertificateChain();
        ArrayList arrayList = new ArrayList();
        for (String str2 : ecCertificateChain) {
            arrayList.add(parseCertificate(str2));
        }
        return arrayList;
    }

    static X509CertificateHolder fetchCertificateHolderFromKeybox(String str) throws Exception {
        IKeyboxProvider provider = KeyProviderManager.getProvider();
        return new X509CertificateHolder(decodePemOrBase64("EC".equals(str) ? provider.getEcCertificateChain()[0] : provider.getRsaCertificateChain()[0]));
    }

    static Pair<KeyPair, KeyMetadata> fetchKeyData(KeyDescriptor keyDescriptor) {
        KeyboxDbHelper keyboxDbHelper;
        if ((keyDescriptor.domain != 0 && keyDescriptor.domain != 4) || (keyboxDbHelper = KeyboxDbHelper.getInstance()) == null) {
            return null;
        }
        long jHashCode = keyDescriptor.nspace;
        if (keyDescriptor.domain != 4) {
            jHashCode = keyDescriptor.alias.hashCode();
        }
        return keyboxDbHelper.fetchKeyData(jHashCode);
    }

    static PrivateKey fetchPrivateKeyFromKeybox(String str) throws Exception {
        IKeyboxProvider provider = KeyProviderManager.getProvider();
        return parsePrivateKey("EC".equals(str) ? provider.getEcPrivateKey() : provider.getRsaPrivateKey(), str);
    }

    static KeyPair generateKeyPair(KeyboxChainGenerator.KeyGenParameters keyGenParameters) throws Exception {
        if (Objects.equals(Integer.valueOf(keyGenParameters.algorithm), 3)) {
            dlog("Generating EC keypair with curve " + keyGenParameters.ecCurveName);
            if (keyGenParameters.ecCurveName.equals("CURVE_25519")) {
                return KeyPairGenerator.getInstance("Ed25519", (Provider) new BouncyCastleProvider()).generateKeyPair();
            }
            ECGenParameterSpec eCGenParameterSpec = new ECGenParameterSpec(keyGenParameters.ecCurveName);
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("ECDSA", (Provider) new BouncyCastleProvider());
            keyPairGenerator.initialize(eCGenParameterSpec);
            return keyPairGenerator.generateKeyPair();
        }
        if (!Objects.equals(Integer.valueOf(keyGenParameters.algorithm), 1)) {
            throw new IllegalArgumentException("Unknown algorithm: " + keyGenParameters.algorithm);
        }
        dlog("Generating RSA keypair of size " + keyGenParameters.keySize);
        RSAKeyGenParameterSpec rSAKeyGenParameterSpec = new RSAKeyGenParameterSpec(keyGenParameters.keySize, keyGenParameters.rsaPublicExponent);
        KeyPairGenerator keyPairGenerator2 = KeyPairGenerator.getInstance("RSA", (Provider) new BouncyCastleProvider());
        keyPairGenerator2.initialize(rSAKeyGenParameterSpec);
        return keyPairGenerator2.generateKeyPair();
    }

    static KeyPair generateKeyPairFromKeyData(byte[] bArr) throws Exception {
        AsymmetricKeyParameter rSAPrivateCrtKeyParametersCreateKey = PrivateKeyFactory.createKey(bArr);
        Pair pair = null;
        if (rSAPrivateCrtKeyParametersCreateKey instanceof RSAPrivateCrtKeyParameters) {
            RSAPrivateCrtKeyParameters rSAPrivateCrtKeyParameters = (RSAPrivateCrtKeyParameters) rSAPrivateCrtKeyParametersCreateKey;
            PrivateKeyInfo privateKeyInfo = new PrivateKeyInfo(new AlgorithmIdentifier(PKCSObjectIdentifiers.rsaEncryption, DERNull.INSTANCE), new RSAPrivateKey(rSAPrivateCrtKeyParameters.getModulus(), rSAPrivateCrtKeyParameters.getPublicExponent(), rSAPrivateCrtKeyParameters.getExponent(), rSAPrivateCrtKeyParameters.getP(), rSAPrivateCrtKeyParameters.getQ(), rSAPrivateCrtKeyParameters.getDP(), rSAPrivateCrtKeyParameters.getDQ(), rSAPrivateCrtKeyParameters.getQInv()), (ASN1Set) null);
            SubjectPublicKeyInfo subjectPublicKeyInfo = new SubjectPublicKeyInfo(new AlgorithmIdentifier(PKCSObjectIdentifiers.rsaEncryption, DERNull.INSTANCE), new RSAPublicKey(rSAPrivateCrtKeyParameters.getModulus(), rSAPrivateCrtKeyParameters.getPublicExponent()));
            KeyFactory keyFactory = getKeyFactory("RSA");
            return new KeyPair(keyFactory.generatePublic(new X509EncodedKeySpec(subjectPublicKeyInfo.getEncoded())), keyFactory.generatePrivate(new PKCS8EncodedKeySpec(privateKeyInfo.getEncoded())));
        }
        if (!(rSAPrivateCrtKeyParametersCreateKey instanceof ECPrivateKeyParameters)) {
            throw new IllegalArgumentException("Unknown key parameters type: " + rSAPrivateCrtKeyParametersCreateKey.getClass().getSimpleName());
        }
        ECPrivateKeyParameters eCPrivateKeyParameters = (ECPrivateKeyParameters) rSAPrivateCrtKeyParametersCreateKey;
        ECDomainParameters parameters = eCPrivateKeyParameters.getParameters();
        Enumeration names = ECNamedCurveTable.getNames();
        while (names.hasMoreElements()) {
            String str = (String) names.nextElement();
            X9ECParameters byName = ECNamedCurveTable.getByName(str);
            if (byName.getCurve().equals(parameters.getCurve())) {
                pair = new Pair(str, byName);
                break;
            }
        }
        if (pair == null) {
            throw new IllegalArgumentException("Unknown EC curve type");
        }
        ECPoint g = ((X9ECParameters) pair.second).getG();
        ECNamedCurveSpec eCNamedCurveSpec = new ECNamedCurveSpec((String) pair.first, new EllipticCurve(new ECFieldFp(((X9ECParameters) pair.second).getCurve().getField().getCharacteristic()), ((X9ECParameters) pair.second).getCurve().getA().toBigInteger(), ((X9ECParameters) pair.second).getCurve().getB().toBigInteger()), new java.security.spec.ECPoint(g.getAffineXCoord().toBigInteger(), g.getAffineYCoord().toBigInteger()), ((X9ECParameters) pair.second).getN(), ((X9ECParameters) pair.second).getH());
        ECPoint eCPointDecodePoint = ((X9ECParameters) pair.second).getCurve().decodePoint(parameters.getG().multiply(eCPrivateKeyParameters.getD()).getEncoded(DEBUG));
        ECPrivateKeySpec eCPrivateKeySpec = new ECPrivateKeySpec(eCPrivateKeyParameters.getD(), eCNamedCurveSpec);
        ECPublicKeySpec eCPublicKeySpec = new ECPublicKeySpec(new java.security.spec.ECPoint(eCPointDecodePoint.getXCoord().toBigInteger(), eCPointDecodePoint.getYCoord().toBigInteger()), eCNamedCurveSpec);
        KeyFactory keyFactory2 = getKeyFactory("ECDSA");
        return new KeyPair(keyFactory2.generatePublic(eCPublicKeySpec), keyFactory2.generatePrivate(eCPrivateKeySpec));
    }

    static String getAlgorithmFromAuthorizations(Authorization[] authorizationArr) {
        String str = null;
        for (Authorization authorization : authorizationArr) {
            if (authorization.keyParameter.tag == 268435458) {
                int algorithm = authorization.keyParameter.value.getAlgorithm();
                if (algorithm == 1) {
                    return "RSA";
                }
                if (algorithm == 3 && str == null) {
                    str = "EC";
                }
            }
            if (authorization.keyParameter.tag == 268435466 && authorization.keyParameter.value.getEcCurve() == 4) {
                return "Ed25519";
            }
        }
        return str;
    }

    static Context getApplicationContext() {
        try {
            return ActivityThread.currentApplication().getApplicationContext();
        } catch (Exception e) {
            Log.e(TAG, "Error getting application context", e);
            return null;
        }
    }

    static int getAttestationVersion() {
        switch (Build.VERSION.DEVICE_INITIAL_SDK_INT) {
            case 31:
            case 32:
                return 100;
            case 33:
                return 200;
            case 34:
            case 35:
                return 300;
            case 36:
                return 400;
            default:
                return 3;
        }
    }

    static X509Certificate getCertificateFromHolder(X509CertificateHolder x509CertificateHolder) throws Exception {
        return (X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate(new ByteArrayInputStream(x509CertificateHolder.getEncoded()));
    }

    static String getDecryptDigest(Integer num) {
        if (num == null) {
            return null;
        }
        int iIntValue = num.intValue();
        if (iIntValue == 2) {
            return "SHA-1";
        }
        if (iIntValue == 3) {
            return "SHA-224";
        }
        if (iIntValue == 4) {
            return "SHA-256";
        }
        if (iIntValue == 5) {
            return "SHA-384";
        }
        if (iIntValue != 6) {
            return null;
        }
        return "SHA-512";
    }

    private static KeyFactory getKeyFactory(String str) throws NoSuchAlgorithmException {
        try {
            return KeyFactory.getInstance(str);
        } catch (NoSuchAlgorithmException e) {
            if (str.equals("ECDSA")) {
                return KeyFactory.getInstance("EC");
            }
            throw e;
        }
    }

    static int getKeyUsage(KeyboxChainGenerator.KeyGenParameters keyGenParameters) {
        List<Integer> list = keyGenParameters.purpose;
        int i = list.contains(2) ? 128 : 0;
        if (list.contains(1)) {
            i |= 48;
        }
        if (list.contains(5)) {
            i |= 32;
        }
        if (list.contains(6)) {
            i |= 8;
        }
        return list.contains(7) ? i | 4 : i;
    }

    static int getKeymasterVersion() {
        switch (Build.VERSION.DEVICE_INITIAL_SDK_INT) {
            case 31:
            case 32:
                return 100;
            case 33:
                return 200;
            case 34:
            case 35:
                return 300;
            case 36:
                return 400;
            default:
                return 4;
        }
    }

    static byte[] getModuleHash() {
        try {
            return MessageDigest.getInstance("SHA-256").digest(("apex-" + Build.VERSION.INCREMENTAL + "-" + Build.BOARD).getBytes(StandardCharsets.UTF_8));
        } catch (Exception unused) {
            return randomBytes(32);
        }
    }

    static int getOSVersion() {
        switch (Build.VERSION.SDK_INT) {
            case 33:
                return 130000;
            case 34:
                return 140000;
            case 35:
                return 150000;
            case 36:
                return 160000;
            default:
                return 0;
        }
    }

    static int getSecurityPatchLevel(boolean z) {
        try {
            String[] strArrSplit = Build.VERSION.SECURITY_PATCH.split("-");
            int i = Integer.parseInt(strArrSplit[0]);
            int i2 = Integer.parseInt(strArrSplit[1]);
            return z ? (i * 10000) + (i2 * 100) + Integer.parseInt(strArrSplit[2]) : (i * 100) + i2;
        } catch (Exception unused) {
            return z ? 20250101 : 202501;
        }
    }

    static String getSignDigest(Integer num) {
        if (num == null) {
            return null;
        }
        switch (num.intValue()) {
            case 0:
                return "NONE";
            case 1:
                return "MD5";
            case 2:
                return "SHA1";
            case 3:
                return "SHA224";
            case 4:
                return "SHA256";
            case 5:
                return "SHA384";
            case 6:
                return "SHA512";
            default:
                return null;
        }
    }

    static byte[] getVerifiedBootHash() {
        String str = SystemProperties.get("ro.boot.vbmeta.digest", "");
        if (!TextUtils.isEmpty(str) && str.length() == 64) {
            return HexFormat.of().parseHex(str);
        }
        try {
            return MessageDigest.getInstance("SHA-256").digest(("hash-" + Build.VERSION.INCREMENTAL + "-" + Build.BOARD).getBytes(StandardCharsets.UTF_8));
        } catch (Exception unused) {
            return randomBytes(32);
        }
    }

    static byte[] getVerifiedBootKey() {
        String str = SystemProperties.get("ro.boot.vbmeta.public_key_digest", "");
        if (!TextUtils.isEmpty(str) && str.length() == 64) {
            return HexFormat.of().parseHex(str);
        }
        try {
            return MessageDigest.getInstance("SHA-256").digest(("key-" + Build.VERSION.INCREMENTAL + "-" + Build.BOARD).getBytes(StandardCharsets.UTF_8));
        } catch (Exception unused) {
            return randomBytes(32);
        }
    }

    static boolean isCallerSamsungKeystoreUtils() {
        return Arrays.stream(Thread.currentThread().getStackTrace()).anyMatch(new Predicate() { // from class: io.lti.KeyboxUtils$$ExternalSyntheticLambda0
            @Override // java.util.function.Predicate
            public final boolean test(Object obj) {
                return ((StackTraceElement) obj).getClassName().equals("com.samsung.android.security.keystore.AttestationUtils");
            }
        });
    }

    private static X509Certificate parseCertificate(String str) throws Exception {
        return (X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate(new ByteArrayInputStream(decodePemOrBase64(str)));
    }

    private static PrivateKey parsePrivateKey(String str, String str2) throws Exception {
        return parsePrivateKey(decodePemOrBase64(str), str2);
    }

    private static PrivateKey parsePrivateKey(byte[] bArr, String str) throws Exception {
        ASN1Primitive aSN1PrimitiveFromByteArray = ASN1Primitive.fromByteArray(bArr);
        if ("EC".equalsIgnoreCase(str)) {
            try {
                return getKeyFactory("ECDSA").generatePrivate(new PKCS8EncodedKeySpec(PrivateKeyInfo.getInstance(aSN1PrimitiveFromByteArray).getEncoded()));
            } catch (Exception unused) {
                ECPrivateKey eCPrivateKey = ECPrivateKey.getInstance(ASN1Sequence.getInstance(aSN1PrimitiveFromByteArray));
                return getKeyFactory("ECDSA").generatePrivate(new PKCS8EncodedKeySpec(new PrivateKeyInfo(new AlgorithmIdentifier(X9ObjectIdentifiers.id_ecPublicKey, eCPrivateKey.getParameters()), eCPrivateKey).getEncoded()));
            }
        }
        if (!"RSA".equalsIgnoreCase(str)) {
            throw new IllegalArgumentException("Unsupported algorithm: " + str);
        }
        try {
            return getKeyFactory("RSA").generatePrivate(new PKCS8EncodedKeySpec(bArr));
        } catch (Exception unused2) {
            RSAPrivateKey rSAPrivateKey = RSAPrivateKey.getInstance(aSN1PrimitiveFromByteArray);
            return getKeyFactory("ECDSA").generatePrivate(new RSAPrivateCrtKeySpec(rSAPrivateKey.getModulus(), rSAPrivateKey.getPublicExponent(), rSAPrivateKey.getPrivateExponent(), rSAPrivateKey.getPrime1(), rSAPrivateKey.getPrime2(), rSAPrivateKey.getExponent1(), rSAPrivateKey.getExponent2(), rSAPrivateKey.getCoefficient()));
        }
    }

    static void putCertificateChain(KeyMetadata keyMetadata, Certificate[] certificateArr) throws Exception {
        if (certificateArr == null || certificateArr.length <= 0) {
            return;
        }
        keyMetadata.certificate = certificateArr[0].getEncoded();
        if (certificateArr.length > 1) {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            for (int i = 1; i < certificateArr.length; i++) {
                byteArrayOutputStream.write(certificateArr[i].getEncoded());
            }
            keyMetadata.certificateChain = byteArrayOutputStream.toByteArray();
        }
    }

    static byte[] randomBytes(int i) {
        byte[] bArr = new byte[i];
        new SecureRandom().nextBytes(bArr);
        return bArr;
    }
}
