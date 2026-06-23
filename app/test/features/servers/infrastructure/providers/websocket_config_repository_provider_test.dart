import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/ha_connection_factory.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_config_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';

void main() {
  test('declares scoped server config dependency', () {
    expect(
      websocketConfigRepositoryProvider.dependencies,
      contains(serverConfigProvider),
    );
  });

  test('keeps one-shot repository alive for deferred config fetch', () {
    expect(websocketConfigRepositoryProvider(3).isAutoDispose, isFalse);
  });

  test('closes one-shot connection after config response completes', () async {
    final factory = _FakeConnectionFactory();
    final repository = OneShotWebSocketConfigRepository(
      factory: factory,
      serverId: 3,
    );

    final configFuture = repository.getConfig();
    await Future<void>.delayed(Duration.zero);

    expect(factory.connection.sentMessage, isA<ConfigMessage>());
    expect(factory.closeCalls, 0);

    factory.connection.completeConfig();

    final config = await configFuture;
    expect(config.version, '2025.12.3');
    expect(factory.closeCalls, 1);
  });
}

class _FakeConnectionFactory implements IHAConnectionFactory {
  final connection = _DelayedConfigConnection();
  int closeCalls = 0;

  @override
  HAConnectionOpening open(int serverId) {
    return HAConnectionOpening(
      future: Future.value(
        ManagedHAConnection(
          currentConnection: () => connection,
          currentState: const Authenticated(),
          states: const Stream<HASocketState>.empty(),
          close: () async {
            closeCalls++;
          },
        ),
      ),
      close: () async {
        closeCalls++;
      },
    );
  }
}

class _DelayedConfigConnection implements IHAConnection {
  final _config = Completer<Map<String, dynamic>>();
  HAMessage? sentMessage;

  @override
  HAResponse sendMessage(HAMessage message) {
    sentMessage = message;
    return _config.future;
  }

  void completeConfig() {
    _config.complete({
      'latitude': 0.0,
      'longitude': 0.0,
      'elevation': 0.0,
      'radius': 100.0,
      'unit_system': {
        'length': 'km',
        'mass': 'g',
        'volume': 'L',
        'temperature': 'C',
        'pressure': 'Pa',
        'wind_speed': 'm/s',
        'accumulated_precipitation': 'mm',
      },
      'location_name': 'Home',
      'time_zone': 'Europe/Kiev',
      'components': <String>[],
      'config_dir': '/config',
      'allowlist_external_dirs': <String>[],
      'allowlist_external_urls': <String>[],
      'version': '2025.12.3',
      'config_source': 'storage',
      'recovery_mode': false,
      'safe_mode': false,
      'state': 'RUNNING',
      'currency': 'USD',
      'language': 'en',
    });
  }

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    return HASubscription(logger: const NoOpLogger(), unsubscribe: () async {});
  }

  @override
  Future<void> close() async {}
}
