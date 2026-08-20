import 'package:dio/dio.dart';
import 'package:pulseboard_frontend/core/network/api_endpoints.dart';

class OrganizationRemoteDatasource {
  final Dio _dio;

  OrganizationRemoteDatasource(this._dio);

  Future<Map<String, dynamic>> createOrganization({
    required String name,
    required String slug,
    required String userId,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.createOrganization,
      data: {'name': name, 'slug': slug},
      options: Options(headers: {'x-user-id': userId}),
    );
    return response.data;
  }
}
