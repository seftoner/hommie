import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/session/network_reconnect_supervisor.dart';
import 'package:hommie/core/domain/repositories/i_network_reachability_repository.dart';
import 'package:hommie/core/infrastructure/networking/connection/i_server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/network_reachability_provider.dart';

class _FakeConnectionManager implements IServerConnectionManager {
  final networkAvailability = <bool>[];
  int retryCalls = 0;

  @override
  void disconnect(int serverId) {}

  @override
  Future<IHAConnection> getConnection(int serverId) {
    throw UnimplementedError();
  }

  @override
  void retryActiveConnection() {
    retryCalls += 1;
  }

  @override
  void setActiveServer(int? serverId) {}

  @override
  void setNetworkAvailable({required bool isAvailable}) {
    networkAvailability.add(isAvailable);
  }
}

class _FakeNetworkReachability implements INetworkReachabilityRepository {
  _FakeNetworkReachability({required this.current});

  bool current;
  final controller = StreamController<bool>.broadcast();

  @override
  Stream<bool> get availability => controller.stream;

  @override
  Future<bool> get isAvailable async => current;

  void emit({required bool isAvailable}) {
    current = isAvailable;
    controller.add(isAvailable);
  }

  Future<void> dispose() => controller.close();
}

void main() {
  test(
    'publishes initial network availability to connection manager',
    () async {
      final manager = _FakeConnectionManager();
      final reachability = _FakeNetworkReachability(current: false);
      final container = ProviderContainer(
        overrides: [
          serverConnectionManagerProvider.overrideWithValue(manager),
          networkReachabilityProvider.overrideWithValue(reachability),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(reachability.dispose);

      container.read(networkReconnectSupervisorProvider);
      await Future<void>.delayed(Duration.zero);

      expect(manager.networkAvailability, [false]);
      expect(manager.retryCalls, 0);
    },
  );

  test('retries active connection when network returns', () async {
    final manager = _FakeConnectionManager();
    final reachability = _FakeNetworkReachability(current: false);
    final container = ProviderContainer(
      overrides: [
        serverConnectionManagerProvider.overrideWithValue(manager),
        networkReachabilityProvider.overrideWithValue(reachability),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(reachability.dispose);

    container.read(networkReconnectSupervisorProvider);
    await Future<void>.delayed(Duration.zero);

    reachability.emit(isAvailable: true);
    await Future<void>.delayed(Duration.zero);

    expect(manager.networkAvailability, [false, true]);
    expect(manager.retryCalls, 1);
  });

  test('does not retry on repeated online events', () async {
    final manager = _FakeConnectionManager();
    final reachability = _FakeNetworkReachability(current: true);
    final container = ProviderContainer(
      overrides: [
        serverConnectionManagerProvider.overrideWithValue(manager),
        networkReachabilityProvider.overrideWithValue(reachability),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(reachability.dispose);

    container.read(networkReconnectSupervisorProvider);
    await Future<void>.delayed(Duration.zero);

    reachability.emit(isAvailable: true);
    await Future<void>.delayed(Duration.zero);

    expect(manager.networkAvailability, [true]);
    expect(manager.retryCalls, 0);
  });
}
