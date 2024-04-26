import 'package:hommie/features/mobile_companion/i_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

class SensorObserver {
  final List<ISensorProvider> _providers;

  SensorObserver({required List<ISensorProvider> providers})
      : _providers = providers;

  Future<List<Sensor>> observe() async {
    if (_providers.isEmpty) {
      throw AssertionError("Providers list is empty");
    }
    List<Sensor> resultList = [];
    for (var provider in _providers) {
      resultList.addAll(await provider.provideSensorsState());
    }
    return resultList;
  }
}
