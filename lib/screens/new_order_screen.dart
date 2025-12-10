import 'package:flutter/material.dart';
import '../models/product.dart';

class NewOrderScreen extends StatelessWidget {
  final int clientId;
  final Product product;

  const NewOrderScreen({
    super.key,
    required this.clientId,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedido para Cliente $clientId')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Preço unitário: R\$ ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const Text('Em breve: escolher quantidade, salvar pedido, etc.'),
          ],
        ),
      ),
    );
  }
}
