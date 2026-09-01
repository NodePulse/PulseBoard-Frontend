class ApiEndpoints {
  ApiEndpoints._();

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String createPaymentOrder = '/payments/create-payment-order';
  static const String completePaymentOrder = '/payments/complete-payment-order';
  static const String activeSubscription = '/subscriptions/active';
  static const Map<String, String> tenants = {
    'createOrganization': '/tenants/create-organization',
    'getOrganization': '/tenants/current-organization',
  };
}
