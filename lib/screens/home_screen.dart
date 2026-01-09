import 'package:flutter/material.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/section_title.dart';
import '../screens/clients_page.dart';
import '../screens/orders_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE7),
      appBar: AppBar(
        title: const Text(
          'Biscoitos Kauê',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.brown.shade500,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle("Bem-vindo!"),
            const SizedBox(height: 8),
            Text(
              "Escolha uma das opções abaixo:",
              style: TextStyle(fontSize: 16, color: Colors.brown.shade600),
            ),
            const SizedBox(height: 28),

            DashboardCard(
              icon: Icons.shopping_cart_outlined,
              title: "Novo Pedido",
              color: Colors.brown.shade600,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ClientsPage(isSwap: false),
                  ),
                );
              },
            ),

            const SizedBox(height: 18),

            DashboardCard(
              icon: Icons.swap_horiz,
              title: "Pedido de Troca",
              color: Colors.orange.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ClientsPage(isSwap: true),
                  ),
                );
              },
            ),

            const SizedBox(height: 18),

            DashboardCard(
              icon: Icons.history,
              title: "Histórico de Pedidos",
              color: Colors.blueGrey.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OrderHistoryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
