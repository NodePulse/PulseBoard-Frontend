import 'package:pulseboard_frontend/models/domain/user.dart';
import 'package:pulseboard_frontend/models/data/auth_request.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password, {bool isWeb = false});
  Future<User> register(
    String firstName,
    String lastName,
    String email,
    String password, {
    bool isWeb = false,
  });
  Future sendVerification(
    String email,
    VerificationType type,
    VerificationMethod method,
  );
  Future verify(
    String email,
    String code,
    VerificationType type,
    VerificationMethod method,
  );
  Future resetPassword(
    String email,
    String code,
    String newPassword,
  );
  Future<User> fetchSession();
}
