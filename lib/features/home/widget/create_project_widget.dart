import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_text_field.dart';

class CreateProjectWidget extends StatefulWidget {
  final bool isDark;
  final ThemeData theme;
  
  const CreateProjectWidget({
    super.key,
    required this.isDark,
    required this.theme,
  });

  @override
  State<CreateProjectWidget> createState() => _CreateProjectWidgetState();
}

class _CreateProjectWidgetState extends State<CreateProjectWidget> {
  final TextEditingController _projectNameController = TextEditingController();

  @override
  void dispose() {
    _projectNameController.dispose();
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
              Icon(Icons.create_new_folder_rounded, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(
                "Create a Project",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Start a new project within your organization and collaborate with your team.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: "Project Name",
            hintText: "e.g. Website Redesign",
            controller: _projectNameController,
          ),
          const SizedBox(height: 16),
          AppButton(
            title: "Create Project",
            backgroundColor: theme.colorScheme.primary,
            onPressed: () {
              // Handle project creation
              final name = _projectNameController.text;
            },
          ),
        ],
      ),
    );
  }
}
