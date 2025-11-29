// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceInfoRepository)
const deviceInfoRepositoryProvider = DeviceInfoRepositoryProvider._();

final class DeviceInfoRepositoryProvider
    extends
        $FunctionalProvider<
          IDeviceInfoRepository,
          IDeviceInfoRepository,
          IDeviceInfoRepository
        >
    with $Provider<IDeviceInfoRepository> {
  const DeviceInfoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceInfoRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceInfoRepositoryHash();

  @$internal
  @override
  $ProviderElement<IDeviceInfoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IDeviceInfoRepository create(Ref ref) {
    return deviceInfoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IDeviceInfoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IDeviceInfoRepository>(value),
    );
  }
}

String _$deviceInfoRepositoryHash() =>
    r'bf05d869ee7af7b33b9efeefd224336637ae3b89';
