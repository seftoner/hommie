import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

abstract interface class ISensorsRepository {
  Future<List<Sensor>> readSensors();
  Stream<List<Sensor>> watchSensors();
  void dispose();
}
