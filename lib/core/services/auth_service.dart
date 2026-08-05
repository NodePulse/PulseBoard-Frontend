import 'package:dio/dio.dart';
import 'package:pulseboard_frontend/core/network/api_client.dart';
import 'package:pulseboard_frontend/core/network/api_endpoints.dart';

class LoginResponseData {
  String accessToken;
  LoginUser user;

  LoginResponseData({required this.accessToken, required this.user});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      accessToken: json['accessToken'] as String,
      user: LoginUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class LoginUser {
  String id;
  String? tenantId;
  String email;
  String firstName;
  String lastName;
  String? avatarUrl;
  bool isEmailVerified;
  String? verificationToken;
  String? verificationOtp;
  String? verificationExpiresAt;
  String workspaceRole;
  String plan;
  bool isActive;
  String createdAt;
  String updatedAt;
  String? deletedAt;

  LoginUser({
    required this.id,
    this.tenantId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
    required this.isEmailVerified,
    this.verificationToken,
    this.verificationOtp,
    this.verificationExpiresAt,
    required this.workspaceRole,
    required this.plan,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      id: json['id'] as String,
      tenantId: json['tenantId'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool,
      verificationToken: json['verificationToken'] as String?,
      verificationOtp: json['verificationOtp'] as String?,
      verificationExpiresAt: json['verificationExpiresAt'] as String?,
      workspaceRole: json['workspaceRole'] as String,
      plan: json['plan'] as String,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      deletedAt: json['deletedAt'] as String?,
    );
  }
}

class LoginResponse {
  bool success;
  int statusCode;
  String message;
  LoginResponseData data;

  LoginResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: LoginResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class AuthService {
  Future<Response<LoginResponse>> login({
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response res = await ApiClient.post(
      ApiEndpoints.login,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return Response<LoginResponse>(
      requestOptions: res.requestOptions,
      data: LoginResponse.fromJson(res.data),
      headers: res.headers,
      isRedirect: res.isRedirect,
      statusCode: res.statusCode,
      statusMessage: res.statusMessage,
      redirects: res.redirects,
      extra: res.extra,
    );
  }
}
