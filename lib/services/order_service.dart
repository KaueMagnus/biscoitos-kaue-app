import '../models/order.dart';
import 'order_database.dart';
import 'cart_service.dart';

class OrderService {
  static Future<Order> createOrder(
      int clientId, {
        String? note,
        String type = "NORMAL", // NORMAL ou SWAP (ou o padrão que você usar)
        String? swapReason,
      }) async {
    final cartItems = CartService.items;

    if (cartItems.isEmpty) {
      throw Exception("Carrinho vazio");
    }

    final isSwap = type.toUpperCase() == 'SWAP';

    final total = isSwap ? 0.0 : CartService.total;

    final orderId = await OrderDatabase.instance.insertOrder(
      clientId,
      total,
      note: note,
      type: type, // <-- AQUI estava faltando
      swapReason: isSwap ? swapReason : null, // <-- AQUI também
    );

    for (var item in cartItems) {
      await OrderDatabase.instance.insertOrderItem(
        orderId: orderId,
        productId: item.product.id!, // assume id não nulo
        quantity: item.quantity,
        subtotal: isSwap ? 0.0 : item.subtotal,
      );
    }

    CartService.clear();

    final orderItems = await OrderDatabase.instance.getOrderItems(orderId);

    return Order(
      id: orderId,
      clientId: clientId,
      total: total,
      date: DateTime.now(),
      items: orderItems,
    );
  }

  static Future<Order> createSwapOrder(
      int clientId, {
        required String swapReason,
        String? note,
        required List<SwapItemInput> items,
      }) async {
    final reason = swapReason.trim();
    if (reason.isEmpty) {
      throw Exception("Motivo da troca é obrigatório");
    }

    final selected = items.where((i) => i.quantity > 0).toList();
    if (selected.isEmpty) {
      throw Exception("Selecione ao menos 1 item para troca");
    }

    const total = 0.0;

    final orderId = await OrderDatabase.instance.insertOrder(
      clientId,
      total,
      note: note,
      type: "SWAP",
      swapReason: reason,
    );

    for (final item in selected) {
      await OrderDatabase.instance.insertOrderItem(
        orderId: orderId,
        productId: item.productId,
        quantity: item.quantity,
        subtotal: 0.0,
      );
    }

    final orderItems = await OrderDatabase.instance.getOrderItems(orderId);

    return Order(
      id: orderId,
      clientId: clientId,
      total: total,
      date: DateTime.now(),
      items: orderItems,
    );
  }
}

class SwapItemInput {
  final int productId;
  final int quantity;

  const SwapItemInput({
    required this.productId,
    required this.quantity,
  });
}
