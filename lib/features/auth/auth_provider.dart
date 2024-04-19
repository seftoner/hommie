import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:hommie/services/networking/secure_credentials_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final securityCredentialStorage =
      SecureCredentialStorage(const FlutterSecureStorage());
  return AuthRepository(securityCredentialStorage);
}
