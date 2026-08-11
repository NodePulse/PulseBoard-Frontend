import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/router/app_bottom_navigation_bar.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottomNavigationBar: const AppBottomNavigationBar(),
      child: child,
    );
  }
}
