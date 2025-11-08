// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_auth_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeAuthState)
const activeAuthStateProvider = ActiveAuthStateProvider._();

final class ActiveAuthStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuthState>,
          AsyncValue<AuthState>,
          AsyncValue<AuthState>
        >
    with $Provider<AsyncValue<AuthState>> {
  const ActiveAuthStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeAuthStateProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          activeServerProvider,
          authStateMachineProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ActiveAuthStateProvider.$allTransitiveDependencies0,
          ActiveAuthStateProvider.$allTransitiveDependencies1,
          ActiveAuthStateProvider.$allTransitiveDependencies2,
          ActiveAuthStateProvider.$allTransitiveDependencies3,
          ActiveAuthStateProvider.$allTransitiveDependencies4,
          ActiveAuthStateProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = activeServerProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = authStateMachineProvider;
  static const $allTransitiveDependencies3 =
      AuthStateMachineProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      AuthStateMachineProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies5 =
      AuthStateMachineProvider.$allTransitiveDependencies2;

  @override
  String debugGetCreateSourceHash() => _$activeAuthStateHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<AuthState>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<AuthState> create(Ref ref) {
    return activeAuthState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<AuthState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<AuthState>>(value),
    );
  }
}

String _$activeAuthStateHash() => r'11bab13e4eef79854b2f616a5f4741f6a14f1ba5';
