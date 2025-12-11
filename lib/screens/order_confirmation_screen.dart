import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/mock_data.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Order order;

  const OrderConfirmationScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pedido Finalizado")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pedido nº ${order.id}",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            Text(
              "Total: R\$ ${order.total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),

            const Text("Itens:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),

            ...order.items.map((i) {
              final product = MockData.products.firstWhere(
                    (p) => p.id == i.productId,
                orElse: () => throw Exception("Produto não encontrado"),
              );

              return Text(
                "${i.quantity}x ${product.name} — R\$ ${i.subtotal.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 16),
              );
            }),

            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (r) => r.isFirst);
                },
                child: const Text("Voltar ao Início"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
