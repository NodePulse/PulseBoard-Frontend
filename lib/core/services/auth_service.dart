import 'package:dio/dio.dart';
import 'package:pulseboard_frontend/core/network/api_client.dart';
import 'package:pulseboard_frontend/core/network/api_endpoints.dart';

class AuthService {
  Future<Response<T>> login<T>({
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await ApiClient.post(
      ApiEndpoints.login,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
