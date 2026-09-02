import 'package:dio/dio.dart';
import 'package:pulseboard_frontend/core/network/api_endpoints.dart';

class OrganizationRemoteDatasource {
  final Dio _dio;

  OrganizationRemoteDatasource(this._dio);

  Future<Map<String, dynamic>> createOrganization({
    required String name,
    required String slug,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.tenants.createOrganization,
      data: {'name': name, 'slug': slug},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getOrganization() async {
    final response = await _dio.get(ApiEndpoints.tenants.getOrganization);
    return response.data;
  }
}
