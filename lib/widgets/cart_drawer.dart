import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../services/cart_service.dart';
import '../widgets/premium_button.dart';

/// Cart contents — used inside a Drawer on desktop and as a full screen
/// body on mobile (see screens/cart_screen.dart).
class CartDrawer extends StatelessWidget {
  final VoidCallback onCheckout;
  final VoidCallback? onClose;

  const CartDrawer({super.key, required this.onCheckout, this.onClose});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartService>();

    return Container(
      color: AppColors.offWhite,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  const Text('Your Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  if (onClose != null)
                    IconButton(icon: const Icon(Icons.close_rounded), onPressed: onClose),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: cart.isEmpty
                  ? const _EmptyCart()
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: cart.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.borderGlass),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  gradient: AppColors.heroGradient,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.ramen_dining_rounded, size: 22, color: AppColors.chocolate),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.product.name,
                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
                                    Text(item.option.label,
                                        style: const TextStyle(fontSize: 11.5, color: AppColors.mutedText)),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        _QtyButton(
                                          icon: Icons.remove_rounded,
                                          onTap: () => context.read<CartService>().decreaseQuantity(item.key),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text('${item.quantity}',
                                              style: const TextStyle(fontWeight: FontWeight.w600)),
                                        ),
                                        _QtyButton(
                                          icon: Icons.add_rounded,
                                          onTap: () => context.read<CartService>().increaseQuantity(item.key),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('৳${item.lineTotal.toStringAsFixed(0)}',
                                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.chocolate)),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.danger),
                                    onPressed: () => context.read<CartService>().removeItem(item.key),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            if (!cart.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(top: BorderSide(color: AppColors.borderGlass)),
                ),
                child: Column(
                  children: [
                    _summaryRow('Subtotal', cart.subtotal),
                    _summaryRow('Delivery Fee', cart.deliveryFee),
                    const Divider(height: 20),
                    _summaryRow('Total', cart.total, bold: true),
                    const SizedBox(height: 16),
                    PremiumButton(
                      text: 'Checkout',
                      icon: Icons.arrow_forward_rounded,
                      width: double.infinity,
                      onPressed: onCheckout,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: bold ? 15 : 13,
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
                  color: bold ? AppColors.darkText : AppColors.mutedText)),
          const Spacer(),
          Text('৳${value.toStringAsFixed(0)}',
              style: TextStyle(
                  fontSize: bold ? 16 : 13,
                  fontWeight: FontWeight.w700,
                  color: bold ? AppColors.chocolate : AppColors.darkText)),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: AppColors.offWhite,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderGlass),
        ),
        child: Icon(icon, size: 13, color: AppColors.darkText),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(gradient: AppColors.heroGradient, shape: BoxShape.circle),
            child: const Icon(Icons.shopping_bag_outlined, size: 30, color: AppColors.chocolate),
          ),
          const SizedBox(height: 16),
          const Text('Your cart is empty', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          const SizedBox(height: 6),
          const Text('Add some delicious momos to get started.',
              style: TextStyle(color: AppColors.mutedText, fontSize: 12.5)),
        ],
      ),
    );
  }
}
