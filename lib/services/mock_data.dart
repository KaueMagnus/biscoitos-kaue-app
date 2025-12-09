import '../models/client.dart';

class MockData {
  static List<Client> clients = [
    Client(id: 1, name: 'Supermercado Centro', city: 'Imbituba', email: 'contato@centro.com', phone: '48999990001'),
    Client(id: 2, name: 'Padaria Bom Pão', city: 'Garopaba', email: 'contato@bompao.com', phone: '48999990002'),
    Client(id: 3, name: 'Mercado Silva', city: 'Imbituba', email: null, phone: '48999990003'),
    Client(id: 4, name: 'Mercearia do Zé', city: 'Imbituba', email: 'ze@mercearia.com', phone: '48999990004'),
  ];
}
