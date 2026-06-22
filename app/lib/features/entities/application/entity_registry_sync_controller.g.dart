// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_registry_sync_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Keeps the local entity cache in sync with Home Assistant.
/// Subscribes to entity_registry_updated and device_registry_updated; refreshes
/// the full entity set into Drift on connect and on either event.

@ProviderFor(EntityRegistrySyncController)
const entityRegistrySyncControllerProvider =
    EntityRegistrySyncControllerProvider._();

/// Keeps the local entity cache in sync with Home Assistant.
/// Subscribes to entity_registry_updated and device_registry_updated; refreshes
/// the full entity set into Drift on connect and on either event.
final class EntityRegistrySyncControllerProvider
    extends $NotifierProvider<EntityRegistrySyncController, EntitySyncStatus> {
  /// Keeps the local entity cache in sync with Home Assistant.
  /// Subscribes to entity_registry_updated and device_registry_updated; refreshes
  /// the full entity set into Drift on connect and on either event.
  const EntityRegistrySyncControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entityRegistrySyncControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          serverScopeIdProvider,
          serverScopeConnectionProvider,
          registryRepositoryProvider,
          entityRepositoryProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          EntityRegistrySyncControllerProvider.$allTransitiveDependencies0,
          EntityRegistrySyncControllerProvider.$allTransitiveDependencies1,
          EntityRegistrySyncControllerProvider.$allTransitiveDependencies2,
          EntityRegistrySyncControllerProvider.$allTransitiveDependencies3,
        },
      );

  static const $allTransitiveDependencies0 = serverScopeIdProvider;
  static const $allTransitiveDependencies1 = serverScopeConnectionProvider;
  static const $allTransitiveDependencies2 = registryRepositoryProvider;
  static const $allTransitiveDependencies3 = entityRepositoryProvider;

  @override
  String debugGetCreateSourceHash() => _$entityRegistrySyncControllerHash();

  @$internal
  @override
  EntityRegistrySyncController create() => EntityRegistrySyncController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntitySyncStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntitySyncStatus>(value),
    );
  }
}

String _$entityRegistrySyncControllerHash() =>
    r'99c3f8c2a2ca52d155f1d94cf936c6120e6bae2e';

/// Keeps the local entity cache in sync with Home Assistant.
/// Subscribes to entity_registry_updated and device_registry_updated; refreshes
/// the full entity set into Drift on connect and on either event.

abstract class _$EntityRegistrySyncController
    extends $Notifier<EntitySyncStatus> {
  EntitySyncStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EntitySyncStatus, EntitySyncStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EntitySyncStatus, EntitySyncStatus>,
              EntitySyncStatus,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
