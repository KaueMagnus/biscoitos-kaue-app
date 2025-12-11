class OrderItem {
  final int? id;
  final int productId;
  final int quantity;
  final double subtotal;

  OrderItem({
    this.id,
    required this.productId,
    required this.quantity,
    required this.subtotal,
  });

  Map<String, dynamic> toMap(int orderId) => {
    'id': id,
    'order_id': orderId,
    'product_id': productId,
    'quantity': quantity,
    'subtotal': subtotal,
  };
}
