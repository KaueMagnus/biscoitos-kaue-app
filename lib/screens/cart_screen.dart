import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../services/cart_service.dart';
import '../services/order_service.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatelessWidget {
  final int clientId;

  const CartScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    final items = CartService.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: items.isEmpty
          ? const Center(
        child: Text('Seu carrinho está vazio'),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final CartItem item = items[i];

                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text(
                    '${item.quantity} x R\$ ${item.product.price.toStringAsFixed(2)}',
                  ),
                  trailing: Text(
                    'R\$ ${item.subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          // TOTAL
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'R\$ ${CartService.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Botão Finalizar Pedido
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {
                      final order = await OrderService.finalizeOrder(clientId);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              OrderConfirmationScreen(order: order),
                        ),
                      );
                    },
                    child: const Text(
                      'Finalizar Pedido',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
