import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

class ConnectionType extends Sensor {
  ConnectionType()
      : super(
          uniqueId: 'connection_type',
          name: 'Connection type',
          state: null,
        ) {
    icon = 'mdi:signal';
  }
}
