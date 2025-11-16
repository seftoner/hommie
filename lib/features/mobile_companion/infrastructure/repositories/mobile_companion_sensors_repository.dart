import 'dart:async';

import 'package:hommie/features/mobile_companion/domain/repositories/i_sensors_repository.dart';
import 'package:hommie/features/mobile_companion/i_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';

class MobileCompanionSensorsRepository implements ISensorsRepository {
  MobileCompanionSensorsRepository({required List<ISensorProvider> providers})
    : _providers = providers;

  final List<ISensorProvider> _providers;
  final StreamController<List<Sensor>> _controller =
      StreamController<List<Sensor>>.broadcast();
  final List<StreamSubscription<List<Sensor>>> _subscriptions = [];
  final Map<ISensorProvider, List<Sensor>> _latestByProvider = {};
  bool _hasSeededStream = false;
  bool _isDisposed = false;

  @override
  Future<List<Sensor>> readSensors() async {
    final snapshots = await Future.wait(
      _providers.map((provider) => provider.provideSensorsState()),
    );
    for (var i = 0; i < _providers.length; i++) {
      _latestByProvider[_providers[i]] = snapshots[i];
    }
    return snapshots.expand((sensors) => sensors).toList(growable: false);
  }

  @override
  Stream<List<Sensor>> watchSensors() {
    _ensureProviderStreams();
    if (!_hasSeededStream) {
      _hasSeededStream = true;
      unawaited(_emitFullSnapshot());
    }
    return _controller.stream;
  }

  void _ensureProviderStreams() {
    if (_subscriptions.isNotEmpty) {
      return;
    }
    for (final provider in _providers) {
      final subscription = provider.watchSensors().listen(
        (sensors) => _handleProviderUpdate(provider, sensors),
        onError: (error, stackTrace) {
          if (_isDisposed) {
            return;
          }
          _controller.addError(error, stackTrace);
        },
      );
      _subscriptions.add(subscription);
    }
  }

  Future<void> _emitFullSnapshot() async {
    if (_isDisposed) {
      return;
    }
    try {
      final sensors = await readSensors();
      if (_isDisposed) {
        return;
      }
      _controller.add(List<Sensor>.unmodifiable(sensors));
    } catch (error, stackTrace) {
      if (_isDisposed) {
        return;
      }
      _controller.addError(error, stackTrace);
    }
  }

  void _handleProviderUpdate(ISensorProvider provider, List<Sensor> sensors) {
    if (_isDisposed) {
      return;
    }
    _latestByProvider[provider] = sensors;
    final combined = _providers
        .map((p) => _latestByProvider[p] ?? const <Sensor>[])
        .expand((sensors) => sensors)
        .toList(growable: false);
    _controller.add(List<Sensor>.unmodifiable(combined));
  }

  @override
  void dispose() {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    for (final provider in _providers) {
      provider.dispose();
    }
    _controller.close();
    _subscriptions.clear();
    _latestByProvider.clear();
  }
}
