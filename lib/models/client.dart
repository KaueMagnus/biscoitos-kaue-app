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

  factory Client.fromMap(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'email': email,
      'phone': phone,
    };
  }
}
