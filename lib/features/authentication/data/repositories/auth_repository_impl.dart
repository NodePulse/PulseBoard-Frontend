import 'package:flutter/foundation.dart';
import 'package:pulseboard_frontend/core/storage/secure_storage_service.dart';
import 'package:pulseboard_frontend/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:pulseboard_frontend/features/authentication/data/models/auth_request.dart';
import 'package:pulseboard_frontend/features/authentication/domain/entities/user.dart';
import 'package:pulseboard_frontend/features/authentication/domain/repositories/auth_repository.dart';

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
}
