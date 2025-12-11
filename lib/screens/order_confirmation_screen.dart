import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/client_service.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Order order;

  const OrderConfirmationScreen({super.key, required this.order});

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}  "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    // Obter o cliente usando o clientId do pedido
    final client = ClientService.getById(order.clientId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedido Finalizado"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Número do pedido
            Text(
              "Pedido nº ${order.id}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Dados do cliente
            Text(
              "Cliente: ${client.name}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Cidade: ${client.city}",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),

            const SizedBox(height: 12),

            // Data
            Text(
              "Data: ${formatDate(order.date)}",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),

            const SizedBox(height: 20),

            // Total
            Text(
              "Total: R\$ ${order.total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Título "Itens"
            const Text(
              "Itens:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            // Lista de itens
            ...order.items.map(
                  (i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "${i.quantity}x ${i.productName} — R\$ ${i.subtotal.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const Spacer(),

            // Botão final
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: () {
                  // Volta ao início limpando o stack de telas
                  Navigator.popUntil(context, (r) => r.isFirst);
                },
                child: const Text(
                  "Voltar ao Início",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
