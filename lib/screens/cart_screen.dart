import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/cart_drawer.dart';
import 'checkout_screen.dart';

/// Dedicated full-screen cart used on mobile (see section 11 of the brief).
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        leading: const BackButton(color: AppColors.darkText),
        title: const Text('Your Cart', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.w700)),
      ),
      body: CartDrawer(
        onCheckout: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutScreen()));
        },
      ),
    );
  }
}
