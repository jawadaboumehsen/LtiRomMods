package io.lti;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Parcel;
import android.system.keystore2.KeyDescriptor;
import android.system.keystore2.KeyMetadata;
import android.text.TextUtils;
import android.util.Log;
import android.util.Pair;
import java.security.KeyPair;
import java.util.ArrayList;

final class KeyboxDbHelper extends SQLiteOpenHelper {
    private static final String COLUMN_KEY_ALIAS = "key_alias";
    private static final String COLUMN_KEY_ID = "key_id";
    private static final String COLUMN_KEY_MATERIAL = "key_material";
    private static final String COLUMN_KEY_METADATA = "key_metadata";
    private static final String DATABASE_NAME = "lti_keystore.db";
    private static final int DATABASE_VERSION = 1;
    private static final String SQL_CREATE_ENTRIES = "CREATE TABLE key_entries (key_id INTEGER PRIMARY KEY NOT NULL,key_alias TEXT NOT NULL,key_material BLOB NOT NULL,key_metadata BLOB NOT NULL)";
    private static final String SQL_DELETE_ENTRIES = "DROP TABLE IF EXISTS key_entries";
    private static final String TABLE_NAME = "key_entries";
    private static final String TAG = "KeyboxDbHelper";
    private static KeyboxDbHelper sInstance;

    private KeyboxDbHelper(Context context) {
        super(context, DATABASE_NAME, (SQLiteDatabase.CursorFactory) null, DATABASE_VERSION);
    }

    static KeyboxDbHelper getInstance() {
        if (sInstance == null) {
            Context applicationContext = KeyboxUtils.getApplicationContext();
            if (applicationContext == null) {
                Log.e(TAG, "Failed to get application context");
                return null;
            }
            sInstance = new KeyboxDbHelper(applicationContext);
        }
        return sInstance;
    }

    private byte[] marshallKeyMetadata(KeyMetadata keyMetadata) {
        Parcel parcelObtain = Parcel.obtain();
        keyMetadata.writeToParcel(parcelObtain, 0);
        byte[] bArrMarshall = parcelObtain.marshall();
        parcelObtain.recycle();
        return bArrMarshall;
    }

    private KeyMetadata unmarshallKeyMetadata(byte[] bArr) {
        Parcel parcelObtain = Parcel.obtain();
        parcelObtain.unmarshall(bArr, 0, bArr.length);
        parcelObtain.setDataPosition(0);
        KeyMetadata keyMetadata = (KeyMetadata) KeyMetadata.CREATOR.createFromParcel(parcelObtain);
        parcelObtain.recycle();
        return keyMetadata;
    }

    boolean deleteKeyData(long j) {
        return getWritableDatabase().delete(TABLE_NAME, "key_id= ?", new String[]{String.valueOf(j)}) != 0;
    }

    Pair<KeyPair, KeyMetadata> fetchKeyData(long j) {
        Cursor cursorQuery = getReadableDatabase().query(TABLE_NAME, null, "key_id = ?", new String[]{String.valueOf(j)}, null, null, null);
        if (cursorQuery == null || !cursorQuery.moveToFirst()) {
            return null;
        }
        try {
            return new Pair<>(KeyboxUtils.generateKeyPairFromKeyData(cursorQuery.getBlob(cursorQuery.getColumnIndexOrThrow(COLUMN_KEY_MATERIAL))), unmarshallKeyMetadata(cursorQuery.getBlob(cursorQuery.getColumnIndexOrThrow(COLUMN_KEY_METADATA))));
        } catch (Exception e) {
            Log.e(TAG, "Error deserializing key data", e);
            return null;
        } finally {
            cursorQuery.close();
        }
    }

    KeyDescriptor[] fetchKeyEntries(String str) {
        Cursor cursorQuery = getReadableDatabase().query(TABLE_NAME, new String[]{COLUMN_KEY_ALIAS}, TextUtils.isEmpty(str) ? null : "key_alias > ?", TextUtils.isEmpty(str) ? null : new String[]{str}, null, null, "key_alias ASC");
        ArrayList arrayList = new ArrayList();
        if (cursorQuery != null) {
            while (cursorQuery.moveToNext()) {
                KeyDescriptor keyDescriptor = new KeyDescriptor();
                keyDescriptor.domain = 0;
                keyDescriptor.nspace = -1L;
                keyDescriptor.alias = cursorQuery.getString(0);
                keyDescriptor.blob = null;
                arrayList.add(keyDescriptor);
            }
            cursorQuery.close();
        }
        return (KeyDescriptor[]) arrayList.toArray(new KeyDescriptor[0]);
    }

    @Override // android.database.sqlite.SQLiteOpenHelper
    public void onCreate(SQLiteDatabase sQLiteDatabase) {
        sQLiteDatabase.execSQL(SQL_CREATE_ENTRIES);
    }

    @Override // android.database.sqlite.SQLiteOpenHelper
    public void onDowngrade(SQLiteDatabase sQLiteDatabase, int i, int i2) {
        onUpgrade(sQLiteDatabase, i, i2);
    }

    @Override // android.database.sqlite.SQLiteOpenHelper
    public void onUpgrade(SQLiteDatabase sQLiteDatabase, int i, int i2) {
        sQLiteDatabase.execSQL(SQL_DELETE_ENTRIES);
        onCreate(sQLiteDatabase);
    }

    void storeKeyData(String str, KeyPair keyPair, KeyMetadata keyMetadata) {
        SQLiteDatabase writableDatabase = getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COLUMN_KEY_ID, Integer.valueOf(str.hashCode()));
        contentValues.put(COLUMN_KEY_ALIAS, str);
        contentValues.put(COLUMN_KEY_MATERIAL, keyPair.getPrivate().getEncoded());
        contentValues.put(COLUMN_KEY_METADATA, marshallKeyMetadata(keyMetadata));
        writableDatabase.replace(TABLE_NAME, null, contentValues);
    }

    void updateKeyData(long j, KeyPair keyPair, KeyMetadata keyMetadata) {
        SQLiteDatabase writableDatabase = getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COLUMN_KEY_MATERIAL, keyPair.getPrivate().getEncoded());
        contentValues.put(COLUMN_KEY_METADATA, marshallKeyMetadata(keyMetadata));
        writableDatabase.update(TABLE_NAME, contentValues, "key_id = ?", new String[]{String.valueOf(j)});
    }
}
