import 'package:flutter/foundation.dart';

class AppLogger {
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';

  /// Logs an error message in bright red.
  static void error(String message) {
    debugPrint('$_red$message$_reset');
  }

  /// Logs a success message in bright green.
  static void success(String message) {
    debugPrint('$_green$message$_reset');
  }

  /// Logs a warning message in bright yellow.
  static void warning(String message) {
    debugPrint('$_yellow$message$_reset');
  }

  /// Logs an info message in bright blue.
  static void info(String message) {
    debugPrint('$_blue$message$_reset');
  }
}
