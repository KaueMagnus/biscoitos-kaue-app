import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../services/cart_service.dart';
import '../services/order_service.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  final int clientId;
  final bool isSwap;

  const CartScreen({
    super.key,
    required this.clientId,
    this.isSwap = false,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _noteCtrl = TextEditingController();
  final TextEditingController _swapReasonCtrl = TextEditingController();

  @override
  void dispose() {
    _noteCtrl.dispose();
    _swapReasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = CartService.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE7),
      appBar: AppBar(
        title: Text(widget.isSwap ? "Carrinho (Troca)" : "Carrinho"),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: items.isEmpty
          ? const Center(
        child: Text("Seu carrinho está vazio", style: TextStyle(fontSize: 18)),
      )
          : Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...items.map(_buildCartItem).toList(),
                const SizedBox(height: 18),

                // --------------------------
                // MOTIVO DA TROCA (somente troca)
                // --------------------------
                if (widget.isSwap) ...[
                  Text(
                    "Motivo da Troca",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _swapReasonCtrl,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "Ex: produto quebrado / vencido / erro no pedido...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.brown.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.brown.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.brown.shade400, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                ],

                // --------------------------
                // OBSERVAÇÃO
                // --------------------------
                Text(
                  widget.isSwap ? "Observação da Troca" : "Observação do Pedido",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _noteCtrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText:
                    "Ex: entregar sexta / produto avariado / falar com comprador...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.brown.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.brown.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.brown.shade400, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomTotal(context),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  widget.isSwap ? "—" : "R\$ ${item.subtotal.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.brown.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _qtyButton(
                icon: Icons.remove,
                onTap: () {
                  if (item.quantity > 1) {
                    CartService.updateQuantity(item.product.id, item.quantity - 1);
                  } else {
                    CartService.removeItem(item.product.id);
                  }
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  item.quantity.toString(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _qtyButton(
                icon: Icons.add,
                onTap: () {
                  CartService.updateQuantity(item.product.id, item.quantity + 1);
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

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

  Widget _buildBottomTotal(BuildContext context) {
    final totalText =
    widget.isSwap ? "R\$ 0,00" : "R\$ ${CartService.total.toStringAsFixed(2)}";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        border: Border(top: BorderSide(color: Colors.brown.shade200)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isSwap ? "Total da Troca:" : "Total do Pedido:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                totalText,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.isSwap ? Colors.orange.shade700 : Colors.brown.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () async {
                final note = _noteCtrl.text.trim();
                final swapReason = _swapReasonCtrl.text.trim();

                if (widget.isSwap && swapReason.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Informe o motivo da troca")),
                  );
                  return;
                }

                final order = await OrderService.createOrder(
                  widget.clientId,
                  note: note.isEmpty ? null : note,
                  type: widget.isSwap ? "SWAP" : "NORMAL",
                  swapReason: widget.isSwap ? swapReason : null,
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => OrderConfirmationScreen(order: order)),
                );
              },
              child: Text(
                widget.isSwap ? "Salvar Troca" : "Finalizar Pedido",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
