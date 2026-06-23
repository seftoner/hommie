import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/i_server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:oauth2/oauth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/tests_logger.dart';

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
  _FakeConnectionManager({this.completeImmediately = true, this.error});

  final bool completeImmediately;
  final Object? error;
  int? activeServerId;
  int opens = 0;
  final connection = _FakeConnection();
  final pending = <Completer<IHAConnection>>[];

  @override
  void setActiveServer(int? serverId) {
    activeServerId = serverId;
  }

  @override
  Future<IHAConnection> getConnection(int serverId) {
    opens += 1;
    final failure = error;
    if (failure != null) {
      return Future.error(failure);
    }
    if (completeImmediately) {
      return Future.value(connection);
    }

    final completer = Completer<IHAConnection>();
    pending.add(completer);
    return completer.future;
  }

  @override
  Future<void> reconnect(int serverId) async {}

  @override
  void disconnect(int serverId) {}

  void completeNext() {
    pending.removeAt(0).complete(connection);
  }
}

class _FakeAuthController implements AuthController {
  final signedOutServerIds = <int>[];

  @override
  Ref get ref => throw UnimplementedError();

  @override
  Future<void> login(ServerUrl serverUrl) async {}

  @override
  Future<void> signOut(int serverId) async {
    signedOutServerIds.add(serverId);
  }
}

class _FakeServerManager implements IServerManager {
  _FakeServerManager(this.activeServer);

  Server? activeServer;

  @override
  Future<Server> addServer(Server config) async => config;

  @override
  Future<Server?> getActiveServer() async => activeServer;

  @override
  Future<List<Server>> getServers() async {
    return [if (activeServer != null) activeServer!];
  }

  @override
  Stream<Server?> watchActiveServer() => const Stream<Server?>.empty();

  @override
  Future<Server?> activateServer(int id) async => activeServer;

  @override
  Future<Server?> activateNextServer({int? excludingId}) async => activeServer;

  @override
  Future<void> removeServer(int id, {bool allowRemovingLast = false}) async {
    activeServer = null;
  }
}

class _AuthStateSource {
  _AuthStateSource(this.value);

  AuthState value;
}

