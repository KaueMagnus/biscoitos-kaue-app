import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/mock_data.dart';
import 'new_order_screen.dart';

class ProductsScreen extends StatelessWidget {
  final int clientId;

  const ProductsScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = MockData.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = products[index];

          return ListTile(
            title: Text(product.name),
            subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewOrderScreen(
                    clientId: clientId,
                    product: product,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
