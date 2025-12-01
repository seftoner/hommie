// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensors_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sensorsRepository)
const sensorsRepositoryProvider = SensorsRepositoryProvider._();

final class SensorsRepositoryProvider
    extends
        $FunctionalProvider<
          ISensorsRepository,
          ISensorsRepository,
          ISensorsRepository
        >
    with $Provider<ISensorsRepository> {
  const SensorsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sensorsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sensorsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ISensorsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ISensorsRepository create(Ref ref) {
    return sensorsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ISensorsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ISensorsRepository>(value),
    );
  }
}

String _$sensorsRepositoryHash() => r'72b6f1082cceb53548effb5416476a08a59f2203';
