import 'cart_item.dart';

class OrderInfo {
  final String orderId;
  final String customerName;
  final String phone;
  final String address;
  final String area;
  final String instructions;
  final String bkashTransactionId;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final DateTime createdAt;

  OrderInfo({
    required this.orderId,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.area,
    required this.instructions,
    required this.bkashTransactionId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.createdAt,
  });
}
