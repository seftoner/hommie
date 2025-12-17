// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_registry_sync_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Keeps the local Drift area cache in sync with Home Assistant.
///
/// - When connected: subscribes to `area_registry_updated` and refreshes the full
///   registry into Drift.
/// - When disconnected: disposes the subscription.

@ProviderFor(AreaRegistrySyncController)
const areaRegistrySyncControllerProvider =
    AreaRegistrySyncControllerProvider._();

/// Keeps the local Drift area cache in sync with Home Assistant.
///
/// - When connected: subscribes to `area_registry_updated` and refreshes the full
///   registry into Drift.
/// - When disconnected: disposes the subscription.
final class AreaRegistrySyncControllerProvider
    extends $NotifierProvider<AreaRegistrySyncController, void> {
  /// Keeps the local Drift area cache in sync with Home Assistant.
  ///
  /// - When connected: subscribes to `area_registry_updated` and refreshes the full
  ///   registry into Drift.
  /// - When disconnected: disposes the subscription.
  const AreaRegistrySyncControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'areaRegistrySyncControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          serverScopeIdProvider,
          serverScopeConnectionProvider,
          areasRepositoryProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AreaRegistrySyncControllerProvider.$allTransitiveDependencies0,
          AreaRegistrySyncControllerProvider.$allTransitiveDependencies1,
          AreaRegistrySyncControllerProvider.$allTransitiveDependencies2,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeIdProvider;
  static const $allTransitiveDependencies1 = serverScopeConnectionProvider;
  static const $allTransitiveDependencies2 = areasRepositoryProvider;

  @override
  String debugGetCreateSourceHash() => _$areaRegistrySyncControllerHash();

  @$internal
  @override
  AreaRegistrySyncController create() => AreaRegistrySyncController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$areaRegistrySyncControllerHash() =>
    r'a8070444f94255732c192d554d5531d8529d5c61';

/// Keeps the local Drift area cache in sync with Home Assistant.
///
/// - When connected: subscribes to `area_registry_updated` and refreshes the full
///   registry into Drift.
/// - When disconnected: disposes the subscription.

abstract class _$AreaRegistrySyncController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
