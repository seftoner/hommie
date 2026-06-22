// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_entities_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reactive list of cached entities for the active server.

@ProviderFor(cachedEntities)
const cachedEntitiesProvider = CachedEntitiesProvider._();

/// Reactive list of cached entities for the active server.

final class CachedEntitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HaEntity>>,
          List<HaEntity>,
          Stream<List<HaEntity>>
        >
    with $FutureModifier<List<HaEntity>>, $StreamProvider<List<HaEntity>> {
  /// Reactive list of cached entities for the active server.
  const CachedEntitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cachedEntitiesProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[serverScopeIdProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          CachedEntitiesProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeIdProvider;

  @override
  String debugGetCreateSourceHash() => _$cachedEntitiesHash();

  @$internal
  @override
  $StreamProviderElement<List<HaEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HaEntity>> create(Ref ref) {
    return cachedEntities(ref);
  }
}

String _$cachedEntitiesHash() => r'd62d045a94a86a0752044133bd1f16645c35bf94';