void main() {
  logger = testLogger;

  const server = Server(id: 1, name: 'Home');

  Future<ActiveServerSessionState> waitForSession(
    ProviderContainer container,
    bool Function(ActiveServerSessionState state) matches,
  ) async {
    final activeServerSubscription = container.listen(
      activeServerProvider,
      (_, _) {},
    );
    try {
      for (var i = 0; i < 20; i += 1) {
        final state = container.read(activeServerSessionProvider);
        if (matches(state)) {
          return state;
        }
        await container.pump();
      }

      final state = container.read(activeServerSessionProvider);
      final activeServer = container.read(activeServerProvider);
      final managerActiveServer = await container
          .read(serverManagerProvider)
          .getActiveServer();
      final authState = container.read(authStateProvider);
      fail(
        'Timed out waiting for session state. '
        'Last state: $state, activeServer: $activeServer, '
        'managerActiveServer: $managerActiveServer, authState: $authState',
      );
    } finally {
      activeServerSubscription.close();
    }
  }

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
    _AuthStateSource? authStateSource,
    _FakeConnectionManager? connectionManager,
    _FakeAuthController? authController,
  }) {
    final manager = connectionManager ?? _FakeConnectionManager();
    final controller = authController ?? _FakeAuthController();
    final source = authStateSource ?? _AuthStateSource(authState);

    return ProviderContainer(
      overrides: [
        serverManagerProvider.overrideWithValue(
          _FakeServerManager(activeServer),
        ),
        authStateProvider.overrideWith((_) => source.value),
        serverConnectionManagerProvider.overrideWithValue(manager),
        authControllerProvider.overrideWithValue(controller),
      ],
    );
  }

  test('emits no active session when no server exists', () async {
    final manager = _FakeConnectionManager();
    final container = makeContainer(
      activeServer: null,
      authState: const AuthState.unauthenticated(),
      connectionManager: manager,
    );
    addTearDown(container.dispose);

    final state = await waitForSession(
      container,
      (state) => state is NoActiveServerSession,
    );

    expect(state, isA<NoActiveServerSession>());
    expect(manager.activeServerId, isNull);
    expect(manager.opens, 0);
  });

  test(
    'does not mutate connection state provider while building no-server session',
    () async {
      final container = ProviderContainer(
        overrides: [
          serverManagerProvider.overrideWithValue(_FakeServerManager(null)),
          authStateProvider.overrideWith(
            (_) => const AuthState.unauthenticated(),
          ),
          authControllerProvider.overrideWithValue(_FakeAuthController()),
        ],
      );
      addTearDown(container.dispose);
      final connectionStateSubscription = container.listen(
        serverConnectionStateProvider,
        (_, _) {},
      );
      addTearDown(connectionStateSubscription.close);

      final state = await waitForSession(
        container,
        (state) => state is NoActiveServerSession,
      );

      expect(state, isA<NoActiveServerSession>());
    },
  );

  test('opens active connection for authenticated active server', () async {
    final manager = _FakeConnectionManager();
    final container = makeContainer(
      activeServer: server,
      authState: AuthState.authenticated(credentials()),
      connectionManager: manager,
    );
    addTearDown(container.dispose);

    final state = await waitForSession(
      container,
      (state) => state is OnlineServerSession,
    );
    expect(state, isA<OnlineServerSession>());
    expect((state as OnlineServerSession).connection, same(manager.connection));
    expect(manager.activeServerId, 1);
    expect(manager.opens, 1);
  });

  test(
    'maps auth failure connection state to revoked session and signs out',
    () async {
      final authController = _FakeAuthController();
      final container = makeContainer(
        activeServer: server,
        authState: AuthState.authenticated(credentials()),
        authController: authController,
      );
      addTearDown(container.dispose);

      await waitForSession(container, (state) => state is OnlineServerSession);

      container.read(serverConnectionStateProvider.notifier).setAuthFailure();

      final state = await waitForSession(
        container,
        (state) => state is AuthRevokedServerSession,
      );
      expect(state, isA<AuthRevokedServerSession>());
      expect(authController.signedOutServerIds, [1]);
    },
  );

  test(
    'maps auth failure during open to revoked session and signs out',
    () async {
      final authController = _FakeAuthController();
      final manager = _FakeConnectionManager(
        error: AuthenticationError('bad token'),
      );
      final container = makeContainer(
        activeServer: server,
        authState: AuthState.authenticated(credentials()),
        connectionManager: manager,
        authController: authController,
      );
      addTearDown(container.dispose);

      final state = await waitForSession(
        container,
        (state) => state is AuthRevokedServerSession,
      );

      expect(state, isA<AuthRevokedServerSession>());
      expect(authController.signedOutServerIds, [1]);
    },
  );

  test(
    'maps token resolution failure during open to revoked session and signs out',
    () async {
      final authController = _FakeAuthController();
      final manager = _FakeConnectionManager(
        error: ConnectionError(
          'Failed to resolve token: AuthFailure.unauthenticated()',
        ),
      );
      final container = makeContainer(
        activeServer: server,
        authState: AuthState.authenticated(credentials()),
        connectionManager: manager,
        authController: authController,
      );
      addTearDown(container.dispose);

      final state = await waitForSession(
        container,
        (state) => state is AuthRevokedServerSession,
      );

      expect(state, isA<AuthRevokedServerSession>());
      expect(authController.signedOutServerIds, [1]);
    },
  );

  test(
    'maps pre-authentication transport failure to offline session without signing out',
    () async {
      final authController = _FakeAuthController();
      final manager = _FakeConnectionManager(
        error: ConnectionError('Connection closed before authentication'),
      );
      final container = makeContainer(
        activeServer: server,
        authState: AuthState.authenticated(credentials()),
        connectionManager: manager,
        authController: authController,
      );
      addTearDown(container.dispose);

      final state = await waitForSession(
        container,
        (state) => state is OfflineServerSession,
      );

      expect(state, isA<OfflineServerSession>());
      expect(authController.signedOutServerIds, isEmpty);
    },
  );

  test(
    'starts replacement open when same server authenticates again while old open is pending',
    () async {
      final manager = _FakeConnectionManager(completeImmediately: false);
      final authStateSource = _AuthStateSource(
        AuthState.authenticated(credentials()),
      );
      final container = makeContainer(
        activeServer: server,
        authState: authStateSource.value,
        authStateSource: authStateSource,
        connectionManager: manager,
      );
      addTearDown(container.dispose);

      await waitForSession(
        container,
        (state) => state is ConnectingServerSession,
      );
      expect(manager.opens, 1);

      authStateSource.value = const AuthState.unauthenticated();
      container.invalidate(authStateProvider);
      await waitForSession(
        container,
        (state) => state is NoActiveServerSession,
      );

      authStateSource.value = AuthState.authenticated(credentials());
      container.invalidate(authStateProvider);
      await waitForSession(
        container,
        (state) => state is ConnectingServerSession,
      );

      expect(manager.opens, 2);
    },
  );

  test('connected transport state restores online session', () async {
    final manager = _FakeConnectionManager();
    final container = makeContainer(
      activeServer: server,
      authState: AuthState.authenticated(credentials()),
      connectionManager: manager,
    );
    addTearDown(container.dispose);

    await waitForSession(container, (state) => state is OnlineServerSession);

    container.read(serverConnectionStateProvider.notifier).setDisconnected();
    await waitForSession(container, (state) => state is OfflineServerSession);

    container.read(serverConnectionStateProvider.notifier).setConnected();
    await waitForSession(container, (state) => state is OnlineServerSession);
  });

  test('revoked auth state signs out once', () async {
    final authController = _FakeAuthController();
    final authStateSource = _AuthStateSource(const AuthState.revoked());
    final container = makeContainer(
      activeServer: server,
      authState: authStateSource.value,
      authStateSource: authStateSource,
      authController: authController,
    );
    addTearDown(container.dispose);

    await waitForSession(
      container,
      (state) => state is AuthRevokedServerSession,
    );
    await container.pump();

    authStateSource.value = const AuthState.revoked();
    container.invalidate(authStateProvider);
    await container.pump();

    expect(authController.signedOutServerIds, [1]);
  });
}
