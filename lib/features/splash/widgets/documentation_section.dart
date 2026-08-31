import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';

class DocumentationSection extends StatelessWidget {
  final bool isLargeScreen;
  final bool isDark;

  const DocumentationSection({super.key, 
    required this.isLargeScreen,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 64 : 20,
        vertical: 56,
      ),
      padding: EdgeInsets.all(isLargeScreen ? 64 : 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Flex(
        direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isLargeScreen ? 1 : 0,
            child: Column(
              crossAxisAlignment: isLargeScreen
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Text(
                  'Developer-Friendly API',
                  textAlign: isLargeScreen ? TextAlign.left : TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'REST and GraphQL endpoints, outbound webhooks, and SDKs so you can '
                  'sync PulseBoard with CI/CD, CRMs, or your own internal tools.',
                  textAlign: isLargeScreen ? TextAlign.left : TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          if (isLargeScreen) const SizedBox(width: 48),
          if (!isLargeScreen) const SizedBox(height: 28),
          AppButton(
            onPressed: () {},
            title: 'Read Documentation',
            backgroundColor: Colors.white,
            textStyle: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
