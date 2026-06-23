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
const entityStatesProvider = EntityStatesProvider._();

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
  const EntityStatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entityStatesProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[activeServerSessionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          EntityStatesProvider.$allTransitiveDependencies0,
          EntityStatesProvider.$allTransitiveDependencies1,
          EntityStatesProvider.$allTransitiveDependencies2,
          EntityStatesProvider.$allTransitiveDependencies3,
          EntityStatesProvider.$allTransitiveDependencies4,
          EntityStatesProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = activeServerSessionProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      ActiveServerSessionProvider.$allTransitiveDependencies4;

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

String _$entityStatesHash() => r'a3a04065a11d84a45578d7c758b80912104769d1';

/// Live entity states for the active server, keyed by entity_id.
///
/// Subscribes to `subscribe_entities` while connected and folds the compressed
/// diffs into a map. Volatile — not persisted. Empty while disconnected.

abstract class _$EntityStates extends $Notifier<Map<String, EntityStateValue>> {
  Map<String, EntityStateValue> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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
    element.handleValue(ref, created);
  }
}
