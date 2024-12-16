import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

class BatteryLevel extends Sensor {
  BatteryLevel()
      : super(
          uniqueId: 'battery_level',
          name: 'Battery level',
          state: null,
        ) {
    icon = 'mdi:battery';
    deviceClass = 'battery';
    unitOfMeasurement = '%';
  }
}
