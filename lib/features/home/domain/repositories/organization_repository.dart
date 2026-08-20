abstract class OrganizationRepository {
  Future<Map<String, dynamic>> createOrganization(String name, String slug, String userId);
}
