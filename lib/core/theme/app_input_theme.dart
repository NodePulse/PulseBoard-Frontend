import 'package:flutter/material.dart';

import 'package:pulseboard_frontend/core/constants/app_colors.dart';

class AppInputTheme {
  AppInputTheme._();

  static final light = InputDecorationTheme(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    hintStyle: TextStyle(
      fontSize: 14,
      color: Colors.black.withValues(alpha: 0.38),
    ),
    helperStyle: TextStyle(
      fontSize: 12,
      color: Colors.black.withValues(alpha: 0.38),
    ),
    labelStyle: TextStyle(
      fontSize: 14,
      color: Colors.black.withValues(alpha: 0.6),
    ),
    errorStyle: const TextStyle(
      fontSize: 12,
      height: 1.0,
      color: AppColors.error,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error),
    ),
  );

  static final dark = InputDecorationTheme(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    hintStyle: TextStyle(
      fontSize: 14,
      color: Colors.white.withValues(alpha: 0.38),
    ),
    helperStyle: TextStyle(
      fontSize: 12,
      color: Colors.white.withValues(alpha: 0.38),
    ),
    labelStyle: TextStyle(
      fontSize: 14,
      color: Colors.white.withValues(alpha: 0.6),
    ),
    errorStyle: const TextStyle(
      fontSize: 12,
      height: 1.0,
      color: AppColors.error,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error),
    ),
  );
}
