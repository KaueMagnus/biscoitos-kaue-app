import 'package:flutter/material.dart';

import '../services/order_database.dart';
import '../services/order_service.dart';
import '../services/mock_data.dart';

class CreateSwapOrderScreen extends StatefulWidget {
  final int originalOrderId;
  final int clientId;

  const CreateSwapOrderScreen({
    super.key,
    required this.originalOrderId,
    required this.clientId,
  });

  @override
  State<CreateSwapOrderScreen> createState() => _CreateSwapOrderScreenState();
}

class _CreateSwapOrderScreenState extends State<CreateSwapOrderScreen> {
  final reasonController = TextEditingController();

  bool loading = true;
  List<_SwapItemForm> items = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  Future<void> loadItems() async {
    final orderItems =
    await OrderDatabase.instance.getOrderItems(widget.originalOrderId);

    items = orderItems
        .map((i) => _SwapItemForm(productId: i.productId, originalQty: i.quantity))
        .toList();

    setState(() => loading = false);
  }

  bool validate() {
    final selected = items.where((i) => i.qty > 0).toList();
    if (selected.isEmpty) return false;

    for (final i in selected) {
      if (i.qty > i.originalQty) return false;
    }
    return true;
  }

  Future<void> saveSwap() async {
    if (!validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verifique as quantidades informadas')),
      );
      return;
    }

    final reason = reasonController.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o motivo da troca')),
      );
      return;
    }

    try {
      final swapItems = items
          .where((i) => i.qty > 0)
          .map((i) => SwapItemInput(productId: i.productId, quantity: i.qty))
          .toList();

      await OrderService.createSwapOrder(
        widget.clientId,
        swapReason: reason,
        note: 'Troca do pedido #${widget.originalOrderId}',
        items: swapItems,
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  String getProductName(int id) {
    return MockData.products.firstWhere((p) => p.id == id).name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedido de Troca')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Motivo da troca',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                final item = items[i];
                return ListTile(
                  title: Text(getProductName(item.productId)),
                  subtitle: Text('Comprado: ${item.originalQty}'),
                  trailing: SizedBox(
                    width: 70,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Troca'),
                      onChanged: (v) {
                        setState(() {
                          item.qty = int.tryParse(v) ?? 0;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: saveSwap,
              child: const Text('Salvar troca'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwapItemForm {
  final int productId;
  final int originalQty;
  int qty;

  _SwapItemForm({
    required this.productId,
    required this.originalQty,
    this.qty = 0,
  });
}
