import '../models/order.dart';
import '../models/order_item.dart';
import '../services/cart_service.dart';
import 'order_database.dart';

class OrderService {
  static Future<Order> finalizeOrder(int clientId) async {
    // Convertendo itens do carrinho para OrderItem (SEM referência a Product)
    final orderItems = CartService.items.map((cartItem) {
      return OrderItem(
        productId: cartItem.product.id!,
        quantity: cartItem.quantity,
        subtotal: cartItem.product.price * cartItem.quantity,
      );
    }).toList();

    // Criando objeto Pedido
    final order = Order(
      clientId: clientId,
      items: orderItems,
      total: CartService.total,
      date: DateTime.now(),
    );

    // Inserindo no banco e recebendo o ID
    final orderId = await OrderDatabase.insertOrder(order);

    // Criamos o objeto final com ID preenchido
    final savedOrder = Order(
      id: orderId,
      clientId: clientId,
      items: orderItems,
      total: CartService.total,
      date: order.date,
    );

    // Limpa o carrinho após finalizar
    CartService.clear();

    return savedOrder;
  }
}
