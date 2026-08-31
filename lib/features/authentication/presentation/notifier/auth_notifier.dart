import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/utils/api_error_handler.dart';
import 'package:pulseboard_frontend/core/utils/app_logger.dart';
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
      final errorMessage = ApiErrorHandler.getMessage(e);
      AppLogger.error(" Error here ================> $errorMessage");
      state = state.copyWith(isLoading: false, error: errorMessage);
    }
  }

  Future<void> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.register(firstName, lastName, email, password);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
      );
    } catch (e) {
      final errorMessage = ApiErrorHandler.getMessage(e);
      AppLogger.error(" Error here ================> $errorMessage");
      state = state.copyWith(isLoading: false, error: errorMessage);
    }
  }

  void logout() {
    // Optionally also call repository.logout() if it clears the token
    state = AuthState.initial();
  }
}
