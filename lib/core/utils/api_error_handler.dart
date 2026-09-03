import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String getMessage(dynamic error) {
    if (error is DioException) {
      if (error.response?.data != null &&
          error.response?.data is Map<String, dynamic>) {
        final data = error.response!.data as Map<String, dynamic>;
        if (data['message'] != null) {
          if (data['message'] is List) {
            return (data['message'] as List).join(', ');
          }
          return data['message'].toString();
        }
      }
      return error.message ?? error.toString();
    } else if (error is String) {
      return error;
    } else if (error is Exception) {
      final str = error.toString();
      if (str.startsWith('Exception: ')) {
        return str.substring(11);
      }
      return str;
    }
    return error.toString();
  }
}
