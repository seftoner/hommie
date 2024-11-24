import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

class BatteryState extends Sensor {
  BatteryState()
      : super(
          uniqueId: "battery_state",
          name: "Battery state",
          state: null,
        ) {
    icon = "mdi:battery";
  }
}
