import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';


class PricingSection extends StatelessWidget {
  final bool isLargeScreen;
  final bool isTablet;
  final bool isDark;

  const PricingSection({super.key, 
    required this.isLargeScreen,
    required this.isTablet,
    required this.isDark,
  });

  Widget _buildPricingCard(
    BuildContext context,
    String title,
    String price,
    String tagline,
    List<String> features, {
    bool isPopular = false,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isPopular
            ? AppColors.primary
            : (isDark ? theme.colorScheme.surface : Colors.white),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isPopular
              ? AppColors.primary
              : (isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : AppColors.grey300),
        ),
        boxShadow: [
          if (isPopular)
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'MOST POPULAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isPopular
                  ? Colors.white
                  : (isDark ? Colors.white : AppColors.surface),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            tagline,
            style: TextStyle(
              color: isPopular
                  ? Colors.white70
                  : (isDark ? Colors.white54 : AppColors.grey400),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price == '0' ? 'Free' : '\$$price',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: isPopular
                      ? Colors.white
                      : (isDark ? Colors.white : AppColors.surface),
                ),
              ),
              if (price != '0')
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Text(
                    '/user/month',
                    style: TextStyle(
                      color: isPopular ? Colors.white70 : AppColors.grey500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 28),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 20,
                    color: isPopular ? Colors.white : AppColors.success,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      f,
                      style: TextStyle(
                        color: isPopular
                            ? Colors.white
                            : (isDark ? Colors.white70 : AppColors.grey500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            onPressed: () => context.go(AppRoutes.signup),
            title: price == '0' ? 'Start Free' : 'Choose $title',
            backgroundColor: isPopular ? Colors.white : AppColors.primary,
            textStyle: TextStyle(
              color: isPopular ? AppColors.primary : Colors.white,
              fontWeight: FontWeight.bold,
            ),
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final horizontal = (isLargeScreen || isTablet)
        ? Axis.horizontal
        : Axis.vertical;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 64 : 20,
        vertical: 56,
      ),
      child: Column(
        children: [
          Text(
            'Simple, Transparent Pricing',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'No hidden fees. Cancel anytime. Annual billing saves 20%.',
            style: TextStyle(
              color: isDark ? Colors.white60 : AppColors.grey500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 56),
          Flex(
            direction: horizontal,
            crossAxisAlignment: horizontal == Axis.horizontal
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.stretch,
            spacing: 20,
            children: [
              Expanded(
                flex: horizontal == Axis.horizontal ? 1 : 0,
                child: _buildPricingCard(
                  context,
                  'Starter',
                  '0',
                  'For individuals & small teams',
                  [
                    'Up to 3 users',
                    'Unlimited boards',
                    'Real-time sync',
                    'Community support',
                  ],
                ),
              ),
              Expanded(
                flex: horizontal == Axis.horizontal ? 1 : 0,
                child: _buildPricingCard(
                  context,
                  'Pro',
                  '12',
                  'For growing teams',
                  [
                    'Unlimited users',
                    'Advanced analytics',
                    'Priority support',
                    'Custom workflows',
                    'Webhooks & API access',
                  ],
                  isPopular: true,
                ),
              ),
              Expanded(
                flex: horizontal == Axis.horizontal ? 1 : 0,
                child: _buildPricingCard(
                  context,
                  'Enterprise',
                  '29',
                  'For large & multi-tenant orgs',
                  [
                    'Everything in Pro',
                    'Dedicated success manager',
                    'SSO & SAML',
                    'Audit logs',
                    'Custom SLAs',
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

