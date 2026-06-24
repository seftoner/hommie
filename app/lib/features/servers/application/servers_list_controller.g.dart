// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servers_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServersListController)
final serversListControllerProvider = ServersListControllerProvider._();

final class ServersListControllerProvider
    extends $AsyncNotifierProvider<ServersListController, List<Server>> {
  ServersListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serversListControllerProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          serverManagerProvider,
          serverLifecycleControllerProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ServersListControllerProvider.$allTransitiveDependencies0,
          ServersListControllerProvider.$allTransitiveDependencies1,
          ServersListControllerProvider.$allTransitiveDependencies2,
          ServersListControllerProvider.$allTransitiveDependencies3,
          ServersListControllerProvider.$allTransitiveDependencies4,
        },
      );

  static final $allTransitiveDependencies0 = serverManagerProvider;
  static final $allTransitiveDependencies1 = serverLifecycleControllerProvider;
  static final $allTransitiveDependencies2 =
      ServerLifecycleControllerProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies3 =
      ServerLifecycleControllerProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies4 =
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
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Server>>, List<Server>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Server>>, List<Server>>,
              AsyncValue<List<Server>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
