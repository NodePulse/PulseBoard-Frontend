import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/router/app_bottom_navigation_bar.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/features/home/widget/sidebar_widget.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isExtended = true;

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.profile)) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        if (isMobile) {
          return AppScaffold(
            bottomNavigationBar: const AppBottomNavigationBar(),
            child: widget.child,
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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: widget.child,
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
