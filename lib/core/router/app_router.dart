import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:pulseboard_frontend/core/network/dio_io_adapter.dart'
    if (dart.library.html) 'package:pulseboard_frontend/core/network/dio_web_adapter.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signin/screen/signin_screen.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signup/screen/signup_screen.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signup/screen/verification_email_screen.dart';
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
    bool isAuthenticated = token != null && token.isNotEmpty;

    // In case of web, we don't save the token, we rely on HttpOnly cookies.
    // We ping the backend to see if a valid session cookie exists.
    if (kIsWeb) {
      try {
        final dio = Dio(BaseOptions(
          baseUrl: "http://localhost:5000/api",
        ));
        setupDioAdapter(dio);
        final response = await dio.get('/auth/me');
        if (response.statusCode == 200) {
          isAuthenticated = true;
        }
      } catch (e) {
        isAuthenticated = false;
      }
    }

    final isGoingToAuth = state.matchedLocation == AppRoutes.splash ||
        state.matchedLocation == AppRoutes.signin ||
        state.matchedLocation == AppRoutes.signup ||
        state.matchedLocation == AppRoutes.emailSent;

    // If there is no cookie saved in case of web (or no token), just send user to non authenticated screen
    if (!isAuthenticated && !isGoingToAuth) {
      return AppRoutes.signin;
    }

    // If authenticated and trying to access onboarding/auth screens, redirect to dashboard
    if (isAuthenticated && isGoingToAuth) {
      return AppRoutes.dashboard;
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
      path: AppRoutes.emailSent,
      builder: (context, state) => const VerificationEmailScreen(),
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
