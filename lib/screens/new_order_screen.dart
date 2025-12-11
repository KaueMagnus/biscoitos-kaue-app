import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class NewOrderScreen extends StatefulWidget {
  final int clientId;
  final Product product;

  const NewOrderScreen({
    super.key,
    required this.clientId,
    required this.product,
  });

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  int quantity = 1;

  void increase() {
    setState(() => quantity++);
  }

  void decrease() {
    if (quantity > 1) {
      setState(() => quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido para Cliente ${widget.clientId}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome do produto
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Preço
            Text(
              'Preço unitário: R\$ ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 24),

            // Seletor de quantidade
            const Text(
              "Quantidade:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _qtyButton(Icons.remove, decrease),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                _qtyButton(Icons.add, increase),
              ],
            ),

            const SizedBox(height: 40),

            // Botão Adicionar ao Pedido
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  CartService.addItem(product, quantity);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} x$quantity adicionado!')),
                  );

                  Navigator.pop(context);
                },
                child: const Text(
                  'Adicionar ao Pedido',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onPressed) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.brown.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 26),
        ),
      ),
    );
  }
}
