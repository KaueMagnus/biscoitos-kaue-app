class OrderItemDb {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double subtotal;

  OrderItemDb({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.subtotal,
  });

  factory OrderItemDb.fromMap(Map<String, dynamic> map) {
    return OrderItemDb(
      id: map['id'] as int,
      orderId: map['orderId'] as int,
      productId: map['productId'] as int,
      quantity: map['quantity'] as int,
      subtotal: (map['subtotal'] as num).toDouble(),
    );
  }
}
