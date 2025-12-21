import '../models/order.dart';
import 'order_database.dart';
import 'cart_service.dart';

class OrderService {
  static Future<Order> createOrder(int clientId, {String? note}) async {
    final cartItems = CartService.items;

    if (cartItems.isEmpty) {
      throw Exception("Carrinho vazio");
    }

    final total = CartService.total;

    final orderId = await OrderDatabase.instance.insertOrder(
      clientId,
      total,
      note: note,
    );

    for (var item in cartItems) {
      await OrderDatabase.instance.insertOrderItem(
        orderId: orderId,
        productId: item.product.id!, // assume id não nulo
        quantity: item.quantity,
        subtotal: item.subtotal,
      );
    }

    CartService.clear();

    final orderItems = await OrderDatabase.instance.getOrderItems(orderId);

    return Order(
      id: orderId,
      clientId: clientId,
      total: total,
      date: DateTime.now(),
      items: orderItems, // se seu Order usa outro tipo, me fala que ajusto
    );
  }
}
