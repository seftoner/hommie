// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensors_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(sensorsList)
const sensorsListProvider = SensorsListProvider._();

final class SensorsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Sensor>>,
          List<Sensor>,
          FutureOr<List<Sensor>>
        >
    with $FutureModifier<List<Sensor>>, $FutureProvider<List<Sensor>> {
  const SensorsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sensorsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sensorsListHash();

  @$internal
  @override
  $FutureProviderElement<List<Sensor>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Sensor>> create(Ref ref) {
    return sensorsList(ref);
  }
}

String _$sensorsListHash() => r'a3d46119d0329b7cdb26c2bdd781786eb1afe3cc';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
