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

  factory Client.fromMap(Map<String, dynamic> map) => Client(
    id: map['id'],
    name: map['name'],
    city: map['city'],
    email: map['email'],
    phone: map['phone'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'city': city,
    'email': email,
    'phone': phone,
  };
}
