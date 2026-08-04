import 'package:flutter/material.dart';

class AppTextField extends FormField<String> {
  AppTextField({
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
    super.validator,
    this.obscureText = false,
    this.readOnly = false,
    super.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.onTap,
    this.fillColor,
    this.filled = true,
    this.contentPadding,
    this.borderRadius = 12,
  }) : super(
         initialValue: controller != null ? controller.text : '',
         autovalidateMode: AutovalidateMode.onUserInteraction,
         builder: (FormFieldState<String> field) {
           final _AppTextFieldState state = field as _AppTextFieldState;
           final theme = Theme.of(state.context);
           final hasError = state.hasError || errorText != null;
           final currentErrorText = state.errorText ?? errorText;

           final iconColor = theme.colorScheme.onSurface.withValues(alpha: 0.7);
           final styledPrefixIcon = prefixIcon != null
               ? IconTheme(
                   data: IconThemeData(color: iconColor),
                   child: prefixIcon,
                 )
               : null;
           final styledSuffixIcon = suffixIcon != null
               ? IconTheme(
                   data: IconThemeData(color: iconColor),
                   child: suffixIcon,
                 )
               : null;

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               if (label != null) ...[
                 Text(
                   label,
                   style: theme.textTheme.bodyMedium?.copyWith(
                     color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                     fontWeight: FontWeight.w500,
                   ),
                 ),
                 const SizedBox(height: 8),
               ],

               TextField(
                 controller: state._effectiveController,
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
                 onChanged: (value) {
                   state.didChange(value);
                   if (onChanged != null) {
                     onChanged(value);
                   }
                 },
                 onSubmitted: onSubmitted,
                 onTap: onTap,
                 decoration: InputDecoration(
                   hintText: hintText,
                   helperText: helperText,
                   prefixIcon: styledPrefixIcon,
                   suffixIcon: styledSuffixIcon,
                   filled: filled,
                   fillColor: fillColor,
                   contentPadding: contentPadding,
                   errorText: hasError ? '' : null,
                   errorStyle: const TextStyle(height: 0, fontSize: 0),
                 ),
               ),
               if (hasError) ...[
                 const SizedBox(height: 6),
                 Text(
                   currentErrorText ?? '',
                   style: TextStyle(
                     color: theme.colorScheme.error,
                     fontSize: 12,
                   ),
                 ),
               ],
             ],
           );
         },
       );

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

  @override
  FormFieldState<String> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends FormFieldState<String> {
  TextEditingController? _controller;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!;

  @override
  AppTextField get widget => super.widget as AppTextField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = TextEditingController.fromValue(
          oldWidget.controller!.value,
        );
      }
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          _controller?.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
