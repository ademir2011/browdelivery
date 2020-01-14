import 'package:brow/helpers/brow_database.dart';
import 'package:brow/model/order.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class OrderDAO {
  Future<Order> saveOrder(Order order) async {
    BrowDatabase browDatabase = BrowDatabase();
    Database dbBrow = await browDatabase.db;

    await dbBrow.insert(
      "ordem",
      order.toMap(),
    );

    return order;
  }

  Future<Order> getOrder(int id) async {
    BrowDatabase browDatabase = BrowDatabase();
    Database dbBrow = await browDatabase.db;

    List<Map> maps = await dbBrow.query(
      "ordem",
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
    BrowDatabase browDatabase = BrowDatabase();
    Database dbBrow = await browDatabase.db;
    return await dbBrow.delete("ordem", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateOrder(Order order) async {
    BrowDatabase browDatabase = BrowDatabase();
    Database dbBrow = await browDatabase.db;
    return await dbBrow.update(
      "ordem",
      order.toMap(),
      where: "id = ?",
      whereArgs: [order.id],
    );
  }

  Future<List> getAllOrders() async {
    BrowDatabase browDatabase = BrowDatabase();
    Database dbBrow = await browDatabase.db;
    List listMap = await dbBrow.rawQuery("SELECT * FROM ordem");
    List<Order> listOrders = List();
    for (Map m in listMap) {
      listOrders.add(Order.fromMap(m));
    }
    return listOrders;
  }

  Future<int> getNumber() async {
    BrowDatabase browDatabase = BrowDatabase();
    Database dbBrow = await browDatabase.db;
    return Sqflite.firstIntValue(
      await dbBrow.rawQuery("SELECT COUNT(*) FROM order"),
    );
  }
}
