import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DatabaseHelper extends SQLiteOpenHelper {
    private static final String DATABASE_NAME = "kaffe_database.db";
    private static final int DATABASE_VERSION = 1;

    public DatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // Tabloları oluştur
        db.execSQL("CREATE TABLE IF NOT EXISTS Customers (customer_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT)");
        // Diğer tabloları burada oluşturabilirsiniz
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // Veritabanı yapısını güncelle
        if (oldVersion < 2) {
            // Eski sürüm 1 ise ve yeni sürüm 2 ise, örneğin yeni bir tablo ekleyebilirsiniz
            db.execSQL("CREATE TABLE IF NOT EXISTS Orders (order_id INTEGER PRIMARY KEY AUTOINCREMENT, customer_id INTEGER, total REAL)");
        }
        // Diğer güncelleme işlemleri buraya eklenir
    }
}
