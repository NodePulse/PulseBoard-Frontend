class Log {
  static void info(String msg) => print('\x1B[32m[INFO] $msg\x1B[0m'); // Green
  static void warn(String msg) => print('\x1B[33m[WARN] $msg\x1B[0m'); // Yellow
  static void error(String msg) => print('\x1B[31m[ERROR] $msg\x1B[0m'); // Red
  static void debug(String msg) => print('\x1B[34m[DEBUG] $msg\x1B[0m'); // Blue
}
