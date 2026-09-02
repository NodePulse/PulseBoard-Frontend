import 'package:pulseboard_frontend/models/domain/payment.dart';

abstract class PaymentRepository {
  Future<Payment> upgradePlan(String plan, String paymentMethod);
  
  Future<Payment> completePaymentOrder(
    String orderId,
    String paymentId,
    String signature,
    String status,
  );
  
  Future<Map<String, dynamic>?> getActiveSubscription();
}
