import 'package:hommie/core/core.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

abstract interface class ISensorProvider {
  Future<List<Sensor>> provideSensorsState();
  void onChange(VoidCallback callback);
}
