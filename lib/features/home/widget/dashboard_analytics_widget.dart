import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';

class DashboardAnalyticsWidget extends StatelessWidget {
  final ThemeData theme;
  final bool isDark;

  const DashboardAnalyticsWidget({
    super.key,
    required this.theme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate number of columns based on width
        int crossAxisCount = 1;
        if (constraints.maxWidth > 800) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 500) {
          crossAxisCount = 2;
        }

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard(
              title: "Active Projects",
              value: "12",
              icon: Icons.folder_open,
              trend: "+2 this week",
              trendUp: true,
              color: AppColors.primary,
              progress: 0.7,
            ),
            _buildStatCard(
              title: "Tasks Completed",
              value: "84",
              icon: Icons.check_circle_outline,
              trend: "+15% vs last week",
              trendUp: true,
              color: AppColors.success,
              progress: 0.84,
            ),
            _buildStatCard(
              title: "Team Members",
              value: "8",
              icon: Icons.people_outline,
              trend: "No change",
              trendUp: true, // neutral visually
              color: AppColors.warning,
              progress: 1.0,
            ),
            _buildStatCard(
              title: "Productivity Score",
              value: "92%",
              icon: Icons.trending_up,
              trend: "+4% from average",
              trendUp: true,
              color: Colors.blueAccent,
              progress: 0.92,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required String trend,
    required bool trendUp,
    required Color color,
    required double progress,
  }) {
    final bgColor = isDark
        ? AppColors.white.withValues(alpha: 0.03)
        : AppColors.black.withValues(alpha: 0.02);
    final borderColor = isDark
        ? AppColors.glassBorder
        : AppColors.black.withValues(alpha: 0.05);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Row(
                children: [
                  Icon(
                    trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 14,
                    color: trendUp ? AppColors.success : AppColors.error,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    trend,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: color.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
