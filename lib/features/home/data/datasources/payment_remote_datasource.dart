import 'package:dio/dio.dart';
import 'package:pulseboard_frontend/core/network/api_endpoints.dart';

class PaymentRemoteDatasource {
  final Dio _dio;

  PaymentRemoteDatasource(this._dio);

  Future<Map<String, dynamic>> createPaymentOrder({
    required String plan,
    required String paymentMethod,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.createPaymentOrder,
      data: {'plan': plan, 'paymentMethod': paymentMethod},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> completePaymentOrder({
    required String orderId,
    required String paymentId,
    required String signature,
    required String status,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.completePaymentOrder,
      data: {
        'orderId': orderId,
        'paymentId': paymentId,
        'razorpaySignature': signature,
        'method': 'RAZORPAY',
        'status': status,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>?> getActiveSubscription() async {
    try {
      final response = await _dio.get(ApiEndpoints.activeSubscription);
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
