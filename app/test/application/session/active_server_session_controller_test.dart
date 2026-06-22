import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
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
  int opens = 0;
  final connection = _FakeConnection();

  @override
  void setActiveServer(int? serverId) {
    activeServerId = serverId;
  }

  @override
  Future<IHAConnection> getConnection(int serverId) async {
    opens += 1;
    return connection;
  }

  @override
  Future<void> reconnect(int serverId) async {}

  @override
  void disconnect(int serverId) {}
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

void main() {
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
    _FakeConnectionManager? connectionManager,
    _FakeAuthController? authController,
  }) {
    final manager = connectionManager ?? _FakeConnectionManager();
    final controller = authController ?? _FakeAuthController();

    return ProviderContainer(
      overrides: [
        serverManagerProvider.overrideWithValue(
          _FakeServerManager(activeServer),
        ),
        authStateProvider.overrideWith((_) async => authState),
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
}
