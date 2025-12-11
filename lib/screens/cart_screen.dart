import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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

          // Total
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
                  child: ElevatedButton(
                    onPressed: () {
                      // No futuro: salvar no banco e enviar email
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Finalização ainda não implementada'),
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
