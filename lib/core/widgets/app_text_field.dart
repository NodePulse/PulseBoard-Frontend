import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.onTap,
    this.fillColor,
    this.filled = true,
    this.contentPadding,
    this.borderRadius = 12,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String? label;

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;

  final int maxLines;
  final int? minLines;
  final int? maxLength;

  final Color? fillColor;
  final bool filled;

  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;

  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[300],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],

        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText,
            readOnly: readOnly,
            enabled: enabled,
            autofocus: autofocus,
            maxLines: obscureText ? 1 : maxLines,
            minLines: minLines,
            maxLength: maxLength,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hintText,
              helperText: helperText,
              errorText: errorText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: filled,
              fillColor: fillColor,
              contentPadding:
                  contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: _border(Colors.grey.shade400),
              enabledBorder: _border(Colors.grey.shade400),
              focusedBorder: _border(theme.primaryColor),
              errorBorder: _border(Colors.red),
              focusedErrorBorder: _border(Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
