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
        dependencies: const <ProviderOrFamily>[serverScopeIdProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          CachedAreasProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeIdProvider;

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

String _$cachedAreasHash() => r'122cb929d72ba55b39c1eed6a1dc154755ca1293';
