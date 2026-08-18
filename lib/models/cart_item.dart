import 'product.dart';

class CartItem {
  final Product product;
  final ProductOption option;
  int quantity;

  CartItem({
    required this.product,
    required this.option,
    this.quantity = 1,
  });

  /// Unique key per product+option so different sizes are separate cart lines.
  String get key => '${product.id}_${option.label}';

  double get lineTotal => option.priceTk * quantity;
}
