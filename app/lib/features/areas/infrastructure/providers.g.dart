// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

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
          AsyncValue<IAreasRepository>,
          IAreasRepository,
          FutureOr<IAreasRepository>
        >
    with $FutureModifier<IAreasRepository>, $FutureProvider<IAreasRepository> {
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
  $FutureProviderElement<IAreasRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IAreasRepository> create(Ref ref) {
    return areasRepository(ref);
  }
}

String _$areasRepositoryHash() => r'287271bd5eb4f9eb4743bffbc942bdac64d698a1';
