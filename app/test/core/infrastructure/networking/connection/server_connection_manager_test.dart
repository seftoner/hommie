import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/infrastructure/networking/connection/ha_connection_factory.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_link_state_provider.dart';

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
      retryNow: () => opening.openingRetryCalls += 1,
      setNetworkAvailable: ({required isAvailable}) =>
          opening.openingNetworkAvailability.add(isAvailable),
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
    opening.completer.complete(
      ManagedHAConnection(
        currentConnection: () => opening.currentConnection,
        currentState: opening.currentState,
        states: opening.stateController.stream,
        close: opening.currentConnection.close,
        retryNow: () => opening.managedRetryCalls += 1,
        setNetworkAvailable: ({required isAvailable}) =>
            opening.managedNetworkAvailability.add(isAvailable),
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
  _FakeConnection currentConnection = _FakeConnection();
  HASocketState currentState = const Authenticated();
  bool openingClosed = false;
  int openingRetryCalls = 0;
  int managedRetryCalls = 0;
  final openingNetworkAvailability = <bool>[];
  final managedNetworkAvailability = <bool>[];

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
    'setActiveServer opens the active server and publishes online when complete',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);

      expect(factory.opens, 1);
      expect(states, isEmpty);

      await Future<void>.delayed(Duration.zero);

      expect(states.single, isA<LinkConnecting>());
      expect(states.single.serverId, 1);

      factory.complete(1);
      await Future<void>.delayed(Duration.zero);

      expect(states.map((state) => state.runtimeType), [
        LinkConnecting,
        LinkOnline,
      ]);
      expect(states.map((state) => state.serverId), [1, 1]);
    },
  );

  test('getConnection rejects non-active server without opening', () async {
    final factory = _FakeFactory();
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setLinkState: (_) {},
      resetLinkState: () {},
    );

    await expectLater(manager.getConnection(1), throwsStateError);

    expect(factory.opens, 0);
  });

  test(
    'setActiveServer does not duplicate opens while in-flight or connected',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      manager.setActiveServer(1);

      expect(factory.opens, 1);
      await Future<void>.delayed(Duration.zero);

      factory.complete(1);
      await Future<void>.delayed(Duration.zero);
      manager.setActiveServer(1);

      expect(factory.opens, 1);
      expect(states.map((state) => state.runtimeType), [
        LinkConnecting,
        LinkOnline,
      ]);
    },
  );

  test(
    'reselecting same server before deferred reset replaces stale online link',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      await Future<void>.delayed(Duration.zero);
      factory.complete(1);
      await Future<void>.delayed(Duration.zero);
      final oldConnection = (states.last as LinkOnline).connection;

      manager.setActiveServer(null);
      manager.setActiveServer(1);

      await Future<void>.delayed(Duration.zero);

      expect(states.last, isA<LinkConnecting>());
      expect(states.last.serverId, 1);
      expect(factory.opens, 2);
      expect((oldConnection as _FakeConnection).closed, isTrue);

      factory.complete(1);
      await Future<void>.delayed(Duration.zero);

      final online = states.last as LinkOnline;
      expect(online.serverId, 1);
      expect(online.connection, isNot(same(oldConnection)));
    },
  );

  test(
    'shares one in-flight open for concurrent getConnection calls',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
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
        setLinkState: (_) {},
        resetLinkState: () {},
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
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      final future = manager.getConnection(1);
      factory.emit(1, const Authenticated());
      factory.complete(1);

      final connection = await future;
      await Future<void>.delayed(Duration.zero);

      expect(states.map((state) => state.runtimeType), [
        LinkConnecting,
        LinkOnline,
      ]);
      expect(states.map((state) => state.serverId), [1, 1]);
      final state = states.last as LinkOnline;
      expect(state.serverId, 1);
      expect(state.connection, same(connection));
    },
  );

  test(
    'active server connecting socket state publishes connecting link state',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      final future = manager.getConnection(1);
      factory.emit(1, const Connecting());
      factory.complete(1);

      await future;
      factory.emit(1, const Authenticated());
      await Future<void>.delayed(Duration.zero);

      expect(states.map((state) => state.runtimeType), [
        LinkConnecting,
        LinkConnecting,
        LinkOnline,
      ]);
      expect(states.map((state) => state.serverId), [1, 1, 1]);
    },
  );

  test(
    'active server auth failure socket disconnect publishes auth failed and removes resource',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      final firstOpen = manager.getConnection(1);
      factory.complete(1);
      await firstOpen;

      factory.emit(1, const Disconnected(type: DisconnectionType.authFailure));
      await Future<void>.delayed(Duration.zero);

      expect(states.map((state) => state.runtimeType), [
        LinkConnecting,
        LinkOnline,
        LinkAuthFailed,
      ]);
      expect(states.map((state) => state.serverId), [1, 1, 1]);

      final secondOpen = manager.getConnection(1);

      expect(factory.opens, 2);
      factory.complete(1);
      await secondOpen;
    },
  );

  test(
    'active server normal socket disconnect publishes offline link state',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      final future = manager.getConnection(1);
      factory.complete(1);
      await future;

      factory.emit(1, const Disconnected());
      await Future<void>.delayed(Duration.zero);

      expect(states.map((state) => state.runtimeType), [
        LinkConnecting,
        LinkOnline,
        LinkOffline,
      ]);
      expect(states.map((state) => state.serverId), [1, 1, 1]);
    },
  );

  test('non-active server socket events do not publish link state', () async {
    final factory = _FakeFactory();
    final states = <ServerLinkState>[];
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setLinkState: states.add,
      resetLinkState: () => states.add(const LinkIdle()),
    );

    manager.setActiveServer(1);
    final future = manager.getConnection(1);
    factory.complete(1);
    await future;

    manager.setActiveServer(2);

    factory.emit(1, const Connecting());
    factory.emit(1, const Reconnecting());
    factory.emit(1, const Authenticated());
    factory.emit(1, const Disconnected());
    await Future<void>.delayed(Duration.zero);

    expect(states.map((state) => state.runtimeType), [
      LinkConnecting,
      LinkOnline,
      LinkConnecting,
    ]);
    expect(states.map((state) => state.serverId), [1, 1, 2]);
  });

  test('stale events from a disconnected resource are ignored', () async {
    final factory = _FakeFactory();
    final states = <ServerLinkState>[];
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setLinkState: states.add,
      resetLinkState: () => states.add(const LinkIdle()),
    );

    manager.setActiveServer(1);
    final first = manager.getConnection(1);
    factory.complete(1);
    await first;

    manager.disconnect(1);
    factory.emit(1, const Authenticated());

    expect(states.map((state) => state.runtimeType), [
      LinkConnecting,
      LinkOnline,
    ]);
    expect(states.map((state) => state.serverId), [1, 1]);

    await Future<void>.delayed(Duration.zero);

    expect(states.map((state) => state.runtimeType), [
      LinkConnecting,
      LinkOnline,
      LinkIdle,
    ]);
    expect(states.map((state) => state.serverId), [1, 1, null]);
  });

  test(
    'returns current managed connection after socket reconnect replaces it',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      final firstFuture = manager.getConnection(1);
      factory.complete(1);
      final first = await firstFuture;

      final opening = factory._latestOpening(1);
      final replacement = _FakeConnection();
      opening.currentConnection = replacement;
      factory.emit(1, const Reconnecting());
      factory.emit(1, const Authenticated());

      final second = await manager.getConnection(1);
      await Future<void>.delayed(Duration.zero);

      expect(second, same(replacement));
      expect(second, isNot(same(first)));
      expect(states.map((state) => state.runtimeType), [
        LinkConnecting,
        LinkOnline,
        LinkReconnecting,
        LinkOnline,
      ]);
      expect(states.map((state) => state.serverId), [1, 1, 1, 1]);
      final state = states.last as LinkOnline;
      expect(state.serverId, 1);
      expect(state.connection, same(replacement));
    },
  );

  test('switching active server cancels stale in-flight open', () async {
    final factory = _FakeFactory();
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setLinkState: (_) {},
      resetLinkState: () {},
    );

    manager.setActiveServer(1);
    final staleOpen = manager.getConnection(1);

    manager.setActiveServer(2);

    await expectLater(staleOpen, throwsA(isA<ConnectionOpenCancelled>()));
    expect(factory.openings.first.openingClosed, isTrue);
  });

  test(
    'cancelled stale same-server open does not publish disconnected',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
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

      expect(states, isNot(contains(isA<LinkOffline>())));
    },
  );

  test('clearing active server defers connection state reset', () async {
    final factory = _FakeFactory();
    final states = <ServerLinkState>[];
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setLinkState: states.add,
      resetLinkState: () => states.add(const LinkIdle()),
    );

    manager.setActiveServer(1);
    await Future<void>.delayed(Duration.zero);

    manager.setActiveServer(null);

    expect(states.map((state) => state.runtimeType), [LinkConnecting]);
    expect(states.single.serverId, 1);

    await Future<void>.delayed(Duration.zero);

    expect(states.map((state) => state.runtimeType), [
      LinkConnecting,
      LinkIdle,
    ]);
  });

  test('stale deferred reset is ignored after active server changes', () async {
    final factory = _FakeFactory();
    final states = <ServerLinkState>[];
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setLinkState: states.add,
      resetLinkState: () => states.add(const LinkIdle()),
    );

    manager.setActiveServer(1);
    manager.setActiveServer(null);
    manager.setActiveServer(2);

    await Future<void>.delayed(Duration.zero);

    expect(states.map((state) => state.runtimeType), [LinkConnecting]);
    expect(states.map((state) => state.serverId), [2]);
  });

  test(
    'stale deferred reset is ignored if same active server id returns',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      manager.disconnect(1);
      manager.setActiveServer(2);
      manager.setActiveServer(1);

      await Future<void>.delayed(Duration.zero);

      expect(states.map((state) => state.runtimeType), [LinkConnecting]);
      expect(states.map((state) => state.serverId), [1]);
    },
  );

  test(
    'auth errors during open publish auth failure for active server',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      final future = manager.getConnection(1);
      final futureExpectation = expectLater(
        future,
        throwsA(isA<AuthenticationError>()),
      );

      factory.fail(1, AuthenticationError('bad token'));

      await futureExpectation;
      expect(states.map((state) => state.runtimeType), [
        LinkConnecting,
        LinkAuthFailed,
      ]);
      expect(states.map((state) => state.serverId), [1, 1]);
    },
  );

  test(
    'pre-authentication transport failures publish disconnected for active server',
    () async {
      final factory = _FakeFactory();
      final states = <ServerLinkState>[];
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: states.add,
        resetLinkState: () => states.add(const LinkIdle()),
      );

      manager.setActiveServer(1);
      final future = manager.getConnection(1);
      final futureExpectation = expectLater(
        future,
        throwsA(isA<ConnectionError>()),
      );

      final error = ConnectionError('Connection closed before authentication');
      factory.fail(1, error);

      await futureExpectation;
      expect(states.map((state) => state.runtimeType), [
        LinkConnecting,
        LinkOffline,
      ]);
      expect(states.map((state) => state.serverId), [1, 1]);
      final state = states.last as LinkOffline;
      expect(state.serverId, 1);
      expect(state.cause, same(error));
    },
  );

  test('dispose closes pending opens', () async {
    final factory = _FakeFactory();
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setLinkState: (_) {},
      resetLinkState: () {},
    );

    manager.setActiveServer(1);
    final future = manager.getConnection(1);
    final futureExpectation = expectLater(
      future,
      throwsA(isA<ConnectionOpenCancelled>()),
    );

    manager.dispose();

    await futureExpectation;
    expect(factory.openings.single.openingClosed, isTrue);
  });

  test(
    'retryActiveConnection forwards retry to active managed connection',
    () async {
      final factory = _FakeFactory();
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: (_) {},
        resetLinkState: () {},
      );

      manager.setActiveServer(1);
      final future = manager.getConnection(1);
      factory.complete(1);
      await future;

      manager.retryActiveConnection();

      expect(factory.openings.single.managedRetryCalls, 1);
    },
  );

  test('retryActiveConnection forwards retry to in-flight opening', () {
    final factory = _FakeFactory();
    final manager = ServerConnectionManagerImpl(
      factory: factory,
      setLinkState: (_) {},
      resetLinkState: () {},
    );

    manager.setActiveServer(1);

    manager.retryActiveConnection();

    expect(factory.openings.single.openingRetryCalls, 1);
  });

  test(
    'setNetworkAvailable forwards network state to opening and resource',
    () async {
      final factory = _FakeFactory();
      final manager = ServerConnectionManagerImpl(
        factory: factory,
        setLinkState: (_) {},
        resetLinkState: () {},
      );

      manager.setActiveServer(1);
      final opening = factory.openings.single;

      manager.setNetworkAvailable(isAvailable: false);

      expect(opening.openingNetworkAvailability, [true, false]);

      final future = manager.getConnection(1);
      factory.complete(1);
      await future;

      expect(opening.managedNetworkAvailability, [false]);

      manager.setNetworkAvailable(isAvailable: true);

      expect(opening.managedNetworkAvailability, [false, true]);
    },
  );
}
