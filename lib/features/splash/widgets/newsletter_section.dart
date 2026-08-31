import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';


class NewsletterSection extends StatefulWidget {
  final bool isLargeScreen;
  final bool isDark;

  const NewsletterSection({super.key, required this.isLargeScreen, required this.isDark});

  @override
  State<NewsletterSection> createState() => NewsletterSectionState();
}

class NewsletterSectionState extends State<NewsletterSection> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter an email address';
    final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!pattern.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: wire up to the newsletter/waitlist API endpoint.
      setState(() => _submitted = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.isLargeScreen ? 64 : 20),
      padding: EdgeInsets.symmetric(
        horizontal: widget.isLargeScreen ? 48 : 24,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: widget.isDark
            ? Colors.white.withValues(alpha: 0.03)
            : AppColors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Get product updates',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'One email a month. New features, integrations, and release notes.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.isDark ? Colors.white60 : AppColors.grey500,
            ),
          ),
          const SizedBox(height: 24),
          if (_submitted)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: AppColors.success),
                const SizedBox(width: 8),
                Text(
                  'Thanks — you\'re on the list.',
                  style: TextStyle(
                    color: widget.isDark ? Colors.white : AppColors.surface,
                  ),
                ),
              ],
            )
          else
            Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Flex(
                  direction: widget.isLargeScreen
                      ? Axis.horizontal
                      : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: widget.isLargeScreen ? 1 : 0,
                      child: TextFormField(
                        controller: _emailController,
                        validator: _validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: widget.isDark
                              ? Colors.white
                              : AppColors.surface,
                        ),
                        decoration: InputDecoration(
                          hintText: 'you@company.com',
                          filled: true,
                          fillColor: widget.isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: widget.isDark
                                  ? Colors.white24
                                  : AppColors.grey300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: widget.isLargeScreen ? 12 : 0,
                      height: widget.isLargeScreen ? 0 : 12,
                    ),
                    AppButton(
                      onPressed: _submit,
                      title: 'Subscribe',
                      backgroundColor: AppColors.primary,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      width: widget.isLargeScreen ? 140 : double.infinity,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

