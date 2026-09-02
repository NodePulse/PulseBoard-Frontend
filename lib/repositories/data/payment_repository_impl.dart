import 'package:pulseboard_frontend/models/domain/payment.dart';
import 'package:pulseboard_frontend/repositories/domain/payment_repository.dart';
import 'package:pulseboard_frontend/datasources/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource _remoteDatasource;

  PaymentRepositoryImpl(this._remoteDatasource);

  @override
  Future<Payment> upgradePlan(String plan, String paymentMethod) async {
    final responseData = await _remoteDatasource.createPaymentOrder(
      plan: plan,
      paymentMethod: paymentMethod,
    );

    // Backend wraps response in { success, data: {...} }
    final data = responseData['data'] ?? responseData;

    return Payment(
      id: data['id'] ?? data.toString(),
      amount: data['amount'] is num
          ? (data['amount'] as num).toInt()
          : int.tryParse(data['amount']?.toString() ?? '0') ?? 0,
      currency: data['currency'] ?? 'INR',
      status: data['status'] ?? 'pending',
      paymentMethod: data['paymentMethod'] ?? paymentMethod,
      userId: data['user_id'] ?? '',
      razorpayOrderId: data['razorpayOrderId'] ?? data['order_id'],
      razorpayPaymentId: data['razorpay_payment_id'],
      razorpaySignature: data['razorpay_signature'],
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : DateTime.now(),
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'])
          : DateTime.now(),
    );
  }

  Future<Payment> completePaymentOrder(
    String orderId,
    String paymentId,
    String signature,
    String status,
  ) async {
    final responseData = await _remoteDatasource.completePaymentOrder(
      orderId: orderId,
      paymentId: paymentId,
      signature: signature,
      status: status,
    );

    // Backend wraps response in { success, data: {...} }
    final data = responseData['data'] ?? responseData;

    return Payment(
      id:
          data['id'] ??
          data['orderId'] ??
          data['razorpayOrderId'] ??
          data.toString(),
      userId: data['userId'] ?? '',
      amount: data['amount'] is num
          ? (data['amount'] as num).toInt()
          : int.tryParse(data['amount']?.toString() ?? '0') ?? 0,
      currency: data['currency'] ?? 'INR',
      status: data['status'] ?? 'pending',
      paymentMethod: data['paymentMethod'] ?? '',
      razorpayOrderId: data['razorpayOrderId'] ?? data['order_id'],
      razorpayPaymentId: data['razorpayPaymentId'] ?? data['razorpay_payment_id'],
      razorpaySignature: data['razorpaySignature'] ?? data['razorpay_signature'],
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : DateTime.now(),
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'])
          : DateTime.now(),
    );
  }

  Future<Map<String, dynamic>?> getActiveSubscription() async {
    final responseData = await _remoteDatasource.getActiveSubscription();
    if (responseData == null) return null;

    return responseData['data'] ?? responseData;
  }
}
