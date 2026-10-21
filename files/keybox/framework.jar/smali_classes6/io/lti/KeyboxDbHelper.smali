.class final Lio/lti/KeyboxDbHelper;
.super Landroid/database/sqlite/SQLiteOpenHelper;
.source "KeyboxDbHelper.java"


# static fields
.field private static final blacklist COLUMN_KEY_ALIAS:Ljava/lang/String; = "key_alias"

.field private static final blacklist COLUMN_KEY_ID:Ljava/lang/String; = "key_id"

.field private static final blacklist COLUMN_KEY_MATERIAL:Ljava/lang/String; = "key_material"

.field private static final blacklist COLUMN_KEY_METADATA:Ljava/lang/String; = "key_metadata"

.field private static final blacklist DATABASE_NAME:Ljava/lang/String; = "lti_keystore.db"

.field private static final blacklist DATABASE_VERSION:I = 0x1

.field private static final blacklist SQL_CREATE_ENTRIES:Ljava/lang/String; = "CREATE TABLE key_entries (key_id INTEGER PRIMARY KEY NOT NULL,key_alias TEXT NOT NULL,key_material BLOB NOT NULL,key_metadata BLOB NOT NULL)"

.field private static final blacklist SQL_DELETE_ENTRIES:Ljava/lang/String; = "DROP TABLE IF EXISTS key_entries"

.field private static final blacklist TABLE_NAME:Ljava/lang/String; = "key_entries"

.field private static final blacklist TAG:Ljava/lang/String; = "KeyboxDbHelper"

.field private static blacklist sInstance:Lio/lti/KeyboxDbHelper;


# direct methods
.method private constructor blacklist <init>(Landroid/content/Context;)V
    .locals 3

    const/4 v0, 0x0

    const/4 v1, 0x1

    const-string v2, "lti_keystore.db"

    invoke-direct {p0, p1, v2, v0, v1}, Landroid/database/sqlite/SQLiteOpenHelper;-><init>(Landroid/content/Context;Ljava/lang/String;Landroid/database/sqlite/SQLiteDatabase$CursorFactory;I)V

    return-void
.end method

.method static blacklist getInstance()Lio/lti/KeyboxDbHelper;
    .locals 2

    sget-object v0, Lio/lti/KeyboxDbHelper;->sInstance:Lio/lti/KeyboxDbHelper;

    if-nez v0, :cond_1

    invoke-static {}, Lio/lti/KeyboxUtils;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "KeyboxDbHelper"

    const-string v1, "Failed to get application context"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return-object v0

    :cond_0
    new-instance v1, Lio/lti/KeyboxDbHelper;

    invoke-direct {v1, v0}, Lio/lti/KeyboxDbHelper;-><init>(Landroid/content/Context;)V

    sput-object v1, Lio/lti/KeyboxDbHelper;->sInstance:Lio/lti/KeyboxDbHelper;

    :cond_1
    sget-object v0, Lio/lti/KeyboxDbHelper;->sInstance:Lio/lti/KeyboxDbHelper;

    return-object v0
.end method

