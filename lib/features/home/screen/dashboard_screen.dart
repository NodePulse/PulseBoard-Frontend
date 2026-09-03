import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_provider.dart';
import 'package:pulseboard_frontend/features/home/screen/upgrade_plan_screen.dart';
import 'package:pulseboard_frontend/features/home/widget/join_organization_widget.dart';
import 'package:pulseboard_frontend/features/home/widget/plan_detailswidget.dart';
import 'package:pulseboard_frontend/features/home/widget/create_project_widget.dart';
import 'package:pulseboard_frontend/features/home/widget/join_project_widget.dart';
import 'package:pulseboard_frontend/features/home/widget/join_project_widget.dart';
import 'package:pulseboard_frontend/features/home/widget/dashboard_analytics_widget.dart';

import 'package:pulseboard_frontend/features/home/presentation/providers/organization_repository_provider.dart';

final currentOrganizationProvider =
    FutureProvider.autoDispose<Map<String, dynamic>?>((ref) async {
      final repository = ref.watch(organizationRepositoryProvider);
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = ref.read(authNotifierProvider);
      if (authState.user == null) {
        ref.read(authNotifierProvider.notifier).checkAuthStatus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;
    final activeSubAsync = ref.watch(activeSubscriptionProvider);
    final currentOrgAsync = ref.watch(currentOrganizationProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    debugPrint(
      'current organization = ${currentOrgAsync.value?['data']?['tenant']}',
    );

    return AppScaffold(
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 800;

              return Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Analytics Grid
                  DashboardAnalyticsWidget(theme: theme, isDark: isDark),
                  const SizedBox(height: 32),

                  // Existing Cards
                  if (currentOrgAsync.value?["data"]?["tenant"] == null)
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
                    ]
                  else
                    Builder(
                      builder: (context) {
                        final role = (currentOrgAsync.value?['data']?['role']?.toString() ??
                                user?.workspaceRole)
                            ?.toLowerCase() ??
                            'viewer';
                        final canCreateProject =
                            role == 'owner' || role == 'admin';
                        debugPrint('Role extracted: $role');

                        if (canCreateProject) {
                          return isWideScreen
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CreateProjectWidget(
                                        theme: theme,
                                        isDark: isDark,
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: JoinProjectWidget(
                                        isDark: isDark,
                                        theme: theme,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    CreateProjectWidget(
                                      theme: theme,
                                      isDark: isDark,
                                    ),
                                    const SizedBox(height: 24),
                                    JoinProjectWidget(
                                      isDark: isDark,
                                      theme: theme,
                                    ),
                                  ],
                                );
                        } else {
                          return JoinProjectWidget(
                            isDark: isDark,
                            theme: theme,
                          );
                        }
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
