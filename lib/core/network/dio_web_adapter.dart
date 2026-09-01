import 'package:dio/dio.dart';
import 'package:dio/browser.dart';

void setupDioAdapter(Dio dio) {
  dio.httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
}
