// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_auth_navigation_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServerAuthNavigationCoordinator)
const serverAuthNavigationCoordinatorProvider =
    ServerAuthNavigationCoordinatorProvider._();

final class ServerAuthNavigationCoordinatorProvider
    extends $AsyncNotifierProvider<ServerAuthNavigationCoordinator, void> {
  const ServerAuthNavigationCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverAuthNavigationCoordinatorProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          activeServerProvider,
          serverConnectionStateProvider,
          serverAuthControllerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerAuthNavigationCoordinatorProvider.$allTransitiveDependencies0,
          ServerAuthNavigationCoordinatorProvider.$allTransitiveDependencies1,
          ServerAuthNavigationCoordinatorProvider.$allTransitiveDependencies2,
          ServerAuthNavigationCoordinatorProvider.$allTransitiveDependencies3,
          ServerAuthNavigationCoordinatorProvider.$allTransitiveDependencies4,
          ServerAuthNavigationCoordinatorProvider.$allTransitiveDependencies5,
          ServerAuthNavigationCoordinatorProvider.$allTransitiveDependencies6,
          ServerAuthNavigationCoordinatorProvider.$allTransitiveDependencies7,
        },
      );

  static const $allTransitiveDependencies0 = activeServerProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = serverConnectionStateProvider;
  static const $allTransitiveDependencies3 = serverAuthControllerProvider;
  static const $allTransitiveDependencies4 =
      ServerAuthControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies5 =
      ServerAuthControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies6 =
      ServerAuthControllerProvider.$allTransitiveDependencies5;
  static const $allTransitiveDependencies7 =
      ServerAuthControllerProvider.$allTransitiveDependencies6;

  @override
  String debugGetCreateSourceHash() => _$serverAuthNavigationCoordinatorHash();

  @$internal
  @override
  ServerAuthNavigationCoordinator create() => ServerAuthNavigationCoordinator();
}

String _$serverAuthNavigationCoordinatorHash() =>
    r'bcdef9f336a01e11ca8a1e25ff94ce383a877b33';

abstract class _$ServerAuthNavigationCoordinator extends $AsyncNotifier<void> {
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
