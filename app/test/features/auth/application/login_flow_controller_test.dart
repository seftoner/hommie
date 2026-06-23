import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart' as ha;
import 'package:hommie/core/infrastructure/networking/connection/i_server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/features/auth/application/login_flow_controller.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/domain/repositories/i_websocket_config_repository.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';
import 'package:oauth2/oauth2.dart';

void main() {
  test('rolls back temporary server when OAuth fails', () async {
    final serverManager = _FakeServerManager();
    final authRepository = _FakeAuthRepository(
      loginResult: left(const AuthFailure.server('login failed')),
    );
    final container = _container(
      serverManager: serverManager,
      authRepository: authRepository,
    );
    addTearDown(container.dispose);

    final controller = container.read(loginFlowControllerProvider);

    await expectLater(
      controller.login(
        ServerUrl('http://example.test'),
        handler: (_) async => const <String, String>{},
      ),
      throwsA(
        isA<LoginFlowException>().having(
          (error) => error.failure,
          'failure',
          const AuthFailure.server('login failed'),
        ),
      ),
    );

    expect(serverManager.removed, [1]);
    expect(serverManager.activated, isNull);
    expect(authRepository.signOutCalls, isEmpty);
  });

  test(
    'rolls back temporary server without throwing when user cancels OAuth',
    () async {
      final serverManager = _FakeServerManager();
      final authRepository = _FakeAuthRepository(
        loginResult: left(const AuthFailure.userBrake('cancelled')),
      );
      final container = _container(
        serverManager: serverManager,
        authRepository: authRepository,
      );
      addTearDown(container.dispose);

      final controller = container.read(loginFlowControllerProvider);

      await controller.login(
        ServerUrl('http://example.test'),
        handler: (_) async => const <String, String>{},
      );

      expect(serverManager.removed, [1]);
      expect(serverManager.activated, isNull);
      expect(authRepository.signOutCalls, isEmpty);
    },
  );

  test(
    'clears credentials and rolls back server when config fetch fails',
    () async {
      final serverManager = _FakeServerManager();
      final connectionManager = _FakeConnectionManager();
      final authRepository = _FakeAuthRepository(
        loginResult: right(_credentials()),
      );
      final container = _container(
        serverManager: serverManager,
        authRepository: authRepository,
        connectionManager: connectionManager,
        configRepository: _FakeConfigRepository(
          error: Exception('config failed'),
        ),
      );
      addTearDown(container.dispose);

      final controller = container.read(loginFlowControllerProvider);

      await expectLater(
        controller.login(
          ServerUrl('http://example.test'),
          handler: (_) async => const <String, String>{},
        ),
        throwsA(isA<Exception>()),
      );

      expect(authRepository.signOutCalls, [1]);
      expect(connectionManager.disconnectCalls, [1]);
      expect(serverManager.removed, [1]);
      expect(serverManager.activated, isNull);
    },
  );

  test(
    'updates server metadata and activates after successful login',
    () async {
      final serverManager = _FakeServerManager();
      final connectionManager = _FakeConnectionManager();
      final authRepository = _FakeAuthRepository(
        loginResult: right(_credentials()),
      );
      final configRepository = _FakeConfigRepository(config: _config());
      final container = _container(
        serverManager: serverManager,
        authRepository: authRepository,
        connectionManager: connectionManager,
        configRepository: configRepository,
      );
      addTearDown(container.dispose);

      final controller = container.read(loginFlowControllerProvider);

      await controller.login(
        ServerUrl('http://example.test'),
        handler: (_) async => const <String, String>{'code': 'abc'},
      );

      expect(authRepository.loginCalls.single.serverId, 1);
      expect(authRepository.loginCalls.single.serverUrl, 'http://example.test');
      expect(connectionManager.disconnectCalls, isEmpty);
      expect(serverManager.removed, isEmpty);
      expect(serverManager.activated, 1);
      expect(serverManager.added, hasLength(2));
      expect(serverManager.added.last.name, 'Kitchen');
      expect(serverManager.added.last.internalUrl, 'http://internal.test');
      expect(serverManager.added.last.externalUrl, 'https://external.test');
      expect(serverManager.added.last.version.toString(), '2026.6.1');
    },
  );
}

