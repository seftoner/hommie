// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_for_home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(areasForHome)
const areasForHomeProvider = AreasForHomeProvider._();

final class AreasForHomeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Area>>,
          List<Area>,
          FutureOr<List<Area>>
        >
    with $FutureModifier<List<Area>>, $FutureProvider<List<Area>> {
  const AreasForHomeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'areasForHomeProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[areasRepositoryProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AreasForHomeProvider.$allTransitiveDependencies0,
          AreasForHomeProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = areasRepositoryProvider;
  static const $allTransitiveDependencies1 =
      AreasRepositoryProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$areasForHomeHash();

  @$internal
  @override
  $FutureProviderElement<List<Area>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Area>> create(Ref ref) {
    return areasForHome(ref);
  }
}

String _$areasForHomeHash() => r'b8a84b642cbefadcfa94d12f5888194ed9f49a8a';
