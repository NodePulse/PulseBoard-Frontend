import 'package:pulseboard_frontend/features/authentication/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
}
