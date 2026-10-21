package io.lti;

import android.app.ActivityTaskManager;
import android.app.Application;
import android.app.TaskStackListener;
import android.content.ComponentName;
import android.content.Context;
import android.os.Binder;
import android.os.Build;
import android.os.Process;
import android.os.SystemProperties;
import android.util.Log;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.function.Predicate;

public final class PlayIntegrityHooks {
    private static final boolean DEBUG = false;
    private static final ComponentName GMS_ADD_ACCOUNT_ACTIVITY = ComponentName.unflattenFromString("com.google.android.gms/.auth.uiflows.minutemaid.MinuteMaidActivity");
    private static final String PACKAGE_FINSKY = "com.android.vending";
    private static final String PACKAGE_GMS = "com.google.android.gms";
    private static final String PIF_BRAND = "null";
    private static final String PIF_DEVICE = "null";
    private static final String PIF_DEVICE_INITIAL_SDK_INT = "null";
    private static final String PIF_FINGERPRINT = "google/shiba_beta/shiba:CANARY/ZP11.251121.010/14518957:user/release-keys";
    private static final String PIF_ID = "null";
    private static final String PIF_INCREMENTAL = "null";
    private static final String PIF_MANUFACTURER = "null";
    private static final String PIF_MODEL = "null";
    private static final String PIF_PRODUCT = "null";
    private static final String PIF_RELEASE = "null";
    private static final String PIF_SECURITY_PATCH = "null";
    private static final String PIF_VERSION = "20251212";
    private static final String TAG = "PlayIntegrityHooks";
    private static volatile String sProcessName;

    private PlayIntegrityHooks() {
    }

    public static void dlog(String str) {
    }

    private static boolean isCallerSafetyNet() {
        return Arrays.stream(Thread.currentThread().getStackTrace()).anyMatch(new Predicate() { // from class: io.lti.PlayIntegrityHooks$$ExternalSyntheticLambda0
            @Override // java.util.function.Predicate
            public final boolean test(Object obj) {
                return ((StackTraceElement) obj).getClassName().toLowerCase().contains("droidguard");
            }
        });
    }

    public static boolean isGmsAddAccountActivityOnTop() {
        try {
            ActivityTaskManager.RootTaskInfo focusedRootTaskInfo = ActivityTaskManager.getService().getFocusedRootTaskInfo();
            if (focusedRootTaskInfo == null || focusedRootTaskInfo.topActivity == null || !focusedRootTaskInfo.topActivity.equals(GMS_ADD_ACCOUNT_ACTIVITY)) {
                return DEBUG;
            }
            return true;
        } catch (Exception e) {
            Log.e(TAG, "Unable to get top activity!", e);
            return DEBUG;
        }
    }

    private static boolean isPIFEnabled() {
        return SystemProperties.getBoolean("persist.sys.pif.enable", DEBUG);
    }

    public static void onEngineGetCertificateChain() {
        if (isPIFEnabled()) {
            if (shouldBlockKeyAttestation()) {
                dlog("Key attestation blocking is disabled because a keybox is defined to spoof");
            } else if (isCallerSafetyNet()) {
                dlog("Blocked key attestation");
                throw new UnsupportedOperationException();
            }
        }
    }

    private static void setPropValue(String str, Object obj) {
        try {
            dlog("Defining prop " + str + " to " + obj.toString());
            Field declaredField = Build.class.getDeclaredField(str);
            declaredField.setAccessible(true);
            declaredField.set(null, obj);
            declaredField.setAccessible(DEBUG);
        } catch (IllegalAccessException | NoSuchFieldException e) {
            Log.e(TAG, "Failed to set prop " + str, e);
        }
    }

    public static void setProps(Context context) {
        String packageName = context.getPackageName();
        String processName = Application.getProcessName();
        if (packageName == null || processName == null || packageName.isEmpty()) {
            return;
        }
        sProcessName = processName;
        if (isPIFEnabled()) {
            if (!packageName.equals(PACKAGE_GMS)) {
                if (packageName.equals(PACKAGE_FINSKY)) {
                    spoofBuildGms();
                }
            } else if (shouldTryToCertifyDevice()) {
                dlog("Spoofing build for GMS to pass CTS/Play Integrity API");
                spoofBuildGms();
            }
        }
    }

    private static void setVersionFieldInt(String str, int i) {
        try {
            Field declaredField = Build.VERSION.class.getDeclaredField(str);
            declaredField.setAccessible(true);
            declaredField.set(null, Integer.valueOf(i));
            declaredField.setAccessible(DEBUG);
        } catch (IllegalAccessException | NoSuchFieldException e) {
            Log.e(TAG, "Failed to spoof Build." + str, e);
        }
    }

    private static void setVersionFieldString(String str, String str2) {
        try {
            Field declaredField = Build.VERSION.class.getDeclaredField(str);
            declaredField.setAccessible(true);
            declaredField.set(null, str2);
            declaredField.setAccessible(DEBUG);
        } catch (IllegalAccessException | NoSuchFieldException e) {
            Log.e(TAG, "Failed to spoof Build." + str, e);
        }
    }

