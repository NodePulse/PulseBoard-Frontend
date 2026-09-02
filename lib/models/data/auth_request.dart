class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}

enum VerificationType {
  signup('signup'),
  forgotPassword('forgot_password');

  final String value;
  const VerificationType(this.value);
}

enum VerificationMethod {
  magic('magic'),
  otp('otp');

  final String value;
  const VerificationMethod(this.value);
}

class SendVerificationRequest {
  final String email;
  final VerificationType type;
  final VerificationMethod method;

  SendVerificationRequest({
    required this.email,
    required this.type,
    required this.method,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'type': type.value, 'method': method};
  }
}
