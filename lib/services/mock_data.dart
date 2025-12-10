import '../models/client.dart';
import '../models/product.dart';

class MockData {
  static List<Client> clients = [
    Client(id: 1, name: "Mercado Silva", city: "Joinville", email: "silva@mercado.com"),
    Client(id: 2, name: "Padaria Doce Pão", city: "Araquari"),
    Client(id: 3, name: "Super Loanda", city: "São Francisco do Sul", phone: "47 99999-1111"),
  ];

  static List<Product> products = [
    Product(id: 1, name: "Rosquinha de Polvilho", price: 10.0),
    Product(id: 2, name: "Suspiro de Merengue", price: 8.0),
    Product(id: 3, name: "Bolinhas de Queijo", price: 12.0),
  ];
}
