import 'package:pulseboard_frontend/features/home/data/datasources/organization_remote_datasource.dart';
import 'package:pulseboard_frontend/features/home/domain/repositories/organization_repository.dart';

class OrganizationRepositoryImpl implements OrganizationRepository {
  final OrganizationRemoteDatasource _remoteDatasource;

  OrganizationRepositoryImpl(this._remoteDatasource);

  @override
  Future<Map<String, dynamic>> createOrganization(
    String name,
    String slug,
  ) async {
    return _remoteDatasource.createOrganization(name: name, slug: slug);
  }

  Future<Map<String, dynamic>> getOrganization() async {
    return _remoteDatasource.getOrganization();
  }
}
