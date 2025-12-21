import 'package:flutter/material.dart';
import '../services/order_database.dart';

import '../utils/date_formatter.dart';
import 'order_details_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<Map<String, dynamic>> orders = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    final data = await OrderDatabase.instance.getAllOrders();
    setState(() {
      orders = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFEA),
      appBar: AppBar(
        title: const Text("Histórico de Pedidos"),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
          ? const Center(
        child: Text(
          "Nenhum pedido encontrado",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (_, i) {
          final order = orders[i];

          return Card(
            elevation: 3,
            shadowColor: Colors.brown.shade200,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                "Pedido #${order['id']}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Total: R\$ ${(order['total'] as double).toStringAsFixed(2)}\n"
                    "Data: ${DateFormatter.format(order['date'])}",
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderDetailsScreen(orderId: order['id']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
