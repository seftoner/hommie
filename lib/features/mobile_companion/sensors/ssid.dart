import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

class SSID extends Sensor {
  SSID()
      : super(
          uniqueId: "ssid",
          name: "SSID",
          state: null,
        ) {
    icon = "mdi:wifi";
  }
}
