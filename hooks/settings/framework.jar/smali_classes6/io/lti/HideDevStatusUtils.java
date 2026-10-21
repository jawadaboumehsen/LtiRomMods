package io.lti;

import android.content.ContentResolver;
import android.os.SystemProperties;
import android.provider.Settings;
import android.text.TextUtils;
import java.util.HashSet;
import java.util.Set;

public class HideDevStatusUtils {
    private static final String KEY_ENABLED = "persist.sys.lti.hide_dev_status";
    private static final HashSet SETTINGS_TO_HIDE;
    private static final String SETTING_LIST = "lti_hide_dev_list";
    private static final String TAG = "HideDevStatusUtils";

    static {
        HashSet hashSet = new HashSet();
        hashSet.add("adb_enabled");
        hashSet.add("adb_wifi_enabled");
        hashSet.add("development_settings_enabled");
        SETTINGS_TO_HIDE = hashSet;
    }

    public static void addApp(ContentResolver contentResolver, String str) {
        if (str == null) {
            return;
        }
        try {
            Set<String> apps = getApps(contentResolver);
            apps.add(str);
            Settings.Secure.putString(contentResolver, SETTING_LIST, TextUtils.join(",", apps));
        } catch (Throwable th) {
        }
    }

    public static Set<String> getApps(ContentResolver contentResolver) {
        HashSet hashSet = new HashSet();
        try {
            String string = Settings.Secure.getString(contentResolver, SETTING_LIST);
            if (string != null && !string.isEmpty()) {
                for (String str : string.split(",")) {
                    String strTrim = str.trim();
                    if (!strTrim.isEmpty()) {
                        hashSet.add(strTrim);
                    }
                }
            }
            return hashSet;
        } catch (Throwable th) {
            return hashSet;
        }
    }

    public static void removeApp(ContentResolver contentResolver, String str) {
        if (str == null) {
            return;
        }
        try {
            Set<String> apps = getApps(contentResolver);
            apps.remove(str);
            Settings.Secure.putString(contentResolver, SETTING_LIST, TextUtils.join(",", apps));
        } catch (Throwable th) {
        }
    }

    public static boolean shouldHideDevStatus(ContentResolver contentResolver, String str, String str2) {
        if (!SystemProperties.getBoolean(KEY_ENABLED, false) || !SystemProperties.getBoolean("sys.boot_completed", false) || !SETTINGS_TO_HIDE.contains(str2) || str == null) {
            return false;
        }
        try {
            return getApps(contentResolver).contains(str);
        } catch (Throwable th) {
            return false;
        }
    }
}
