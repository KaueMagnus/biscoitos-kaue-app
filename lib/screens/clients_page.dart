import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/mock_data.dart';
import '../widgets/app_card.dart';
import '../widgets/section_title.dart';
import 'products_screen.dart';

class ClientsPage extends StatefulWidget {
  final bool isSwap;

  const ClientsPage({super.key, this.isSwap = false});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final List<Client> allClients = MockData.clients;

    final filteredClients = allClients.where((c) {
      return c.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          c.city.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE7),
      appBar: AppBar(
        title: Text(widget.isSwap ? "Clientes (Troca)" : "Clientes"),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              widget.isSwap ? "Selecione o Cliente (Troca)" : "Selecione o Cliente",
            ),
            const SizedBox(height: 12),

            TextField(
              decoration: InputDecoration(
                hintText: "Buscar cliente...",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
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
                  style: TextStyle(fontSize: 16, color: Colors.brown.shade700),
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
                          builder: (_) => ProductsScreen(
                            clientId: c.id,
                            isSwap: widget.isSwap,
                          ),
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
