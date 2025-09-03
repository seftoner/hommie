import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:hommie/services/networking/http_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

/// Provides a singleton auth repository that can handle multiple servers
///
/// This replaces the family provider pattern with a single repository
/// that accepts server IDs as method parameters
@Riverpod(keepAlive: true)
IAuthRepository authRepository(Ref ref) {
  final credentialRepository = ref.read(credentialRepositoryProvider);
  final httpClient = ref.read(httpClientProvider);

  return AuthRepository(credentialRepository, httpClient);
}
