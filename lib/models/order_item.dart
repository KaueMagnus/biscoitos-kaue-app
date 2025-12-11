class OrderItemDb {
  final int? id;
  final int orderId;
  final int productId;
  final String productName;
  final int quantity;
  final double subtotal;

  OrderItemDb({
    this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.subtotal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }

  factory OrderItemDb.fromMap(Map<String, dynamic> map) {
    return OrderItemDb(
      id: map['id'] as int?,
      orderId: map['order_id'] as int,
      productId: map['product_id'] as int,
      productName: map['product_name'] as String,
      quantity: map['quantity'] as int,
      subtotal: (map['subtotal'] as num).toDouble(),
    );
  }
}
