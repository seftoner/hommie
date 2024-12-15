import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:hommie/services/networking/http_client_provider.dart';
import 'package:hommie/features/auth/infrastructure/repositories/secure_credentials_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
IAuthRepository authRepository(Ref ref) {
  final securityCredentialStorage =
      SecureCredentialRepository(const FlutterSecureStorage());
  final httpClinet = ref.watch(httpClientProvider);

  return AuthRepository(securityCredentialStorage, httpClinet);
}
