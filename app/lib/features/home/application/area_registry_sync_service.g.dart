// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_registry_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(areaRegistrySyncService)
final areaRegistrySyncServiceProvider = AreaRegistrySyncServiceProvider._();

final class AreaRegistrySyncServiceProvider
    extends
        $FunctionalProvider<
          AreaRegistrySyncService,
          AreaRegistrySyncService,
          AreaRegistrySyncService
        >
    with $Provider<AreaRegistrySyncService> {
  AreaRegistrySyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'areaRegistrySyncServiceProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[areaRepositoryProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          AreaRegistrySyncServiceProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = areaRepositoryProvider;

  @override
  String debugGetCreateSourceHash() => _$areaRegistrySyncServiceHash();

  @$internal
  @override
  $ProviderElement<AreaRegistrySyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AreaRegistrySyncService create(Ref ref) {
    return areaRegistrySyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AreaRegistrySyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AreaRegistrySyncService>(value),
    );
  }
}

String _$areaRegistrySyncServiceHash() =>
    r'db1a7f5f71dccf82bc01d3db32c1b89dd5612936';
