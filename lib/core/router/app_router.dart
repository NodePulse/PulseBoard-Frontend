import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signin/screen/signin_screen.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signup/screen/signup_screen.dart';
import 'package:pulseboard_frontend/features/home/screen/home_screen.dart';
import 'package:pulseboard_frontend/features/home/screen/dashboard_screen.dart';
import 'package:pulseboard_frontend/features/home/screen/profile_screen.dart';
import 'package:pulseboard_frontend/features/home/screen/upgrade_plan_screen.dart';
import 'package:pulseboard_frontend/features/splash_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pulseboard_frontend/core/storage/secure_storage_service.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  redirect: (context, state) async {
    // Check if there is an auth token in storage
    final storageService = SecureStorageService(const FlutterSecureStorage());
    final token = await storageService.getToken();
    final bool isAuthenticated = token != null && token.isNotEmpty;

    // If authenticated and trying to access onboarding/auth screens, redirect to dashboard
    if (isAuthenticated) {
      if (state.matchedLocation == AppRoutes.splash ||
          state.matchedLocation == AppRoutes.signin ||
          state.matchedLocation == AppRoutes.signup) {
        return AppRoutes.dashboard;
      }
    }

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.signin,
      builder: (context, state) => const SigninScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.upgradePlan,
      builder: (context, state) => const UpgradePlanScreen(),
    ),
  ],
);
