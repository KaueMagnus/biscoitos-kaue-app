import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/mock_data.dart';
import '../widgets/app_card.dart';
import '../widgets/section_title.dart';
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

    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE7),

      appBar: AppBar(
        title: const Text("Produtos"),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        actions: [
          // -------------------------
          // BADGE DO CARRINHO
          // -------------------------
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 28),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen(clientId: widget.clientId)),
                  );
                  setState(() {}); // Atualiza badge ao voltar
                },
              ),

              // Badge
              if (CartService.totalItems > 0)
                Positioned(
                  right: 6,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      CartService.totalItems.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle("Selecione um Produto"),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (_, i) {
                  final product = products[i];

                  return AppCard(
                    icon: Icons.cookie_outlined,
                    title: product.name,
                    subtitle: "R\$ ${product.price.toStringAsFixed(2)}",
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewOrderScreen(
                            clientId: widget.clientId,
                            product: product,
                          ),
                        ),
                      );
                      setState(() {}); // Atualiza badge do carrinho
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
