import 'package:flutter/foundation.dart';
import 'package:pulseboard_frontend/core/storage/secure_storage_service.dart';
import 'package:pulseboard_frontend/datasources/auth_remote_datasource.dart';
import 'package:pulseboard_frontend/models/data/auth_request.dart';
import 'package:pulseboard_frontend/models/domain/user.dart';
import 'package:pulseboard_frontend/repositories/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._secureStorage);

  @override
  Future<User> register(
    String firstName,
    String lastName,
    String email,
    String password, {
    bool isWeb = false,
  }) async {
    final request = RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
    final response = await _remoteDataSource.register(request);

    if (!response.success) {
      throw Exception(response.message);
    }

    if (!kIsWeb) {
      await _secureStorage.saveToken(response.data.accessToken);
    }

    return response.data.user.toEntity();
  }

  @override
  Future<User> login(
    String email,
    String password, {
    bool isWeb = false,
  }) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _remoteDataSource.login(request);

    if (!response.success) {
      throw Exception(response.message);
    }

    if (!kIsWeb) {
      await _secureStorage.saveToken(response.data.accessToken);
    }

    return response.data.user.toEntity();
  }

  @override
  Future sendVerification(
    String email,
    VerificationType type,
    VerificationMethod method,
  ) async {
    final request = SendVerificationRequest(
      email: email,
      type: type,
      method: method,
    );
    final response = await _remoteDataSource.sendVerification(request);

    if (response['success'] != true) {
      throw response['message'] ?? 'An error occurred';
    }

    return response['message'];
  }

  @override
  Future verify(
    String email,
    String otp,
    VerificationType type,
    VerificationMethod method,
  ) async {
    final request = VerifyOtpRequest(
      email: email,
      otp: otp,
      type: type,
      method: method,
    );
    final response = await _remoteDataSource.verifyOtp(request);

    if (response['success'] != true) {
      throw response['message'] ?? 'An error occurred';
    }

    return response['message'];
  }

  @override
  Future resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    final request = ResetPasswordRequest(
      mode: 'forgot',
      email: email,
      code: code,
      newPassword: newPassword,
    );
    final response = await _remoteDataSource.resetPassword(request);

    if (response['success'] != true) {
      throw response['message'] ?? 'An error occurred';
    }

    return response['message'];
  }
}