    private static boolean shouldBlockKeyAttestation() {
        if (SystemProperties.getBoolean("persist.sys.lti.pif.block_attest_key", DEBUG) || !KeyProviderManager.isKeyboxAvailable()) {
            return DEBUG;
        }
        return true;
    }

    public static boolean shouldBypassTaskPermission(Context context) {
        int callingUid = Binder.getCallingUid();
        try {
            int i = context.getPackageManager().getApplicationInfo(PACKAGE_GMS, 0).uid;
            dlog("shouldBypassTaskPermission: gmsUid:" + i + " callingUid:" + callingUid);
            if (i == callingUid) {
                return true;
            }
            return DEBUG;
        } catch (Exception e) {
            Log.e(TAG, "shouldBypassTaskPermission: unable to get gms uid", e);
            return DEBUG;
        }
    }

    private static boolean shouldTryToCertifyDevice() {
        if (!Application.getProcessName().toLowerCase().contains("unstable")) {
            return DEBUG;
        }
        final boolean zIsGmsAddAccountActivityOnTop = isGmsAddAccountActivityOnTop();
        if (!zIsGmsAddAccountActivityOnTop) {
            return true;
        }
        dlog("Skip spoofing build for GMS, because GmsAddAccountActivityOnTop!");
        try {
            ActivityTaskManager.getService().registerTaskStackListener(new TaskStackListener() { // from class: io.lti.PlayIntegrityHooks.1
                public void onTaskStackChanged() {
                    boolean zIsGmsAddAccountActivityOnTop2 = PlayIntegrityHooks.isGmsAddAccountActivityOnTop();
                    if (zIsGmsAddAccountActivityOnTop ^ zIsGmsAddAccountActivityOnTop2) {
                        PlayIntegrityHooks.dlog(String.format("%s changed: isNow=%b, was=%b, killing myself!", "GmsAddAccountActivityOnTop", Boolean.valueOf(zIsGmsAddAccountActivityOnTop2), Boolean.valueOf(zIsGmsAddAccountActivityOnTop)));
                        Process.killProcess(Process.myPid());
                    }
                }
            });
            return DEBUG;
        } catch (Exception e) {
            Log.e(TAG, "Failed to register task stack listener!", e);
            return true;
        }
    }

    private static void spoofBuildGms() {
        String str = SystemProperties.get("persist.sys.pif.product", "null");
        if (!str.equals("null")) {
            dlog("PRODUCT: " + str);
            setPropValue("PRODUCT", str);
        }
        String str2 = SystemProperties.get("persist.sys.pif.device", "null");
        if (!str2.equals("null")) {
            dlog("DEVICE: " + str2);
            setPropValue("DEVICE", str2);
        }
        String str3 = SystemProperties.get("persist.sys.pif.manufacturer", "null");
        if (!str3.equals("null")) {
            dlog("MANUFACTURER: " + str3);
            setPropValue("MANUFACTURER", str3);
        }
        String str4 = SystemProperties.get("persist.sys.pif.brand", "null");
        if (!str4.equals("null")) {
            dlog("BRAND: " + str4);
            setPropValue("BRAND", str4);
        }
        String str5 = SystemProperties.get("persist.sys.pif.model", "null");
        if (!str5.equals("null")) {
            dlog("MODEL: " + str5);
            setPropValue("MODEL", str5);
        }
        String str6 = SystemProperties.get("persist.sys.pif.release", "null");
        if (!str6.equals("null")) {
            dlog("RELEASE: " + str6);
            setVersionFieldString("RELEASE", str6);
        }
        String str7 = SystemProperties.get("persist.sys.pif.incremental", "null");
        if (!str7.equals("null")) {
            dlog("INCREMENTAL: " + str7);
            setVersionFieldString("INCREMENTAL", str7);
        }
        String str8 = SystemProperties.get("persist.sys.pif.id", "null");
        if (!str8.equals("null")) {
            dlog("ID: " + str8);
            setPropValue("ID", str8);
        }
        String str9 = SystemProperties.get("persist.sys.pif.fingerprint", PIF_FINGERPRINT);
        if (!str9.equals("null")) {
            dlog("FINGERPRINT: " + str9);
            setPropValue("FINGERPRINT", str9);
        }
        String str10 = SystemProperties.get("persist.sys.pif.security_patch", "null");
        if (!str10.equals("null")) {
            dlog("SECURITY_PATCH: " + str10);
            setVersionFieldString("SECURITY_PATCH", str10);
        }
        String str11 = SystemProperties.get("persist.sys.pif.first_api_level", "null");
        if (str11.equals("null")) {
            return;
        }
        dlog("DEVICE_INITIAL_SDK_INT: " + str11);
        setVersionFieldInt("DEVICE_INITIAL_SDK_INT", Integer.parseInt(str11));
    }
}
