import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_machine.g.dart';

/// Server-scoped state machine that keeps the UI, connection layer, and
/// background tasks aligned on the current authentication status.
///
/// Responsibilities:
/// * Hydrates persisted credentials when the app boots or the active server
///   changes.
/// * Maps token read/refresh failures into user-actionable states (`revoked`,
///   `unauthenticated`, `failure`).
/// * Exposes imperative helpers (`refresh`, `clearSession`, `markRevoked`)
///   consumed by flow orchestration when auth edges occur (user sign-out,
///   server-side revocation, etc.).
@Riverpod(keepAlive: true, dependencies: [ActiveServer])
class AuthStateMachine extends _$AuthStateMachine {
  @override
  Future<AuthState> build() async {
    final activeServerAsync = ref.watch(activeServerProvider);

    return activeServerAsync.when(
      data: (activeServer) {
        if (activeServer?.id == null) {
          return const AuthState.unauthenticated();
        }
        return _evaluateCredentials(activeServer!.id!);
      },
      loading: () => const AuthState.initial(),
      error: (error, stack) =>
          AuthState.failure(AuthFailure.server(error.toString())),
    );
  }

  /// Evaluates stored credentials for the current server, returning the
  /// appropriate [AuthState] (authenticated, revoked, unauthenticated, etc.).
  Future<AuthState> _evaluateCredentials(int serverId) async {
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.getCredentials(serverId);

    return result.fold(
      _mapFailureToState,
      (credentials) => AuthState.authenticated(credentials),
    );
  }

  /// Normalises repository failures into high-level states that drive routing
  /// and UI.
  AuthState _mapFailureToState(AuthFailure failure) {
    return switch (failure) {
      MissingCredentials() => const AuthState.unauthenticated(),
      InvalidToken() => AuthState.revoked(failure: failure),
      _ => AuthState.failure(failure),
    };
  }
}
