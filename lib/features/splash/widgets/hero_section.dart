import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';

import 'fade_in_widget.dart';

class HeroSection extends StatelessWidget {
  final bool isLargeScreen;
  final bool isDark;

  const HeroSection({super.key, required this.isLargeScreen, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeInWidget(
          delay: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.rocket_launch,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'PulseBoard is now live in Beta — join early access',
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.9)
                        : AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        FadeInWidget(
          delay: const Duration(milliseconds: 200),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: isDark
                  ? [Colors.white, Colors.white.withValues(alpha: 0.7)]
                  : [AppColors.surface, AppColors.grey500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Manage your work at\nthe Speed of Pulse.',
              textAlign: TextAlign.center,
              style: theme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.1,
                letterSpacing: -1.5,
                fontSize: isLargeScreen ? 76 : 42,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        FadeInWidget(
          delay: const Duration(milliseconds: 300),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              'One workspace for boards, docs, and real-time chat — PulseBoard replaces the '
              'Jira-plus-Slack juggle with a single multi-tenant platform that keeps every '
              'update, comment, and status change in sync the instant it happens.',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.6)
                    : AppColors.grey500,
                height: 1.5,
                fontWeight: FontWeight.w400,
                fontSize: isLargeScreen ? 19 : 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        FadeInWidget(
          delay: const Duration(milliseconds: 400),
          child: Flex(
            direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                onPressed: () => context.go(AppRoutes.signup),
                title: 'Start for Free',
                backgroundColor: AppColors.primary,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                width: isLargeScreen ? 200 : double.infinity,
              ),
              SizedBox(
                height: isLargeScreen ? 0 : 16,
                width: isLargeScreen ? 16 : 0,
              ),
              AppButton(
                onPressed: () => context.go(AppRoutes.signin),
                title: 'Sign In',
                backgroundColor: Colors.transparent,
                borderSide: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.2)
                      : AppColors.grey300,
                  width: 1.5,
                ),
                textStyle: TextStyle(
                  color: isDark ? Colors.white : AppColors.surface,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                width: isLargeScreen ? 200 : double.infinity,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FadeInWidget(
          delay: const Duration(milliseconds: 450),
          child: Text(
            'No credit card required · Free forever for up to 3 users',
            style: TextStyle(
              color: isDark ? Colors.white38 : AppColors.grey400,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 56),
      ],
    );
  }
}

