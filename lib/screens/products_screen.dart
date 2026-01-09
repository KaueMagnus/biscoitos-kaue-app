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
  final bool isSwap;

  const ProductsScreen({
    super.key,
    required this.clientId,
    this.isSwap = false,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final products = MockData.products.where((p) => p.active).toList();

    products.sort((a, b) {
      final cat = a.category.compareTo(b.category);
      if (cat != 0) return cat;
      final pr = a.priority.compareTo(b.priority);
      if (pr != 0) return pr;
      return a.name.compareTo(b.name);
    });

    final Map<String, List<Product>> grouped = {};
    for (final p in products) {
      grouped.putIfAbsent(p.category, () => []);
      grouped[p.category]!.add(p);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE7),
      appBar: AppBar(
        title: Text(widget.isSwap ? "Produtos (Troca)" : "Produtos"),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 28),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartScreen(
                    clientId: widget.clientId,
                    isSwap: widget.isSwap,
                  ),
                ),
              );
              setState(() {});
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              widget.isSwap ? "Selecione os Produtos (Troca)" : "Selecione um Produto",
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: grouped.entries.map((entry) {
                  final category = entry.key;
                  final items = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle("— $category —"),
                      const SizedBox(height: 12),
                      ...items.map(
                            (product) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: AppCard(
                            icon: Icons.cookie_outlined,
                            title: "${product.name} ${product.weightG}g",
                            subtitle:
                            "Cód. ${product.code} • R\$ ${product.price.toStringAsFixed(2)}",
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
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
