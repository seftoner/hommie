import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/token_store_provider.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:oauth2/oauth2.dart';
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
@Riverpod(keepAlive: true, dependencies: [authRepository, tokenStore])
class AuthStateMachine extends _$AuthStateMachine {
  @override
  Future<AuthState> build(int serverId) async {
    return _evaluateCredentials();
  }

  /// Evaluates stored credentials for the current server, returning the
  /// appropriate [AuthState] (authenticated, revoked, unauthenticated, etc.).
  Future<AuthState> _evaluateCredentials() async {
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

  /// Forces a re-evaluation from persisted storage; used on cold boot or when
  /// the active server changes.
  Future<void> hydrate() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_evaluateCredentials);
  }

  /// Runs a refresh cycle while preserving the last known credentials so UI can
  /// keep rendering privileged content until the refresh succeeds or fails.
  Future<void> refresh() async {
    final current = state.asData?.value;
    final previousCredentials = current?.maybeWhen(
      authenticated: (credentials) => credentials,
      refreshing: (credentials) => credentials,
      orElse: () => null,
    );

    state = AsyncData(
      previousCredentials != null
          ? AuthState.refreshing(previousCredentials)
          : const AuthState.authenticating(),
    );

    state = await AsyncValue.guard(_evaluateCredentials);
  }

  /// Clears persisted credentials and transitions into an unauthenticated state.
  Future<void> clearSession() async {
    final store = ref.read(tokenStoreProvider(serverId));
    await store.clear();
    state = const AsyncData(AuthState.unauthenticated());
  }

  void markRevoked([AuthFailure? failure]) {
    state = AsyncData(AuthState.revoked(failure: failure));
  }

  void setAuthenticatedWithCredentials(Credentials credentials) {
    state = AsyncData(AuthState.authenticated(credentials));
  }

  void setFailure(AuthFailure failure) {
    state = AsyncData(AuthState.failure(failure));
  }
}
