import 'package:dio/dio.dart';
import 'package:pulseboard_frontend/core/network/api_endpoints.dart';
import 'package:pulseboard_frontend/features/authentication/data/models/login_request.dart';
import 'package:pulseboard_frontend/features/authentication/data/models/login_response.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );

    return LoginResponse.fromJson(response.data);
  }
}
