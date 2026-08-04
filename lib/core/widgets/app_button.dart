import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  final ButtonStyle? style;

  final double? width;
  final double? height;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextStyle? textStyle;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledColor;

  final double borderRadius;
  final BorderSide? borderSide;

  final double elevation;

  final bool isLoading;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.style,
    this.width,
    this.height = 50,
    this.padding,
    this.margin,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledColor,
    this.borderRadius = 12,
    this.borderSide,
    this.elevation = 0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style ??
            ((backgroundColor == null &&
                    foregroundColor == null &&
                    elevation == 0 &&
                    padding == null &&
                    borderSide == null &&
                    borderRadius == 12)
                ? null
                : ElevatedButton.styleFrom(
                    elevation: elevation,
                    backgroundColor: backgroundColor,
                    foregroundColor: foregroundColor,
                    disabledBackgroundColor: disabledColor,
                    padding: padding,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      side: borderSide ?? BorderSide.none,
                    ),
                  )),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 8),
                  ],
                  Text(title, style: textStyle),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );

    if (margin != null) {
      return Padding(padding: margin!, child: button);
    }

    return button;
  }
}
