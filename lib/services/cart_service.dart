import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../core/constants/app_constants.dart';

/// Centralized cart state, exposed via Provider.
class CartService extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => _items.isEmpty;

  double get subtotal =>
      _items.values.fold(0.0, (sum, item) => sum + item.lineTotal);

  double get deliveryFee => isEmpty ? 0.0 : AppConstants.deliveryFeeTk;

  double get total => subtotal + deliveryFee;

  void addToCart(Product product, ProductOption option, {int quantity = 1}) {
    final key = '${product.id}_${option.label}';
    if (_items.containsKey(key)) {
      _items[key]!.quantity += quantity;
    } else {
      _items[key] = CartItem(product: product, option: option, quantity: quantity);
    }
    notifyListeners();
  }

  void increaseQuantity(String key) {
    if (_items.containsKey(key)) {
      _items[key]!.quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String key) {
    if (_items.containsKey(key)) {
      if (_items[key]!.quantity > 1) {
        _items[key]!.quantity--;
      } else {
        _items.remove(key);
      }
      notifyListeners();
    }
  }

  void removeItem(String key) {
    _items.remove(key);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
