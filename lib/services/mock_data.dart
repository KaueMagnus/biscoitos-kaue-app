import '../models/product.dart';
import '../models/client.dart';

class MockData {
  // -----------------------
  // CLIENTES (exemplo)
  // -----------------------
  static final List<Client> clients = [
    Client(id: 1, name: "Mercado Silva", city: "Joinville", email: "silva@mercado.com"),
    Client(id: 2, name: "Padaria Doce Pão", city: "Araquari"),
    Client(id: 3, name: "Super Loanda", city: "São Francisco do Sul"),
  ];

  // -----------------------
  // PRODUTOS (REAIS)
  // -----------------------
  static final List<Product> products = [
    // ===== ROSQUINHAS =====
    Product(
      id: 2,
      code: 2,
      name: "Rosquinha Natural",
      category: "Rosquinhas",
      weightG: 120,
      price: 0.0,
      priority: 1, // ✅ teu pai pediu esse primeiro
    ),
    Product(
      id: 1,
      code: 1,
      name: "Rosquinha Natural",
      category: "Rosquinhas",
      weightG: 80,
      price: 0.0,
      priority: 2,
    ),
    Product(
      id: 3,
      code: 3,
      name: "Rosquinha Cebola e Salsa",
      category: "Rosquinhas",
      weightG: 70,
      price: 0.0,
    ),
    Product(
      id: 4,
      code: 4,
      name: "Rosquinha Calabresa",
      category: "Rosquinhas",
      weightG: 70,
      price: 0.0,
    ),
    Product(
      id: 5,
      code: 5,
      name: "Rosquinha Churrasco",
      category: "Rosquinhas",
      weightG: 70,
      price: 0.0,
    ),
    Product(
      id: 6,
      code: 6,
      name: "Rosquinha Pizza",
      category: "Rosquinhas",
      weightG: 70,
      price: 0.0,
    ),
    Product(
      id: 7,
      code: 7,
      name: "Rosquinha Bacon",
      category: "Rosquinhas",
      weightG: 70,
      price: 0.0,
    ),

    // Item 08 alterado pelo teu pai:
    Product(
      id: 8,
      code: 8,
      name: "Palito de Polvilho com mais proteína",
      category: "Palito de Polvilho",
      weightG: 60,
      price: 0.0,
      priority: 5,
    ),

    // Item 09 removido (mantém no catálogo, mas não aparece)
    Product(
      id: 9,
      code: 9,
      name: "Rosquinha Fit Batata Doce",
      category: "Rosquinhas",
      weightG: 50,
      price: 0.0,
      active: false, // ❌ teu pai pediu tirar
    ),

    Product(
      id: 10,
      code: 10,
      name: "Rosquinha Fit Chia e Linhaça",
      category: "Rosquinhas",
      weightG: 70,
      price: 0.0,
    ),

    // Item 11 (multigrãos) removido (não aparece)
    Product(
      id: 11,
      code: 11,
      name: "Biscoito de Polvilho Integral Multigrãos",
      category: "Polvilho",
      weightG: 60,
      price: 0.0,
      active: false, // ❌ não tem mais
    ),

    // ===== OUTROS =====
    Product(
      id: 12,
      code: 12,
      name: "Bolinha de Queijo",
      category: "Salgados",
      weightG: 70,
      price: 0.0,
    ),

    // ===== MERENGUES =====
    // ✅ Novo item (não estava na folha) - teu pai pediu 170g primeiro
    Product(
      id: 29,
      code: 29,
      name: "Merengue Caseiro",
      category: "Merengues",
      weightG: 170,
      price: 0.0,
      priority: 1,
    ),

    Product(
      id: 13,
      code: 13,
      name: "Merengue Caseiro",
      category: "Merengues",
      weightG: 100,
      price: 0.0,
      priority: 2,
    ),
    Product(
      id: 14,
      code: 14,
      name: "Merengue Limão",
      category: "Merengues",
      weightG: 100,
      price: 0.0,
    ),
    Product(
      id: 15,
      code: 15,
      name: "Merengue Leite Condensado",
      category: "Merengues",
      weightG: 100,
      price: 0.0,
    ),
    Product(
      id: 16,
      code: 16,
      name: "Merengue Morango",
      category: "Merengues",
      weightG: 100,
      price: 0.0,
    ),

    Product(
      id: 17,
      code: 17,
      name: "Flocos de Arroz Natural",
      category: "Flocos",
      weightG: 100,
      price: 0.0,
    ),

    // ===== BROAS =====
    Product(
      id: 18,
      code: 18,
      name: "Broa de Neve",
      category: "Broas",
      weightG: 170,
      price: 0.0,
    ),
    Product(
      id: 19,
      code: 19,
      name: "Broa de Polvilho Tradicional",
      category: "Broas",
      weightG: 200,
      price: 0.0,
    ),
    Product(
      id: 20,
      code: 20,
      name: "Broa de Polvilho com Coco",
      category: "Broas",
      weightG: 200,
      price: 0.0,
    ),
    Product(
      id: 21,
      code: 21,
      name: "Broa de Milho sem Lactose",
      category: "Broas",
      weightG: 200,
      price: 0.0,
    ),

    // ===== BISCOITOS =====
    Product(
      id: 22,
      code: 22,
      name: "Biscoito de Amendoim",
      category: "Biscoitos Doces",
      weightG: 200,
      price: 0.0,
    ),
    Product(
      id: 23,
      code: 23,
      name: "Biscoito Amanteigado",
      category: "Biscoitos Doces",
      weightG: 250,
      price: 0.0,
    ),
    Product(
      id: 24,
      code: 24,
      name: "Biscoito Amanteigado com Goiabada",
      category: "Biscoitos Doces",
      weightG: 250,
      price: 0.0,
    ),
    Product(
      id: 25,
      code: 25,
      name: "Biscoito de Natal",
      category: "Biscoitos Doces",
      weightG: 250,
      price: 0.0,
    ),

    Product(
      id: 26,
      code: 26,
      name: "Rosca Merengada",
      category: "Biscoitos Doces",
      weightG: 250,
      price: 0.0,
    ),
    Product(
      id: 27,
      code: 27,
      name: "Joelhinho Crocante",
      category: "Salgados",
      weightG: 180,
      price: 0.0,
    ),

    // ===== SALGADOS =====
    Product(
      id: 28,
      code: 28,
      name: "Salgadinho de Bacon",
      category: "Salgados",
      weightG: 70, // ✅ teu pai confirmou 70g
      price: 0.0,
    ),
  ];
}
