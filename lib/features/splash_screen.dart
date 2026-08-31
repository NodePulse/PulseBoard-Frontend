import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'splash/widgets/glow_orb.dart';
import 'package:pulseboard_frontend/core/widgets/top_nav.dart';
import 'splash/widgets/hero_section.dart';
import 'splash/widgets/stats_bar.dart';
import 'splash/widgets/features_section.dart';
import 'splash/widgets/why_pulseboard_section.dart';
import 'splash/widgets/use_cases_section.dart';
import 'splash/widgets/testimonials_section.dart';
import 'splash/widgets/pricing_section.dart';
import 'splash/widgets/documentation_section.dart';
import 'splash/widgets/faq_section.dart';
import 'splash/widgets/newsletter_section.dart';
import 'splash/widgets/footer_section.dart';

/// Responsive breakpoints used throughout the landing page.
class _Breakpoints {
  static const double tablet = 760;
  static const double desktop = 1100;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _featuresKey = GlobalKey();
  final _whyKey = GlobalKey();
  final _useCasesKey = GlobalKey();
  final _pricingKey = GlobalKey();
  final _faqKey = GlobalKey();

  void _scrollToSection(String anchor) {
    GlobalKey? key;
    switch (anchor) {
      case 'features':
        key = _featuresKey;
        break;
      case 'why':
        key = _whyKey;
        break;
      case 'use-cases':
        key = _useCasesKey;
        break;
      case 'pricing':
        key = _pricingKey;
        break;
      case 'faq':
        key = _faqKey;
        break;
    }

    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppScaffold(
      padding: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isLargeScreen = width > _Breakpoints.desktop;
          final isTablet =
              width > _Breakpoints.tablet && width <= _Breakpoints.desktop;

          return Stack(
            children: [
              // Abstract background elements
              Positioned(
                top: -150,
                right: -100,
                child: GlowOrb(
                  color: AppColors.primary,
                  size: 600,
                  alpha: 0.15,
                ),
              ),
              Positioned(
                top: 500,
                left: -150,
                child: GlowOrb(
                  color: AppColors.secondary,
                  size: 500,
                  alpha: 0.12,
                ),
              ),
              Positioned(
                top: 1800,
                right: -120,
                child: GlowOrb(
                  color: AppColors.success,
                  size: 420,
                  alpha: 0.10,
                ),
              ),

              // Main scrolling content
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 100,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        alignment: Alignment.center,
                        child: HeroSection(
                          isLargeScreen: isLargeScreen,
                          isDark: isDark,
                        ),
                      ),
                      StatsBar(isLargeScreen: isLargeScreen, isDark: isDark),
                      Container(
                        key: _featuresKey,
                        child: FeaturesSection(
                          isLargeScreen: isLargeScreen,
                          isTablet: isTablet,
                          isDark: isDark,
                        ),
                      ),
                      Container(
                        key: _whyKey,
                        child: WhyPulseBoardSection(
                          isLargeScreen: isLargeScreen,
                          isDark: isDark,
                        ),
                      ),
                      Container(
                        key: _useCasesKey,
                        child: UseCasesSection(
                          isLargeScreen: isLargeScreen,
                          isTablet: isTablet,
                          isDark: isDark,
                        ),
                      ),
                      TestimonialsSection(
                        isLargeScreen: isLargeScreen,
                        isTablet: isTablet,
                        isDark: isDark,
                      ),
                      Container(
                        key: _pricingKey,
                        child: PricingSection(
                          isLargeScreen: isLargeScreen,
                          isTablet: isTablet,
                          isDark: isDark,
                        ),
                      ),
                      DocumentationSection(
                        isLargeScreen: isLargeScreen,
                        isDark: isDark,
                      ),
                      Container(
                        key: _faqKey,
                        child: FaqSection(
                          isLargeScreen: isLargeScreen,
                          isDark: isDark,
                        ),
                      ),
                      NewsletterSection(
                        isLargeScreen: isLargeScreen,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 32),
                      FooterSection(
                        isLargeScreen: isLargeScreen,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: TopNav(
                  isLargeScreen: isLargeScreen,
                  isDark: isDark,
                  onNavTap: _scrollToSection,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
