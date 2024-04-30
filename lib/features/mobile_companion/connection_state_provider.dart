import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hommie/core/core.dart';
import 'package:hommie/features/mobile_companion/i_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/connection_type.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';
import 'package:hommie/features/mobile_companion/sensors/ssid.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ConnectionStateProvider implements ISensorProvider {
  late final Connectivity _connectivity;
  late final NetworkInfo _netwokInfo;

  ConnectionStateProvider()
      : _connectivity = Connectivity(),
        _netwokInfo = NetworkInfo();

  @override
  Future<List<Sensor>> provideSensorsState() async {
    final connectivityResult = await _connectivity.checkConnectivity();

    var connectionState = ConnectionType();

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      connectionState
        ..state = "Cellular"
        ..icon = "mdi:signal";
    }
    // When both mobile and Wi-Fi are turned on return Wi-Fi only as active network type
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      connectionState
        ..state = "Wi-Fi"
        ..icon = "mdi:wifi";
    }

    var ssid = SSID();
    final wifiName = await _netwokInfo.getWifiName();
    if (wifiName != null) {
      ssid.state = wifiName;
    } else {
      ssid
        ..state = "Not connected"
        ..icon = "mdi:wifi-off";
    }

    return [connectionState, ssid];
  }

  @override
  void onChange(VoidCallback callback) {
    _connectivity.onConnectivityChanged.listen((event) {
      callback();
    });
  }
}
