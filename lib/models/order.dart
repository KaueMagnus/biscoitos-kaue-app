import 'order_item.dart';

class Order {
  final int? id;
  final int clientId;
  final List<OrderItem> items;
  final double total;
  final DateTime date;

  Order({
    this.id,
    required this.clientId,
    required this.items,
    required this.total,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'client_id': clientId,
    'total': total,
    'date': date.toIso8601String(),
  };
}
