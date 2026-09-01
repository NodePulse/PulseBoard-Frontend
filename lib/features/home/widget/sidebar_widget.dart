import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';

class SidebarWidget extends StatelessWidget {
  final bool isExtended;
  final VoidCallback onToggle;
  final String currentRoute;

  const SidebarWidget({
    super.key,
    required this.isExtended,
    required this.onToggle,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark
        ? AppColors.white.withValues(alpha: 0.03)
        : AppColors.black.withValues(alpha: 0.02);
    final borderColor = isDark
        ? AppColors.white.withValues(alpha: 0.1)
        : AppColors.black.withValues(alpha: 0.1);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isExtended ? 260 : 80,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          right: BorderSide(color: borderColor),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isExtended ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          // Header / Logo Area
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isExtended ? 24.0 : 0.0),
            child: Row(
              mainAxisAlignment: isExtended
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (isExtended)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.insights,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "PulseBoard",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                IconButton(
                  icon: Icon(
                    isExtended ? Icons.menu_open : Icons.menu,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  onPressed: onToggle,
                  tooltip: isExtended ? "Collapse sidebar" : "Expand sidebar",
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Navigation Items
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _SidebarItem(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard,
                    label: "Dashboard",
                    isActive: currentRoute == AppRoutes.dashboard,
                    isExtended: isExtended,
                    onTap: () => context.go(AppRoutes.dashboard),
                    theme: theme,
                  ),
                  const SizedBox(height: 8),
                  _SidebarItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: "Profile",
                    isActive: currentRoute.startsWith(AppRoutes.profile),
                    isExtended: isExtended,
                    onTap: () => context.go(AppRoutes.profile),
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
          // Footer / Settings
          const Divider(height: 1, color: Colors.white10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: _SidebarItem(
              icon: Icons.settings_outlined,
              activeIcon: Icons.settings,
              label: "Settings",
              isActive: false,
              isExtended: isExtended,
              onTap: () {},
              theme: theme,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final bool isExtended;
  final VoidCallback onTap;
  final ThemeData theme;

  const _SidebarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.isExtended,
    required this.onTap,
    required this.theme,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary;
    final idleColor = widget.theme.colorScheme.onSurface.withValues(alpha: 0.6);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? activeColor.withValues(alpha: 0.15)
                  : _isHovering
                      ? widget.theme.colorScheme.onSurface
                          .withValues(alpha: 0.05)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: widget.isExtended
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Icon(
                  widget.isActive ? widget.activeIcon : widget.icon,
                  color: widget.isActive ? activeColor : idleColor,
                  size: 22,
                ),
                if (widget.isExtended) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.label,
                      style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: widget.isActive ? activeColor : idleColor,
                        fontWeight: widget.isActive
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
