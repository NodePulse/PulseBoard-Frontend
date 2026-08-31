import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';


class UseCasesSection extends StatelessWidget {
  final bool isLargeScreen;
  final bool isTablet;
  final bool isDark;

  const UseCasesSection({super.key, 
    required this.isLargeScreen,
    required this.isTablet,
    required this.isDark,
  });

  static const _cases = [
    (
      Icons.code_outlined,
      'Engineering Sprints',
      AppColors.primary,
      'Plan sprints, link pull requests to cards, and track cycle time without leaving the board.',
    ),
    (
      Icons.campaign_outlined,
      'Marketing Campaigns',
      AppColors.secondary,
      'Coordinate launches across content, design, and paid channels on shared timelines.',
    ),
    (
      Icons.route_outlined,
      'Product Roadmaps',
      AppColors.success,
      'Turn customer feedback into a prioritized, stakeholder-visible roadmap in minutes.',
    ),
  ];

  Widget _buildCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.surface,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 10),
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
    );
  }

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
          Text(
            'One board, every kind of team',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'PulseBoard adapts to how your team already works.',
            style: TextStyle(
              color: isDark ? Colors.white60 : AppColors.grey500,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 44),
          Flex(
            direction: (isLargeScreen || isTablet)
                ? Axis.horizontal
                : Axis.vertical,
            spacing: 20,
            children: _cases
                .map(
                  (c) => Expanded(
                    flex: (isLargeScreen || isTablet) ? 1 : 0,
                    child: _buildCard(context, c.$1, c.$2, c.$3, c.$4),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

