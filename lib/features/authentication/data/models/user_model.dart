import 'package:pulseboard_frontend/features/authentication/domain/entities/user.dart';

class UserModel {
  final String id;
  final String? tenantId;
  final String email;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final bool isEmailVerified;
  final String? verificationToken;
  final String? verificationOtp;
  final String? verificationExpiresAt;
  final String workspaceRole;
  final String plan;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      tenantId: json['tenantId']?.toString(),
      email: json['email']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      avatarUrl: json['avatarUrl']?.toString(),
      isEmailVerified: json['isEmailVerified'] == true,
      verificationToken: json['verificationToken']?.toString(),
      verificationOtp: json['verificationOtp']?.toString(),
      verificationExpiresAt: json['verificationExpiresAt']?.toString(),
      workspaceRole: json['workspaceRole']?.toString() ?? '',
      plan: json['plan']?.toString() ?? '',
      isActive: json['isActive'] == true,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      deletedAt: json['deletedAt']?.toString(),
    );
  }

  User toEntity() {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      isEmailVerified: isEmailVerified,
      avatarUrl: avatarUrl,
      plan: plan,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}
