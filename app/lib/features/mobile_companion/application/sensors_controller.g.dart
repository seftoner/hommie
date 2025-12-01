// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensors_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SensorsController)
const sensorsControllerProvider = SensorsControllerProvider._();

final class SensorsControllerProvider
    extends $AsyncNotifierProvider<SensorsController, List<Sensor>> {
  const SensorsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sensorsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sensorsControllerHash();

  @$internal
  @override
  SensorsController create() => SensorsController();
}

String _$sensorsControllerHash() => r'f881fcd190ebccc9c9847872018a0085906db5de';

abstract class _$SensorsController extends $AsyncNotifier<List<Sensor>> {
  FutureOr<List<Sensor>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Sensor>>, List<Sensor>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Sensor>>, List<Sensor>>,
              AsyncValue<List<Sensor>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
