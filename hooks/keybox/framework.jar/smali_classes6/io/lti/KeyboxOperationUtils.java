package io.lti;

import android.os.RemoteException;
import android.system.keystore2.CreateOperationResponse;
import android.system.keystore2.IKeystoreOperation;
import com.android.internal.org.bouncycastle.jce.provider.BouncyCastleProvider;
import java.io.ByteArrayOutputStream;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.Provider;
import java.security.Signature;
import java.security.spec.MGF1ParameterSpec;
import java.security.spec.X509EncodedKeySpec;
import javax.crypto.Cipher;
import javax.crypto.KeyAgreement;
import javax.crypto.spec.OAEPParameterSpec;
import javax.crypto.spec.PSource;

final class KeyboxOperationUtils {
    private static final boolean DEBUG = false;
    private static final String TAG = "KeyboxOperationUtils";

    private static final class DecryptOperation extends IKeystoreOperation.Stub {
        private final Cipher cipher;

        DecryptOperation(PrivateKey privateKey, String str, Integer num, Integer num2) throws Exception {
            Cipher cipher = Cipher.getInstance(str, (Provider) new BouncyCastleProvider());
            this.cipher = cipher;
            if (num2 == null) {
                cipher.init(2, privateKey);
                return;
            }
            num.getClass();
            String decryptDigest = KeyboxUtils.getDecryptDigest(num);
            decryptDigest.getClass();
            int iIntValue = num.intValue();
            OAEPParameterSpec oAEPParameterSpec = iIntValue != 2 ? iIntValue != 3 ? iIntValue != 4 ? iIntValue != 5 ? iIntValue != 6 ? null : new OAEPParameterSpec(decryptDigest, "MGF1", MGF1ParameterSpec.SHA512, PSource.PSpecified.DEFAULT) : new OAEPParameterSpec(decryptDigest, "MGF1", MGF1ParameterSpec.SHA384, PSource.PSpecified.DEFAULT) : new OAEPParameterSpec(decryptDigest, "MGF1", MGF1ParameterSpec.SHA256, PSource.PSpecified.DEFAULT) : new OAEPParameterSpec(decryptDigest, "MGF1", MGF1ParameterSpec.SHA224, PSource.PSpecified.DEFAULT) : new OAEPParameterSpec(decryptDigest, "MGF1", MGF1ParameterSpec.SHA1, PSource.PSpecified.DEFAULT);
            if (oAEPParameterSpec == null) {
                throw new NoSuchAlgorithmException("Unsupported mgfDigest: " + num2);
            }
            cipher.init(2, privateKey, oAEPParameterSpec);
        }

        public void abort() {
        }

        public byte[] finish(byte[] bArr, byte[] bArr2) throws RemoteException {
            try {
                return bArr == null ? this.cipher.doFinal() : this.cipher.doFinal(bArr);
            } catch (Exception e) {
                throw new RemoteException(e);
            }
        }

        public String getInterfaceHash() {
            return "98d815116c190250e9e5a1d9182cea8126fd0e97";
        }

        public int getInterfaceVersion() {
            return 5;
        }

        public byte[] update(byte[] bArr) {
            this.cipher.update(bArr);
            return null;
        }

        public void updateAad(byte[] bArr) {
        }
    }

    private static final class KeyAgreementOperation extends IKeystoreOperation.Stub {
        private final KeyAgreement keyAgreement;
        private final ByteArrayOutputStream output = new ByteArrayOutputStream();

        KeyAgreementOperation(PrivateKey privateKey) throws Exception {
            KeyAgreement keyAgreement = KeyAgreement.getInstance("ECDH", (Provider) new BouncyCastleProvider());
            this.keyAgreement = keyAgreement;
            keyAgreement.init(privateKey);
        }

        public void abort() {
        }

