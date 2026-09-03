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

  Future sendVerification(SendVerificationRequest request) async {
    final response = await _dio.post(
      ApiEndpoints.auth.sendVerification,
      data: request.toJson(),
    );

    return response.data;
  }

  Future verifyOtp(VerifyOtpRequest request) async {
    final response = await _dio.post(
      ApiEndpoints.auth.verify,
      data: request.toJson(),
    );

    return response.data;
  }

  Future resetPassword(ResetPasswordRequest request) async {
    final response = await _dio.post(
      ApiEndpoints.auth.resetPassword,
      data: request.toJson(),
    );

    return response.data;
  }
}
