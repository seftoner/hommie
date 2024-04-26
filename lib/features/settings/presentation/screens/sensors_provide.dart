import 'package:hommie/features/mobile_companion/battery_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/connection_state_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';
import 'package:hommie/features/mobile_companion/sensors_observer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sensors_provide.g.dart';

@riverpod
Future<List<Sensor>> sensorsList(SensorsListRef ref) {
  var sensorObserver = SensorObserver(providers: [
    BatterySensorProvider(),
    ConnectionStateProvider(),
  ]);
  return sensorObserver.observe();
}
