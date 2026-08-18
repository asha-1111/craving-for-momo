/// A single purchasable size/quantity option for a product.
/// e.g. "6 Pieces" -> 140 Tk
class ProductOption {
  final String label; // e.g. "6 Pieces"
  final double priceTk;

  const ProductOption({required this.label, required this.priceTk});
}

class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final String image; // asset path, replaceable
  final List<ProductOption> options;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.options,
  });

  double get startingPrice =>
      options.map((o) => o.priceTk).reduce((a, b) => a < b ? a : b);
}
