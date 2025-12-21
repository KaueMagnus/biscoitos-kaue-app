import 'package:flutter/material.dart';
import '../services/order_database.dart';
import '../models/order_item.dart';
import '../utils/date_formatter.dart';
import '../services/mock_data.dart';
import '../models/product.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Map<String, dynamic>? order;
  List<OrderItemDb> items = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final db = OrderDatabase.instance;

    final orderList = await db.getAllOrders();
    order = orderList.firstWhere((o) => o['id'] == widget.orderId);

    items = await db.getOrderItems(widget.orderId);

    setState(() => loading = false);
  }

  String getClientName(int clientId) {
    final client = MockData.clients.firstWhere(
          (c) => c.id == clientId,
      orElse: () => throw Exception("Cliente não encontrado"),
    );
    return client.name;
  }

  Product getProduct(int productId) {
    return MockData.products.firstWhere(
          (p) => p.id == productId,
      orElse: () => Product(
        id: 0,
        code: 0,
        name: "Produto não encontrado",
        category: "",
        weightG: 0,
        price: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final note = (order?['note'] as String?)?.trim();

    return Scaffold(
      backgroundColor: const Color(0xFFF8EFEA),
      appBar: AppBar(
        title: const Text("Detalhes do Pedido"),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------------
            // CABEÇALHO
            // -------------------------
            Text(
              "Pedido #${order!['id']}",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              "Data: ${DateFormatter.format(order!['date'])}",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 8),

            Text(
              "Cliente: ${getClientName(order!['clientId'])}",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),

            // -------------------------
            // OBSERVAÇÃO
            // -------------------------
            if (note != null && note.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.brown.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Observação",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      note,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            const Text(
              "Itens",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // -------------------------
            // LISTA DE ITENS
            // -------------------------
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final item = items[i];
                  final product = getProduct(item.productId);
                  final displayName =
                      "${product.name} ${product.weightG}g";

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.brown.shade200.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        "${item.quantity}x — R\$ ${item.subtotal.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // -------------------------
            // TOTAL
            // -------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "R\$ ${(order!['total'] as double).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
