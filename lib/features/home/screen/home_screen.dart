import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/router/app_bottom_navigation_bar.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/features/home/widget/sidebar_widget.dart';
import 'package:pulseboard_frontend/features/home/widget/dashboard_header_widget.dart';
import 'package:pulseboard_frontend/features/home/screen/dashboard_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isExtended = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = ref.read(authNotifierProvider);
      if (authState.user == null) {
        ref.read(authNotifierProvider.notifier).checkAuthStatus();
      }
    });
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.profile)) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;
    final currentOrgAsync = ref.watch(currentOrganizationProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        if (isMobile) {
          return AppScaffold(
            bottomNavigationBar: const AppBottomNavigationBar(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                  child: DashboardHeaderWidget(
                    user: user,
                    organization: currentOrgAsync.value,
                    theme: theme,
                    isDark: isDark,
                  ),
                ),
                Expanded(child: widget.child),
              ],
            ),
          );
        } else {
          return AppScaffold(
            padding: 0, // Remove padding for the rail to sit flush
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SidebarWidget(
                  isExtended: _isExtended,
                  onToggle: () {
                    setState(() {
                      _isExtended = !_isExtended;
                    });
                  },
                  currentRoute: GoRouterState.of(context).uri.toString(),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
                        child: DashboardHeaderWidget(
                          user: user,
                          organization: currentOrgAsync.value,
                          theme: theme,
                          isDark: isDark,
                        ),
                      ),
                      Expanded(
                        child: widget.child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
