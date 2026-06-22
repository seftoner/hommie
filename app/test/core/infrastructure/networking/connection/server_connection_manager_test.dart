import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/ha_connection_factory.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';

class _FakeConnection implements IHAConnection {
  bool closed = false;

  @override
  Future<void> close() async {
    closed = true;
  }

  @override
  HAResponse sendMessage(HAMessage message) {
    return Future.value(null);
  }

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    return HASubscription(logger: const NoOpLogger(), unsubscribe: () async {});
  }
}

class _FakeFactory implements IHAConnectionFactory {
  int opens = 0;
  final completers = <int, Completer<ManagedHAConnection>>{};
  final stateControllers = <int, StreamController<HASocketState>>{};
  final connections = <int, _FakeConnection>{};

  @override
  Future<ManagedHAConnection> open(int serverId) {
    opens += 1;
    final completer = Completer<ManagedHAConnection>();
    completers[serverId] = completer;
    stateControllers[serverId] = StreamController<HASocketState>.broadcast();
    connections[serverId] = _FakeConnection();
    return completer.future;
  }

  void complete(int serverId) {
    final connection = connections[serverId]!;
    completers[serverId]!.complete(
      ManagedHAConnection(
        connection: connection,
        states: stateControllers[serverId]!.stream,
        close: connection.close,
      ),
    );
  }

  void emit(int serverId, HASocketState state) {
    stateControllers[serverId]!.add(state);
  }
}

void main() {
  test(
    'shares one in-flight open for concurrent getConnection calls',
    () async {
      final factory = _FakeFactory();
      final states = <HAServerConnectionState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setState: states.add,
        resetState: () => states.add(HAServerConnectionState.unknown),
      );

      manager.setActiveServer(1);
      final first = manager.getConnection(1);
      final second = manager.getConnection(1);

      expect(factory.opens, 1);
      factory.complete(1);

      expect(await first, same(await second));
    },
  );

  test(
    'disconnect closes the managed connection and clears cached resource',
    () async {
      final factory = _FakeFactory();
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setState: (_) {},
        resetState: () {},
      );

      manager.setActiveServer(1);
      final future = manager.getConnection(1);
      factory.complete(1);
      final connection = await future as _FakeConnection;

      manager.disconnect(1);

      expect(connection.closed, isTrue);
    },
  );

  test('stale events from a disconnected resource are ignored', () async {
    final factory = _FakeFactory();
    final states = <HAServerConnectionState>[];
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setState: states.add,
      resetState: () => states.add(HAServerConnectionState.unknown),
    );

    manager.setActiveServer(1);
    final first = manager.getConnection(1);
    factory.complete(1);
    await first;

    manager.disconnect(1);
    factory.emit(1, const Authenticated());

    expect(states, [HAServerConnectionState.unknown]);
  });

  test('switching active server cancels stale in-flight open', () async {
    final factory = _FakeFactory();
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setState: (_) {},
      resetState: () {},
    );

    manager.setActiveServer(1);
    final staleOpen = manager.getConnection(1);

    manager.setActiveServer(2);
    factory.complete(1);

    await expectLater(staleOpen, throwsA(isA<StateError>()));
    expect(factory.connections[1]!.closed, isTrue);
  });
}
