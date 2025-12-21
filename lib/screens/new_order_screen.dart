import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import '../widgets/app_button.dart';

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

  void increase() => setState(() => quantity++);
  void decrease() {
    if (quantity > 1) setState(() => quantity--);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE7),

      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // -------------------------
            // CARD DO PRODUTO
            // -------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.shade200.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cookie_outlined,
                    size: 64,
                    color: Colors.brown.shade600,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "R\$ ${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // -------------------------
            // CONTROLE DE QUANTIDADE
            // -------------------------
            Text(
              "Quantidade",
              style: TextStyle(
                fontSize: 18,
                color: Colors.brown.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _qtyButton(Icons.remove, decrease),
                const SizedBox(width: 28),
                Text(
                  "$quantity",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 28),
                _qtyButton(Icons.add, increase),
              ],
            ),
          ],
        ),
      ),

      // -------------------------
      // BOTÃO FIXO NO RODAPÉ
      // -------------------------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.brown.shade500,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: AppButton(
          label: "Adicionar ao Pedido",
          icon: Icons.add_shopping_cart,
          backgroundColor: Colors.white,
          color: Colors.brown.shade700,
          onPressed: () {
            CartService.addItem(product, quantity);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${product.name} x$quantity adicionado ao pedido!"),
                duration: const Duration(seconds: 2),
              ),
            );

            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // BOTÃO DE DIMINUIR/AUMENTAR QUANTIDADE
  // ---------------------------------------------------------------
  Widget _qtyButton(IconData icon, VoidCallback onPressed) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.brown.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 28, color: Colors.brown.shade700),
        ),
      ),
    );
  }
}
