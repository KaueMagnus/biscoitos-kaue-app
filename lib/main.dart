import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/clients_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biscoitos Kaue',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown.shade500,
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
          actionsIconTheme: const IconThemeData(color: Colors.white, size: 28),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      routes: {
        '/': (_) => const HomeScreen(),
        '/clients': (_) => const ClientsPage(),
      },
      initialRoute: '/',
    );
  }
}
