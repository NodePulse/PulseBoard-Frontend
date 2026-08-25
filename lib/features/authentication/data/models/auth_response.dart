import 'package:pulseboard_frontend/features/authentication/data/models/user_model.dart';

class LoginResponse {
  final bool success;
  final int statusCode;
  final String message;
  final LoginResponseData data;

  LoginResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] == true,
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message']?.toString() ?? '',
      data: LoginResponseData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class LoginResponseData {
  final String accessToken;
  final UserModel user;

  LoginResponseData({
    required this.accessToken,
    required this.user,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      accessToken: json['accessToken']?.toString() ?? '',
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }
}
