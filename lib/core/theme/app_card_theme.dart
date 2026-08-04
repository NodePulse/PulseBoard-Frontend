import 'package:flutter/material.dart';

class AppCardTheme {
  AppCardTheme._();

  static final light = CardThemeData(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: Colors.white,
  );

  static final dark = CardThemeData(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: Colors.transparent,
  );
}
