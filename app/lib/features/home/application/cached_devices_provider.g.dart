// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_devices_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reactive list of cached Home Assistant device registry rows for the active
/// server.

@ProviderFor(cachedDevices)
final cachedDevicesProvider = CachedDevicesProvider._();

/// Reactive list of cached Home Assistant device registry rows for the active
/// server.

final class CachedDevicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Device>>,
          List<Device>,
          Stream<List<Device>>
        >
    with $FutureModifier<List<Device>>, $StreamProvider<List<Device>> {
  /// Reactive list of cached Home Assistant device registry rows for the active
  /// server.
  CachedDevicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cachedDevicesProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[serverScopeIdProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          CachedDevicesProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = serverScopeIdProvider;

  @override
  String debugGetCreateSourceHash() => _$cachedDevicesHash();

  @$internal
  @override
  $StreamProviderElement<List<Device>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Device>> create(Ref ref) {
    return cachedDevices(ref);
  }
}

String _$cachedDevicesHash() => r'31d47cb6b2f1c8605675642c1b792bb5f639f2af';
