// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_machine.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(AuthStateMachine)
const authStateMachineProvider = AuthStateMachineProvider._();

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
final class AuthStateMachineProvider
    extends $AsyncNotifierProvider<AuthStateMachine, AuthState> {
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
  const AuthStateMachineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateMachineProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[activeServerProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AuthStateMachineProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = activeServerProvider;

  @override
  String debugGetCreateSourceHash() => _$authStateMachineHash();

  @$internal
  @override
  AuthStateMachine create() => AuthStateMachine();
}

String _$authStateMachineHash() => r'9835db35107e67e8c6bb37bd85eb2187cb3905c7';

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

abstract class _$AuthStateMachine extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthState>, AuthState>,
              AsyncValue<AuthState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
