import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';


class WhyPulseBoardSection extends StatelessWidget {
  final bool isLargeScreen;
  final bool isDark;

  const WhyPulseBoardSection({super.key, 
    required this.isLargeScreen,
    required this.isDark,
  });

  static const _points = [
    (
      Icons.compare_arrows,
      'One tool instead of three',
      'Stop reconciling Jira tickets, Slack threads, and a separate reporting '
          'dashboard. Planning, discussion, and analytics live on the same card.',
    ),
    (
      Icons.speed,
      'Built for real-time from day one',
      'PulseBoard was architected around WebSockets and event sourcing, not '
          'retrofitted with polling — so collaboration always feels instant.',
    ),
    (
      Icons.groups_outlined,
      'Scales from 3 people to 3,000',
      'The same multi-tenant core that powers a solo founder\'s free workspace '
          'also isolates data for enterprise customers running dozens of teams.',
    ),
  ];

  Widget _buildPoint(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : AppColors.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.secondary, size: 26),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    color: isDark ? Colors.white60 : AppColors.grey500,
                    height: 1.5,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 64 : 20,
        vertical: 56,
      ),
      color: isDark ? Colors.black12 : AppColors.grey.withValues(alpha: 0.05),
      child: Flex(
        direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isLargeScreen ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why teams switch to PulseBoard',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Most project tools bolt real-time features onto an old request/response '
                  'model. PulseBoard was designed around live collaboration from the first '
                  'commit, so it feels fast because it is fast.',
                  style: TextStyle(
                    color: isDark ? Colors.white60 : AppColors.grey500,
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 28),
                AppButton(
                  onPressed: () => context.go(AppRoutes.signup),
                  title: 'See it in action',
                  backgroundColor: AppColors.secondary,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (isLargeScreen) const SizedBox(width: 64),
          if (!isLargeScreen) const SizedBox(height: 40),
          Expanded(
            flex: isLargeScreen ? 1 : 0,
            child: Column(
              children: _points
                  .map((p) => _buildPoint(context, p.$1, p.$2, p.$3))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