        public byte[] finish(byte[] bArr, byte[] bArr2) throws RemoteException {
            try {
                this.output.write(bArr);
                this.keyAgreement.doPhase(KeyFactory.getInstance("EC", (Provider) new BouncyCastleProvider()).generatePublic(new X509EncodedKeySpec(this.output.toByteArray())), true);
                return this.keyAgreement.generateSecret();
            } catch (Exception e) {
                throw new RemoteException(e);
            }
        }

        public String getInterfaceHash() {
            return "98d815116c190250e9e5a1d9182cea8126fd0e97";
        }

        public int getInterfaceVersion() {
            return 5;
        }

        public byte[] update(byte[] bArr) throws RemoteException {
            try {
                this.output.write(bArr);
                return null;
            } catch (Exception e) {
                throw new RemoteException(e);
            }
        }

        public void updateAad(byte[] bArr) {
        }
    }

    private static final class SignOperation extends IKeystoreOperation.Stub {
        private final Cipher cipher;
        private final Signature signature;

        SignOperation(PrivateKey privateKey, String str) throws Exception {
            if (str.equals("RSA/None/Padding")) {
                Cipher cipher = Cipher.getInstance(str, (Provider) new BouncyCastleProvider());
                this.cipher = cipher;
                cipher.init(1, privateKey);
                this.signature = null;
                return;
            }
            this.cipher = null;
            Signature signature = Signature.getInstance(str, (Provider) new BouncyCastleProvider());
            this.signature = signature;
            signature.initSign(privateKey);
        }

        public void abort() {
        }

        public byte[] finish(byte[] bArr, byte[] bArr2) throws RemoteException {
            try {
                Cipher cipher = this.cipher;
                if (cipher != null) {
                    return bArr == null ? cipher.doFinal() : cipher.doFinal(bArr);
                }
                Signature signature = this.signature;
                if (signature == null) {
                    return null;
                }
                signature.update(bArr);
                return this.signature.sign();
            } catch (Exception e) {
                throw new RemoteException(e);
            }
        }

        public String getInterfaceHash() {
            return "98d815116c190250e9e5a1d9182cea8126fd0e97";
        }

        public int getInterfaceVersion() {
            return 5;
        }

        public byte[] update(byte[] bArr) throws RemoteException {
            try {
                Cipher cipher = this.cipher;
                if (cipher != null) {
                    cipher.update(bArr);
                    return null;
                }
                Signature signature = this.signature;
                if (signature == null) {
                    return null;
                }
                signature.update(bArr);
                return null;
            } catch (Exception e) {
                throw new RemoteException(e);
            }
        }

        public void updateAad(byte[] bArr) {
        }
    }

    private KeyboxOperationUtils() {
    }

    private static void dlog(String str) {
    }

    static CreateOperationResponse getDecryptOperation(PrivateKey privateKey, String str) throws Exception {
        return getDecryptOperation(privateKey, str, null, null);
    }

    static CreateOperationResponse getDecryptOperation(PrivateKey privateKey, String str, Integer num, Integer num2) throws Exception {
        CreateOperationResponse createOperationResponse = new CreateOperationResponse();
        createOperationResponse.iOperation = new DecryptOperation(privateKey, str, num, num2);
        dlog("Called createOperation with purpose DECRYPT");
        return createOperationResponse;
    }

    static CreateOperationResponse getKeyAgreementOperation(PrivateKey privateKey) throws Exception {
        CreateOperationResponse createOperationResponse = new CreateOperationResponse();
        createOperationResponse.iOperation = new KeyAgreementOperation(privateKey);
        dlog("Called createOperation with purpose AGREE_KEY");
        return createOperationResponse;
    }

    static CreateOperationResponse getSignOperation(PrivateKey privateKey, String str) throws Exception {
        CreateOperationResponse createOperationResponse = new CreateOperationResponse();
        createOperationResponse.iOperation = new SignOperation(privateKey, str);
        dlog("Called createOperation with purpose SIGN");
        return createOperationResponse;
    }
}
