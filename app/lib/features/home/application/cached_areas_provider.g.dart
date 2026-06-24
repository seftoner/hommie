// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_areas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cachedAreas)
const cachedAreasProvider = CachedAreasProvider._();

final class CachedAreasProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Area>>,
          List<Area>,
          Stream<List<Area>>
        >
    with $FutureModifier<List<Area>>, $StreamProvider<List<Area>> {
  const CachedAreasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cachedAreasProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          serverScopeIdProvider,
          areasForServerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          CachedAreasProvider.$allTransitiveDependencies0,
          CachedAreasProvider.$allTransitiveDependencies1,
          CachedAreasProvider.$allTransitiveDependencies2,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeIdProvider;
  static const $allTransitiveDependencies1 = areasForServerProvider;
  static const $allTransitiveDependencies2 =
      AreasForServerProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$cachedAreasHash();

  @$internal
  @override
  $StreamProviderElement<List<Area>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Area>> create(Ref ref) {
    return cachedAreas(ref);
  }
}

String _$cachedAreasHash() => r'476ceaa9d65727986ab8f59d1501fbbef4da18f8';
