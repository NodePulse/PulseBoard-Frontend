import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_provider.dart';
import 'package:pulseboard_frontend/features/home/screen/upgrade_plan_screen.dart';
import 'package:pulseboard_frontend/features/home/widget/join_organization_widget.dart';
import 'package:pulseboard_frontend/features/home/widget/plan_detailswidget.dart';
import 'package:pulseboard_frontend/features/home/widget/dashboard_header_widget.dart';
import 'package:pulseboard_frontend/features/home/widget/dashboard_analytics_widget.dart';

import 'package:pulseboard_frontend/core/network/dio_provider.dart';
import 'package:pulseboard_frontend/features/home/data/datasources/organization_remote_datasource.dart';
import 'package:pulseboard_frontend/features/home/data/repositories/organization_repository_impl.dart';

final currentOrganizationProvider =
    FutureProvider.autoDispose<Map<String, dynamic>?>((ref) async {
      final dio = ref.read(dioProvider);
      final remoteDatasource = OrganizationRemoteDatasource(dio);
      final repository = OrganizationRepositoryImpl(remoteDatasource);
      final x = await repository.getOrganization();
      debugPrint('current organization = $x');
      return x;
    });

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
    final currentOrgAsync = ref.watch(currentOrganizationProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppScaffold(
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 800;

              return Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // New Header
                  DashboardHeaderWidget(
                    user: user,
                    organization: currentOrgAsync.value,
                    theme: theme,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 32),

                  // Analytics Grid
                  DashboardAnalyticsWidget(theme: theme, isDark: isDark),
                  const SizedBox(height: 32),

                  // Existing Cards
                  if (isWideScreen)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PlanDetailswidget(
                            theme: theme,
                            isDark: isDark,
                            activeSubAsync: activeSubAsync,
                            organization: currentOrgAsync.value,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: JoinOrganizationWidget(
                            isDark: isDark,
                            theme: theme,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    PlanDetailswidget(
                      theme: theme,
                      isDark: isDark,
                      activeSubAsync: activeSubAsync,
                      organization: currentOrgAsync.value,
                    ),
                    const SizedBox(height: 24),
                    JoinOrganizationWidget(isDark: isDark, theme: theme),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
