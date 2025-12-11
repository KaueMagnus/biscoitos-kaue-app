import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  static final List<CartItem> items = [];

  static void addItem(Product product, int qty) {
    // Caso o item já exista, soma a quantidade
    final existing = items.where((i) => i.product.id == product.id);

    if (existing.isNotEmpty) {
      existing.first.quantity += qty;
    } else {
      items.add(CartItem(product: product, quantity: qty));
    }
  }

  static void clear() {
    items.clear();
  }

  static double get total {
    return items.fold(0, (sum, item) => sum + item.subtotal);
  }
}
