import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/networking/connection/ha_connection_factory.dart';
import 'package:hommie/core/infrastructure/networking/connection/i_server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_link_state_provider.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:oauth2/oauth2.dart';

class _FakeConnection implements IHAConnection {
  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) => Future.value(null);

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    return HASubscription(logger: const NoOpLogger(), unsubscribe: () async {});
  }
}

class _FakeConnectionManager implements IServerConnectionManager {
  int? activeServerId;
  int getConnectionCalls = 0;
  final activeServerIds = <int?>[];

  @override
  void setActiveServer(int? serverId) {
    activeServerId = serverId;
    activeServerIds.add(serverId);
  }

  @override
  Future<IHAConnection> getConnection(int serverId) {
    getConnectionCalls += 1;
    throw UnimplementedError('ActiveServerSession must not open connections');
  }

  @override
  void disconnect(int serverId) {}
}

class _NeverCompletingConnectionFactory implements IHAConnectionFactory {
  int opens = 0;

  @override
  HAConnectionOpening open(int serverId) {
    opens += 1;
    final completer = Completer<ManagedHAConnection>();
    return HAConnectionOpening(
      future: completer.future,
      close: () async {
        if (!completer.isCompleted) {
          completer.completeError(const ConnectionOpenCancelled());
        }
      },
    );
  }
}

class _FakeServerManager implements IServerManager {
  _FakeServerManager(this.activeServer);

  Server? activeServer;
  final _activeServerController = StreamController<Server?>.broadcast();

  @override
  Future<Server> addServer(Server config) async => config;

  @override
  Future<Server?> getActiveServer() async => activeServer;

  @override
  Future<List<Server>> getServers() async {
    return [if (activeServer != null) activeServer!];
  }

  @override
  Stream<Server?> watchActiveServer() => _activeServerController.stream;

  @override
  Future<Server?> activateServer(int id) async => activeServer;

  @override
  Future<Server?> activateNextServer({int? excludingId}) async => activeServer;

  @override
  Future<void> removeServer(int id, {bool allowRemovingLast = false}) async {
    activeServer = null;
    _activeServerController.add(activeServer);
  }

  void emitActiveServer(Server? server) {
    activeServer = server;
    _activeServerController.add(server);
  }

  void dispose() {
    _activeServerController.close();
  }
}

