import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/theme/app_button_theme.dart';
import 'package:pulseboard_frontend/core/theme/app_card_theme.dart';
import 'package:pulseboard_frontend/core/theme/app_color_scheme.dart';
import 'package:pulseboard_frontend/core/theme/app_input_theme.dart';
import 'package:pulseboard_frontend/core/theme/app_text_theme.dart';

class DarkTheme {
  DarkTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.dark,
    textTheme: AppTextTheme.dark,
    inputDecorationTheme: AppInputTheme.dark,
    elevatedButtonTheme: AppButtonTheme.dark,
    cardTheme: AppCardTheme.dark,
  );
}