.method private blacklist marshallKeyMetadata(Landroid/system/keystore2/KeyMetadata;)[B
    .locals 1

    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object p0

    const/4 v0, 0x0

    invoke-virtual {p1, p0, v0}, Landroid/system/keystore2/KeyMetadata;->writeToParcel(Landroid/os/Parcel;I)V

    invoke-virtual {p0}, Landroid/os/Parcel;->marshall()[B

    move-result-object p1

    invoke-virtual {p0}, Landroid/os/Parcel;->recycle()V

    return-object p1
.end method

.method private blacklist unmarshallKeyMetadata([B)Landroid/system/keystore2/KeyMetadata;
    .locals 2

    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object p0

    array-length v0, p1

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Landroid/os/Parcel;->unmarshall([BII)V

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->setDataPosition(I)V

    sget-object p1, Landroid/system/keystore2/KeyMetadata;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p1, p0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/system/keystore2/KeyMetadata;

    invoke-virtual {p0}, Landroid/os/Parcel;->recycle()V

    return-object p1
.end method


# virtual methods
.method blacklist deleteKeyData(J)Z
    .locals 3

    invoke-virtual {p0}, Lio/lti/KeyboxDbHelper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object p0

    const/4 v0, 0x1

    new-array v1, v0, [Ljava/lang/String;

    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    aput-object p1, v1, p2

    const-string p1, "key_entries"

    const-string v2, "key_id= ?"

    invoke-virtual {p0, p1, v2, v1}, Landroid/database/sqlite/SQLiteDatabase;->delete(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;)I

    move-result p0

    if-eqz p0, :cond_0

    return v0

    :cond_0
    return p2
.end method

.method blacklist fetchKeyData(J)Landroid/util/Pair;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J)",
            "Landroid/util/Pair<",
            "Ljava/security/KeyPair;",
            "Landroid/system/keystore2/KeyMetadata;",
            ">;"
        }
    .end annotation

    invoke-virtual {p0}, Lio/lti/KeyboxDbHelper;->getReadableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    const/4 v1, 0x1

    new-array v4, v1, [Ljava/lang/String;

    const/4 v1, 0x0

    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p1

    aput-object p1, v4, v1

    const/4 v6, 0x0

    const/4 v7, 0x0

    const-string v1, "key_entries"

    const/4 v2, 0x0

    const-string v3, "key_id = ?"

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v7}, Landroid/database/sqlite/SQLiteDatabase;->query(Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-interface {p1}, Landroid/database/Cursor;->moveToFirst()Z

    move-result p2

    if-eqz p2, :cond_0

    :try_start_0
    new-instance p2, Landroid/util/Pair;

    const-string v0, "key_material"

    invoke-interface {p1, v0}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p1, v0}, Landroid/database/Cursor;->getBlob(I)[B

    move-result-object v0

    invoke-static {v0}, Lio/lti/KeyboxUtils;->generateKeyPairFromKeyData([B)Ljava/security/KeyPair;

    move-result-object v0

    const-string v1, "key_metadata"

    invoke-interface {p1, v1}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v1

    invoke-interface {p1, v1}, Landroid/database/Cursor;->getBlob(I)[B

    move-result-object v1

    invoke-direct {p0, v1}, Lio/lti/KeyboxDbHelper;->unmarshallKeyMetadata([B)Landroid/system/keystore2/KeyMetadata;

    move-result-object p0

    invoke-direct {p2, v0, p0}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-interface {p1}, Landroid/database/Cursor;->close()V

    return-object p2

    :catchall_0
    move-exception v0

    move-object p0, v0

    goto :goto_0

    :catch_0
    move-exception v0

    move-object p0, v0

    :try_start_1
    const-string p2, "KeyboxDbHelper"

    const-string v0, "Error deserializing key data"

    invoke-static {p2, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    invoke-interface {p1}, Landroid/database/Cursor;->close()V

    goto :goto_1

    :goto_0
    invoke-interface {p1}, Landroid/database/Cursor;->close()V

    throw p0

    :cond_0
    :goto_1
    const/4 p0, 0x0

    return-object p0
.end method

.method blacklist fetchKeyEntries(Ljava/lang/String;)[Landroid/system/keystore2/KeyDescriptor;
    .locals 10

    invoke-virtual {p0}, Lio/lti/KeyboxDbHelper;->getReadableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    const/4 p0, 0x1

    new-array v2, p0, [Ljava/lang/String;

    const-string v1, "key_alias"

    const/4 v8, 0x0

    aput-object v1, v2, v8

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v9, 0x0

    if-eqz v1, :cond_0

    move-object v3, v9

    goto :goto_0

    :cond_0
    const-string v1, "key_alias > ?"

    move-object v3, v1

    :goto_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    move-object v4, v9

    goto :goto_1

    :cond_1
    new-array p0, p0, [Ljava/lang/String;

    aput-object p1, p0, v8

    move-object v4, p0

    :goto_1
    const/4 v6, 0x0

    const-string v7, "key_alias ASC"

    const-string v1, "key_entries"

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v7}, Landroid/database/sqlite/SQLiteDatabase;->query(Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    if-eqz p0, :cond_3

    :goto_2
    invoke-interface {p0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Landroid/system/keystore2/KeyDescriptor;

    invoke-direct {v0}, Landroid/system/keystore2/KeyDescriptor;-><init>()V

    iput v8, v0, Landroid/system/keystore2/KeyDescriptor;->domain:I

    const-wide/16 v1, -0x1

    iput-wide v1, v0, Landroid/system/keystore2/KeyDescriptor;->nspace:J

    invoke-interface {p0, v8}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    iput-object v9, v0, Landroid/system/keystore2/KeyDescriptor;->blob:[B

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_2
    invoke-interface {p0}, Landroid/database/Cursor;->close()V

    :cond_3
    new-array p0, v8, [Landroid/system/keystore2/KeyDescriptor;

    invoke-virtual {p1, p0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [Landroid/system/keystore2/KeyDescriptor;

    return-object p0
.end method

.method public blacklist onCreate(Landroid/database/sqlite/SQLiteDatabase;)V
    .locals 0

    const-string p0, "CREATE TABLE key_entries (key_id INTEGER PRIMARY KEY NOT NULL,key_alias TEXT NOT NULL,key_material BLOB NOT NULL,key_metadata BLOB NOT NULL)"

    invoke-virtual {p1, p0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    return-void
.end method

.method public blacklist onDowngrade(Landroid/database/sqlite/SQLiteDatabase;II)V
    .locals 0

    invoke-virtual {p0, p1, p2, p3}, Lio/lti/KeyboxDbHelper;->onUpgrade(Landroid/database/sqlite/SQLiteDatabase;II)V

    return-void
.end method

.method public blacklist onUpgrade(Landroid/database/sqlite/SQLiteDatabase;II)V
    .locals 0

    const-string p2, "DROP TABLE IF EXISTS key_entries"

    invoke-virtual {p1, p2}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lio/lti/KeyboxDbHelper;->onCreate(Landroid/database/sqlite/SQLiteDatabase;)V

    return-void
.end method

.method blacklist storeKeyData(Ljava/lang/String;Ljava/security/KeyPair;Landroid/system/keystore2/KeyMetadata;)V
    .locals 4

    invoke-virtual {p0}, Lio/lti/KeyboxDbHelper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    new-instance v1, Landroid/content/ContentValues;

    invoke-direct {v1}, Landroid/content/ContentValues;-><init>()V

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "key_id"

    invoke-virtual {v1, v3, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v2, "key_alias"

    invoke-virtual {v1, v2, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p2}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object p1

    invoke-interface {p1}, Ljava/security/PrivateKey;->getEncoded()[B

    move-result-object p1

    const-string p2, "key_material"

    invoke-virtual {v1, p2, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;[B)V

    const-string p1, "key_metadata"

    invoke-direct {p0, p3}, Lio/lti/KeyboxDbHelper;->marshallKeyMetadata(Landroid/system/keystore2/KeyMetadata;)[B

    move-result-object p0

    invoke-virtual {v1, p1, p0}, Landroid/content/ContentValues;->put(Ljava/lang/String;[B)V

    const-string p0, "key_entries"

    const/4 p1, 0x0

    invoke-virtual {v0, p0, p1, v1}, Landroid/database/sqlite/SQLiteDatabase;->replace(Ljava/lang/String;Ljava/lang/String;Landroid/content/ContentValues;)J

    return-void
.end method

.method blacklist updateKeyData(JLjava/security/KeyPair;Landroid/system/keystore2/KeyMetadata;)V
    .locals 3

    invoke-virtual {p0}, Lio/lti/KeyboxDbHelper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    new-instance v1, Landroid/content/ContentValues;

    invoke-direct {v1}, Landroid/content/ContentValues;-><init>()V

    invoke-virtual {p3}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object p3

    invoke-interface {p3}, Ljava/security/PrivateKey;->getEncoded()[B

    move-result-object p3

    const-string v2, "key_material"

    invoke-virtual {v1, v2, p3}, Landroid/content/ContentValues;->put(Ljava/lang/String;[B)V

    const-string p3, "key_metadata"

    invoke-direct {p0, p4}, Lio/lti/KeyboxDbHelper;->marshallKeyMetadata(Landroid/system/keystore2/KeyMetadata;)[B

    move-result-object p0

    invoke-virtual {v1, p3, p0}, Landroid/content/ContentValues;->put(Ljava/lang/String;[B)V

    const/4 p0, 0x1

    new-array p0, p0, [Ljava/lang/String;

    const/4 p3, 0x0

    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p1

    aput-object p1, p0, p3

    const-string p1, "key_entries"

    const-string p2, "key_id = ?"

    invoke-virtual {v0, p1, v1, p2, p0}, Landroid/database/sqlite/SQLiteDatabase;->update(Ljava/lang/String;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    return-void
.end method
