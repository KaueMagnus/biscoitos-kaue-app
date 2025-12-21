import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../services/cart_service.dart';
import '../services/order_service.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  final int clientId;

  const CartScreen({super.key, required this.clientId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final items = CartService.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE7),

      appBar: AppBar(
        title: const Text("Carrinho"),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
        elevation: 2,
      ),

      body: items.isEmpty
          ? const Center(
        child: Text(
          "Seu carrinho está vazio",
          style: TextStyle(fontSize: 18),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 16),
              itemBuilder: (_, i) {
                final CartItem item = items[i];

                return _buildCartItem(item);
              },
            ),
          ),

          _buildBottomTotal(),
        ],
      ),
    );
  }

  // --------------------------
  // CARD DO ITEM (estilo iFood)
  // --------------------------
  Widget _buildCartItem(CartItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          // Ícone do produto
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.brown.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.cookie_outlined, size: 26),
          ),

          const SizedBox(width: 16),

          // Nome + subtotal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "R\$ ${item.subtotal.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.brown.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Botões +/- estilo iFood
          Row(
            children: [
              _qtyButton(
                icon: Icons.remove,
                onTap: () {
                  if (item.quantity > 1) {
                    CartService.updateQuantity(
                        item.product.id!, item.quantity - 1);
                  } else {
                    CartService.removeItem(item.product.id!);
                  }
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  item.quantity.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _qtyButton(
                icon: Icons.add,
                onTap: () {
                  CartService.updateQuantity(
                      item.product.id!, item.quantity + 1);
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------
  // BOTÃO CIRCULAR iFood
  // --------------------------
  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Colors.brown.shade300, width: 1),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  // --------------------------
  // TOTAL + BOTÃO FINALIZAR
  // --------------------------
  Widget _buildBottomTotal() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        border: Border(
          top: BorderSide(color: Colors.brown.shade200),
        ),
      ),
      child: Column(
        children: [
          // Total do pedido
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total do Pedido:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "R\$ ${CartService.total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Botão finalizar
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () async {
                final order = await OrderService.createOrder(widget.clientId);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderConfirmationScreen(order: order),
                  ),
                );
              },
              child: const Text(
                "Finalizar Pedido",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
