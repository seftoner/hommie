// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Server-scoped auth state machine represented as a stream. Consumers receive a
/// new [AuthState] every time the active server (and therefore credential
/// scope) changes.

@ProviderFor(authState)
const authStateProvider = AuthStateProvider._();

/// Server-scoped auth state machine represented as a stream. Consumers receive a
/// new [AuthState] every time the active server (and therefore credential
/// scope) changes.

final class AuthStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuthState>,
          AuthState,
          FutureOr<AuthState>
        >
    with $FutureModifier<AuthState>, $FutureProvider<AuthState> {
  /// Server-scoped auth state machine represented as a stream. Consumers receive a
  /// new [AuthState] every time the active server (and therefore credential
  /// scope) changes.
  const AuthStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateHash();

  @$internal
  @override
  $FutureProviderElement<AuthState> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AuthState> create(Ref ref) {
    return authState(ref);
  }
}

String _$authStateHash() => r'f0bf81a8bc2db2ef3d3faa2171b384da999e0d00';
