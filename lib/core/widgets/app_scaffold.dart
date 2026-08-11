import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget? child;
  final double? padding;
  final Widget? bottomNavigationBar;
  const AppScaffold({
    super.key,
    this.child,
    this.padding,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final startColor = isDark ? AppColors.scaffoldGradientStart : Colors.white;
    final endColor = isDark
        ? AppColors.scaffoldGradientEnd
        : const Color(0xFFE2E8F0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: startColor,
          bottomNavigationBar: bottomNavigationBar,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [startColor, endColor]),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding ?? 12),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
