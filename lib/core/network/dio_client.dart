import 'package:dio/dio.dart';
import 'package:pulseboard_frontend/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  DioClient._();

  static final Dio dioInstance =
      Dio(
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
        )
        ..interceptors.addAll([
          // LogInterceptor(
          //   requestUrl: true,
          //   requestBody: true,
          //   requestHeader: true,
          //   responseHeader: true,
          //   responseBody: true,
          // ),
          AuthInterceptor(
            tokenProvider: () async {
              return "token";
            },
          ),
        ]);
}
