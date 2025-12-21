import 'package:biscoitos_kaue_app/models/order.dart';
import '../models/order_item.dart';
import 'order_database.dart';
import 'cart_service.dart';

class OrderService {
  static Future<Order> createOrder(int clientId) async {
    final cartItems = CartService.items;

    if (cartItems.isEmpty) {
      throw Exception("Carrinho vazio");
    }

    final total = CartService.total;

    // Criar pedido no banco
    final orderId = await OrderDatabase.instance.insertOrder(clientId, total);

    // Inserir os itens
    for (var item in cartItems) {
      await OrderDatabase.instance.insertOrderItem(
        orderId: orderId,
        productId: item.product.id,
        productName: item.product.name, // 👈 AGORA ENVIADO
        quantity: item.quantity,
        subtotal: item.subtotal,
      );
    }

    // Limpa o carrinho
    CartService.clear();

    // Buscar os itens inseridos
    final orderItems = await OrderDatabase.instance.getOrderItems(orderId);

    return Order(
      id: orderId,
      clientId: clientId,
      total: total,
      date: DateTime.now(),
      items: orderItems,
    );
  }
  
  static Future<List<Order>> getAllOrders() async {
    final rows = await OrderDatabase.instance.getAllOrders();
    List<Order> orders = [];

    for (var row in rows) {
      final orderId = row['id'] as int;

      final items = await OrderDatabase.instance.getOrderItems(orderId);

      orders.add(
        Order(
          id: orderId,
          clientId: row['clientId'],
          total: row['total'],
          date: DateTime.parse(row['date']),
          items: items,
        ),
      );
    }

    return orders;
  }
}
