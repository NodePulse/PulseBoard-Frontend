import 'package:flutter/material.dart';

class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const FadeInWidget({super.key, required this.child, required this.delay});

  @override
  State<FadeInWidget> createState() => FadeInWidgetState();
}

class FadeInWidgetState extends State<FadeInWidget> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.1),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

