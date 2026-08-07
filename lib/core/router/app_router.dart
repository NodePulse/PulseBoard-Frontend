import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signin/screen/signin_screen.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signup/screen/signup_screen.dart';
import 'package:pulseboard_frontend/features/splash_screen.dart';

final GoRouter appRouter = GoRouter(
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
  ],
);
