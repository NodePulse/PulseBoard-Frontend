class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isEmailVerified;
  final String? avatarUrl;
  final String plan;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  // String? tenantId;
  // String? verificationToken;
  // String? verificationOtp;
  // String? verificationExpiresAt;
  // String workspaceRole;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isEmailVerified,
    this.avatarUrl,
    required this.plan,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? isEmailVerified,
    String? avatarUrl,
    String? plan,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      plan: plan ?? this.plan,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
