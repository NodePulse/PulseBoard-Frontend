import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/network/dio_provider.dart';
import 'package:pulseboard_frontend/datasources/organization_remote_datasource.dart';
import 'package:pulseboard_frontend/repositories/data/organization_repository_impl.dart';
import 'package:pulseboard_frontend/repositories/domain/organization_repository.dart';

final organizationRepositoryProvider = Provider<OrganizationRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final remoteDatasource = OrganizationRemoteDatasource(dio);
  return OrganizationRepositoryImpl(remoteDatasource);
});
