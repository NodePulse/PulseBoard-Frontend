class ApiEndpoints {
  ApiEndpoints._();

  static const AuthEndpoints auth = AuthEndpoints();
  static const TenantsEndpoints tenants = TenantsEndpoints();

  static const String createPaymentOrder = '/payments/create-payment-order';
  static const String completePaymentOrder = '/payments/complete-payment-order';
  static const String activeSubscription = '/subscriptions/active';
}

class AuthEndpoints {
  const AuthEndpoints();
  final String login = '/auth/login';
  final String register = '/auth/register';
  final String logout = '/auth/logout';
  final String verify = '/auth/verify';
  final String sendVerification = '/auth/send-verification';
  final String resetPassword = '/auth/reset-password';
}

class TenantsEndpoints {
  const TenantsEndpoints();
  final String createOrganization = '/tenants/create-organization';
  final String getOrganization = '/tenants/current-organization';
}
