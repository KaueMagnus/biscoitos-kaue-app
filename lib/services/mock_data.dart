import '../models/client.dart';

class MockData {
  static List<Client> clients = [
    Client(id: 1, name: "Mercado Silva", city: "Joinville", email: "silva@mercado.com"),
    Client(id: 2, name: "Padaria Doce Pão", city: "Araquari"),
    Client(id: 3, name: "Super Loanda", city: "São Francisco do Sul", phone: "47 99999-1111"),
  ];
}
