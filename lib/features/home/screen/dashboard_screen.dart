import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_provider.dart';
import 'package:pulseboard_frontend/features/home/screen/upgrade_plan_screen.dart';
import 'package:pulseboard_frontend/features/home/widget/join_organization_widget.dart';
import 'package:pulseboard_frontend/features/home/widget/plan_detailswidget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;
    final activeSubAsync = ref.watch(activeSubscriptionProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppScaffold(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Header
              Text(
                "Welcome back,",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                user?.firstName ?? "Explorer",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Plan Information Card
              PlanDetailswidget(
                theme: theme,
                isDark: isDark,
                activeSubAsync: activeSubAsync,
              ),

              const SizedBox(height: 24),

              // Join Team Card
              JoinOrganizationWidget(isDark: isDark, theme: theme),
            ],
          ),
        ),
      ),
    );
  }
}
