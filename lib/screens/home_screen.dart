import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../data/menu_data.dart';
import '../services/cart_service.dart';
import '../widgets/cart_drawer.dart';
import '../widgets/feature_card.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import '../widgets/premium_button.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _heroKey = GlobalKey();
  final _menuKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _contactKey = GlobalKey();

  String _selectedCategory = MenuData.categories.first;

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void _openCart() {
    final width = MediaQuery.of(context).size.width;
    if (AppBreakpoints.isMobile(width)) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen()));
    } else {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Cart',
        barrierColor: Colors.black38,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (_, __, ___) => Align(
          alignment: Alignment.centerRight,
          child: Material(
            child: SizedBox(
              width: 420,
              height: double.infinity,
              child: CartDrawer(
                onCheckout: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutScreen()));
                },
                onClose: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
        transitionBuilder: (_, anim, __, child) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(anim),
          child: child,
        ),
      );
    }
  }

  void _goToCheckout() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);
    final isTablet = AppBreakpoints.isTablet(width);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(
        onHomeTap: () => _scrollTo(_heroKey),
        onMenuTap: () => _scrollTo(_menuKey),
        onAboutTap: () => _scrollTo(_aboutKey),
        onContactTap: () => _scrollTo(_contactKey),
        onCartTap: _openCart,
        onOrderNowTap: () => _scrollTo(_menuKey),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _HeroSection(key: _heroKey, isMobile: isMobile, onOrderNow: () => _scrollTo(_menuKey), onViewMenu: () => _scrollTo(_menuKey)),
                _WhyChooseUsSection(isMobile: isMobile, isTablet: isTablet),
                _MenuSection(
                  key: _menuKey,
                  isMobile: isMobile,
                  isTablet: isTablet,
                  selectedCategory: _selectedCategory,
                  onCategoryChanged: (c) => setState(() => _selectedCategory = c),
                ),
                _AboutSection(key: _aboutKey, isMobile: isMobile),
                const _DeliveryAreaSection(),
                _ContactSection(key: _contactKey, isMobile: isMobile),
                AppFooter(
                  onHomeTap: () => _scrollTo(_heroKey),
                  onMenuTap: () => _scrollTo(_menuKey),
                  onAboutTap: () => _scrollTo(_aboutKey),
                  onContactTap: () => _scrollTo(_contactKey),
                ),
              ],
            ),
          ),
          if (isMobile)
            Positioned(
              right: 16,
              bottom: 20,
              child: PremiumButton(
                text: 'Order Now',
                icon: Icons.arrow_forward_rounded,
                height: 48,
                onPressed: () => _scrollTo(_menuKey),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------- HERO ----------------

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onOrderNow;
  final VoidCallback onViewMenu;

  const _HeroSection({super.key, required this.isMobile, required this.onOrderNow, required this.onViewMenu});

  @override
  Widget build(BuildContext context) {
    final content = [
      _HeroText(isMobile: isMobile, onOrderNow: onOrderNow, onViewMenu: onViewMenu),
      SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 32 : 0),
      const _HeroVisual(),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(isMobile ? 20 : 60, isMobile ? 120 : 160, isMobile ? 20 : 60, 60),
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Stack(
        children: [
          const Positioned(top: -60, left: -60, child: _Blob(size: 220, opacity: 0.35)),
          const Positioned(bottom: -80, right: -60, child: _Blob(size: 260, opacity: 0.3)),
          isMobile
              ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: content)
              : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(flex: 5, child: content[0]),
                  SizedBox(width: 40),
                  Expanded(flex: 5, child: content[2]),
                ]),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final double size;
  final double opacity;
  const _Blob({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withOpacity(opacity),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onOrderNow;
  final VoidCallback onViewMenu;
  const _HeroText({required this.isMobile, required this.onOrderNow, required this.onViewMenu});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.businessName,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile ? 34 : 52,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppConstants.tagline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(fontSize: isMobile ? 18 : 22, fontWeight: FontWeight.w600, color: AppColors.chocolate),
        ),
        const SizedBox(height: 14),
        Text(
          AppConstants.subTagline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(fontSize: 15, color: AppColors.mutedText, height: 1.6),
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 14,
          runSpacing: 14,
          children: [
            PremiumButton(text: 'Order Now', icon: Icons.arrow_forward_rounded, onPressed: onOrderNow),
            PremiumButton(text: 'View Menu', style: PremiumButtonStyle.secondary, onPressed: onViewMenu),
          ],
        ),
      ],
    );
  }
}

class _HeroVisual extends StatefulWidget {
  const _HeroVisual();

  @override
  State<_HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<_HeroVisual> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final dy = (_controller.value - 0.5) * 14;
        return Transform.translate(offset: Offset(0, dy), child: child);
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: 320,
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 460),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: AppColors.borderGlass, width: 1.5),
              boxShadow: [BoxShadow(color: AppColors.shadowSoft, blurRadius: 30, offset: const Offset(0, 16))],
            ),
            child: const Icon(Icons.ramen_dining_rounded, size: 110, color: AppColors.chocolate),
          ),
          Positioned(top: 10, left: -10, child: _FloatingInfoCard(emoji: '🔥', label: 'Freshly Prepared')),
          Positioned(bottom: 20, right: -10, child: _FloatingInfoCard(emoji: '🚚', label: 'Home Delivery')),
          Positioned(bottom: -18, left: 30, child: _FloatingInfoCard(emoji: '💳', label: 'bKash Payment')),
        ],
      ),
    );
  }
}

