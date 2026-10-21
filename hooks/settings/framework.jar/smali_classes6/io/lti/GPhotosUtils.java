package io.lti;

import android.app.ActivityThread;
import android.os.SystemProperties;
import java.util.Arrays;
import java.util.List;

public class GPhotosUtils {
    private static final List<String> FEATURES_NEXUS = Arrays.asList("com.google.android.apps.photos.NEXUS_PRELOAD", "com.google.android.apps.photos.nexus_preload", "com.google.android.feature.PIXEL_EXPERIENCE", "com.google.android.feature.GOOGLE_BUILD", "com.google.android.feature.GOOGLE_EXPERIENCE");

    public static boolean hasSystemFeature(String str) {
        String strCurrentPackageName = ActivityThread.currentPackageName();
        return strCurrentPackageName != null && strCurrentPackageName.equals("com.google.android.apps.photos") && SystemProperties.getBoolean("persist.sys.lti.gphotos", false) && FEATURES_NEXUS.contains(str);
    }
}
