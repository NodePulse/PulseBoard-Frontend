import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_text_field.dart';

class JoinProjectWidget extends StatefulWidget {
  final bool isDark;
  final ThemeData theme;
  
  const JoinProjectWidget({
    super.key,
    required this.isDark,
    required this.theme,
  });

  @override
  State<JoinProjectWidget> createState() => _JoinProjectWidgetState();
}

class _JoinProjectWidgetState extends State<JoinProjectWidget> {
  final TextEditingController _invitationCodeController = TextEditingController();

  @override
  void dispose() {
    _invitationCodeController.dispose();
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
              Icon(Icons.link_rounded, color: theme.colorScheme.secondary),
              const SizedBox(width: 12),
              Text(
                "Join a Project",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Have an invitation code? Enter it below to join a project and start collaborating.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: "Invitation Code",
            hintText: "e.g. PRJ-9X2K",
            controller: _invitationCodeController,
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: 16),
          AppButton(
            title: "Join Project",
            backgroundColor: theme.colorScheme.secondary,
            onPressed: () {
              // Handle joining project
              final code = _invitationCodeController.text;
            },
          ),
        ],
      ),
    );
  }
}
