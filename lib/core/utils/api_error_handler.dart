import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String getMessage(dynamic error) {
    String errorMessage = 'An unexpected error occurred';
    
    if (error is DioException) {
      if (error.response?.data != null && error.response?.data is Map<String, dynamic>) {
        errorMessage = error.response!.data['message']?.toString() ?? error.toString();
      } else {
        errorMessage = error.message ?? error.toString();
      }
    } else {
      errorMessage = error.toString();
    }
    
    return errorMessage;
  }
}