void main() {
  const server = Server(id: 1, name: 'Home');

  Credentials credentials() {
    return Credentials(
      'access',
      refreshToken: 'refresh',
      expiration: DateTime.now().add(const Duration(days: 1)),
      tokenEndpoint: Uri.parse('http://example.test/auth/token'),
    );
  }

  ProviderContainer makeContainer({
    required Server? activeServer,
    required AuthState authState,
    _FakeConnectionManager? connectionManager,
    _FakeServerManager? serverManager,
  }) {
    final manager = connectionManager ?? _FakeConnectionManager();
    final servers = serverManager ?? _FakeServerManager(activeServer);
    if (serverManager == null) {
      addTearDown(servers.dispose);
    }

    return ProviderContainer(
      overrides: [
        serverManagerProvider.overrideWithValue(servers),
        authStateProvider.overrideWith((_) => authState),
        serverConnectionManagerProvider.overrideWithValue(manager),
      ],
    );
  }

  Future<ActiveServerSessionState> waitForSession(
    ProviderContainer container,
    bool Function(ActiveServerSessionState state) matches,
  ) async {
    for (var i = 0; i < 100; i += 1) {
      final state = container.read(activeServerSessionProvider);
      if (matches(state)) {
        return state;
      }
      await container.pump();
      await Future<void>.delayed(Duration.zero);
    }

    final state = container.read(activeServerSessionProvider);
    final activeServer = container.read(activeServerProvider);
    final authState = container.read(authStateProvider);
    fail(
      'Timed out waiting for session. '
      'state: $state, activeServer: $activeServer, authState: $authState',
    );
  }

  Future<ActiveServerSessionState> readSession(
    ProviderContainer container,
  ) async {
    final activeServerSubscription = container.listen(
      activeServerProvider,
      (_, _) {},
    );
    try {
      await container.read(activeServerProvider.future);
      return waitForSession(
        container,
        (state) => state is! ResolvingServerSession,
      );
    } finally {
      activeServerSubscription.close();
    }
  }

  test('emits no active session when no server exists', () async {
    final manager = _FakeConnectionManager();
    final container = makeContainer(
      activeServer: null,
      authState: const AuthState.unauthenticated(),
      connectionManager: manager,
    );
    addTearDown(container.dispose);

    final state = await readSession(container);

    expect(state, isA<NoActiveServerSession>());
    expect(manager.activeServerId, isNull);
  });

  test('maps authenticated idle link to connecting session', () async {
    final manager = _FakeConnectionManager();
    final container = makeContainer(
      activeServer: server,
      authState: AuthState.authenticated(credentials()),
      connectionManager: manager,
    );
    addTearDown(container.dispose);

    final state = await readSession(container);

    expect(state, isA<ConnectingServerSession>());
    expect((state as ConnectingServerSession).activeServer, server);
    expect(manager.activeServerId, 1);
  });

  test(
    'initializing authenticated session starts connection without provider mutation assertion',
    () async {
      final factory = _NeverCompletingConnectionFactory();
      final serverManager = _FakeServerManager(server);
      late final ServerConnectionManagerImpl connectionManager;
      final container = ProviderContainer(
        overrides: [
          serverManagerProvider.overrideWithValue(serverManager),
          authStateProvider.overrideWith(
            (_) => AuthState.authenticated(credentials()),
          ),
          serverConnectionManagerProvider.overrideWith((ref) {
            final linkState = ref.read(serverLinkStateProvider.notifier);
            connectionManager = ServerConnectionManagerImpl(
              factory: factory,
              setLinkState: linkState.set,
              resetLinkState: linkState.reset,
            );
            ref.onDispose(connectionManager.dispose);
            return connectionManager;
          }),
        ],
      );
      addTearDown(serverManager.dispose);
      addTearDown(container.dispose);

      final state = await readSession(container);

      expect(state, isA<ConnectingServerSession>());
      expect(factory.opens, 1);
    },
  );

  test('maps authenticated connecting link to connecting session', () async {
    final manager = _FakeConnectionManager();
    final container = makeContainer(
      activeServer: server,
      authState: AuthState.authenticated(credentials()),
      connectionManager: manager,
    );
    addTearDown(container.dispose);
    container
        .read(serverLinkStateProvider.notifier)
        .set(const LinkConnecting(serverId: 1));

    final state = await readSession(container);

    expect(state, isA<ConnectingServerSession>());
    expect((state as ConnectingServerSession).activeServer, server);
    expect(manager.activeServerId, 1);
  });

  test(
    'maps authenticated online link to online session with link connection',
    () async {
      final manager = _FakeConnectionManager();
      final connection = _FakeConnection();
      final container = makeContainer(
        activeServer: server,
        authState: AuthState.authenticated(credentials()),
        connectionManager: manager,
      );
      addTearDown(container.dispose);
      container
          .read(serverLinkStateProvider.notifier)
          .set(LinkOnline(serverId: 1, connection: connection));

      final state = await readSession(container);

      expect(state, isA<OnlineServerSession>());
      expect((state as OnlineServerSession).activeServer, server);
      expect(state.connection, same(connection));
      expect(manager.activeServerId, 1);
    },
  );

  test('maps authenticated reconnecting link to offline session', () async {
    final manager = _FakeConnectionManager();
    final container = makeContainer(
      activeServer: server,
      authState: AuthState.authenticated(credentials()),
      connectionManager: manager,
    );
    addTearDown(container.dispose);
    container
        .read(serverLinkStateProvider.notifier)
        .set(const LinkReconnecting(serverId: 1));

    final state = await readSession(container);

    expect(state, isA<OfflineServerSession>());
    expect((state as OfflineServerSession).activeServer, server);
    expect(state.cause, isNull);
    expect(manager.activeServerId, 1);
  });

  test(
    'maps authenticated offline link to offline session with cause',
    () async {
      final manager = _FakeConnectionManager();
      final cause = StateError('network down');
      final container = makeContainer(
        activeServer: server,
        authState: AuthState.authenticated(credentials()),
        connectionManager: manager,
      );
      addTearDown(container.dispose);
      container
          .read(serverLinkStateProvider.notifier)
          .set(LinkOffline(serverId: 1, cause: cause));

      final state = await readSession(container);

      expect(state, isA<OfflineServerSession>());
      expect((state as OfflineServerSession).activeServer, server);
      expect(state.cause, same(cause));
      expect(manager.activeServerId, 1);
    },
  );

  test('maps authenticated auth-failed link to revoked session', () async {
    final manager = _FakeConnectionManager();
    final container = makeContainer(
      activeServer: server,
      authState: AuthState.authenticated(credentials()),
      connectionManager: manager,
    );
    addTearDown(container.dispose);
    container
        .read(serverLinkStateProvider.notifier)
        .set(const LinkAuthFailed(serverId: 1));

    final state = await readSession(container);

    expect(state, isA<AuthRevokedServerSession>());
    expect((state as AuthRevokedServerSession).activeServer, server);
    expect(manager.activeServerId, 1);
  });

  test(
    'revoked auth state maps to revoked session without cleanup side effects',
    () async {
      final manager = _FakeConnectionManager();
      final container = makeContainer(
        activeServer: server,
        authState: const AuthState.revoked(),
        connectionManager: manager,
      );
      addTearDown(container.dispose);

      final state = await readSession(container);

      expect(state, isA<AuthRevokedServerSession>());
      expect((state as AuthRevokedServerSession).activeServer, server);
      expect(manager.activeServerId, 1);
    },
  );

  test(
    'unauthenticated auth state clears active server and maps to no active session',
    () async {
      final manager = _FakeConnectionManager();
      final container = makeContainer(
        activeServer: server,
        authState: const AuthState.unauthenticated(),
        connectionManager: manager,
      );
      addTearDown(container.dispose);

      final state = await readSession(container);

      expect(state, isA<NoActiveServerSession>());
      expect(manager.activeServerId, isNull);
    },
  );

  test('does not call getConnection while projecting online session', () async {
    final manager = _FakeConnectionManager();
    final connection = _FakeConnection();
    final container = makeContainer(
      activeServer: server,
      authState: AuthState.authenticated(credentials()),
      connectionManager: manager,
    );
    addTearDown(container.dispose);
    container
        .read(serverLinkStateProvider.notifier)
        .set(LinkOnline(serverId: 1, connection: connection));

    final state = await readSession(container);

    expect(state, isA<OnlineServerSession>());
    expect((state as OnlineServerSession).connection, same(connection));
    expect(manager.getConnectionCalls, 0);
  });

  test('link state changes reproject session', () async {
    final manager = _FakeConnectionManager();
    final connection = _FakeConnection();
    final container = makeContainer(
      activeServer: server,
      authState: AuthState.authenticated(credentials()),
      connectionManager: manager,
    );
    addTearDown(container.dispose);

    final connecting = await readSession(container);
    expect(connecting, isA<ConnectingServerSession>());

    container
        .read(serverLinkStateProvider.notifier)
        .set(LinkOnline(serverId: 1, connection: connection));
    await container.pump();
    final online = container.read(activeServerSessionProvider);

    expect(online, isA<OnlineServerSession>());
    expect((online as OnlineServerSession).connection, same(connection));
    expect(manager.getConnectionCalls, 0);
  });

  test(
    'stale online link from previous server projects new server connecting',
    () async {
      const nextServer = Server(id: 2, name: 'Cabin');
      final serverManager = _FakeServerManager(server);
      addTearDown(serverManager.dispose);
      final connection = _FakeConnection();
      final container = makeContainer(
        activeServer: server,
        authState: AuthState.authenticated(credentials()),
        serverManager: serverManager,
      );
      addTearDown(container.dispose);
      final activeServerSubscription = container.listen(
        activeServerProvider,
        (_, _) {},
      );
      final sessionSubscription = container.listen(
        activeServerSessionProvider,
        (_, _) {},
      );
      addTearDown(activeServerSubscription.close);
      addTearDown(sessionSubscription.close);
      container
          .read(serverLinkStateProvider.notifier)
          .set(LinkOnline(serverId: 1, connection: connection));

      final online = await waitForSession(
        container,
        (state) => state is OnlineServerSession && state.server.id == 1,
      );
      expect(online, isA<OnlineServerSession>());

      serverManager.emitActiveServer(nextServer);
      container.invalidate(activeServerProvider);
      container.invalidate(activeServerSessionProvider);
      final switched = await waitForSession(
        container,
        (state) => state.server?.id == 2,
      );

      expect(switched, isA<ConnectingServerSession>());
      expect((switched as ConnectingServerSession).activeServer, nextServer);
    },
  );

  test(
    'stale offline link from previous server projects new server connecting',
    () async {
      const nextServer = Server(id: 2, name: 'Cabin');
      final serverManager = _FakeServerManager(server);
      addTearDown(serverManager.dispose);
      final container = makeContainer(
        activeServer: server,
        authState: AuthState.authenticated(credentials()),
        serverManager: serverManager,
      );
      addTearDown(container.dispose);
      final activeServerSubscription = container.listen(
        activeServerProvider,
        (_, _) {},
      );
      final sessionSubscription = container.listen(
        activeServerSessionProvider,
        (_, _) {},
      );
      addTearDown(activeServerSubscription.close);
      addTearDown(sessionSubscription.close);
      container
          .read(serverLinkStateProvider.notifier)
          .set(
            LinkOffline(serverId: 1, cause: StateError('old server offline')),
          );

      final offline = await waitForSession(
        container,
        (state) => state is OfflineServerSession && state.server.id == 1,
      );
      expect(offline, isA<OfflineServerSession>());

      serverManager.emitActiveServer(nextServer);
      container.invalidate(activeServerProvider);
      container.invalidate(activeServerSessionProvider);
      final switched = await waitForSession(
        container,
        (state) => state.server?.id == 2,
      );

      expect(switched, isA<ConnectingServerSession>());
      expect((switched as ConnectingServerSession).activeServer, nextServer);
    },
  );

  test(
    'stale auth failed link from previous server projects new server connecting',
    () async {
      const nextServer = Server(id: 2, name: 'Cabin');
      final serverManager = _FakeServerManager(server);
      addTearDown(serverManager.dispose);
      final container = makeContainer(
        activeServer: server,
        authState: AuthState.authenticated(credentials()),
        serverManager: serverManager,
      );
      addTearDown(container.dispose);
      final activeServerSubscription = container.listen(
        activeServerProvider,
        (_, _) {},
      );
      final sessionSubscription = container.listen(
        activeServerSessionProvider,
        (_, _) {},
      );
      addTearDown(activeServerSubscription.close);
      addTearDown(sessionSubscription.close);
      container
          .read(serverLinkStateProvider.notifier)
          .set(const LinkAuthFailed(serverId: 1));

      final revoked = await waitForSession(
        container,
        (state) => state is AuthRevokedServerSession && state.server.id == 1,
      );
      expect(revoked, isA<AuthRevokedServerSession>());

      serverManager.emitActiveServer(nextServer);
      container.invalidate(activeServerProvider);
      container.invalidate(activeServerSessionProvider);
      final switched = await waitForSession(
        container,
        (state) => state.server?.id == 2,
      );

      expect(switched, isA<ConnectingServerSession>());
      expect((switched as ConnectingServerSession).activeServer, nextServer);
    },
  );
}
