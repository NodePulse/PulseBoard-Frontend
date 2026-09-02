import 'package:dio/dio.dart';
import 'package:pulseboard_frontend/core/network/api_endpoints.dart';
import 'package:pulseboard_frontend/models/data/auth_request.dart';
import 'package:pulseboard_frontend/models/data/auth_response.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      ApiEndpoints.auth.login,
      data: request.toJson(),
    );

    return LoginResponse.fromJson(response.data);
  }

  Future<LoginResponse> register(RegisterRequest request) async {
    final response = await _dio.post(
      ApiEndpoints.auth.register,
      data: request.toJson(),
    );

    return LoginResponse.fromJson(response.data);
  }

  Future sendVerification(request) async {
    final response = await _dio.post(
      ApiEndpoints.auth.sendVerification,
      data: request.toJson(),
    );

    return response.data;
  }
}
