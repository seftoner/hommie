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
const authStateMachineProvider = AuthStateMachineFamily._();

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
  const AuthStateMachineProvider._({
    required AuthStateMachineFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'authStateMachineProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = authRepositoryProvider;
  static const $allTransitiveDependencies1 = tokenStoreProvider;
  static const $allTransitiveDependencies2 =
      TokenStoreProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$authStateMachineHash();

  @override
  String toString() {
    return r'authStateMachineProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AuthStateMachine create() => AuthStateMachine();

  @override
  bool operator ==(Object other) {
    return other is AuthStateMachineProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$authStateMachineHash() => r'106116be7e60c3296325f0373f1ad632badf883a';

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

final class AuthStateMachineFamily extends $Family
    with
        $ClassFamilyOverride<
          AuthStateMachine,
          AsyncValue<AuthState>,
          AuthState,
          FutureOr<AuthState>,
          int
        > {
  const AuthStateMachineFamily._()
    : super(
        retry: null,
        name: r'authStateMachineProvider',
        dependencies: const <ProviderOrFamily>[
          authRepositoryProvider,
          tokenStoreProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AuthStateMachineProvider.$allTransitiveDependencies0,
          AuthStateMachineProvider.$allTransitiveDependencies1,
          AuthStateMachineProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: false,
      );

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

  AuthStateMachineProvider call(int serverId) =>
      AuthStateMachineProvider._(argument: serverId, from: this);

  @override
  String toString() => r'authStateMachineProvider';
}

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
  late final _$args = ref.$arg as int;
  int get serverId => _$args;

  FutureOr<AuthState> build(int serverId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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
