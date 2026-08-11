import 'package:pulseboard_frontend/features/home/domain/entities/payment.dart';

abstract class PaymentRepository {
  Future<Payment> upgradePlan(String plan, String paymentMethod);
}
