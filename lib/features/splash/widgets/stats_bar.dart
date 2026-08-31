import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';

import 'fade_in_widget.dart';

class StatsBar extends StatelessWidget {
  final bool isLargeScreen;
  final bool isDark;

  const StatsBar({super.key, required this.isLargeScreen, required this.isDark});

  static const _stats = [
    ('99.9%', 'Uptime SLA'),
    ('<150ms', 'Median sync latency'),
    ('40+', 'Native integrations'),
    ('SOC 2', 'Type II compliant'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeInWidget(
      delay: const Duration(milliseconds: 500),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isLargeScreen ? 64 : 20,
          vertical: 32,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isLargeScreen ? 48 : 20,
          vertical: 28,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.03)
              : AppColors.grey.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : AppColors.grey300.withValues(alpha: 0.5),
          ),
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          runSpacing: 20,
          children: _stats
              .map(
                (s) => SizedBox(
                  width: isLargeScreen ? 200 : 150,
                  child: Column(
                    children: [
                      Text(
                        s.$1,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        s.$2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white60 : AppColors.grey500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