ProviderContainer _container({
  required _FakeServerManager serverManager,
  required _FakeAuthRepository authRepository,
  _FakeConnectionManager? connectionManager,
  _FakeConfigRepository? configRepository,
}) {
  return ProviderContainer(
    overrides: [
      serverManagerProvider.overrideWithValue(serverManager),
      authRepositoryProvider.overrideWithValue(authRepository),
      websocketConfigRepositoryProvider.overrideWith(
        (_, _) => configRepository ?? _FakeConfigRepository(config: _config()),
      ),
      serverConnectionManagerProvider.overrideWithValue(
        connectionManager ?? _FakeConnectionManager(),
      ),
    ],
  );
}

Credentials _credentials() {
  return Credentials(
    'access-token',
    refreshToken: 'refresh-token',
    tokenEndpoint: Uri.parse('http://example.test/auth/token'),
  );
}

ha.HassConfig _config() {
  return const ha.HassConfig(
    latitude: 0,
    longitude: 0,
    elevation: 0,
    radius: 100,
    unit_system: ha.UnitSystem(
      length: 'km',
      mass: 'kg',
      volume: 'L',
      temperature: 'C',
      pressure: 'Pa',
      wind_speed: 'm/s',
      accumulated_precipitation: 'mm',
    ),
    location_name: 'Kitchen',
    time_zone: 'UTC',
    components: [],
    config_dir: '/config',
    allowlist_external_dirs: [],
    allowlist_external_urls: [],
    version: '2026.6.1',
    config_source: 'storage',
    recovery_mode: false,
    safe_mode: false,
    state: ha.State.RUNNING,
    external_url: 'https://external.test',
    internal_url: 'http://internal.test',
    currency: 'USD',
    language: 'en',
  );
}

class _FakeServerManager implements IServerManager {
  int nextId = 1;
  final added = <Server>[];
  final removed = <int>[];
  int? activated;
  Server? active;

  @override
  Future<Server> addServer(Server config) async {
    final saved = Server(
      id: config.id ?? nextId++,
      name: config.name,
      baseUrl: config.baseUrl,
      internalUrl: config.internalUrl,
      externalUrl: config.externalUrl,
      version: config.version,
    );
    added.add(saved);
    return saved;
  }

  @override
  Future<void> removeServer(int id, {bool allowRemovingLast = false}) async {
    removed.add(id);
  }

  @override
  Future<Server?> activateServer(int id) async {
    activated = id;
    active = added.lastWhere((server) => server.id == id);
    return active;
  }

  @override
  Future<Server?> activateNextServer({int? excludingId}) async => null;

  @override
  Future<Server?> getActiveServer() async => active;

  @override
  Future<List<Server>> getServers() async => added;

  @override
  Stream<Server?> watchActiveServer() => const Stream.empty();
}

class _FakeAuthRepository implements IAuthRepository {
  _FakeAuthRepository({required this.loginResult});

  final Either<AuthFailure, Credentials> loginResult;
  final loginCalls = <_LoginCall>[];
  final signOutCalls = <int>[];

  @override
  Future<Either<AuthFailure, Credentials>> login({
    required int serverId,
    required String serverUrl,
    required Uri redirectUrl,
    required AuthResponseHandler handler,
  }) async {
    loginCalls.add(_LoginCall(serverId: serverId, serverUrl: serverUrl));
    return loginResult;
  }

  @override
  Future<Either<AuthFailure, Credentials>> getCredentials(int serverId) async {
    return loginResult;
  }

  @override
  Future<bool> isLoggedIn(int serverId) async => loginResult.isRight();

  @override
  Future<Either<AuthFailure, Unit>> signOut(int serverId) async {
    signOutCalls.add(serverId);
    return right(unit);
  }
}

class _FakeConnectionManager implements IServerConnectionManager {
  final disconnectCalls = <int>[];
  int? activeServerId;

  @override
  void disconnect(int serverId) {
    disconnectCalls.add(serverId);
  }

  @override
  Future<ha.IHAConnection> getConnection(int serverId) {
    throw UnimplementedError('Config repository is overridden in these tests.');
  }

  @override
  void setActiveServer(int? serverId) {
    activeServerId = serverId;
  }
}

class _LoginCall {
  const _LoginCall({required this.serverId, required this.serverUrl});

  final int serverId;
  final String serverUrl;
}

class _FakeConfigRepository implements IWebSocketConfigRepository {
  _FakeConfigRepository({this.config, this.error});

  final ha.HassConfig? config;
  final Exception? error;

  @override
  Future<ha.HassConfig> getConfig() async {
    final failure = error;
    if (failure != null) {
      throw failure;
    }
    return config!;
  }
}
