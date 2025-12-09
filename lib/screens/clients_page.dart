import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/mock_data.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Client> clients = MockData.clients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: ListView.separated(
        itemCount: clients.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final c = clients[index];

          return ListTile(
            title: Text(c.name),
            subtitle: Text(c.city),
            trailing: c.email != null
                ? const Icon(Icons.email, size: 20)
                : null,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => _clientDetailsSheet(context, c),
              );
            },
          );
        },
      ),
    );
  }

  Widget _clientDetailsSheet(BuildContext context, Client c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(c.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Cidade: ${c.city}'),
          if (c.email != null) ...[
            const SizedBox(height: 8),
            Text('Email: ${c.email}'),
          ],
          if (c.phone != null) ...[
            const SizedBox(height: 8),
            Text('Telefone: ${c.phone}'),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Abrir produtos (em desenvolvimento)')),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Fazer Pedido'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Abrir tela de Troca (em desenvolvimento)')),
                  );
                },
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Troca'),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
