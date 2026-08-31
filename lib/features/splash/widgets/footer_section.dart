import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';


class FooterSection extends StatelessWidget {
  final bool isLargeScreen;
  final bool isDark;

  const FooterSection({super.key, required this.isLargeScreen, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 64 : 20,
        vertical: 48,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : AppColors.grey300.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Column(
        children: [
          Flex(
            direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isLargeScreen
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: isLargeScreen
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bolt, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'PulseBoard',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: isDark ? Colors.white : AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Real-time project management for modern teams.',
                    textAlign: isLargeScreen
                        ? TextAlign.left
                        : TextAlign.center,
                    style: TextStyle(
                      color: isDark ? Colors.white60 : AppColors.grey500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SocialIcon(icon: Icons.alternate_email, isDark: isDark),
                      const SizedBox(width: 12),
                      SocialIcon(icon: Icons.forum_outlined, isDark: isDark),
                      const SizedBox(width: 12),
                      SocialIcon(icon: Icons.code, isDark: isDark),
                    ],
                  ),
                ],
              ),
              if (isLargeScreen)
                Row(
                  spacing: 48,
                  children: const [
                    FooterCol(
                      title: 'Product',
                      links: ['Features', 'Pricing', 'Changelog', 'API Docs'],
                    ),
                    FooterCol(
                      title: 'Company',
                      links: ['About', 'Blog', 'Careers'],
                    ),
                    FooterCol(
                      title: 'Legal',
                      links: ['Privacy Policy', 'Terms of Service', 'Security'],
                    ),
                  ],
                )
              else ...[
                const SizedBox(height: 32),
                const Wrap(
                  spacing: 32,
                  runSpacing: 24,
                  children: [
                    FooterCol(
                      title: 'Product',
                      links: ['Features', 'Pricing', 'Changelog', 'API Docs'],
                    ),
                    FooterCol(
                      title: 'Company',
                      links: ['About', 'Blog', 'Careers'],
                    ),
                    FooterCol(
                      title: 'Legal',
                      links: ['Privacy Policy', 'Terms of Service', 'Security'],
                    ),
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(height: 40),
          Divider(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : AppColors.grey300.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 20),
          Text(
            '© ${DateTime.now().year} PulseBoard Inc. All rights reserved.',
            style: TextStyle(
              color: isDark ? Colors.white30 : AppColors.grey400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class FooterCol extends StatelessWidget {
  final String title;
  final List<String> links;

  const FooterCol({super.key, required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.surface,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              link,
              style: TextStyle(
                color: isDark ? Colors.white60 : AppColors.grey500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final bool isDark;

  const SocialIcon({super.key, required this.icon, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : AppColors.grey.withValues(alpha: 0.08),
      ),
      child: Icon(
        icon,
        size: 18,
        color: isDark ? Colors.white70 : AppColors.grey500,
      ),
    );
  }
}

