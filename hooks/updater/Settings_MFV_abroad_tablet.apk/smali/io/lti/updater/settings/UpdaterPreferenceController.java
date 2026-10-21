package io.lti.updater.settings;

import android.content.Context;
import android.provider.Settings;
import androidx.preference.Preference;
import com.android.settings.Utils;
import com.android.settings.core.BasePreferenceController;

/** The "Software update" entry LtiRom adds to Settings: shown while the updater app is enabled. */
public class UpdaterPreferenceController extends BasePreferenceController {
    private static final int AVAILABLE = 0;
    private static final int UNSUPPORTED_ON_DEVICE = 3;
    /** The stock string softupdate_settings_summary (a public id: apktool keeps it). */
    private static final int SUMMARY_STRING = 2132026626;

    public UpdaterPreferenceController(Context context, String key) {
        super(context, key);
    }

    @Override
    public int getAvailabilityStatus() {
        return Utils.isPackageEnabled(mContext, "com.zte.zdm") ? AVAILABLE : UNSUPPORTED_ON_DEVICE;
    }

    @Override
    public CharSequence getSummary() {
        return mContext.getString(SUMMARY_STRING);
    }

    @Override
    public void updateState(Preference preference) {
        if (Settings.System.getInt(mContext.getContentResolver(), "lti_update_available", 0) > 0) {
            preference.setSummary("Update available");
        } else {
            super.updateState(preference);
        }
    }
}
