class Client {
  final int id;
  final String name;
  final String city;
  final String? email;
  final String? phone;

  Client({
    required this.id,
    required this.name,
    required this.city,
    this.email,
    this.phone,
  });

  factory Client.fromMap(Map<String, dynamic> m) => Client(
    id: m['id'],
    name: m['name'] ?? '',
    city: m['city'] ?? '',
    email: m['email'],
    phone: m['phone'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'city': city,
    'email': email,
    'phone': phone,
  };
}
