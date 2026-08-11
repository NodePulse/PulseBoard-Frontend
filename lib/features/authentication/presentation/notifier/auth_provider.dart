import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_notifier.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_state.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

// A provider that injects the repository into the notifier
// Using a separate provider or modifying the NotifierProvider to watch the repository.
// In Riverpod 2.0 with Notifier, we can access ref inside the build method.
