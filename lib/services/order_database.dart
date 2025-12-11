import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';
import '../models/order.dart';
import '../models/order_item.dart';

class OrderDatabase {
  static Future<int> insertOrder(Order order) async {
    final db = await AppDatabase.instance.database;

    // Salva o pedido
    final orderId = await db.insert('orders', order.toMap());

    // Salva os itens
    for (final item in order.items) {
      await db.insert('order_items', item.toMap(orderId));
    }

    return orderId;
  }

  static Future<List<Order>> getAllOrders() async {
    final db = await AppDatabase.instance.database;

    final result = await db.query('orders', orderBy: 'date DESC');

    return result.map((map) {
      return Order(
        id: map['id'] as int,
        clientId: map['client_id'] as int,
        items: [],
        total: (map['total'] as num).toDouble(),
        date: DateTime.parse(map['date'].toString()),
      );
    }).toList();
  }
}
