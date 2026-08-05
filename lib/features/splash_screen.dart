import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppScaffold(
      padding: 32,
      child: Center(
        child: Column(
          spacing: 18,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "PulseBoard is now live in Beta",
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.8,
                        ),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "Manage your work at the Speed of Pulse.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 48,
                fontWeight: FontWeight.w600,
                height: 1.15,
              ),
            ),
            Text(
              "The real-time project management tool built for modern teams. Sync instantly, collaborate seamlessly, and ship faster than ever before.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
                height: 1.15,
              ),
            ),
            AppButton(
              onPressed: () {
                context.push(AppRoutes.signup);
              },
              textStyle: const TextStyle(color: Colors.white, fontSize: 20),
              title: "Get Started for Free",
              backgroundColor: AppColors.primary,
            ),
            AppButton(
              onPressed: () {
                context.push(AppRoutes.signin);
              },
              textStyle: TextStyle(
                color: isDark ? Colors.white : theme.colorScheme.primary,
                fontSize: 20,
              ),
              title: "Sign In",
              backgroundColor: Colors.transparent,
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.glassBorder
                    : theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
