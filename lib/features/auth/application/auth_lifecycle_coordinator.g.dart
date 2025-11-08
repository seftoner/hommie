// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_lifecycle_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthLifecycleCoordinator)
const authLifecycleCoordinatorProvider = AuthLifecycleCoordinatorProvider._();

final class AuthLifecycleCoordinatorProvider
    extends $AsyncNotifierProvider<AuthLifecycleCoordinator, void> {
  const AuthLifecycleCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLifecycleCoordinatorProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          activeServerProvider,
          authStateMachineProvider,
          serverConnectionStateProvider,
          goRouterProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies0,
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies1,
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies2,
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies3,
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies4,
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies5,
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies6,
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies7,
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies8,
          AuthLifecycleCoordinatorProvider.$allTransitiveDependencies9,
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
  static const $allTransitiveDependencies6 = serverConnectionStateProvider;
  static const $allTransitiveDependencies7 = goRouterProvider;
  static const $allTransitiveDependencies8 =
      GoRouterProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies9 =
      GoRouterProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$authLifecycleCoordinatorHash();

  @$internal
  @override
  AuthLifecycleCoordinator create() => AuthLifecycleCoordinator();
}

String _$authLifecycleCoordinatorHash() =>
    r'd3abb9c72ec644f737f141381a4002e85c2d2eeb';

abstract class _$AuthLifecycleCoordinator extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
