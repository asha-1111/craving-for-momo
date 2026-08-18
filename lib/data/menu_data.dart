import '../models/product.dart';

/// NOTE: No real menu image was provided to generate this data from.
/// Prices/sizes below use the sample pricing pattern given in the project
/// brief (e.g. Chicken Momo 6/12/18/25 pcs). REPLACE with your actual
/// menu image's real items, sizes and prices before publishing.
class MenuData {
  MenuData._();

  static const List<String> categories = [
    'Chicken Momo',
    'BBQ Momo',
    'Gravy Momo',
    'Naga Momo',
    'Egg Momo',
    'Frozen Momo',
    'Tandoori Momo',
    'Thai Soup Momo',
    'Caramel Pudding',
    'Chili Oil',
  ];

  static final List<Product> products = [
    const Product(
      id: 'chicken_momo',
      name: 'Chicken Momo',
      description: 'Steamed dumplings filled with juicy seasoned chicken.',
      category: 'Chicken Momo',
      image: 'assets/images/chicken_momo.jpg',
      options: [
        ProductOption(label: '6 Pieces', priceTk: 140),
        ProductOption(label: '12 Pieces', priceTk: 260),
        ProductOption(label: '18 Pieces', priceTk: 390),
        ProductOption(label: '25 Pieces', priceTk: 560),
      ],
    ),
    const Product(
      id: 'bbq_momo',
      name: 'BBQ Momo',
      description: 'Momo tossed in a smoky, tangy BBQ glaze.',
      category: 'BBQ Momo',
      image: 'assets/images/bbq_momo.jpg',
      options: [
        ProductOption(label: '6 Pieces', priceTk: 160),
        ProductOption(label: '12 Pieces', priceTk: 300),
      ],
    ),
    const Product(
      id: 'gravy_momo',
      name: 'Gravy Momo',
      description: 'Momo simmered in a rich, spiced gravy sauce.',
      category: 'Gravy Momo',
      image: 'assets/images/gravy_momo.jpg',
      options: [
        ProductOption(label: '6 Pieces', priceTk: 170),
        ProductOption(label: '12 Pieces', priceTk: 320),
      ],
    ),
    const Product(
      id: 'naga_momo',
      name: 'Naga Momo',
      description: 'Fiery momo coated in a bold naga chili sauce.',
      category: 'Naga Momo',
      image: 'assets/images/naga_momo.jpg',
      options: [
        ProductOption(label: '6 Pieces', priceTk: 170),
        ProductOption(label: '12 Pieces', priceTk: 320),
      ],
    ),
    const Product(
      id: 'egg_momo',
      name: 'Egg Momo',
      description: 'Momo filled with a soft, savory egg mixture.',
      category: 'Egg Momo',
      image: 'assets/images/egg_momo.jpg',
      options: [
        ProductOption(label: '6 Pieces', priceTk: 130),
        ProductOption(label: '12 Pieces', priceTk: 240),
      ],
    ),
    const Product(
      id: 'frozen_momo',
      name: 'Frozen Momo',
      description: 'Uncooked momo, frozen and ready to steam at home.',
      category: 'Frozen Momo',
      image: 'assets/images/frozen_momo.jpg',
      options: [
        ProductOption(label: '12 Pieces', priceTk: 220),
        ProductOption(label: '25 Pieces', priceTk: 420),
      ],
    ),
    const Product(
      id: 'tandoori_momo',
      name: 'Tandoori Momo',
      description: 'Char-grilled momo finished with tandoori spice.',
      category: 'Tandoori Momo',
      image: 'assets/images/tandoori_momo.jpg',
      options: [
        ProductOption(label: '6 Pieces', priceTk: 180),
        ProductOption(label: '12 Pieces', priceTk: 340),
      ],
    ),
    const Product(
      id: 'thai_soup_momo',
      name: 'Thai Soup Momo',
      description: 'Momo served in a fragrant, tangy Thai-style soup.',
      category: 'Thai Soup Momo',
      image: 'assets/images/thai_soup_momo.jpg',
      options: [
        ProductOption(label: 'Regular Bowl', priceTk: 190),
        ProductOption(label: 'Large Bowl', priceTk: 260),
      ],
    ),
    const Product(
      id: 'caramel_pudding',
      name: 'Caramel Pudding',
      description: 'Silky homemade caramel pudding for dessert.',
      category: 'Caramel Pudding',
      image: 'assets/images/caramel_pudding.jpg',
      options: [
        ProductOption(label: 'Single Cup', priceTk: 90),
      ],
    ),
    const Product(
      id: 'chili_oil',
      name: 'Chili Oil',
      description: 'House-made chili oil — the perfect momo companion.',
      category: 'Chili Oil',
      image: 'assets/images/chili_oil.jpg',
      options: [
        ProductOption(label: 'Small Bottle', priceTk: 60),
      ],
    ),
  ];

  static List<Product> byCategory(String category) =>
      products.where((p) => p.category == category).toList();
}
