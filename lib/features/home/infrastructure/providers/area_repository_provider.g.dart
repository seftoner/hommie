// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(areaRepository)
const areaRepositoryProvider = AreaRepositoryProvider._();

final class AreaRepositoryProvider
    extends
        $FunctionalProvider<IAreaRepository, IAreaRepository, IAreaRepository>
    with $Provider<IAreaRepository> {
  const AreaRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'areaRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$areaRepositoryHash();

  @$internal
  @override
  $ProviderElement<IAreaRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IAreaRepository create(Ref ref) {
    return areaRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IAreaRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IAreaRepository>(value),
    );
  }
}

String _$areaRepositoryHash() => r'fb8a92eedcbeaf4fb78443b0195af95b291c418b';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
