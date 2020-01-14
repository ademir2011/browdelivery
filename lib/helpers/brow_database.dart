import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BrowDatabase {
  static final BrowDatabase _instance = BrowDatabase.internal();

  factory BrowDatabase() => _instance;

  BrowDatabase.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'brow_database.db');
    print(path);
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        return await db.execute(
          "CREATE TABLE ordem (id INTEGER PRIMARY KEY, location TEXT, amountBrownie INTEGER, orderStatus TEXT, tod STRING, userName TEXT)",
        );
      },
    );
  }

  Future close() async {
    BrowDatabase browDatabase = BrowDatabase();
    Database dbBrow = await browDatabase.db;
    dbBrow.close();
  }
}
