import 'order_item.dart';

class Order {
  final int id;
  final int clientId;
  final double total;
  final DateTime date;
  final List<OrderItemDb> items;

  Order({
    required this.id,
    required this.clientId,
    required this.total,
    required this.date,
    required this.items,
  });
}
