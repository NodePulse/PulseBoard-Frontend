import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';

class FaqSection extends StatelessWidget {
  final bool isLargeScreen;
  final bool isDark;

  const FaqSection({
    super.key,
    required this.isLargeScreen,
    required this.isDark,
  });

  static const _faqs = [
    (
      'Is there a free plan?',
      'Yes — up to 3 users, unlimited boards, and real-time sync are free forever. No credit card required.',
    ),
    (
      'Can I migrate from Jira or Trello?',
      'Yes. PulseBoard supports CSV and API-based imports so existing boards, cards, and history carry over.',
    ),
    (
      'How does multi-tenancy work?',
      'Each workspace is isolated at the database level, so agencies and enterprises can host multiple client organizations securely on one account.',
    ),
    (
      'Do you offer SSO?',
      'SAML and OIDC single sign-on are available on the Enterprise plan, alongside audit logs and custom SLAs.',
    ),
    (
      'Can I cancel anytime?',
      'Yes, all paid plans are month-to-month with no lock-in. Annual billing is optional and saves 20%.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 64 : 20,
        vertical: 56,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            Text(
              'Frequently Asked Questions',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 40),
            ..._faqs.map(
              (f) => FaqTile(question: f.$1, answer: f.$2, isDark: isDark),
            ),
          ],
        ),
      ),
    );
  }
}

class FaqTile extends StatefulWidget {
  final String question;
  final String answer;
  final bool isDark;

  const FaqTile({
    super.key,
    required this.question,
    required this.answer,
    required this.isDark,
  });

  @override
  State<FaqTile> createState() => FaqTileState();
}

class FaqTileState extends State<FaqTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: widget.isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: widget.isDark
                ? Colors.white.withValues(alpha: 0.06)
                : AppColors.grey300.withValues(alpha: 0.5),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (v) => setState(() => _expanded = v),
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 4,
            ),
            childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            title: Text(
              widget.question,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: widget.isDark ? Colors.white : AppColors.surface,
              ),
            ),
            trailing: Icon(
              _expanded
                  ? Icons.remove_circle_outline
                  : Icons.add_circle_outline,
              color: AppColors.primary,
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.answer,
                  style: TextStyle(
                    color: widget.isDark ? Colors.white60 : AppColors.grey500,
                    height: 1.5,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
