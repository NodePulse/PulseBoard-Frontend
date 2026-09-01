import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/features/home/widget/create_organization_dialog.dart';
import 'package:pulseboard_frontend/core/widgets/app_toast.dart';

import 'package:pulseboard_frontend/core/network/dio_provider.dart';
import 'package:pulseboard_frontend/features/home/data/datasources/organization_remote_datasource.dart';
import 'package:pulseboard_frontend/features/home/data/repositories/organization_repository_impl.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_provider.dart';
import 'package:pulseboard_frontend/features/home/screen/upgrade_plan_screen.dart';

class PlanDetailswidget extends ConsumerStatefulWidget {
  final ThemeData theme;
  final bool isDark;
  final AsyncValue<Map<String, dynamic>?> activeSubAsync;
  final Map<String, dynamic>? organization;
  const PlanDetailswidget({
    super.key,
    required this.theme,
    required this.isDark,
    required this.activeSubAsync,
    required this.organization,
  });

  @override
  ConsumerState<PlanDetailswidget> createState() => _PlanDetailswidgetState();
}

class _PlanDetailswidgetState extends ConsumerState<PlanDetailswidget> {
  Future<void> _createOrganization(
    BuildContext dialogContext,
    String name,
    String slug,
  ) async {
    try {
      final authState = ref.read(authNotifierProvider);
      final userId = authState.user?.id;

      // if (userId == null) {
      //   if (mounted) {
      //     AppToast.showError(message: 'User not authenticated');
      //   }
      //   throw Exception('User not authenticated');
      // }

      final dio = ref.read(dioProvider);
      final remoteDatasource = OrganizationRemoteDatasource(dio);
      final repository = OrganizationRepositoryImpl(remoteDatasource);

      await repository.createOrganization(name, slug);
      if (mounted) {
        Navigator.pop(dialogContext);
      }
    } catch (e) {
      AppToast.showError(message: 'Failed to create organization: $e');
      if (mounted) {
        // Navigator.pop(dialogContext);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final isDark = widget.isDark;
    final activeSubAsync = widget.activeSubAsync;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: isDark ? 0.4 : 1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium_rounded,
              color: theme.colorScheme.primary,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          activeSubAsync.when(
            data: (activeSub) {
              final isActive =
                  activeSub != null && activeSub['status'] == 'ACTIVE';
              final planName = isActive ? activeSub['plan'] ?? 'FREE' : 'FREE';

              return Column(
                children: [
                  Text(
                    "${planName.toString().toUpperCase()} PLAN",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isActive
                        ? "You have an active plan. Create your organization to get started."
                        : "Unlock advanced features and unlimited collaboration.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  if (isActive)
                    AppButton(
                      title: "Create Organization",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) => CreateOrganizationDialog(
                            onSubmit: (name, slug) =>
                                _createOrganization(dialogContext, name, slug),
                          ),
                        );
                      },
                    )
                  else
                    AppButton(
                      title: "Upgrade Plan",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const UpgradePlanScreen(),
                        );
                      },
                    ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Text('Error loading plan: $e'),
          ),
        ],
      ),
    );
  }
}
