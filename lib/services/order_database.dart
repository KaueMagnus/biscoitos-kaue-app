import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/order_item.dart';

class OrderDatabase {
  OrderDatabase._();
  static final OrderDatabase instance = OrderDatabase._();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    return _db = await _initDb();
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'orders.db');

    return await openDatabase(
      path,
      version: 2, // 👈 IMPORTANTE
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            clientId INTEGER,
            total REAL,
            date TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE order_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            order_id INTEGER,
            product_id INTEGER,
            product_name TEXT,
            quantity INTEGER,
            subtotal REAL
          )
        ''');
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          await db.execute("ALTER TABLE order_items ADD COLUMN product_name TEXT");
        }
      },
    );
  }

  Future<int> insertOrder(int clientId, double total) async {
    final db = await database;
    return db.insert('orders', {
      'clientId': clientId,
      'total': total,
      'date': DateTime.now().toIso8601String(),
    });
  }

  Future<int> insertOrderItem({
    required int orderId,
    required int productId,
    required String productName,
    required int quantity,
    required double subtotal,
  }) async {
    final db = await database;
    return db.insert(
      'order_items',
      {
        'order_id': orderId,
        'product_id': productId,
        'product_name': productName,
        'quantity': quantity,
        'subtotal': subtotal,
      },
    );
  }

  Future<List<OrderItemDb>> getOrderItems(int orderId) async {
    final db = await database;

    final maps = await db.query(
      'order_items',
      where: 'order_id = ?',
      whereArgs: [orderId],
    );

    return maps.map((m) => OrderItemDb.fromMap(m)).toList();
  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final db = await database;
    return await db.query(
      'orders',
      orderBy: 'id DESC',
    );
  }
}