class _FloatingInfoCard extends StatelessWidget {
  final String emoji;
  final String label;
  const _FloatingInfoCard({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderGlass),
        boxShadow: [BoxShadow(color: AppColors.shadowSoft, blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.darkText)),
        ],
      ),
    );
  }
}

// ---------------- WHY CHOOSE US ----------------

class _WhyChooseUsSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  const _WhyChooseUsSection({required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final cards = const [
      FeatureCard(icon: Icons.eco_rounded, title: 'Fresh Ingredients', description: 'Prepared fresh with quality ingredients.'),
      FeatureCard(icon: Icons.favorite_rounded, title: 'Homemade Taste', description: 'Made with a comforting homemade-style taste.'),
      FeatureCard(icon: Icons.delivery_dining_rounded, title: 'Fast Delivery', description: 'Home delivery available across Sylhet Sadar.'),
      FeatureCard(icon: Icons.payments_rounded, title: 'Easy Payment', description: 'Convenient bKash payment option.'),
    ];
    final columns = isMobile ? 1 : (isTablet ? 2 : 4);

    return Container(
      width: double.infinity,
      color: AppColors.offWhite,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 70),
      child: Column(
        children: [
          Text('Why Choose Craving for Momo?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 40),
          GridView.count(
            crossAxisCount: columns,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: isMobile ? 2.4 : 1.05,
            children: cards,
          ),
        ],
      ),
    );
  }
}

// ---------------- MENU ----------------

class _MenuSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const _MenuSection({
    super.key,
    required this.isMobile,
    required this.isTablet,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final products = MenuData.byCategory(selectedCategory);
    final columns = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Our Menu', style: TextStyle(fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 6),
          const Text('Choose your favorite momo', style: TextStyle(fontSize: 14, color: AppColors.mutedText)),
          const SizedBox(height: 28),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: MenuData.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final cat = MenuData.categories[index];
                final selected = cat == selectedCategory;
                return GestureDetector(
                  onTap: () => onCategoryChanged(cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: selected ? AppColors.heroGradient : null,
                      color: selected ? null : AppColors.offWhite,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: selected ? Colors.transparent : AppColors.borderGlass),
                    ),
                    child: Text(cat,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: selected ? AppColors.chocolate : AppColors.mutedText)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          if (products.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text('More items in this category coming soon.', style: TextStyle(color: AppColors.mutedText)),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: isMobile ? 0.95 : 0.78,
              ),
              itemBuilder: (context, index) => ProductCard(product: products[index]),
            ),
        ],
      ),
    );
  }
}

// ---------------- ABOUT ----------------

class _AboutSection extends StatelessWidget {
  final bool isMobile;
  const _AboutSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final textCol = Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Made With Love, Served With Flavor',
              style: TextStyle(fontSize: isMobile ? 22 : 30, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 14),
          const Text(
            'Craving for Momo is a home-delivery momo business proudly serving customers across Sylhet Sadar. '
            'Every order is prepared fresh with care, bringing homemade comfort straight to your doorstep.',
            style: TextStyle(fontSize: 14.5, color: AppColors.mutedText, height: 1.7),
          ),
        ],
      ),
    );

    final imageCol = Expanded(
      flex: 4,
      child: Container(
        height: 220,
        margin: EdgeInsets.only(top: isMobile ? 24 : 0, left: isMobile ? 0 : 30),
        decoration: BoxDecoration(
          gradient: AppColors.heroGradient,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [BoxShadow(color: AppColors.shadowSoft, blurRadius: 24, offset: const Offset(0, 12))],
        ),
        child: const Center(child: Icon(Icons.restaurant_rounded, size: 60, color: AppColors.chocolate)),
      ),
    );

    return Container(
      width: double.infinity,
      color: AppColors.offWhite,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 70),
      child: isMobile
          ? Column(children: [textCol, imageCol])
          : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [textCol, imageCol]),
    );
  }
}

// ---------------- DELIVERY AREA ----------------

class _DeliveryAreaSection extends StatelessWidget {
  const _DeliveryAreaSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 60),
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Column(
        children: [
          const Icon(Icons.location_on_rounded, size: 34, color: AppColors.chocolate),
          const SizedBox(height: 10),
          Text('Home Delivery in ${AppConstants.deliveryArea}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 10),
          const Text(
            'We currently deliver across Sylhet Sadar. Delivery time and charges will be confirmed at checkout.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.mutedText),
          ),
          const SizedBox(height: 20),
          PremiumButton(text: 'Contact Us', icon: Icons.call_outlined, onPressed: () {}),
        ],
      ),
    );
  }
}

// ---------------- CONTACT ----------------

class _ContactSection extends StatelessWidget {
  final bool isMobile;
  const _ContactSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 70),
      child: Column(
        children: [
          Text('Get In Touch', style: TextStyle(fontSize: isMobile ? 22 : 28, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 30),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _ContactTile(icon: Icons.call_outlined, label: 'Phone', value: AppConstants.phoneNumber),
              _ContactTile(icon: Icons.payments_outlined, label: 'bKash', value: AppConstants.bkashNumber),
              _ContactTile(icon: Icons.facebook_rounded, label: 'Facebook', value: AppConstants.facebookUrl),
              _ContactTile(icon: Icons.camera_alt_outlined, label: 'Instagram', value: AppConstants.instagramUrl),
              _ContactTile(icon: Icons.home_outlined, label: 'Address', value: AppConstants.address),
              _ContactTile(icon: Icons.map_outlined, label: 'Delivery Area', value: AppConstants.deliveryArea),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderGlass),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.chocolate, size: 22),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.mutedText)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.darkText)),
        ],
      ),
    );
  }
}
