import 'dart:math';
import '../models/cart_item.dart';
import '../models/order.dart';

/// Handles order submission. Currently uses local/mock logic.
///
/// Future architecture:
///   Flutter Web -> REST API -> FastAPI Backend -> Database
///
/// Replace [submitOrder] internals with an ApiService POST call once a
/// backend exists (e.g. services/api_service.dart). Keep API logic out of
/// UI widgets — screens should only call this service.
class OrderService {
  Future<OrderInfo> submitOrder({
    required String customerName,
    required String phone,
    required String address,
    required String area,
    required String instructions,
    required String bkashTransactionId,
    required List<CartItem> items,
    required double subtotal,
    required double deliveryFee,
    required double total,
  }) async {
    // Simulated network delay — replace with real API call later.
    await Future.delayed(const Duration(milliseconds: 900));

    final orderId = 'CM${1000 + Random().nextInt(9000)}';

    return OrderInfo(
      orderId: orderId,
      customerName: customerName,
      phone: phone,
      address: address,
      area: area,
      instructions: instructions,
      bkashTransactionId: bkashTransactionId,
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      createdAt: DateTime.now(),
    );
  }
}
