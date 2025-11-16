import 'dart:async';

import 'package:battery_plus/battery_plus.dart' as battery_plus;
import 'package:flutter/services.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/mobile_companion/i_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/battery_level.dart';
import 'package:hommie/features/mobile_companion/sensors/battery_state.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

class BatterySensorProvider implements ISensorProvider {
  BatterySensorProvider() : _battery = battery_plus.Battery();

  final battery_plus.Battery _battery;
  StreamSubscription<battery_plus.BatteryState>? _stateSubscription;
  StreamController<List<Sensor>>? _controller;

  @override
  Future<List<Sensor>> provideSensorsState() async {
    final List<Sensor> results = [];

    try {
      final batteryLevel = await _battery.batteryLevel;
      results.add(BatteryLevel()..state = batteryLevel);
    } on PlatformException catch (e, stackTrace) {
      logger.d('Failed to fetch battery level: $e\n$stackTrace');
    }

    final batteryState = await _battery.batteryState;
    final isInBatterySaveMode = await _battery.isInBatterySaveMode;

    final batteryStateSensor = BatteryState()
      ..state = _interpretBatteryState(batteryState)
      ..attributes = {'Low Power Mode': isInBatterySaveMode};

    if (batteryState == battery_plus.BatteryState.charging) {
      batteryStateSensor.icon = 'mdi:battery-charging';
    }
    results.add(batteryStateSensor);

    return results;
  }

  @override
  Stream<List<Sensor>> watchSensors() {
    _controller ??= StreamController<List<Sensor>>.broadcast(
      onListen: _startObserving,
      onCancel: _stopObservingIfNeeded,
    );
    return _controller!.stream;
  }

  Future<void> _startObserving() async {
    await _emitSnapshot();
    _stateSubscription ??= _battery.onBatteryStateChanged.listen(
      (_) => _emitSnapshot(),
    );
  }

  void _stopObservingIfNeeded() {
    if (_controller?.hasListener ?? false) {
      return;
    }
    _stateSubscription?.cancel();
    _stateSubscription = null;
  }

  Future<void> _emitSnapshot() async {
    final sensors = await provideSensorsState();
    if (!(_controller?.isClosed ?? true)) {
      _controller?.add(sensors);
    }
  }

  String _interpretBatteryState(battery_plus.BatteryState state) {
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
  void dispose() {
    _stateSubscription?.cancel();
    _stateSubscription = null;
    _controller?.close();
    _controller = null;
  }
}
