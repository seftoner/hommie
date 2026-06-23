// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servers_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServersListController)
const serversListControllerProvider = ServersListControllerProvider._();

final class ServersListControllerProvider
    extends $AsyncNotifierProvider<ServersListController, List<Server>> {
  const ServersListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serversListControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          serverManagerProvider,
          serverLifecycleControllerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServersListControllerProvider.$allTransitiveDependencies0,
          ServersListControllerProvider.$allTransitiveDependencies1,
          ServersListControllerProvider.$allTransitiveDependencies2,
          ServersListControllerProvider.$allTransitiveDependencies3,
          ServersListControllerProvider.$allTransitiveDependencies4,
        },
      );

  static const $allTransitiveDependencies0 = serverManagerProvider;
  static const $allTransitiveDependencies1 = serverLifecycleControllerProvider;
  static const $allTransitiveDependencies2 =
      ServerLifecycleControllerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies3 =
      ServerLifecycleControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies4 =
      ServerLifecycleControllerProvider.$allTransitiveDependencies2;

  @override
  String debugGetCreateSourceHash() => _$serversListControllerHash();

  @$internal
  @override
  ServersListController create() => ServersListController();
}

String _$serversListControllerHash() =>
    r'd855c2e55fef7cf45b228f82eab3ef6bca6a101e';

abstract class _$ServersListController extends $AsyncNotifier<List<Server>> {
  FutureOr<List<Server>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Server>>, List<Server>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Server>>, List<Server>>,
              AsyncValue<List<Server>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
