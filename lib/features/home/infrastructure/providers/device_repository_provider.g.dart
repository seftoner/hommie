// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceRepository)
const deviceRepositoryProvider = DeviceRepositoryProvider._();

final class DeviceRepositoryProvider
    extends
        $FunctionalProvider<
          IDeviceRepository,
          IDeviceRepository,
          IDeviceRepository
        >
    with $Provider<IDeviceRepository> {
  const DeviceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceRepositoryHash();

  @$internal
  @override
  $ProviderElement<IDeviceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IDeviceRepository create(Ref ref) {
    return deviceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IDeviceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IDeviceRepository>(value),
    );
  }
}

String _$deviceRepositoryHash() => r'6161d560e008c805e512cea229904b19dd8899b6';
