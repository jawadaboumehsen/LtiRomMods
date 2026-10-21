package io.lti;

import android.os.SystemProperties;

public class LtiSettingsUtils {
    public static boolean isFeatureEnabled(String str) {
        return SystemProperties.getBoolean(str, false);
    }
}
