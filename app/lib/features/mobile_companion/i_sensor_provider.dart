import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

abstract interface class ISensorProvider {
  Future<List<Sensor>> provideSensorsState();
  Stream<List<Sensor>> watchSensors();
  void dispose();
}
