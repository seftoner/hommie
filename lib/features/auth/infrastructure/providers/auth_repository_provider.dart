import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:hommie/services/networking/http_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
IAuthRepository authRepository(Ref ref, int serverId) {
  final securityCredentialStorage =
      ref.read(credentialsRepositoryProvider(serverId));
  final httpClinet = ref.read(httpClientProvider);

  return AuthRepository(securityCredentialStorage, httpClinet);
}
