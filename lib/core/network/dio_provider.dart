import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/network/interceptors/auth_interceptor.dart';
import 'package:pulseboard_frontend/core/storage/secure_storage_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

final cookieJarProvider = Provider<CookieJar>((ref) {
  return CookieJar();
});

final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final cookieJar = ref.watch(cookieJarProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: defaultTargetPlatform == TargetPlatform.android
          ? "http://10.0.2.2:5000/api"
          : "http://localhost:5000/api",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  );

  dio.interceptors.add(CookieManager(cookieJar));

  dio.interceptors.add(
    AuthInterceptor(
      tokenProvider: () async {
        return await secureStorage.getToken();
      },
    ),
  );

  // You can add LogInterceptor here for debugging if needed

  return dio;
});
