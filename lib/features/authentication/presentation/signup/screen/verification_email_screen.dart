import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class VerificationEmailScreen extends StatelessWidget {
  const VerificationEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: ZoSegmentBorder(
                      segmentLength: 0.2,
                      glowOpacity: 1.0,
                      glowRadius: 10,
                      colors: const [
                        Colors.transparent,
                        Colors.cyanAccent,
                        Colors.cyanAccent,
                        Colors.transparent,
                      ],
                      borderRadius: 20,
                      child: Card(
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Icon(
                                Icons.mark_email_unread_outlined,
                                size: 64,
                                color: AppColors.primary,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "Check Your Email",
                                textAlign: TextAlign.center,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Just check your email to verify your email or account.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.7),
                                      height: 1.5,
                                    ),
                              ),
                              const SizedBox(height: 32),
                              AppButton(
                                title: "Go to Sign In",
                                backgroundColor: AppColors.primary,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  context.go(AppRoutes.signin);
                                },
                                width: double.infinity,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
