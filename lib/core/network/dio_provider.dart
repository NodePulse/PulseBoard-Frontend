import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/network/interceptors/auth_interceptor.dart';
import 'package:pulseboard_frontend/core/storage/secure_storage_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import "dart:developer" as developer;
import 'package:pulseboard_frontend/core/network/dio_io_adapter.dart'
    if (dart.library.html) 'package:pulseboard_frontend/core/network/dio_web_adapter.dart';

// CookieJar is only used on non-web platforms.
// On web, the browser manages cookies natively via its HTTP stack.
final cookieJarProvider = Provider<CookieJar?>((ref) {
  if (kIsWeb) return null;
  final cookieJar = CookieJar();
  developer.log("Cookie Jar: ${cookieJar.toString()}");
  return cookieJar;
});

final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: kIsWeb
          ? "http://localhost:5000/api"
          : defaultTargetPlatform == TargetPlatform.android
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

  setupDioAdapter(dio);

  // Only attach CookieManager on non-web platforms.
  // dio_cookie_manager asserts !kIsWeb and will crash on Chrome/web.
  if (!kIsWeb) {
    final cookieJar = ref.watch(cookieJarProvider);
    if (cookieJar != null) {
      dio.interceptors.add(CookieManager(cookieJar));
    }
  }

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
