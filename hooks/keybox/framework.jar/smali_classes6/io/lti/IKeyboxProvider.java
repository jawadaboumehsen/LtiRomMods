package io.lti;

public interface IKeyboxProvider {
    String[] getEcCertificateChain();

    String getEcPrivateKey();

    String[] getRsaCertificateChain();

    String getRsaPrivateKey();

    boolean hasKeybox();
}
