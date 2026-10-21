package io.lti;

import android.content.Context;
import android.os.SystemProperties;
import android.provider.Settings;
import android.util.Log;
import android.util.Xml;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.function.IntFunction;
import org.xmlpull.v1.XmlPullParser;

public final class KeyProviderManager {
    private static final boolean DEBUG = false;
    private static final String TAG = "KeyProviderManager";
    private static IKeyboxProvider sInstance;

    static class DefaultKeyboxProvider implements IKeyboxProvider {
        private final Map<String, String> keyboxData;

        private DefaultKeyboxProvider() {
            this.keyboxData = new HashMap();
            Context applicationContext = KeyboxUtils.getApplicationContext();
            if (applicationContext == null) {
                Log.e(KeyProviderManager.TAG, "Failed to get application context");
            } else {
                loadFromXmlSetting(applicationContext);
            }
        }

        private String[] getCertificateChain(String str) {
            ArrayList arrayList = new ArrayList();
            for (String str2 : this.keyboxData.keySet()) {
                if (str2.startsWith(str + ".CERT_")) {
                    arrayList.add(this.keyboxData.get(str2));
                }
            }
            String[] strArr = (String[]) arrayList.toArray(new IntFunction() { // from class: io.lti.KeyProviderManager$DefaultKeyboxProvider$$ExternalSyntheticLambda0
                @Override // java.util.function.IntFunction
                public final Object apply(int i) {
                    return KeyProviderManager.DefaultKeyboxProvider.lambda$getCertificateChain$0(i);
                }
            });
            Arrays.sort(strArr);
            return strArr;
        }

        static /* synthetic */ String[] lambda$getCertificateChain$0(int i) {
            return new String[i];
        }

        private void loadFromXmlSetting(Context context) {
            String str;
            try {
                String string = Settings.Secure.getString(context.getContentResolver(), "lti_keybox_data");
                if (string != null && !string.trim().isEmpty()) {
                    XmlPullParser xmlPullParserNewPullParser = Xml.newPullParser();
                    xmlPullParserNewPullParser.setInput(new StringReader(string));
                    boolean z = false;
                    int i = 0;
                    String str2 = null;
                    for (int next = xmlPullParserNewPullParser.next(); next != 1; next = xmlPullParserNewPullParser.next()) {
                        if (next == 2) {
                            switch (xmlPullParserNewPullParser.getName()) {
                                case "Certificate":
                                    String attributeValue = xmlPullParserNewPullParser.getAttributeValue(null, "format");
                                    if (!"pem".equalsIgnoreCase(attributeValue)) {
                                        Log.w(KeyProviderManager.TAG, "Unsupported Certificate format: " + attributeValue);
                                        return;
                                    } else if (str2 != null) {
                                        xmlPullParserNewPullParser.next();
                                        i++;
                                        this.keyboxData.put(str2 + ".CERT_" + i, xmlPullParserNewPullParser.getText().trim());
                                        continue;
                                    }
                                    break;
                                case "Key":
                                    String attributeValue2 = xmlPullParserNewPullParser.getAttributeValue(null, "algorithm");
                                    if (!"ecdsa".equalsIgnoreCase(attributeValue2)) {
                                        if ("rsa".equalsIgnoreCase(attributeValue2)) {
                                            str = "RSA";
                                        } else {
                                            str2 = null;
                                        }
                                        i = 0;
                                        break;
                                    } else {
                                        str = "EC";
                                    }
                                    str2 = str;
                                    i = 0;
                                    break;
                                case "PrivateKey":
                                    String attributeValue3 = xmlPullParserNewPullParser.getAttributeValue(null, "format");
                                    if (!"pem".equalsIgnoreCase(attributeValue3)) {
                                        Log.w(KeyProviderManager.TAG, "Unsupported PrivateKey format: " + attributeValue3);
                                        return;
                                    }
                                    xmlPullParserNewPullParser.next();
                                    if (str2 != null) {
                                        this.keyboxData.put(str2 + ".PRIV", xmlPullParserNewPullParser.getText().trim());
                                    }
                                    break;
                                case "NumberOfKeyboxes":
                                    xmlPullParserNewPullParser.next();
                                    try {
                                        int i2 = Integer.parseInt(xmlPullParserNewPullParser.getText().trim());
                                        if (i2 != 1) {
                                            Log.w(KeyProviderManager.TAG, "Invalid NumberOfKeyboxes: " + i2);
                                            return;
                                        }
                                        z = true;
                                    } catch (NumberFormatException e) {
                                        Log.w(KeyProviderManager.TAG, "Failed to parse NumberOfKeyboxes", e);
                                        return;
                                    }
                                    break;
                                default:
                                    continue;
                            }
                        }
                    }
                    if (!z) {
                        Log.w(KeyProviderManager.TAG, "Missing <NumberOfKeyboxes> in keybox XML");
                    } else if (hasKeybox()) {
                        KeyProviderManager.dlog("Loaded keybox from XML setting");
                    } else {
                        Log.w(KeyProviderManager.TAG, "Failed to load keybox from XML setting");
                    }
                }
            } catch (Exception e2) {
                Log.e(KeyProviderManager.TAG, "XML keybox load failed", e2);
            }
        }

        @Override // io.lti.IKeyboxProvider
        public String[] getEcCertificateChain() {
            return getCertificateChain("EC");
        }

        @Override // io.lti.IKeyboxProvider
        public String getEcPrivateKey() {
            return this.keyboxData.get("EC.PRIV");
        }

        @Override // io.lti.IKeyboxProvider
        public String[] getRsaCertificateChain() {
            return getCertificateChain("RSA");
        }

        @Override // io.lti.IKeyboxProvider
        public String getRsaPrivateKey() {
            return this.keyboxData.get("RSA.PRIV");
        }

        @Override // io.lti.IKeyboxProvider
        public boolean hasKeybox() {
            if (this.keyboxData.containsKey("EC.PRIV") && this.keyboxData.containsKey("RSA.PRIV") && this.keyboxData.containsKey("EC.CERT_1") && this.keyboxData.containsKey("RSA.CERT_1")) {
                return true;
            }
            return KeyProviderManager.DEBUG;
        }
    }

    private KeyProviderManager() {
    }

    public static void dlog(String str) {
    }

    public static IKeyboxProvider getProvider() {
        if (sInstance == null) {
            sInstance = new DefaultKeyboxProvider();
        }
        return sInstance;
    }

    public static boolean isKeyboxAvailable() {
        return !SystemProperties.getBoolean("persist.sys.lti.keybox", DEBUG) ? DEBUG : getProvider().hasKeybox();
    }
}
