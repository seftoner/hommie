// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$areaRepositoryHash() => r'7dc8f1de27d150de5eae4b3a402702ae3501f1dc';
