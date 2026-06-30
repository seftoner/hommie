// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tile_override_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeTileOverrideRepository)
final homeTileOverrideRepositoryProvider =
    HomeTileOverrideRepositoryProvider._();

final class HomeTileOverrideRepositoryProvider
    extends
        $FunctionalProvider<
          IHomeTileOverrideRepository,
          IHomeTileOverrideRepository,
          IHomeTileOverrideRepository
        >
    with $Provider<IHomeTileOverrideRepository> {
  HomeTileOverrideRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeTileOverrideRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeTileOverrideRepositoryHash();

  @$internal
  @override
  $ProviderElement<IHomeTileOverrideRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IHomeTileOverrideRepository create(Ref ref) {
    return homeTileOverrideRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IHomeTileOverrideRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IHomeTileOverrideRepository>(value),
    );
  }
}

String _$homeTileOverrideRepositoryHash() =>
    r'7a47d884cc6d2d3835b031fc78dffd02516af580';
