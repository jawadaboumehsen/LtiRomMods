package io.lti;

import android.app.ActivityThread;
import android.app.Application;
import android.content.ContentResolver;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.ParceledListSlice;
import android.os.SystemProperties;
import android.provider.Settings;
import android.text.TextUtils;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class HideAppListUtils {
    private static final String KEY_ENABLED = "persist.sys.lti.hma";
    private static final String SETTING_LIST = "lti_hma_list";
    private static final String TAG = "HideAppListUtils";

    public static ParceledListSlice<PackageInfo> filterInstalledPackages(ParceledListSlice<PackageInfo> parceledListSlice) {
        if (parceledListSlice == null || !isBootCompleted() || !SystemProperties.getBoolean(KEY_ENABLED, false)) {
            return parceledListSlice;
        }
        Set<String> hiddenPackages = getHiddenPackages();
        if (hiddenPackages.isEmpty()) {
            return parceledListSlice;
        }
        List<PackageInfo> list = parceledListSlice.getList();
        ArrayList arrayList = new ArrayList();
        for (PackageInfo packageInfo : list) {
            String str = packageInfo.packageName;
            if (str == null || !hiddenPackages.contains(str)) {
                arrayList.add(packageInfo);
            }
        }
        return new ParceledListSlice<>(arrayList);
    }

    private static Context getApplicationContext() {
        try {
            Application applicationCurrentApplication = ActivityThread.currentApplication();
            if (applicationCurrentApplication != null) {
                return applicationCurrentApplication.getApplicationContext();
            }
            return null;
        } catch (Throwable th) {
            return null;
        }
    }

    private static Set<String> getHiddenPackages() {
        Context context = getApplicationContext();
        return context == null ? new HashSet<>() : getApps(context.getContentResolver());
    }

    /** The packages in the hide list setting (comma separated); empty when it is unset or unreadable. */
    public static Set<String> getApps(ContentResolver resolver) {
        Set<String> apps = new HashSet<>();
        try {
            String list = Settings.Secure.getString(resolver, SETTING_LIST);
            if (list != null && !list.isEmpty()) {
                for (String entry : list.split(",")) {
                    String name = entry.trim();
                    if (!name.isEmpty()) {
                        apps.add(name);
                    }
                }
            }
        } catch (Throwable ignored) {
            // A broken setting hides nothing.
        }
        return apps;
    }

    public static void addApp(ContentResolver resolver, String packageName) {
        update(resolver, packageName, true);
    }

    public static void removeApp(ContentResolver resolver, String packageName) {
        update(resolver, packageName, false);
    }

    private static void update(ContentResolver resolver, String packageName, boolean add) {
        if (packageName == null) {
            return;
        }
        try {
            Set<String> apps = getApps(resolver);
            if (add) {
                apps.add(packageName);
            } else {
                apps.remove(packageName);
            }
            Settings.Secure.putString(resolver, SETTING_LIST, TextUtils.join(",", apps));
        } catch (Throwable ignored) {
            // Losing a list update is better than crashing the caller.
        }
    }

    private static boolean isBootCompleted() {
        return SystemProperties.getBoolean("sys.boot_completed", false);
    }

    public static boolean shouldHideAppList(String str) {
        if (isBootCompleted() && SystemProperties.getBoolean(KEY_ENABLED, false) && str != null) {
            return getHiddenPackages().contains(str);
        }
        return false;
    }
}
