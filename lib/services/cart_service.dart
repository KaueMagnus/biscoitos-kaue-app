import 'package:biscoitos_kaue_app/models/cart_item.dart';
import 'package:biscoitos_kaue_app/models/product.dart';

class CartService {
  static final List<CartItem> _items = [];

  // Acesso externo somente leitura
  static List<CartItem> get items => List.unmodifiable(_items);

  // Total de itens para badge
  static int get totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  // Total em dinheiro
  static double get total =>
      _items.fold(0, (sum, item) => sum + item.subtotal);

  // Adicionar item ao carrinho
  static void addItem(Product product, int qty) {
    final existing =
    _items.indexWhere((item) => item.product.id == product.id);

    if (existing != -1) {
      _items[existing].quantity += qty;
    } else {
      _items.add(CartItem(
        product: product,
        quantity: qty,
      ));
    }
  }

  // 🔥 Atualizar quantidade de um item
  static void updateQuantity(int productId, int newQuantity) {
    final index =
    _items.indexWhere((item) => item.product.id == productId);

    if (index != -1) {
      _items[index].quantity = newQuantity;
    }
  }

  // 🔥 Remover item
  static void removeItem(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  // Limpar carrinho
  static void clear() {
    _items.clear();
  }
}
