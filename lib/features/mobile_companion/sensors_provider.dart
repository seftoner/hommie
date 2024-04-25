import 'package:battery_plus/battery_plus.dart' as BatteryPlus;

enum SensorType {
  binarySensor("binary_sensor"),
  sensor("sensor");

  final String type;

  const SensorType(this.type);

  @override
  toString() => type;
}

abstract class Sensor {
  ///An identifier unique to this installation of your app.
  ///You'll need this later.
  ///Usually best when its a safe version of the sensor name
  ///This is required.
  String uniqueId;

  ///The name of the sensor
  String name;

  ///The state of the sensor
  dynamic state;

  ///The type of the sensor. Must be one of `binary_sensor` or `sensor`
  SensorType type = SensorType.sensor;

  ///The unit of measurement for the sensor. Example: '%', ''
  late String unitOfMeasurement;

  late String stateClass = "measurement";

  ///Must be prefixed mdi:. If not provided, default value is `mdi:cellphone`
  late String icon;

  ///The entity category of the entity
  late dynamic entityCategory;

  ///Full list described here:
  ///https://www.home-assistant.io/integrations/sensor/#device-class
  late String deviceClass;

  ///If the entity should be enabled or disabled.
  bool isDisabled = true;

  ///Attributes to attach to the sensor
  late Map<String, dynamic> attributes;

  Sensor({required this.uniqueId, required this.name, this.state});
}

class BatteryLevel extends Sensor {
  BatteryLevel()
      : super(
          uniqueId: "battery_level",
          name: "Battery level",
          state: null,
        ) {
    icon = "mdi:battery";
    deviceClass = "battery";
    unitOfMeasurement = "%";
  }
}

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

abstract class SensorProvider {
  Future<List<Sensor>> provideSensorsState();
}

class BatterySensorProvide extends SensorProvider {
  late final BatteryPlus.Battery _battery;

  BatterySensorProvide() : _battery = BatteryPlus.Battery();

  @override
  Future<List<Sensor>> provideSensorsState() async {
    final batteryLevel = await _battery.batteryLevel;
    final batteryState = await _battery.batteryState;
    final isInBatterySaveMode = await _battery.isInBatterySaveMode;

    var batteryLevelSensor = BatteryLevel()..state = batteryLevel;

    var batteryStatelSensor = BatteryState()
      ..state = _entepretuerBatteryState(batteryState)
      ..attributes = {"Low Power Mode": isInBatterySaveMode};

    if (batteryState == BatteryPlus.BatteryState.charging) {
      batteryStatelSensor.icon = "mdi:battery-charging";
    }

    return [batteryLevelSensor, batteryStatelSensor];
  }

  String _entepretuerBatteryState(BatteryPlus.BatteryState state) {
    return switch (state) {
      BatteryPlus.BatteryState.full => "Fully charged",
      BatteryPlus.BatteryState.charging => "Charging",
      BatteryPlus.BatteryState.discharging => "Not charging",
      BatteryPlus.BatteryState.connectedNotCharging =>
        "Connected, but not charging",
      BatteryPlus.BatteryState.unknown => "Unknown",
    };
  }
}
