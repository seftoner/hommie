// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servers_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServersList)
const serversListProvider = ServersListProvider._();

final class ServersListProvider
    extends $AsyncNotifierProvider<ServersList, List<Server>> {
  const ServersListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serversListProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[serverManagerProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ServersListProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverManagerProvider;

  @override
  String debugGetCreateSourceHash() => _$serversListHash();

  @$internal
  @override
  ServersList create() => ServersList();
}

String _$serversListHash() => r'e5645ddc2e12b03d439a0692266fe96ed9e46adb';

abstract class _$ServersList extends $AsyncNotifier<List<Server>> {
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
