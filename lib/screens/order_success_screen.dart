import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../models/order.dart';
import '../widgets/premium_button.dart';
import 'home_screen.dart';

class OrderSuccessScreen extends StatefulWidget {
  final OrderInfo order;
  const OrderSuccessScreen({super.key, required this.order});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scale,
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(gradient: AppColors.heroGradient, shape: BoxShape.circle),
                    child: const Icon(Icons.check_rounded, size: 48, color: AppColors.chocolate),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Order Placed Successfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.darkText)),
                const SizedBox(height: 10),
                Text('Thank you for ordering from ${AppConstants.businessName}.',
                    textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: AppColors.mutedText)),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.borderGlass)),
                  child: Text('Order #${widget.order.orderId}',
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.chocolate)),
                ),
                const SizedBox(height: 18),
                const Text('Your order has been received.\nWe will contact you if needed.',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: AppColors.mutedText, height: 1.6)),
                const SizedBox(height: 30),
                PremiumButton(
                  text: 'Back to Home',
                  icon: Icons.home_rounded,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
