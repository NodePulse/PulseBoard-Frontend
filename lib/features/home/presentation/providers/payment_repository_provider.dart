import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/network/dio_provider.dart';
import 'package:pulseboard_frontend/datasources/payment_remote_datasource.dart';
import 'package:pulseboard_frontend/repositories/data/payment_repository_impl.dart';
import 'package:pulseboard_frontend/repositories/domain/payment_repository.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final remoteDatasource = PaymentRemoteDatasource(dio);
  return PaymentRepositoryImpl(remoteDatasource);
});
