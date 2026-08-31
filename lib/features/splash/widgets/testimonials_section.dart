import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';


class TestimonialsSection extends StatelessWidget {
  final bool isLargeScreen;
  final bool isTablet;
  final bool isDark;

  const TestimonialsSection({super.key, 
    required this.isLargeScreen,
    required this.isTablet,
    required this.isDark,
  });

  // NOTE: replace with real customer quotes and initials before launch.
  static const _quotes = [
    (
      '"We cut our weekly status-meeting time in half within a month of switching."',
      'Engineering Lead, mid-size SaaS team',
      'EL',
    ),
    (
      '"The multi-tenant setup let us finally give each client their own isolated workspace."',
      'Agency Operations Manager',
      'AO',
    ),
    (
      '"Real-time sync means our remote team stopped asking \'is this board up to date?\'"',
      'Product Manager, distributed startup',
      'PM',
    ),
  ];

  Widget _buildCard(
    BuildContext context,
    String quote,
    String attribution,
    String initials,
  ) {
    final theme = Theme.of(context);
    return Container(
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote, color: AppColors.primary, size: 32),
          const SizedBox(height: 16),
          Text(
            quote,
            style: TextStyle(
              color: isDark ? Colors.white70 : AppColors.grey500,
              fontStyle: FontStyle.italic,
              height: 1.5,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  attribution,
                  style: TextStyle(
                    color: isDark ? Colors.white54 : AppColors.grey400,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
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
            'Trusted by early adopter teams',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 44),
          Flex(
            direction: (isLargeScreen || isTablet)
                ? Axis.horizontal
                : Axis.vertical,
            spacing: 20,
            children: _quotes
                .map(
                  (q) => Expanded(
                    flex: (isLargeScreen || isTablet) ? 1 : 0,
                    child: _buildCard(context, q.$1, q.$2, q.$3),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

