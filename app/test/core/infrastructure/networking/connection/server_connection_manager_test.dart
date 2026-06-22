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
  final openings = <_FakeOpening>[];

  int get opens => openings.length;

  @override
  HAConnectionOpening open(int serverId) {
    final opening = _FakeOpening(serverId);
    openings.add(opening);
    return HAConnectionOpening(
      future: opening.completer.future,
      close: opening.close,
    );
  }

  void complete(int serverId) {
    completeOpening(_latestOpening(serverId));
  }

  void completeAt(int index) {
    completeOpening(openings[index]);
  }

  void fail(int serverId, Object error) {
    failOpening(_latestOpening(serverId), error);
  }

  void completeOpening(_FakeOpening opening) {
    final connection = opening.connection;
    opening.completer.complete(
      ManagedHAConnection(
        connection: connection,
        currentState: opening.currentState,
        states: opening.stateController.stream,
        close: connection.close,
      ),
    );
  }

  void failOpening(_FakeOpening opening, Object error) {
    opening.completer.completeError(error);
  }

  void emit(int serverId, HASocketState state) {
    emitOpening(_latestOpening(serverId), state);
  }

  void emitOpening(_FakeOpening opening, HASocketState state) {
    opening.currentState = state;
    opening.stateController.add(state);
  }

  _FakeOpening _latestOpening(int serverId) {
    return openings.lastWhere((opening) => opening.serverId == serverId);
  }
}

class _FakeOpening {
  _FakeOpening(this.serverId);

  final int serverId;
  final completer = Completer<ManagedHAConnection>();
  final stateController = StreamController<HASocketState>.broadcast();
  final connection = _FakeConnection();
  HASocketState currentState = const Authenticated();
  bool openingClosed = false;

  Future<void> close() async {
    openingClosed = true;
    if (!completer.isCompleted) {
      completer.completeError(const ConnectionOpenCancelled());
    }
    await stateController.close();
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

  test(
    'uses authenticated state emitted during open to mark active server connected',
    () async {
      final factory = _FakeFactory();
      final states = <HAServerConnectionState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setState: states.add,
        resetState: () => states.add(HAServerConnectionState.unknown),
      );

      manager.setActiveServer(1);
      final future = manager.getConnection(1);
      factory.emit(1, const Authenticated());
      factory.complete(1);

      await future;
      await Future<void>.delayed(Duration.zero);

      expect(states, [HAServerConnectionState.connected]);
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

    expect(states, [
      HAServerConnectionState.connected,
      HAServerConnectionState.unknown,
    ]);
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

    await expectLater(staleOpen, throwsA(isA<ConnectionOpenCancelled>()));
    expect(factory.openings.single.openingClosed, isTrue);
  });

  test(
    'cancelled stale same-server open does not publish disconnected',
    () async {
      final factory = _FakeFactory();
      final states = <HAServerConnectionState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setState: states.add,
        resetState: () => states.add(HAServerConnectionState.unknown),
      );

      manager.setActiveServer(1);
      final staleOpen = manager.getConnection(1);
      final staleOpenExpectation = expectLater(
        staleOpen,
        throwsA(isA<ConnectionOpenCancelled>()),
      );

      manager.disconnect(1);
      final replacementOpen = manager.getConnection(1);

      factory.completeAt(1);
      await replacementOpen;

      await staleOpenExpectation;

      expect(states, isNot(contains(HAServerConnectionState.disconnected)));
    },
  );

  test(
    'auth errors during open publish auth failure for active server',
    () async {
      final factory = _FakeFactory();
      final states = <HAServerConnectionState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setState: states.add,
        resetState: () => states.add(HAServerConnectionState.unknown),
      );

      manager.setActiveServer(1);
      final future = manager.getConnection(1);
      final futureExpectation = expectLater(
        future,
        throwsA(isA<AuthenticationError>()),
      );

      factory.fail(1, AuthenticationError('bad token'));

      await futureExpectation;
      expect(states, [HAServerConnectionState.authFailure]);
    },
  );

  test('dispose closes pending opens', () async {
    final factory = _FakeFactory();
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setState: (_) {},
      resetState: () {},
    );

    final future = manager.getConnection(1);
    final futureExpectation = expectLater(
      future,
      throwsA(isA<ConnectionOpenCancelled>()),
    );

    manager.dispose();

    await futureExpectation;
    expect(factory.openings.single.openingClosed, isTrue);
  });
}
