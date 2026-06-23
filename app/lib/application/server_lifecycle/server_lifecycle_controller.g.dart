// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_lifecycle_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serverLifecycleController)
const serverLifecycleControllerProvider = ServerLifecycleControllerProvider._();

final class ServerLifecycleControllerProvider
    extends
        $FunctionalProvider<
          IServerLifecycleController,
          IServerLifecycleController,
          IServerLifecycleController
        >
    with $Provider<IServerLifecycleController> {
  const ServerLifecycleControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverLifecycleControllerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          serverConnectionManagerProvider,
          authRepositoryProvider,
          serverManagerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerLifecycleControllerProvider.$allTransitiveDependencies0,
          ServerLifecycleControllerProvider.$allTransitiveDependencies1,
          ServerLifecycleControllerProvider.$allTransitiveDependencies2,
          ServerLifecycleControllerProvider.$allTransitiveDependencies3,
        },
      );

  static const $allTransitiveDependencies0 = serverConnectionManagerProvider;
  static const $allTransitiveDependencies1 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = authRepositoryProvider;
  static const $allTransitiveDependencies3 = serverManagerProvider;

  @override
  String debugGetCreateSourceHash() => _$serverLifecycleControllerHash();

  @$internal
  @override
  $ProviderElement<IServerLifecycleController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IServerLifecycleController create(Ref ref) {
    return serverLifecycleController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IServerLifecycleController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IServerLifecycleController>(value),
    );
  }
}

String _$serverLifecycleControllerHash() =>
    r'9b5e4dd7ba8bb9c3598cb379365ebf4dce2f8d71';
