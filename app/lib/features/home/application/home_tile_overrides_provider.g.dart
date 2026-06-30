// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tile_overrides_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reactive list of local tile layout overrides for the active server.

@ProviderFor(homeTileOverrides)
final homeTileOverridesProvider = HomeTileOverridesProvider._();

/// Reactive list of local tile layout overrides for the active server.

final class HomeTileOverridesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HomeTileOverride>>,
          List<HomeTileOverride>,
          Stream<List<HomeTileOverride>>
        >
    with
        $FutureModifier<List<HomeTileOverride>>,
        $StreamProvider<List<HomeTileOverride>> {
  /// Reactive list of local tile layout overrides for the active server.
  HomeTileOverridesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeTileOverridesProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[serverScopeIdProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          HomeTileOverridesProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = serverScopeIdProvider;

  @override
  String debugGetCreateSourceHash() => _$homeTileOverridesHash();

  @$internal
  @override
  $StreamProviderElement<List<HomeTileOverride>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HomeTileOverride>> create(Ref ref) {
    return homeTileOverrides(ref);
  }
}

String _$homeTileOverridesHash() => r'a1e8ce9ca10ac3cf7e4afbc95f988f6cefc7a7bb';
