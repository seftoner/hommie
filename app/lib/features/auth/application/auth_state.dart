import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state.g.dart';

/// Server-scoped auth state machine represented as a stream. Consumers receive a
/// new [AuthState] every time the active server (and therefore credential
/// scope) changes.
@Riverpod(keepAlive: true)
Future<AuthState> authState(Ref ref) async {
  final repository = ref.watch(authRepositoryProvider);
  final activeServer = ref.watch(activeServerProvider);

  return switch (activeServer) {
    AsyncData(:final value) when value?.id == null =>
      const AuthState.unauthenticated(),
    AsyncData(:final value) => await _evaluateCredentials(
      repository,
      value!.id!,
    ),
    AsyncLoading() => const AuthState.initial(),
    AsyncError(:final error) => AuthState.failure(
      AuthFailure.server(error.toString()),
    ),
  };
}

Future<AuthState> _evaluateCredentials(
  IAuthRepository repository,
  int serverId,
) async {
  final result = await repository.getCredentials(serverId);

  return result.fold(
    _mapFailureToState,
    (credentials) => AuthState.authenticated(credentials),
  );
}

AuthState _mapFailureToState(AuthFailure failure) {
  return switch (failure) {
    MissingCredentials() => const AuthState.unauthenticated(),
    InvalidToken() => AuthState.revoked(failure: failure),
    _ => AuthState.failure(failure),
  };
}
