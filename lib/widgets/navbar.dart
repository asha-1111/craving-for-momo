import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../services/cart_service.dart';
import 'premium_button.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onMenuTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;
  final VoidCallback onCartTap;
  final VoidCallback onOrderNowTap;

  const NavBar({
    super.key,
    required this.onHomeTap,
    required this.onMenuTap,
    required this.onAboutTap,
    required this.onContactTap,
    required this.onCartTap,
    required this.onOrderNowTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(84);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);
    final cart = context.watch<CartService>();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 40,
          vertical: 14,
        ),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.55),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.borderGlass, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowSoft,
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onHomeTap,
                child: Text(
                  'CRAVING FOR MOMO',
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: AppColors.darkText,
                  ),
                ),
              ),
              const Spacer(),
              if (!isMobile) ...[
                _NavItem(label: 'Home', onTap: onHomeTap),
                _NavItem(label: 'Menu', onTap: onMenuTap),
                _NavItem(label: 'About', onTap: onAboutTap),
                _NavItem(label: 'Contact', onTap: onContactTap),
                const SizedBox(width: 12),
                _CartIcon(count: cart.itemCount, onTap: onCartTap),
                const SizedBox(width: 14),
                PremiumButton(
                  text: 'Order Now',
                  icon: Icons.arrow_forward_rounded,
                  height: 44,
                  onPressed: onOrderNowTap,
                ),
              ] else ...[
                _CartIcon(count: cart.itemCount, onTap: onCartTap),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  color: AppColors.darkText,
                  onPressed: () => _showMobileMenu(context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MobileMenuTile(label: 'Home', icon: Icons.home_rounded, onTap: () { Navigator.pop(context); onHomeTap(); }),
              _MobileMenuTile(label: 'Menu', icon: Icons.restaurant_menu_rounded, onTap: () { Navigator.pop(context); onMenuTap(); }),
              _MobileMenuTile(label: 'About', icon: Icons.info_outline_rounded, onTap: () { Navigator.pop(context); onAboutTap(); }),
              _MobileMenuTile(label: 'Contact', icon: Icons.call_outlined, onTap: () { Navigator.pop(context); onContactTap(); }),
              const SizedBox(height: 12),
              PremiumButton(
                text: 'Order Now',
                icon: Icons.arrow_forward_rounded,
                width: double.infinity,
                onPressed: () { Navigator.pop(context); onOrderNowTap(); },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _hovering ? AppColors.chocolate : AppColors.darkText,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _CartIcon extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _CartIcon({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderGlass),
            ),
            child: const Icon(Icons.shopping_bag_outlined, size: 19, color: AppColors.darkText),
          ),
          if (count > 0)
            Positioned(
              right: -2,
              top: -2,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.chocolate,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  '$count',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.white, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MobileMenuTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _MobileMenuTile({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.chocolate),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}
