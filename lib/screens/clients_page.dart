import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/mock_data.dart';
import '../widgets/app_card.dart';
import '../widgets/section_title.dart';
import 'products_screen.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final List<Client> allClients = MockData.clients;

    // 🔎 Filtragem simples
    final filteredClients = allClients.where((c) {
      return c.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          c.city.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE7),

      appBar: AppBar(
        title: const Text("Clientes"),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
        elevation: 2,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle("Selecione o Cliente"),

            const SizedBox(height: 12),

            // 🔍 Campo de busca
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar cliente...",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) {
                setState(() => searchQuery = text);
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: filteredClients.isEmpty
                  ? Center(
                child: Text(
                  "Nenhum cliente encontrado",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.brown.shade700,
                  ),
                ),
              )
                  : ListView.separated(
                itemCount: filteredClients.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (_, i) {
                  final c = filteredClients[i];

                  return AppCard(
                    icon: Icons.storefront_outlined,
                    title: c.name,
                    subtitle: c.city,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductsScreen(clientId: c.id),
                        ),
                      );
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
