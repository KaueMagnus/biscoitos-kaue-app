class Product {
  final int id;        // id interno do app (vamos usar o código da tabela)
  final int code;      // código do catálogo (01, 02, 03...)
  final String name;   // nome do produto
  final String category;
  final int weightG;   // peso em gramas
  final double price;  // por enquanto 0.0
  final bool active;   // se aparece ou não no app
  final int priority;  // menor = aparece primeiro

  const Product({
    required this.id,
    required this.code,
    required this.name,
    required this.category,
    required this.weightG,
    required this.price,
    this.active = true,
    this.priority = 999,
  });

  String get displayName => "$name ${weightG}g";
}
