import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:hommie/services/networking/secure_credentials_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@Riverpod(keepAlive: true)
IAuthRepository authRepository(Ref ref) {
  final securityCredentialStorage =
      SecureCredentialStorage(const FlutterSecureStorage());
  return AuthRepository(securityCredentialStorage);
}
