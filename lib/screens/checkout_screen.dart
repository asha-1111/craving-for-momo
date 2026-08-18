import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../services/cart_service.dart';
import '../services/order_service.dart';
import '../widgets/premium_button.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _areaController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _transactionIdController = TextEditingController();

  final _orderService = OrderService();
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _areaController.dispose();
    _instructionsController.dispose();
    _transactionIdController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder(CartService cart) async {
    if (!_formKey.currentState!.validate()) return;
    if (cart.isEmpty) return;

    setState(() => _submitting = true);

    final order = await _orderService.submitOrder(
      customerName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      area: _areaController.text.trim(),
      instructions: _instructionsController.text.trim(),
      bkashTransactionId: _transactionIdController.text.trim(),
      items: cart.items,
      subtotal: cart.subtotal,
      deliveryFee: cart.deliveryFee,
      total: cart.total,
    );

    if (!mounted) return;
    cart.clear();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => OrderSuccessScreen(order: order)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartService>();
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        leading: const BackButton(color: AppColors.darkText),
        title: const Text('Checkout', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.w700)),
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty.', style: TextStyle(color: AppColors.mutedText)))
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 24),
              child: Form(
                key: _formKey,
                child: isMobile
                    ? Column(children: [_formCard(), const SizedBox(height: 20), _summaryCard(cart)])
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 6, child: _formCard()),
                          const SizedBox(width: 24),
                          Expanded(flex: 4, child: _summaryCard(cart)),
                        ],
                      ),
              ),
            ),
    );
  }

  Widget _formCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderGlass),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Delivery Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 18),
          _field(_nameController, 'Customer Name', required: true),
          _field(_phoneController, 'Phone Number', required: true, keyboardType: TextInputType.phone),
          _field(_addressController, 'Delivery Address', required: true, maxLines: 2),
          _field(_areaController, 'Area', required: false),
          _field(_instructionsController, 'Additional Instructions', required: false, maxLines: 2),
          const SizedBox(height: 12),
          const Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          _bkashBox(),
        ],
      ),
    );
  }

  Widget _bkashBox() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.circle, size: 10, color: AppColors.chocolate),
              SizedBox(width: 8),
              Text('bKash', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.chocolate)),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Send payment to:', style: TextStyle(fontSize: 12.5, color: AppColors.darkText)),
          const SizedBox(height: 2),
          Text(AppConstants.bkashNumber,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 14),
          _field(_transactionIdController, 'bKash Transaction ID', required: true, filled: true),
          const SizedBox(height: 6),
          const Text(
            'Please complete the bKash payment and enter your transaction ID.',
            style: TextStyle(fontSize: 12, color: AppColors.darkText),
          ),
          const SizedBox(height: 6),
          const Text(
            'Payment will be verified before order processing.',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.chocolate),
          ),
        ],
      ),
    );
  }

  Widget _field(TextEditingController controller, String label,
      {bool required = true, int maxLines = 1, TextInputType? keyboardType, bool filled = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          filled: true,
          fillColor: filled ? AppColors.white.withOpacity(0.7) : AppColors.offWhite,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        validator: required
            ? (value) => (value == null || value.trim().isEmpty) ? 'This field is required' : null
            : null,
      ),
    );
  }

  Widget _summaryCard(CartService cart) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderGlass),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ...cart.items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                        child: Text('${item.product.name} — ${item.option.label} x${item.quantity}',
                            style: const TextStyle(fontSize: 13))),
                    Text('৳${item.lineTotal.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              )),
          const Divider(height: 24),
          _row('Subtotal', cart.subtotal),
          _row('Delivery Fee', cart.deliveryFee),
          const Divider(height: 24),
          _row('Total', cart.total, bold: true),
          const SizedBox(height: 20),
          PremiumButton(
            text: _submitting ? 'Placing Order...' : 'Place Order',
            icon: Icons.check_rounded,
            width: double.infinity,
            onPressed: _submitting ? () {} : () => _placeOrder(cart),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: bold ? 15 : 13, fontWeight: bold ? FontWeight.w700 : FontWeight.w400)),
          const Spacer(),
          Text('৳${value.toStringAsFixed(0)}',
              style: TextStyle(fontSize: bold ? 16 : 13, fontWeight: FontWeight.w700, color: AppColors.chocolate)),
        ],
      ),
    );
  }
}
