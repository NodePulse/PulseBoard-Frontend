import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/theme/app_button_theme.dart';
import 'package:pulseboard_frontend/core/theme/app_card_theme.dart';
import 'package:pulseboard_frontend/core/theme/app_color_scheme.dart';
import 'package:pulseboard_frontend/core/theme/app_input_theme.dart';
import 'package:pulseboard_frontend/core/theme/app_text_theme.dart';

class LightTheme {
  LightTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.light,
    textTheme: AppTextTheme.light,
    inputDecorationTheme: AppInputTheme.light,
    elevatedButtonTheme: AppButtonTheme.light,
    cardTheme: AppCardTheme.light,
  );
}
