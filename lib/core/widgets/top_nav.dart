import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';

class TopNav extends StatefulWidget {
  final bool isLargeScreen;
  final bool isDark;
  final void Function(String anchor)? onNavTap;

  const TopNav({
    super.key,
    required this.isLargeScreen,
    required this.isDark,
    this.onNavTap,
  });

  @override
  State<TopNav> createState() => _TopNavState();
}

class _TopNavState extends State<TopNav> {
  bool _isMenuOpen = false;

  static const _sections = <NavItem>[
    NavItem('Features', 'features'),
    NavItem('Why Us', 'why'),
    NavItem('Use Cases', 'use-cases'),
    NavItem('Pricing', 'pricing'),
    NavItem('FAQ', 'faq'),
  ];

  Widget _navLink(String title, String anchor, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Semantics(
        button: true,
        label: 'Navigate to $title section',
        child: TextButton(
          onPressed: () {
            if (_isMenuOpen) setState(() => _isMenuOpen = false);
            widget.onNavTap?.call(anchor);
          },
          style: TextButton.styleFrom(
            foregroundColor: widget.isDark ? Colors.white70 : AppColors.grey500,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          child: Text(title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Close the menu if we resize to a large screen
    if (widget.isLargeScreen && _isMenuOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isMenuOpen = false);
      });
    }

    return Container(
      decoration: BoxDecoration(
        color: widget.isDark
            ? AppColors.surface.withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(
            color: widget.isDark
                ? Colors.white.withValues(alpha: 0.05)
                : AppColors.grey300.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.isLargeScreen ? 48 : 20,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Semantics(
                      label: 'PulseBoard home',
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.bolt,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'PulseBoard',
                      style: GoogleFonts.blackOpsOne(
                        textStyle: theme.textTheme.titleMedium,
                        // fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        fontSize: 32,
                      ),
                    ),
                    if (widget.isLargeScreen) ...[
                      const SizedBox(width: 40),
                      ..._sections.map(
                        (s) => _navLink(s.label, s.anchor, context),
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    if (widget.isLargeScreen)
                      TextButton(
                        onPressed: () => context.go(AppRoutes.signin),
                        style: TextButton.styleFrom(
                          foregroundColor: widget.isDark
                              ? Colors.white
                              : AppColors.surface,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Sign In'),
                      ),
                    SizedBox(width: widget.isLargeScreen ? 16 : 0),
                    AppButton(
                      onPressed: () => context.go(AppRoutes.signup),
                      title: widget.isLargeScreen
                          ? 'Get Started Free'
                          : 'Start',
                      backgroundColor: AppColors.primary,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    if (!widget.isLargeScreen) const SizedBox(width: 12),
                    if (!widget.isLargeScreen)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isMenuOpen = !_isMenuOpen;
                          });
                        },
                        icon: Icon(
                          _isMenuOpen ? Icons.close : Icons.menu,
                          color: widget.isDark
                              ? Colors.white
                              : AppColors.surface,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: (!widget.isLargeScreen && _isMenuOpen)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Divider(),
                        ..._sections.map(
                          (s) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              s.label,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: widget.isDark
                                    ? Colors.white
                                    : AppColors.surface,
                              ),
                            ),
                            onTap: () {
                              setState(() => _isMenuOpen = false);
                              widget.onNavTap?.call(s.anchor);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: widget.isDark
                                  ? Colors.white
                                  : AppColors.surface,
                            ),
                          ),
                          onTap: () {
                            setState(() => _isMenuOpen = false);
                            context.go(AppRoutes.signin);
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class NavItem {
  final String label;
  final String anchor;
  const NavItem(this.label, this.anchor);
}
