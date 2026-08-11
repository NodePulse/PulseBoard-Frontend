import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/providers/auth_repository_provider.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_state.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.login(email, password);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void logout() {
    // Optionally also call repository.logout() if it clears the token
    state = AuthState.initial();
  }
}

