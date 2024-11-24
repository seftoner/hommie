import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/mobile_companion/battery_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/connection_state_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';
import 'package:hommie/features/mobile_companion/sensors_observer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sensors_provider.g.dart';

@riverpod
Future<List<Sensor>> sensorsList(Ref ref) {
  var sensorObserver = SensorObserver(
    providers: [
      BatterySensorProvider(),
      ConnectionStateProvider(),
    ],
    onNewData: () => ref.invalidateSelf(),
  );

  return sensorObserver.observe();
}
