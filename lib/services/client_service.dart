import '../models/client.dart';
import '../services/mock_data.dart';

class ClientService {
  static Client getById(int id) {
    return MockData.clients.firstWhere((c) => c.id == id);
  }
}
