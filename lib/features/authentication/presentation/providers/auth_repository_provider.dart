import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/network/dio_provider.dart';
import 'package:pulseboard_frontend/core/storage/secure_storage_provider.dart';
import 'package:pulseboard_frontend/datasources/auth_remote_datasource.dart';
import 'package:pulseboard_frontend/repositories/data/auth_repository_impl.dart';
import 'package:pulseboard_frontend/repositories/domain/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  final remoteDataSource = AuthRemoteDataSource(dio);
  return AuthRepositoryImpl(remoteDataSource, secureStorage);
});
