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
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serversListHash();

  @$internal
  @override
  ServersList create() => ServersList();
}

String _$serversListHash() => r'5aa7a2d7d3e7dc51ad1887397a25590ea18b8fcf';

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
