// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_states_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Live entity states for the active server, keyed by entity_id.
///
/// Subscribes to `subscribe_entities` while connected and folds the compressed
/// diffs into a map. Volatile — not persisted. Empty while disconnected.

@ProviderFor(EntityStates)
final entityStatesProvider = EntityStatesProvider._();

/// Live entity states for the active server, keyed by entity_id.
///
/// Subscribes to `subscribe_entities` while connected and folds the compressed
/// diffs into a map. Volatile — not persisted. Empty while disconnected.
final class EntityStatesProvider
    extends $NotifierProvider<EntityStates, Map<String, EntityStateValue>> {
  /// Live entity states for the active server, keyed by entity_id.
  ///
  /// Subscribes to `subscribe_entities` while connected and folds the compressed
  /// diffs into a map. Volatile — not persisted. Empty while disconnected.
  EntityStatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entityStatesProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[serverScopeConnectionProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          EntityStatesProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = serverScopeConnectionProvider;

  @override
  String debugGetCreateSourceHash() => _$entityStatesHash();

  @$internal
  @override
  EntityStates create() => EntityStates();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, EntityStateValue> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, EntityStateValue>>(
        value,
      ),
    );
  }
}

String _$entityStatesHash() => r'd42aea7469fd2967e643374400521fd356d6f3a7';

/// Live entity states for the active server, keyed by entity_id.
///
/// Subscribes to `subscribe_entities` while connected and folds the compressed
/// diffs into a map. Volatile — not persisted. Empty while disconnected.

abstract class _$EntityStates extends $Notifier<Map<String, EntityStateValue>> {
  Map<String, EntityStateValue> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<String, EntityStateValue>,
              Map<String, EntityStateValue>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, EntityStateValue>,
                Map<String, EntityStateValue>
              >,
              Map<String, EntityStateValue>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
