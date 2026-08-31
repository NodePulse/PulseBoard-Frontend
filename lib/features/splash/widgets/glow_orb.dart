import 'package:flutter/material.dart';


/// Decorative radial-gradient orb used behind sections. Purely cosmetic —
/// wrapped with IgnorePointer so it never intercepts taps/scrolls.
class GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  final double alpha;

  const GlowOrb({super.key, 
    required this.color,
    required this.size,
    required this.alpha,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: alpha),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

