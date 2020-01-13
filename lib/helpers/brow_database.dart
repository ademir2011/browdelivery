import 'package:sqflite/sqflite.dart';
import 'package:brow/model/order.dart';
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
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'brow_database.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE order(id INTEGER PRIMARY KEY, location TEXT, amount_brownie INT, order_aproved BOOL)",
      );
    });
  }

  Future<Order> saveOrder(Order order) async {
    Database dbBrow = await db;
    await dbBrow.insert(
      "order",
      order.toMap(),
    );
    return order;
  }

  Future<Order> getOrder(int id) async {
    Database dbBrow = await db;
    List<Map> maps = await dbBrow.query(
      "order",
      columns: ["id", "location", "amount_brownie", "order_aproved"],
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      print(maps[0]["location"]);
    } else {
      print("ordem não encontrada!");
    }
  }

  Future<int> deleteOrder(int id) async {
    Database dbBrow = await db;
    return await dbBrow.delete("order", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateOrder(Order order) async {
    Database dbBrow = await db;
    return await dbBrow.update(
      "order",
      order.toMap(),
      where: "id = ?",
      whereArgs: [order.id],
    );
  }

  Future<List> getAllOrders() async {
    Database dbBrow = await db;
    List listMap = await dbBrow.rawQuery("SELECT * FROM order");
    List<Order> listOrders = List();
    for (Map m in listMap) {
      print(m["location"]);
    }
    return listOrders;
  }

  Future<int> getNumber() async {
    Database dbBrow = await db;
    return Sqflite.firstIntValue(
      await dbBrow.rawQuery("SELECT COUNT(*) FROM order"),
    );
  }

  Future close() async {
    Database dbBrow = await db;
    dbBrow.close();
  }
}
