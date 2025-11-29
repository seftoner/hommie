import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hommie/features/mobile_companion/i_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/connection_type.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';
import 'package:hommie/features/mobile_companion/sensors/ssid.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ConnectionStateProvider implements ISensorProvider {
  ConnectionStateProvider()
    : _connectivity = Connectivity(),
      _networkInfo = NetworkInfo();

  final Connectivity _connectivity;
  final NetworkInfo _networkInfo;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  StreamController<List<Sensor>>? _controller;

  @override
  Future<List<Sensor>> provideSensorsState() async {
    final connectivityResult = await _connectivity.checkConnectivity();

    final connectionState = ConnectionType();

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      connectionState
        ..state = 'Cellular'
        ..icon = 'mdi:signal';
    }
    // When both mobile and Wi-Fi are turned on return Wi-Fi only as active network type
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      connectionState
        ..state = 'Wi-Fi'
        ..icon = 'mdi:wifi';
    }
    if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      connectionState
        ..state = 'Ethernet'
        ..icon = 'mdi:ethernet-cable';
    }
    if (connectionState.state == null) {
      connectionState
        ..state = 'Offline'
        ..icon = 'mdi:wifi-off';
    }

    final ssid = SSID();
    final wifiName = await _networkInfo.getWifiName();
    if (wifiName != null) {
      ssid.state = wifiName;
    } else {
      ssid
        ..state = 'Not connected'
        ..icon = 'mdi:wifi-off';
    }

    return [connectionState, ssid];
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
    _subscription ??= _connectivity.onConnectivityChanged.listen(
      (_) => _emitSnapshot(),
    );
  }

  void _stopObservingIfNeeded() {
    if (_controller?.hasListener ?? false) {
      return;
    }
    _subscription?.cancel();
    _subscription = null;
  }

  Future<void> _emitSnapshot() async {
    final sensors = await provideSensorsState();
    if (!(_controller?.isClosed ?? true)) {
      _controller?.add(sensors);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _controller?.close();
    _controller = null;
  }
}
