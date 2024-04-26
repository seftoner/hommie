import 'package:hommie/features/mobile_companion/i_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/battery_level.dart';
import 'package:hommie/features/mobile_companion/sensors/battery_state.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';
// ignore: library_prefixes
import 'package:battery_plus/battery_plus.dart' as BatteryPlus;

class BatterySensorProvider implements ISensorProvider {
  late final BatteryPlus.Battery _battery;

  BatterySensorProvider() : _battery = BatteryPlus.Battery();

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
