// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servers_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
          ServersListProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = serverManagerProvider;
  static const $allTransitiveDependencies1 =
      ServerManagerProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$serversListHash();

  @$internal
  @override
  ServersList create() => ServersList();
}

String _$serversListHash() => r'0542abc4ff1a8552fdae2cb2b585ecd130aad48d';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
