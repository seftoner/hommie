// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servers_discovery_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ServersDiscoveryController)
const serversDiscoveryControllerProvider =
    ServersDiscoveryControllerProvider._();

final class ServersDiscoveryControllerProvider
    extends $AsyncNotifierProvider<ServersDiscoveryController, List<HaServer>> {
  const ServersDiscoveryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serversDiscoveryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serversDiscoveryControllerHash();

  @$internal
  @override
  ServersDiscoveryController create() => ServersDiscoveryController();
}

String _$serversDiscoveryControllerHash() =>
    r'eb990ef66c025467c0d7a06391ddcba925553498';

abstract class _$ServersDiscoveryController
    extends $AsyncNotifier<List<HaServer>> {
  FutureOr<List<HaServer>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<HaServer>>, List<HaServer>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<HaServer>>, List<HaServer>>,
              AsyncValue<List<HaServer>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
