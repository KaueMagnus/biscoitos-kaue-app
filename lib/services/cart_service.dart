import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  // Lista interna de itens
  static final List<CartItem> _items = [];

  // Getter de leitura
  static List<CartItem> get items => _items;

  // Adiciona item ao carrinho
  static void addItem(Product product, int qty) {
    final existing = _items.where((i) => i.product.id == product.id);

    if (existing.isNotEmpty) {
      existing.first.quantity += qty;
    } else {
      _items.add(CartItem(product: product, quantity: qty));
    }
  }

  // Limpa carrinho
  static void clear() {
    _items.clear();
  }

  // Total de itens (soma das quantidades)
  static int get totalItems {
    return _items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  // Total em dinheiro
  static double get total {
    return _items.fold<double>(0, (sum, item) => sum + item.subtotal);
  }
}
