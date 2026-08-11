import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_text_field.dart';

class JoinOrganizationWidget extends StatefulWidget {
  final bool isDark;
  final ThemeData theme;
  const JoinOrganizationWidget({
    super.key,
    required this.isDark,
    required this.theme,
  });

  @override
  State<JoinOrganizationWidget> createState() => _JoinOrganizationWidgetState();
}

class _JoinOrganizationWidgetState extends State<JoinOrganizationWidget> {
  final TextEditingController _organizationCodeController =
      TextEditingController();

  @override
  void dispose() {
    _organizationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final isDark = widget.isDark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: isDark ? 0.4 : 1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.group_add_rounded, color: theme.colorScheme.secondary),
              const SizedBox(width: 12),
              Text(
                "Join an existing team",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Have a private code? Enter it below to join an organization workspace immediately.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: "Private Code",
            hintText: "e.g. T-8X91P",
            controller: _organizationCodeController,
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: 16),
          AppButton(
            title: "Join Organization",
            backgroundColor: theme.colorScheme.secondary,
            onPressed: () {
              // Handle joining organization
              final code = _organizationCodeController.text;
            },
          ),
        ],
      ),
    );
  }
}
