import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/mock_data.dart';
import '../services/cart_service.dart';
import 'new_order_screen.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatefulWidget {
  final int clientId;

  const ProductsScreen({super.key, required this.clientId});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final products = MockData.products;
    final count = CartService.totalItems;

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
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewOrderScreen(
                    clientId: widget.clientId, // pega do widget
                    product: product,
                  ),
                ),
              );

              // Quando voltar da tela de Novo Pedido,
              // força rebuild para atualizar o contador do carrinho
              setState(() {});
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
              MaterialPageRoute(
                builder: (_) => CartScreen(clientId: widget.clientId),
              ),
          );
        },
        icon: const Icon(Icons.shopping_cart),
        label: Text(
          'Carrinho ($count)', // usa o count calculado acima
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
