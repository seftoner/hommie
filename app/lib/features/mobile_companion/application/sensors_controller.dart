import 'dart:async';

import 'package:hommie/features/mobile_companion/infrastructure/providers/sensors_repository_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sensors_controller.g.dart';

@riverpod
class SensorsController extends _$SensorsController {
  StreamSubscription<List<Sensor>>? _subscription;

  @override
  FutureOr<List<Sensor>> build() async {
    final repository = ref.watch(sensorsRepositoryProvider);
    _subscription?.cancel();
    _subscription = repository.watchSensors().listen(
      (event) => state = AsyncData(event),
      onError: (error, stackTrace) => state = AsyncError(error, stackTrace),
    );
    ref.onDispose(() {
      _subscription?.cancel();
      _subscription = null;
    });
    return repository.readSensors();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(sensorsRepositoryProvider);
      final sensors = await repository.readSensors();
      state = AsyncData(sensors);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
