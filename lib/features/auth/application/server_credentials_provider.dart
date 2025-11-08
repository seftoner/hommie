import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:oauth2/oauth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_credentials_provider.g.dart';

@Riverpod(dependencies: [authRepository])
Future<Credentials> serverCredentials(Ref ref, int serverId) async {
  final repository = ref.read(authRepositoryProvider);
  final result = await repository.getCredentials(serverId);
  return result.fold(
    (failure) => throw AuthFailureException(failure),
    (credentials) => credentials,
  );
}

class AuthFailureException implements Exception {
  AuthFailureException(this.failure);

  final AuthFailure failure;

  @override
  String toString() => 'AuthFailureException($failure)';
}
