import 'package:flutter/services.dart';
import 'package:hommie/core/core.dart';
import 'package:hommie/features/mobile_companion/i_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/battery_level.dart';
import 'package:hommie/features/mobile_companion/sensors/battery_state.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';
import 'package:battery_plus/battery_plus.dart' as battery_plus;
import 'package:hommie/core/utils/logger.dart';

class BatterySensorProvider implements ISensorProvider {
  late final battery_plus.Battery _battery;

  BatterySensorProvider() : _battery = battery_plus.Battery();

  @override
  Future<List<Sensor>> provideSensorsState() async {
    final List<Sensor> results = [];

    try {
      final batteryLevel = await _battery.batteryLevel;
      results.add(BatteryLevel()..state = batteryLevel);
    } on PlatformException catch (e) {
      logger.d(e);
    }

    final batteryState = await _battery.batteryState;
    final isInBatterySaveMode = await _battery.isInBatterySaveMode;

    final batteryStatelSensor = BatteryState()
      ..state = _entepretuerBatteryState(batteryState)
      ..attributes = {'Low Power Mode': isInBatterySaveMode};

    if (batteryState == battery_plus.BatteryState.charging) {
      batteryStatelSensor.icon = 'mdi:battery-charging';
    }
    results.add(batteryStatelSensor);

    return results;
  }

  String _entepretuerBatteryState(battery_plus.BatteryState state) {
    return switch (state) {
      battery_plus.BatteryState.full => 'Fully charged',
      battery_plus.BatteryState.charging => 'Charging',
      battery_plus.BatteryState.discharging => 'Not charging',
      battery_plus.BatteryState.connectedNotCharging =>
        'Connected, but not charging',
      battery_plus.BatteryState.unknown => 'Unknown',
    };
  }

  @override
  void onChange(VoidCallback callback) {
    _battery.onBatteryStateChanged.listen((event) {
      callback();
    });
  }
}
