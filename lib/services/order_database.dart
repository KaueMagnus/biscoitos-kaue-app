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
      version: 2, // 🔥 subiu versão
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            clientId INTEGER,
            total REAL,
            date TEXT,
            note TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE order_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderId INTEGER,
            productId INTEGER,
            quantity INTEGER,
            subtotal REAL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE orders ADD COLUMN note TEXT");
        }
      },
    );
  }

  Future<int> insertOrder(int clientId, double total, {String? note}) async {
    final db = await database;
    return db.insert('orders', {
      'clientId': clientId,
      'total': total,
      'date': DateTime.now().toIso8601String(),
      'note': note,
    });
  }

  Future<int> insertOrderItem({
    required int orderId,
    required int productId,
    required int quantity,
    required double subtotal,
  }) async {
    final db = await database;
    return db.insert(
      'order_items',
      {
        'orderId': orderId,
        'productId': productId,
        'quantity': quantity,
        'subtotal': subtotal,
      },
    );
  }

  Future<List<OrderItemDb>> getOrderItems(int orderId) async {
    final db = await database;

    final maps = await db.query(
      'order_items',
      where: 'orderId = ?',
      whereArgs: [orderId],
    );

    return maps.map((m) => OrderItemDb.fromMap(m)).toList();
  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final db = await database;

    return await db.query(
      'orders',
      orderBy: 'date DESC',
    );
  }

}
