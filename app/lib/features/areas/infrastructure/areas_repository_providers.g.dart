// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(areasRepository)
const areasRepositoryProvider = AreasRepositoryProvider._();

final class AreasRepositoryProvider
    extends
        $FunctionalProvider<
          IAreasRepository,
          IAreasRepository,
          IAreasRepository
        >
    with $Provider<IAreasRepository> {
  const AreasRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'areasRepositoryProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[serverScopeConnectionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AreasRepositoryProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeConnectionProvider;

  @override
  String debugGetCreateSourceHash() => _$areasRepositoryHash();

  @$internal
  @override
  $ProviderElement<IAreasRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IAreasRepository create(Ref ref) {
    return areasRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IAreasRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IAreasRepository>(value),
    );
  }
}

String _$areasRepositoryHash() => r'490cf21930068a58e5df11456c82f16dd0abf9e2';
