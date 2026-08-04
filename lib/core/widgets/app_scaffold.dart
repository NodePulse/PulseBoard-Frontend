import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget? child;
  const AppScaffold({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final startColor = isDark ? AppColors.scaffoldGradientStart : Colors.white;
    final endColor = isDark ? AppColors.scaffoldGradientEnd : const Color(0xFFE2E8F0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: startColor,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  startColor,
                  endColor,
                ],
              ),
            ),
            child: Padding(padding: const EdgeInsets.all(12), child: child),
          ),
        ),
      ),
    );
  }
}
