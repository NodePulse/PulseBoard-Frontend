import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';

import 'fade_in_widget.dart';

class FeaturesSection extends StatelessWidget {
  final bool isLargeScreen;
  final bool isTablet;
  final bool isDark;

  const FeaturesSection({super.key, 
    required this.isLargeScreen,
    required this.isTablet,
    required this.isDark,
  });

  static const _features = [
    (
      Icons.bolt_outlined,
      'Real-Time Sync',
      'Board changes, comments, and status updates propagate over WebSockets in '
          'under 150ms — no refresh, no polling, no stale state.',
    ),
    (
      Icons.forum_outlined,
      'Built-In Team Chat',
      'Every board and card has a threaded discussion channel, so context never '
          'lives in a separate Slack tab your team forgets to check.',
    ),
    (
      Icons.query_stats_outlined,
      'Automated Insights',
      'Burndown charts, cycle time, and workload heatmaps are generated '
          'automatically from your existing board activity — no manual reports.',
    ),
    (
      Icons.apartment_outlined,
      'True Multi-Tenancy',
      'Each workspace is fully isolated at the data layer, so agencies and '
          'enterprises can safely host dozens of client organizations on one plan.',
    ),
    (
      Icons.hub_outlined,
      'Open API & Webhooks',
      'A documented REST and GraphQL API plus outbound webhooks let you wire '
          'PulseBoard into CI pipelines, CRMs, or internal tools in minutes.',
    ),
    (
      Icons.security_outlined,
      'Enterprise-Grade Security',
      'SSO via SAML/OIDC, granular role-based permissions, and full audit logs '
          'keep security and compliance teams satisfied.',
    ),
  ];

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    final theme = Theme.of(context);
    return Semantics(
      label: '$title. $description',
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: isDark
              ? theme.colorScheme.surface.withValues(alpha: 0.4)
              : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : AppColors.grey300.withValues(alpha: 0.5),
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: AppColors.grey400.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 30),
            ),
            const SizedBox(height: 22),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 19,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                color: isDark ? Colors.white60 : AppColors.grey500,
                height: 1.55,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int get _columns => isLargeScreen ? 3 : (isTablet ? 2 : 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 64 : 20,
        vertical: 56,
      ),
      child: Column(
        children: [
          FadeInWidget(
            delay: const Duration(milliseconds: 500),
            child: Column(
              children: [
                Text(
                  'Everything you need to ship faster',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(
                    'A single, opinionated platform for planning, communicating, and reporting on work — '
                    'built so your team never has to leave the board.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? Colors.white60 : AppColors.grey500,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 44),
          FadeInWidget(
            delay: const Duration(milliseconds: 600),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: _columns,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: isLargeScreen ? 1.15 : (isTablet ? 1.3 : 1.5),
              children: _features
                  .map((f) => _buildFeatureCard(context, f.$1, f.$2, f.$3))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

