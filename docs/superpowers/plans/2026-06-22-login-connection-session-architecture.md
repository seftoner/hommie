# Login Connection Session Architecture Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Consolidate login, active-server websocket lifecycle, connection state, and initial registry sync behind a single active-session boundary so feature controllers do not watch raw connection state.

**Architecture:** The implementation introduces an idempotent connection resource, an `ActiveServerSessionController`, and a `ServerSyncCoordinator`. Feature providers consume session/sync summaries and cached repositories instead of directly reading `serverConnectionStateProvider`.

**Tech Stack:** Flutter, Riverpod 3 codegen, Dart sealed classes, existing `home_assistant_websocket` package, Drift repositories, Patrol integration tests.

---

## File Structure

**Connection lifecycle:**
- Modify: `app/lib/core/infrastructure/networking/connection/i_server_connection_manager.dart` - return `IHAConnection` and keep active connection operations narrow.
- Create: `app/lib/core/infrastructure/networking/connection/managed_ha_connection.dart` - testable wrapper around a connection, state stream, and close callback.
- Create: `app/lib/core/infrastructure/networking/connection/ha_connection_factory.dart` - default factory that builds `ConnectionOrchestrator`.
- Modify: `app/lib/core/infrastructure/networking/connection/server_connection_manager.dart` - use the factory, memoize in-flight opens, ignore stale events.
- Test: `app/test/core/infrastructure/networking/connection/server_connection_manager_test.dart`.

**Session boundary:**
- Create: `app/lib/application/session/active_server_session_state.dart` - sealed session states.
- Create: `app/lib/application/session/active_server_session_controller.dart` - active-session owner.
- Generated: `app/lib/application/session/active_server_session_controller.g.dart`.
- Modify: `app/lib/app.dart` - watch active session instead of legacy session coordinator.
- Modify: `app/lib/application/scopes/server_scope_host.dart` - scope from active session instead of opening a connection.
- Test: `app/test/application/session/active_server_session_controller_test.dart`.
- Test: `app/test/application/scopes/server_scope_host_test.dart`.

**Sync coordination:**
- Create: `app/lib/application/session/server_sync_state.dart` - sealed sync states.
- Create: `app/lib/application/session/server_sync_coordinator.dart` - public sync owner.
- Generated: `app/lib/application/session/server_sync_coordinator.g.dart`.
- Modify: `app/lib/features/areas/application/area_registry_sync_controller.dart` - stop using as public screen dependency; keep logic only if reused privately.
- Modify: `app/lib/features/entities/application/entity_registry_sync_controller.dart` - stop using as public screen dependency; keep logic only if reused privately.
- Test: `app/test/application/session/server_sync_coordinator_test.dart`.

**Feature cleanup:**
- Modify: `app/lib/features/home/application/home_page_controller.dart`.
- Modify: `app/lib/features/home/presentation/screens/home_page.dart`.
- Modify: `app/lib/features/entities/application/entity_states_provider.dart`.
- Modify: `app/lib/features/entities/application/entity_service_controller.dart`.
- Modify: `app/lib/features/settings/application/hub_status_provider.dart`.
- Modify: `app/lib/ui/screens/widgets/offline_container.dart`.
- Tests:
  - `app/test/features/home/home_page_controller_test.dart`
  - `app/test/features/entities/application/entity_states_provider_test.dart`
  - `app/test/features/entities/application/entity_service_controller_test.dart`
  - `app/test/features/settings/application/hub_status_provider_test.dart`

**Login transaction:**
- Create: `app/lib/features/auth/application/login_flow_controller.dart`.
- Generated: `app/lib/features/auth/application/login_flow_controller.g.dart`.
- Modify: `app/lib/features/auth/application/auth_controller.dart` - delegate login to `LoginFlowController`, keep sign-out.
- Test: `app/test/features/auth/application/login_flow_controller_test.dart`.

**Integration readiness:**
- Modify: `app/integration_test/test_bundle.dart`.
- Modify: `docker/scripts/hass-init.py`.
- Modify: `app/integration_test/step/i_have_successfully_logged_in.dart`.
- Create: `app/integration_test/step/i_see_light_card.dart`.
- Create: `app/integration_test/step/i_do_not_see_home_loading_spinner.dart`.
- Modify: `app/integration_test/authorization.feature`.
- Modify: `app/integration_test/offline_banner.feature`.
- Regenerate generated BDD files if the repo's BDD generator is available; otherwise update generated Dart test files by mirroring feature edits.

---

## Task 1: Make Active Connection Acquisition Idempotent

**Files:**
- Create: `app/lib/core/infrastructure/networking/connection/managed_ha_connection.dart`
- Create: `app/lib/core/infrastructure/networking/connection/ha_connection_factory.dart`
- Modify: `app/lib/core/infrastructure/networking/connection/i_server_connection_manager.dart`
- Modify: `app/lib/core/infrastructure/networking/connection/server_connection_manager.dart`
- Test: `app/test/core/infrastructure/networking/connection/server_connection_manager_test.dart`

- [ ] **Step 1: Write the failing manager tests**

Create `app/test/core/infrastructure/networking/connection/server_connection_manager_test.dart`:

```dart
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
  test('shares one in-flight open for concurrent getConnection calls', () async {
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
  });

  test('disconnect closes the managed connection and clears cached resource', () async {
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
  });

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
}
```

- [ ] **Step 2: Run the test and verify it fails**

Run from `app/`:

```bash
flutter test test/core/infrastructure/networking/connection/server_connection_manager_test.dart
```

Expected: FAIL because `managed_ha_connection.dart`, `ha_connection_factory.dart`, and `ServerConnectionManagerImpl` do not exist.

- [ ] **Step 3: Add `ManagedHAConnection`**

Create `app/lib/core/infrastructure/networking/connection/managed_ha_connection.dart`:

```dart
import 'package:home_assistant_websocket/home_assistant_websocket.dart';

final class ManagedHAConnection {
  const ManagedHAConnection({
    required this.connection,
    required this.states,
    required this.close,
  });

  final IHAConnection connection;
  final Stream<HASocketState> states;
  final Future<void> Function() close;
}
```

- [ ] **Step 4: Add the connection factory**

Create `app/lib/core/infrastructure/networking/connection/ha_connection_factory.dart`:

```dart
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/logging/ha_logger_adapter.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/server_auth_token_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_config_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

abstract interface class IHAConnectionFactory {
  Future<ManagedHAConnection> open(int serverId);
}

final class HAConnectionFactory implements IHAConnectionFactory {
  HAConnectionFactory(this._ref);

  final Ref _ref;

  @override
  Future<ManagedHAConnection> open(int serverId) async {
    final server = await _ref.read(serverConfigProvider(serverId).future);
    final serverUrl = Uri.parse(server.url);

    Future<HAAuthToken> fetchToken() async {
      try {
        return await _ref.read(serverAuthTokenProvider(serverId).future);
      } on AuthFailure catch (failure) {
        throw ConnectionError('Failed to resolve token: $failure');
      }
    }

    final options = HAConnectionOption.withLogger(
      serverUrl: serverUrl,
      fetchAuthToken: fetchToken,
      customLogger: HaLoggerAdapter(logger),
    );

    final orchestrator = ConnectionOrchestrator(options);
    await orchestrator.connect();

    final connection = orchestrator.connection;
    if (connection == null) {
      await orchestrator.close();
      throw ConnectionError('Connection failed to establish');
    }

    return ManagedHAConnection(
      connection: connection,
      states: orchestrator.state,
      close: orchestrator.close,
    );
  }
}
```

- [ ] **Step 5: Narrow the connection manager interface**

Replace `app/lib/core/infrastructure/networking/connection/i_server_connection_manager.dart` with:

```dart
import 'package:home_assistant_websocket/home_assistant_websocket.dart';

abstract interface class IServerConnectionManager {
  Future<IHAConnection> getConnection(int serverId);
  Future<void> reconnect(int serverId);
  void disconnect(int serverId);
  void setActiveServer(int? serverId);
}
```

- [ ] **Step 6: Replace the manager implementation**

In `app/lib/core/infrastructure/networking/connection/server_connection_manager.dart`, keep the provider name but replace the private implementation with `ServerConnectionManagerImpl`. The provider should construct it like this:

```dart
@Riverpod(keepAlive: true, dependencies: [serverConfig])
IServerConnectionManager serverConnectionManager(Ref ref) {
  final stateNotifier = ref.read(serverConnectionStateProvider.notifier);
  final manager = ServerConnectionManagerImpl(
    factory: HAConnectionFactory(ref),
    setState: (state) {
      switch (state) {
        case HAServerConnectionState.unknown:
          stateNotifier.reset();
        case HAServerConnectionState.connected:
          stateNotifier.setConnected();
        case HAServerConnectionState.disconnected:
          stateNotifier.setDisconnected();
        case HAServerConnectionState.connecting:
          stateNotifier.setConnecting();
        case HAServerConnectionState.reconnecting:
          stateNotifier.setReconnecting();
        case HAServerConnectionState.authFailure:
          stateNotifier.setAuthFailure();
      }
    },
    resetState: stateNotifier.reset,
  );

  ref.onDispose(manager.dispose);
  return manager;
}
```

Add this public implementation class in the same file:

```dart
typedef ConnectionStateSetter = void Function(HAServerConnectionState state);

final class ServerConnectionManagerImpl implements IServerConnectionManager {
  ServerConnectionManagerImpl({
    required IHAConnectionFactory factory,
    required ConnectionStateSetter setState,
    required void Function() resetState,
  }) : _factory = factory,
       _setState = setState,
       _resetState = resetState;

  final IHAConnectionFactory _factory;
  final ConnectionStateSetter _setState;
  final void Function() _resetState;

  final _resources = <int, _ConnectionResource>{};
  final _inFlight = <int, Future<IHAConnection>>{};
  int? _activeServerId;
  bool _isDisposed = false;

  @override
  void setActiveServer(int? serverId) {
    if (_activeServerId == serverId) {
      return;
    }
    _activeServerId = serverId;
    if (serverId == null) {
      _resetState();
    }
    for (final id in [..._resources.keys]) {
      if (id != serverId) {
        disconnect(id);
      }
    }
  }

  @override
  Future<IHAConnection> getConnection(int serverId) {
    if (_isDisposed) {
      return Future.error(StateError('ServerConnectionManager is disposed'));
    }
    final existing = _resources[serverId];
    if (existing != null) {
      return Future.value(existing.connection);
    }
    final opening = _inFlight[serverId];
    if (opening != null) {
      return opening;
    }
    final future = _open(serverId);
    _inFlight[serverId] = future;
    return future;
  }

  Future<IHAConnection> _open(int serverId) async {
    try {
      final managed = await _factory.open(serverId);
      if (_isDisposed) {
        await managed.close();
        throw StateError('ServerConnectionManager is disposed');
      }

      late final StreamSubscription<HASocketState> subscription;
      subscription = managed.states.listen((state) {
        final current = _resources[serverId];
        if (current?.subscription != subscription) {
          return;
        }
        _handleConnectionState(serverId, state);
      });

      _resources[serverId] = _ConnectionResource(
        connection: managed.connection,
        close: managed.close,
        subscription: subscription,
      );

      return managed.connection;
    } catch (error) {
      if (_activeServerId == serverId && !_isDisposed) {
        final text = error.toString();
        _setState(
          text.contains('auth') || text.contains('token')
              ? HAServerConnectionState.authFailure
              : HAServerConnectionState.disconnected,
        );
      }
      rethrow;
    } finally {
      _inFlight.remove(serverId);
    }
  }

  @override
  Future<void> reconnect(int serverId) async {
    disconnect(serverId);
    await getConnection(serverId);
  }

  @override
  void disconnect(int serverId) {
    final resource = _resources.remove(serverId);
    unawaited(resource?.dispose());
    _inFlight.remove(serverId);
    if (_activeServerId == serverId && !_isDisposed) {
      _resetState();
    }
  }

  void _handleConnectionState(int serverId, HASocketState state) {
    if (_activeServerId != serverId || _isDisposed) {
      return;
    }
    switch (state) {
      case Disconnected(type: DisconnectionType.authFailure):
        _setState(HAServerConnectionState.authFailure);
        disconnect(serverId);
      case Connecting():
        _setState(HAServerConnectionState.connecting);
      case Authenticated():
        _setState(HAServerConnectionState.connected);
      case Reconnecting():
        _setState(HAServerConnectionState.reconnecting);
      case Disconnected():
        _setState(HAServerConnectionState.disconnected);
    }
  }

  void dispose() {
    _isDisposed = true;
    for (final id in [..._resources.keys]) {
      disconnect(id);
    }
    _inFlight.clear();
  }
}

final class _ConnectionResource {
  _ConnectionResource({
    required this.connection,
    required this.close,
    required this.subscription,
  });

  final IHAConnection connection;
  final Future<void> Function() close;
  final StreamSubscription<HASocketState> subscription;

  Future<void> dispose() async {
    await subscription.cancel();
    await close();
  }
}
```

Remove unused imports that referenced `HAConnectionOption`, `HaLoggerAdapter`, `AuthFailure`, or `serverAuthTokenProvider` directly from `server_connection_manager.dart`; those live in the factory now.

- [ ] **Step 7: Update repository constructors that require `HAConnection`**

Change `app/lib/features/servers/infrastructure/repositories/websocket_repository.dart`:

```dart
class WebSocketRepository implements IWebSocketRepository {
  final IHAConnection _connection;

  WebSocketRepository(this._connection);
  ...
}
```

Change `app/lib/features/home/infrastructure/repositories/websocket_device_repository.dart` the same way if it currently stores `HAConnection`.

- [ ] **Step 8: Run the focused test**

Run from `app/`:

```bash
flutter test test/core/infrastructure/networking/connection/server_connection_manager_test.dart
```

Expected: PASS.

- [ ] **Step 9: Run analysis**

Run from `app/`:

```bash
flutter analyze
```

Expected: `No issues found!`

- [ ] **Step 10: Commit**

```bash
git add app/lib/core/infrastructure/networking/connection app/lib/features/servers/infrastructure/repositories/websocket_repository.dart app/lib/features/home/infrastructure/repositories/websocket_device_repository.dart app/test/core/infrastructure/networking/connection/server_connection_manager_test.dart
git commit -m "refactor: make server connection acquisition idempotent"
```

---

## Task 2: Add Active Server Session State And Controller

**Files:**
- Create: `app/lib/application/session/active_server_session_state.dart`
- Create: `app/lib/application/session/active_server_session_controller.dart`
- Generated: `app/lib/application/session/active_server_session_controller.g.dart`
- Test: `app/test/application/session/active_server_session_controller_test.dart`

- [ ] **Step 1: Write the failing provider tests**

Create `app/test/application/session/active_server_session_controller_test.dart` with fake managers and repositories:

```dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/networking/connection/i_server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
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

class _FakeServerManager implements IServerManager {
  _FakeServerManager(this.server);

  Server? server;
  final controller = StreamController<Server?>.broadcast();

  @override
  Future<Server> addServer(Server config) async => config;

  @override
  Future<Server?> getActiveServer() async => server;

  @override
  Future<List<Server>> getServers() async => [if (server != null) server!];

  @override
  Stream<Server?> watchActiveServer() => controller.stream;

  @override
  Future<Server?> activateServer(int id) async => server;

  @override
  Future<Server?> activateNextServer({int? excludingId}) async => server;

  @override
  Future<void> removeServer(int id, {bool allowRemovingLast = false}) async {
    server = null;
    controller.add(null);
  }
}

class _FakeAuthRepository implements IAuthRepository {
  _FakeAuthRepository({required this.hasCredentials});

  bool hasCredentials;

  @override
  Future<Either<AuthFailure, Credentials>> getCredentials(int serverId) async {
    if (!hasCredentials) {
      return left(const AuthFailure.missingCredentials());
    }
    return right(
      Credentials(
        'access',
        refreshToken: 'refresh',
        expiration: DateTime.now().add(const Duration(days: 1)),
        tokenEndpoint: Uri.parse('http://example.test/auth/token'),
      ),
    );
  }

  @override
  Future<bool> isLoggedIn(int serverId) async => hasCredentials;

  @override
  Future<Either<AuthFailure, Credentials>> login({
    required int serverId,
    required String serverUrl,
    required Uri redirectUrl,
    required AuthResponseHandler handler,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut(int serverId) async {
    hasCredentials = false;
    return right(unit);
  }
}

void main() {
  ProviderContainer makeContainer({
    required Server? server,
    bool hasCredentials = true,
    _FakeConnectionManager? connectionManager,
  }) {
    final serverManager = _FakeServerManager(server);
    final authRepository = _FakeAuthRepository(hasCredentials: hasCredentials);
    final manager = connectionManager ?? _FakeConnectionManager();
    return ProviderContainer(
      overrides: [
        serverManagerProvider.overrideWithValue(serverManager),
        authRepositoryProvider.overrideWithValue(authRepository),
        serverConnectionManagerProvider.overrideWithValue(manager),
      ],
    );
  }

  test('emits no active session when no server exists', () async {
    final container = makeContainer(server: null);
    addTearDown(container.dispose);

    final state = await container.read(activeServerSessionProvider.future);

    expect(state, isA<NoActiveServerSession>());
  });

  test('opens active connection for authenticated active server', () async {
    final manager = _FakeConnectionManager();
    final container = makeContainer(
      server: const Server(id: 1, name: 'Home'),
      connectionManager: manager,
    );
    addTearDown(container.dispose);

    final state = await container.read(activeServerSessionProvider.future);

    expect(state, isA<OnlineServerSession>());
    expect(manager.activeServerId, 1);
    expect(manager.opens, 1);
  });

  test('maps auth failure connection state to revoked session', () async {
    final container = makeContainer(server: const Server(id: 1, name: 'Home'));
    addTearDown(container.dispose);

    await container.read(activeServerSessionProvider.future);
    container
        .read(serverConnectionStateProvider.notifier)
        .setAuthFailure();
    await Future<void>.delayed(Duration.zero);

    final state = container.read(activeServerSessionProvider).value;
    expect(state, isA<AuthRevokedServerSession>());
  });
}
```

- [ ] **Step 2: Run the test and verify it fails**

Run from `app/`:

```bash
flutter test test/application/session/active_server_session_controller_test.dart
```

Expected: FAIL because the session state/controller files do not exist.

- [ ] **Step 3: Add session state classes**

Create `app/lib/application/session/active_server_session_state.dart`:

```dart
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

sealed class ActiveServerSessionState {
  const ActiveServerSessionState();

  Server? get server => null;
  bool get isOnline => this is OnlineServerSession;
  bool get isOffline => this is OfflineServerSession;
}

final class NoActiveServerSession extends ActiveServerSessionState {
  const NoActiveServerSession();
}

final class ResolvingServerSession extends ActiveServerSessionState {
  const ResolvingServerSession();
}

final class ConnectingServerSession extends ActiveServerSessionState {
  const ConnectingServerSession(this.activeServer);

  final Server activeServer;

  @override
  Server get server => activeServer;
}

final class OnlineServerSession extends ActiveServerSessionState {
  const OnlineServerSession({
    required this.activeServer,
    required this.connection,
  });

  final Server activeServer;
  final IHAConnection connection;

  @override
  Server get server => activeServer;
}

final class OfflineServerSession extends ActiveServerSessionState {
  const OfflineServerSession({
    required this.activeServer,
    this.cause,
  });

  final Server activeServer;
  final Object? cause;

  @override
  Server get server => activeServer;
}

final class AuthRevokedServerSession extends ActiveServerSessionState {
  const AuthRevokedServerSession(this.activeServer);

  final Server activeServer;

  @override
  Server get server => activeServer;
}
```

- [ ] **Step 4: Add active session controller**

Create `app/lib/application/session/active_server_session_controller.dart`:

```dart
import 'dart:async';

import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_server_session_controller.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [serverConnectionManager, authController],
)
class ActiveServerSession extends _$ActiveServerSession {
  Server? _activeServer;
  AuthState? _authState;
  bool _connecting = false;
  bool _signingOut = false;

  @override
  Future<ActiveServerSessionState> build() async {
    state = const AsyncData(ResolvingServerSession());

    ref.listen(activeServerProvider, (_, next) {
      switch (next) {
        case AsyncData(:final value):
          _activeServer = value;
          _syncSession();
        case AsyncError():
          _activeServer = null;
          state = const AsyncData(NoActiveServerSession());
        case AsyncLoading():
          state = const AsyncData(ResolvingServerSession());
      }
    });

    ref.listen(authStateProvider, (_, next) {
      switch (next) {
        case AsyncData(:final value):
          _authState = value;
          _syncSession();
        case AsyncError():
          state = const AsyncData(NoActiveServerSession());
        case AsyncLoading():
          state = const AsyncData(ResolvingServerSession());
      }
    });

    ref.listen(serverConnectionStateProvider, (_, next) {
      _handleTransportState(next);
    });

    final initialServer = await ref.watch(activeServerProvider.future);
    _activeServer = initialServer;
    final initialAuth = await ref.watch(authStateProvider.future);
    _authState = initialAuth;
    return _stateForCurrentInputs();
  }

  ActiveServerSessionState _stateForCurrentInputs() {
    final server = _activeServer;
    if (server == null) {
      ref.read(serverConnectionManagerProvider).setActiveServer(null);
      return const NoActiveServerSession();
    }
    final auth = _authState;
    if (auth is Authenticated || auth is Refreshing) {
      _connect(server);
      return ConnectingServerSession(server);
    }
    if (auth is Revoked) {
      return AuthRevokedServerSession(server);
    }
    return const NoActiveServerSession();
  }

  void _syncSession() {
    state = AsyncData(_stateForCurrentInputs());
  }

  void _connect(Server server) {
    final serverId = server.id;
    if (serverId == null || _connecting) {
      return;
    }
    _connecting = true;
    ref.read(serverConnectionManagerProvider).setActiveServer(serverId);
    unawaited(_open(server));
  }

  Future<void> _open(Server server) async {
    final serverId = server.id!;
    try {
      final connection = await ref
          .read(serverConnectionManagerProvider)
          .getConnection(serverId);
      if (_activeServer?.id == serverId) {
        state = AsyncData(
          OnlineServerSession(activeServer: server, connection: connection),
        );
      }
    } catch (error, stackTrace) {
      logger.w(
        'Failed to open active session for server $serverId',
        error: error,
        stackTrace: stackTrace,
      );
      if (_activeServer?.id == serverId) {
        state = AsyncData(
          OfflineServerSession(activeServer: server, cause: error),
        );
      }
    } finally {
      _connecting = false;
    }
  }

  void _handleTransportState(HAServerConnectionState transportState) {
    final server = _activeServer;
    if (server == null) {
      return;
    }
    switch (transportState) {
      case HAServerConnectionState.authFailure:
        state = AsyncData(AuthRevokedServerSession(server));
        _triggerSignOut(server);
      case HAServerConnectionState.disconnected:
      case HAServerConnectionState.reconnecting:
        state = AsyncData(OfflineServerSession(activeServer: server));
      case HAServerConnectionState.connecting:
        state = AsyncData(ConnectingServerSession(server));
      case HAServerConnectionState.connected:
      case HAServerConnectionState.unknown:
        break;
    }
  }

  void _triggerSignOut(Server server) {
    final serverId = server.id;
    if (serverId == null || _signingOut) {
      return;
    }
    _signingOut = true;
    unawaited(() async {
      try {
        await ref.read(authControllerProvider).signOut(serverId);
      } finally {
        _signingOut = false;
      }
    }());
  }
}
```

- [ ] **Step 5: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: `active_server_session_controller.g.dart` is generated.

- [ ] **Step 6: Run the focused test**

Run from `app/`:

```bash
flutter test test/application/session/active_server_session_controller_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/application/session/active_server_session_state.dart app/lib/application/session/active_server_session_controller.dart app/lib/application/session/active_server_session_controller.g.dart app/test/application/session/active_server_session_controller_test.dart
git commit -m "feat: add active server session controller"
```

---

## Task 3: Wire App And Server Scope To Session State

**Files:**
- Modify: `app/lib/app.dart`
- Modify: `app/lib/application/scopes/server_scope_host.dart`
- Test: `app/test/application/scopes/server_scope_host_test.dart`

- [ ] **Step 1: Write the failing scope host tests**

Create `app/test/application/scopes/server_scope_host_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/scopes/server_scope_host.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

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

class _ScopeProbe extends ConsumerWidget {
  const _ScopeProbe();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final server = ref.watch(serverScopeServerProvider);
    final id = ref.watch(serverScopeIdProvider);
    final connection = ref.watch(serverScopeConnectionProvider);
    return Text('${server.name}-$id-${connection.runtimeType}');
  }
}

void main() {
  testWidgets('injects scoped server and connection for online session', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            AsyncData(
              OnlineServerSession(
                activeServer: const Server(id: 7, name: 'Home'),
                connection: _FakeConnection(),
              ),
            ),
          ),
        ],
        child: const MaterialApp(
          home: ServerScopeHost(child: _ScopeProbe()),
        ),
      ),
    );

    expect(find.textContaining('Home-7'), findsOneWidget);
  });

  testWidgets('does not mount child when session is not online', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            AsyncData(NoActiveServerSession()),
          ),
        ],
        child: MaterialApp(
          home: ServerScopeHost(child: _ScopeProbe()),
        ),
      ),
    );

    expect(find.byType(_ScopeProbe), findsNothing);
  });
}
```

- [ ] **Step 2: Run the test and verify it fails**

Run from `app/`:

```bash
flutter test test/application/scopes/server_scope_host_test.dart
```

Expected: FAIL because `ServerScopeHost` still watches `activeServerProvider` and starts its own connection future.

- [ ] **Step 3: Update `app.dart` to initialize the new session**

Replace imports and dependencies in `app/lib/app.dart`:

```dart
import 'package:hommie/application/session/active_server_session_controller.dart';
```

Change annotations from `serverSessionCoordinator` to `ActiveServerSession`, and change the initializer:

```dart
@Dependencies([ActiveServerSession])
class _ServiceInitializer extends ConsumerWidget {
  const _ServiceInitializer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(activeServerSessionProvider);
    return child;
  }
}
```

Remove the legacy `server_session_coordinator.dart` import from `app.dart`.

- [ ] **Step 4: Update `ServerScopeHost`**

Replace the build logic in `app/lib/application/scopes/server_scope_host.dart` with:

```dart
@Dependencies([ActiveServerSession])
class ServerScopeHost extends ConsumerWidget {
  const ServerScopeHost({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(activeServerSessionProvider);

    return switch (session) {
      AsyncLoading() => const SizedBox.shrink(),
      AsyncError() => const SizedBox.shrink(),
      AsyncData(:final value) => switch (value) {
        OnlineServerSession(:final activeServer, :final connection) =>
          ProviderScope(
            key: ValueKey(activeServer.id),
            overrides: [
              serverScopeIdProvider.overrideWith((_) => activeServer.id!),
              serverScopeServerProvider.overrideWith((_) => activeServer),
              serverScopeConnectionProvider.overrideWith((_) => connection),
            ],
            child: child,
          ),
        _ => const SizedBox.shrink(),
      },
    };
  }
}
```

Remove `UnavailableHAConnection` usage and delete `NoActiveServerSelectedException` from this file if no tests or code still depend on it.

- [ ] **Step 5: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: generated app/provider dependency files update cleanly.

- [ ] **Step 6: Run focused tests**

Run from `app/`:

```bash
flutter test test/application/scopes/server_scope_host_test.dart test/application/session/active_server_session_controller_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/app.dart app/lib/application/scopes/server_scope_host.dart app/lib/application/session/active_server_session_controller.g.dart app/test/application/scopes/server_scope_host_test.dart
git commit -m "refactor: scope server providers from active session"
```

---

## Task 4: Add Server Sync Coordinator

**Files:**
- Create: `app/lib/application/session/server_sync_state.dart`
- Create: `app/lib/application/session/server_sync_coordinator.dart`
- Generated: `app/lib/application/session/server_sync_coordinator.g.dart`
- Test: `app/test/application/session/server_sync_coordinator_test.dart`

- [ ] **Step 1: Write the failing sync coordinator tests**

Create `app/test/application/session/server_sync_coordinator_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/server_sync_coordinator.dart';
import 'package:hommie/application/session/server_sync_state.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/domain/repositories/i_areas_repository.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/domain/repositories/i_entity_repository.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:fpdart/fpdart.dart';

class _FakeConnection implements IHAConnection {
  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) {
    if (message is HARequestMessage && message.type == 'config/area_registry/list') {
      return Future.value(<dynamic>[]);
    }
    if (message is HARequestMessage && message.type == 'config/entity_registry/list') {
      return Future.value(<dynamic>[
        {'entity_id': 'light.kitchen', 'name': 'Kitchen', 'disabled_by': null, 'hidden_by': null},
      ]);
    }
    if (message is HARequestMessage && message.type == 'config/device_registry/list') {
      return Future.value(<dynamic>[]);
    }
    return Future.value(null);
  }

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    return HASubscription(logger: const NoOpLogger(), unsubscribe: () async {});
  }
}

class _FakeAreaRepo implements IAreaRepository {
  int syncs = 0;

  @override
  Future<void> syncAll({required int serverId, required List<Area> areas}) async {
    syncs += 1;
  }

  @override
  Stream<List<Area>> watchByServer(int serverId) => Stream.value(const []);
}

class _FakeEntityRepo implements IEntityRepository {
  int syncs = 0;
  List<HaEntity> captured = const [];

  @override
  Future<List<HaEntity>> getByServer(int serverId) async => captured;

  @override
  Future<void> syncAll({
    required int serverId,
    required List<HaEntity> entities,
  }) async {
    syncs += 1;
    captured = entities;
  }

  @override
  Stream<List<HaEntity>> watchByServer(int serverId) => Stream.value(captured);
}

void main() {
  test('runs initial sync when session is online', () async {
    final areaRepo = _FakeAreaRepo();
    final entityRepo = _FakeEntityRepo();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          AsyncData(
            OnlineServerSession(
              activeServer: const Server(id: 1, name: 'Home'),
              connection: _FakeConnection(),
            ),
          ),
        ),
        areaRepositoryProvider.overrideWithValue(areaRepo),
        entityRepositoryProvider.overrideWithValue(entityRepo),
      ],
    );
    addTearDown(container.dispose);

    container.listen(serverSyncCoordinatorProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(container.read(serverSyncCoordinatorProvider), isA<SyncReady>());
    expect(areaRepo.syncs, 1);
    expect(entityRepo.syncs, 1);
    expect(entityRepo.captured.single.entityId, 'light.kitchen');
  });

  test('does not start remote sync while offline', () async {
    final entityRepo = _FakeEntityRepo();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const AsyncData(
            OfflineServerSession(
              activeServer: Server(id: 1, name: 'Home'),
            ),
          ),
        ),
        entityRepositoryProvider.overrideWithValue(entityRepo),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(serverSyncCoordinatorProvider), isA<SyncOfflineWithCache>());
    expect(entityRepo.syncs, 0);
  });
}
```

- [ ] **Step 2: Run the test and verify it fails**

Run from `app/`:

```bash
flutter test test/application/session/server_sync_coordinator_test.dart
```

Expected: FAIL because sync state/coordinator files do not exist.

- [ ] **Step 3: Add sync state**

Create `app/lib/application/session/server_sync_state.dart`:

```dart
sealed class ServerSyncState {
  const ServerSyncState();
}

final class SyncIdle extends ServerSyncState {
  const SyncIdle();
}

final class InitialSyncRunning extends ServerSyncState {
  const InitialSyncRunning();
}

final class SyncReady extends ServerSyncState {
  const SyncReady();
}

final class SyncOfflineWithCache extends ServerSyncState {
  const SyncOfflineWithCache();
}

final class SyncFailed extends ServerSyncState {
  const SyncFailed(this.error);

  final Object error;
}
```

- [ ] **Step 4: Add sync coordinator**

Create `app/lib/application/session/server_sync_coordinator.dart`:

```dart
import 'dart:async';

import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/server_sync_state.dart';
import 'package:hommie/features/areas/infrastructure/repositories/areas_repository.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/repositories/entity_resolver.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_sync_coordinator.g.dart';

@Riverpod(
  dependencies: [ActiveServerSession, areaRepository, entityRepository],
)
class ServerSyncCoordinator extends _$ServerSyncCoordinator {
  HASubscription? _areaSub;
  HASubscription? _entitySub;
  HASubscription? _deviceSub;
  StreamSubscription<dynamic>? _areaEvents;
  StreamSubscription<dynamic>? _entityEvents;
  StreamSubscription<dynamic>? _deviceEvents;
  int? _serverId;

  @override
  ServerSyncState build() {
    ref.onDispose(() => unawaited(_stop()));
    final session = ref.watch(activeServerSessionProvider).valueOrNull;
    switch (session) {
      case OnlineServerSession(:final activeServer, :final connection):
        final id = activeServer.id;
        if (id == null) {
          return const SyncIdle();
        }
        if (_serverId != id) {
          unawaited(_stop());
          _serverId = id;
        }
        unawaited(_start(id, connection));
        return const InitialSyncRunning();
      case OfflineServerSession():
        unawaited(_stop());
        return const SyncOfflineWithCache();
      case AuthRevokedServerSession():
      case NoActiveServerSession():
      case ResolvingServerSession():
      case ConnectingServerSession():
      case null:
        unawaited(_stop());
        return const SyncIdle();
    }
  }

  Future<void> _start(int serverId, IHAConnection connection) async {
    if (_areaSub != null || state is SyncReady) {
      return;
    }
    try {
      _areaSub = HACommands.subscribeEvents(connection, 'area_registry_updated');
      _entitySub = HACommands.subscribeEvents(connection, 'entity_registry_updated');
      _deviceSub = HACommands.subscribeEvents(connection, 'device_registry_updated');
      _areaEvents = _areaSub!.stream.listen((_) => unawaited(_syncAreas(serverId, connection)));
      _entityEvents = _entitySub!.stream.listen((_) => unawaited(_syncEntities(serverId, connection)));
      _deviceEvents = _deviceSub!.stream.listen((_) => unawaited(_syncEntities(serverId, connection)));
    } catch (_) {
      await _stop();
    }

    try {
      await _syncAreas(serverId, connection);
      await _syncEntities(serverId, connection);
      state = const SyncReady();
    } catch (error) {
      state = SyncFailed(error);
    }
  }

  Future<void> _syncAreas(int serverId, IHAConnection connection) async {
    final remote = AreasRepository(connection);
    final local = ref.read(areaRepositoryProvider);
    final result = await remote.getAreas();
    await result.match(
      (error) => throw error,
      (areas) => local.syncAll(serverId: serverId, areas: areas),
    );
  }

  Future<void> _syncEntities(int serverId, IHAConnection connection) async {
    final remote = HaRegistryRepository(connection);
    final local = ref.read(entityRepositoryProvider);
    final entities = await remote.getEntities();
    final devices = await remote.getDevices();
    final resolved = resolveEntities(entities: entities, devices: devices);
    await local.syncAll(serverId: serverId, entities: resolved);
  }

  Future<void> _stop() async {
    await _areaEvents?.cancel();
    await _entityEvents?.cancel();
    await _deviceEvents?.cancel();
    _areaEvents = null;
    _entityEvents = null;
    _deviceEvents = null;

    for (final sub in [_areaSub, _entitySub, _deviceSub]) {
      if (sub != null && !sub.isDisposed) {
        try {
          await sub.dispose();
        } catch (_) {}
      }
    }
    _areaSub = null;
    _entitySub = null;
    _deviceSub = null;
  }
}
```

- [ ] **Step 5: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: `server_sync_coordinator.g.dart` is generated.

- [ ] **Step 6: Run the focused test**

Run from `app/`:

```bash
flutter test test/application/session/server_sync_coordinator_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/application/session/server_sync_state.dart app/lib/application/session/server_sync_coordinator.dart app/lib/application/session/server_sync_coordinator.g.dart app/test/application/session/server_sync_coordinator_test.dart
git commit -m "feat: coordinate active server registry sync"
```

---

## Task 5: Move Home Loading Logic To Session And Sync Summaries

**Files:**
- Modify: `app/lib/features/home/application/home_page_controller.dart`
- Modify: `app/lib/features/home/presentation/screens/home_page.dart`
- Test: `app/test/features/home/home_page_controller_test.dart`

- [ ] **Step 1: Update home controller tests first**

Replace the sync-controller stubs in `app/test/features/home/home_page_controller_test.dart` with session/sync overrides:

```dart
class _OnlineSession extends ActiveServerSession {
  @override
  Future<ActiveServerSessionState> build() async => OnlineServerSession(
    activeServer: const Server(id: 1, name: 'Home'),
    connection: _FakeConnection(),
  );
}

class _OfflineSession extends ActiveServerSession {
  @override
  Future<ActiveServerSessionState> build() async =>
      const OfflineServerSession(activeServer: Server(id: 1, name: 'Home'));
}

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
```

Use overrides like:

```dart
activeServerSessionProvider.overrideWith(_OnlineSession.new),
serverSyncCoordinatorProvider.overrideWithValue(const SyncReady()),
```

Add these expectations:

```dart
expect(state.isInitialSyncing, isFalse);
expect(state.isOffline, isFalse);
expect(state.syncFailure, isNull);
```

Change the loading test to use:

```dart
serverSyncCoordinatorProvider.overrideWithValue(const InitialSyncRunning()),
```

and assert:

```dart
expect(state.isInitialSyncing, isTrue);
```

Add an offline-with-cache test:

```dart
test('keeps cached sections visible while offline', () async {
  final container = ProviderContainer(
    overrides: [
      serverScopeServerProvider.overrideWithValue(const Server(id: 1, name: 'Home')),
      cachedAreasProvider.overrideWith((ref) => Stream.value(const [Area(id: 'kitchen', name: 'Kitchen')])),
      cachedEntitiesProvider.overrideWith((ref) => Stream.value(const [
        HaEntity(entityId: 'light.a', domain: 'light', name: 'A', areaId: 'kitchen'),
      ])),
      activeServerSessionProvider.overrideWith(_OfflineSession.new),
      serverSyncCoordinatorProvider.overrideWithValue(const SyncOfflineWithCache()),
    ],
  );
  addTearDown(container.dispose);

  container.listen(homePageControllerProvider, (_, _) {});
  await Future<void>.delayed(const Duration(milliseconds: 20));

  final state = container.read(homePageControllerProvider);
  expect(state.isOffline, isTrue);
  expect(state.sections.first.entities.single.entityId, 'light.a');
  expect(state.isInitialSyncing, isFalse);
});
```

- [ ] **Step 2: Run the test and verify it fails**

Run from `app/`:

```bash
flutter test test/features/home/home_page_controller_test.dart
```

Expected: FAIL because `HomePageState` does not have `isInitialSyncing`, `isOffline`, or `syncFailure`.

- [ ] **Step 3: Update `HomePageState` and controller**

In `app/lib/features/home/application/home_page_controller.dart`, replace `isSyncing` with:

```dart
final bool isInitialSyncing;
final bool isOffline;
final Object? syncFailure;
```

Compute from session/sync:

```dart
final session = ref.watch(activeServerSessionProvider).valueOrNull;
final syncState = ref.watch(serverSyncCoordinatorProvider);
final isOffline = session is OfflineServerSession;
final syncFailure = syncState is SyncFailed ? syncState.error : null;
final isInitialSyncing =
    entities.isEmpty && syncState is InitialSyncRunning;
```

Remove:

```dart
ref.watch(areaRegistrySyncControllerProvider);
final syncStatus = ref.watch(entityRegistrySyncControllerProvider);
```

Add:

```dart
ref.watch(serverSyncCoordinatorProvider);
```

Update the provider dependencies to include `ActiveServerSession` and `ServerSyncCoordinator`, and remove `AreaRegistrySyncController` and `EntityRegistrySyncController`.

- [ ] **Step 4: Update Home page rendering**

In `app/lib/features/home/presentation/screens/home_page.dart`, replace:

```dart
if (state.isSyncing && state.sections.isEmpty) {
```

with:

```dart
if (state.isInitialSyncing && state.sections.isEmpty) {
```

If `state.syncFailure != null && state.sections.isEmpty`, render a scaffold with:

```dart
body: const Center(child: Text('Unable to sync Home Assistant data')),
```

Keep cached sections visible when `state.isOffline` is true.

- [ ] **Step 5: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: `home_page_controller.g.dart` dependency metadata updates.

- [ ] **Step 6: Run focused tests**

Run from `app/`:

```bash
flutter test test/features/home/home_page_controller_test.dart test/features/home/home_page_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/features/home/application/home_page_controller.dart app/lib/features/home/application/home_page_controller.g.dart app/lib/features/home/presentation/screens/home_page.dart app/test/features/home/home_page_controller_test.dart app/test/features/home/home_page_test.dart
git commit -m "refactor: drive home loading from session sync state"
```

---

## Task 6: Remove Raw Connection State From Entity Providers

**Files:**
- Modify: `app/lib/features/entities/application/entity_states_provider.dart`
- Modify: `app/lib/features/entities/application/entity_service_controller.dart`
- Tests:
  - `app/test/features/entities/application/entity_states_provider_test.dart`
  - `app/test/features/entities/application/entity_service_controller_test.dart`

- [ ] **Step 1: Add entity state provider tests**

Create `app/test/features/entities/application/entity_states_provider_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

class _OfflineSession extends ActiveServerSession {
  @override
  Future<ActiveServerSessionState> build() async =>
      const OfflineServerSession(activeServer: Server(id: 1, name: 'Home'));
}

void main() {
  test('does not subscribe while session is offline', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWith(_OfflineSession.new),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(entityStatesProvider), isEmpty);
  });
}
```

- [ ] **Step 2: Add entity service offline test**

Replace or extend `app/test/features/entities/application/entity_service_controller_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/entities/application/entity_service_controller.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

class _OfflineSession extends ActiveServerSession {
  @override
  Future<ActiveServerSessionState> build() async =>
      const OfflineServerSession(activeServer: Server(id: 1, name: 'Home'));
}

void main() {
  test('call fails with ConnectionClosedError while offline', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWith(_OfflineSession.new),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(entityServiceControllerProvider);

    await expectLater(
      controller.call('light.kitchen', 'toggle'),
      throwsA(isA<ConnectionClosedError>()),
    );
  });
}
```

- [ ] **Step 3: Run the tests and verify they fail**

Run from `app/`:

```bash
flutter test test/features/entities/application/entity_states_provider_test.dart test/features/entities/application/entity_service_controller_test.dart
```

Expected: FAIL because the providers still depend on `serverConnectionStateProvider` or `serverScopeConnectionProvider`.

- [ ] **Step 4: Update `entity_states_provider.dart`**

Change dependencies to `[ActiveServerSession]`, and replace raw connection-state logic with:

```dart
final session = ref.watch(activeServerSessionProvider).valueOrNull;
if (session is! OnlineServerSession) {
  return const {};
}

final connection = session.connection;
```

Remove the import for `connection_state_provider.dart`.

- [ ] **Step 5: Update `entity_service_controller.dart`**

Change the controller to hold `Ref` instead of a connection:

```dart
class EntityServiceController {
  EntityServiceController(this._ref);

  final Ref _ref;

  Future<void> call(
    String entityId,
    String service, {
    String? domainOverride,
    Map<String, dynamic>? data,
  }) async {
    final session = _ref.read(activeServerSessionProvider).valueOrNull;
    if (session is! OnlineServerSession) {
      throw ConnectionClosedError('Home Assistant connection is offline.');
    }
    final domain = domainOverride ?? entityId.split('.').first;
    await HACommands.callService(
      session.connection,
      domain: domain,
      service: service,
      target: entityId,
      serviceData: data,
    );
  }
}

@Riverpod(dependencies: [ActiveServerSession])
EntityServiceController entityServiceController(Ref ref) {
  return EntityServiceController(ref);
}
```

- [ ] **Step 6: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: entity provider generated files update.

- [ ] **Step 7: Run focused tests**

Run from `app/`:

```bash
flutter test test/features/entities/application/entity_states_provider_test.dart test/features/entities/application/entity_service_controller_test.dart
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add app/lib/features/entities/application/entity_states_provider.dart app/lib/features/entities/application/entity_states_provider.g.dart app/lib/features/entities/application/entity_service_controller.dart app/lib/features/entities/application/entity_service_controller.g.dart app/test/features/entities/application/entity_states_provider_test.dart app/test/features/entities/application/entity_service_controller_test.dart
git commit -m "refactor: use active session for entity connection access"
```

---

## Task 7: Replace Legacy Public Sync Controllers In Home Path

**Files:**
- Modify: `app/lib/features/areas/application/area_registry_sync_controller.dart`
- Modify: `app/lib/features/entities/application/entity_registry_sync_controller.dart`
- Modify tests that still override these providers.

- [ ] **Step 1: Search for old public sync dependencies**

Run:

```bash
rg -n "AreaRegistrySyncController|EntityRegistrySyncController|areaRegistrySyncControllerProvider|entityRegistrySyncControllerProvider|serverConnectionStateProvider" app/lib app/test
```

Expected: Remaining matches identify code to update. After Tasks 5 and 6, no feature/home provider should use old sync controllers or raw connection state.

- [ ] **Step 2: Remove old sync providers from Home tests**

In `app/test/features/home/home_page_controller_test.dart`, remove classes extending `AreaRegistrySyncController` and `EntityRegistrySyncController`. Keep only `activeServerSessionProvider` and `serverSyncCoordinatorProvider` overrides.

- [ ] **Step 3: Internalize old sync controllers**

If no production code reads `areaRegistrySyncControllerProvider` or `entityRegistrySyncControllerProvider`, delete both controller files and generated files:

```bash
git rm app/lib/features/areas/application/area_registry_sync_controller.dart app/lib/features/areas/application/area_registry_sync_controller.g.dart
git rm app/lib/features/entities/application/entity_registry_sync_controller.dart app/lib/features/entities/application/entity_registry_sync_controller.g.dart
```

If a non-home production path still reads one of them, replace that read with `serverSyncCoordinatorProvider` first, then delete the old controller.

- [ ] **Step 4: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: generated dependency metadata no longer references deleted sync providers.

- [ ] **Step 5: Run focused tests**

Run from `app/`:

```bash
flutter test test/features/home/home_page_controller_test.dart test/application/session/server_sync_coordinator_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib app/test
git commit -m "refactor: centralize registry sync startup"
```

---

## Task 8: Move Offline Banner And Hub Status To Session State

**Files:**
- Modify: `app/lib/ui/screens/widgets/offline_container.dart`
- Modify: `app/lib/features/settings/application/hub_status_provider.dart`
- Test: `app/test/features/settings/application/hub_status_provider_test.dart`

- [ ] **Step 1: Add hub status test**

Create `app/test/features/settings/application/hub_status_provider_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/settings/application/hub_status_provider.dart';
import 'package:hommie/features/settings/domain/repository/i_device_info_repository.dart';
import 'package:hommie/features/settings/infrastructure/providers/device_info_repository_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

class _FakeDeviceInfoRepository implements IDeviceInfoRepository {
  @override
  Future<String> getDeviceName() async => 'Test device';
}

class _OfflineSession extends ActiveServerSession {
  @override
  Future<ActiveServerSessionState> build() async =>
      const OfflineServerSession(activeServer: Server(id: 1, name: 'Home'));
}

void main() {
  test('uses active session state for connection status', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWith(_OfflineSession.new),
        deviceInfoRepositoryProvider.overrideWithValue(_FakeDeviceInfoRepository()),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(hubStatusProvider.future);

    expect(state.server?.name, 'Home');
    expect(state.isOffline, isTrue);
    expect(state.deviceName, 'Test device');
  });
}
```

- [ ] **Step 2: Run the test and verify it fails**

Run from `app/`:

```bash
flutter test test/features/settings/application/hub_status_provider_test.dart
```

Expected: FAIL because `HubStatusState` still exposes raw `HAServerConnectionState`.

- [ ] **Step 3: Update hub status state**

In `app/lib/features/settings/application/hub_status_provider.dart`, replace `connectionState` with:

```dart
required ActiveServerSessionState sessionState,
```

Add computed getters inside the freezed class extension if needed:

```dart
extension HubStatusStateX on HubStatusState {
  bool get isOffline => sessionState is OfflineServerSession;
  bool get isOnline => sessionState is OnlineServerSession;
}
```

Build from:

```dart
final sessionState = await ref.watch(activeServerSessionProvider.future);
final server = sessionState.server;
```

Remove `serverConnectionStateProvider` and `activeServerProvider` imports from this file.

- [ ] **Step 4: Update offline container**

In `app/lib/ui/screens/widgets/offline_container.dart`, replace:

```dart
final showBanner = ref.watch(
  serverConnectionStateProvider.select(_isConnectionDisrupted),
);
```

with:

```dart
final showBanner = ref.watch(
  activeServerSessionProvider.select((session) {
    final value = session.valueOrNull;
    return value is OfflineServerSession || value is ConnectingServerSession;
  }),
);
```

Remove `_isConnectionDisrupted` and the raw connection-state import.

- [ ] **Step 5: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: `hub_status_provider.g.dart` and `.freezed.dart` update.

- [ ] **Step 6: Run focused tests**

Run from `app/`:

```bash
flutter test test/features/settings/application/hub_status_provider_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/ui/screens/widgets/offline_container.dart app/lib/features/settings/application/hub_status_provider.dart app/lib/features/settings/application/hub_status_provider.g.dart app/lib/features/settings/application/hub_status_provider.freezed.dart app/test/features/settings/application/hub_status_provider_test.dart
git commit -m "refactor: derive offline UI from active session"
```

---

## Task 9: Add Explicit Login Flow Controller

**Files:**
- Create: `app/lib/features/auth/application/login_flow_controller.dart`
- Generated: `app/lib/features/auth/application/login_flow_controller.g.dart`
- Modify: `app/lib/features/auth/application/auth_controller.dart`
- Test: `app/test/features/auth/application/login_flow_controller_test.dart`

- [ ] **Step 1: Write failing login flow rollback test**

Create `app/test/features/auth/application/login_flow_controller_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hommie/features/auth/application/login_flow_controller.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:oauth2/oauth2.dart';

class _FakeServerManager implements IServerManager {
  int nextId = 1;
  final added = <Server>[];
  final removed = <int>[];
  int? activated;

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
    return added.firstWhere((server) => server.id == id);
  }

  @override
  Future<Server?> activateNextServer({int? excludingId}) async => null;

  @override
  Future<Server?> getActiveServer() async => null;

  @override
  Future<List<Server>> getServers() async => added;

  @override
  Stream<Server?> watchActiveServer() => const Stream.empty();
}

class _FailingAuthRepository implements IAuthRepository {
  @override
  Future<Either<AuthFailure, Credentials>> login({
    required int serverId,
    required String serverUrl,
    required Uri redirectUrl,
    required AuthResponseHandler handler,
  }) async {
    return left(const AuthFailure.server('login failed'));
  }

  @override
  Future<Either<AuthFailure, Credentials>> getCredentials(int serverId) async =>
      left(const AuthFailure.missingCredentials());

  @override
  Future<bool> isLoggedIn(int serverId) async => false;

  @override
  Future<Either<AuthFailure, Unit>> signOut(int serverId) async => right(unit);
}

void main() {
  test('rolls back temporary server when OAuth fails', () async {
    final serverManager = _FakeServerManager();
    final container = ProviderContainer(
      overrides: [
        serverManagerProvider.overrideWithValue(serverManager),
        authRepositoryProvider.overrideWithValue(_FailingAuthRepository()),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(loginFlowControllerProvider);

    await expectLater(
      controller.login(ServerUrl('http://example.test')),
      throwsA(isA<AuthFailure>()),
    );

    expect(serverManager.removed, [1]);
    expect(serverManager.activated, isNull);
  });
}
```

- [ ] **Step 2: Run the test and verify it fails**

Run from `app/`:

```bash
flutter test test/features/auth/application/login_flow_controller_test.dart
```

Expected: FAIL because `login_flow_controller.dart` does not exist.

- [ ] **Step 3: Implement `LoginFlowController`**

Create `app/lib/features/auth/application/login_flow_controller.dart`:

```dart
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';
import 'package:hommie/features/common/domain/entities/ha_version.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_flow_controller.g.dart';

class LoginFlowController {
  LoginFlowController(this._ref);

  final Ref _ref;
  static final Uri _redirectUrl = Uri.parse('hommie://');

  Future<void> login(ServerUrl serverUrl) async {
    final serverManager = _ref.read(serverManagerProvider);
    final authRepository = _ref.read(authRepositoryProvider);
    Server? createdServer;

    try {
      createdServer = await serverManager.addServer(
        Server.temporary(baseUrl: serverUrl),
      );

      final loginResult = await authRepository.login(
        serverId: createdServer.id!,
        serverUrl: createdServer.baseUrl!.value.getOrElse((_) => ''),
        redirectUrl: _redirectUrl,
        handler: (uri) async {
          throw UnsupportedError(
            'LoginFlowController.login must be called through AuthController in production.',
          );
        },
      );

      await loginResult.match(
        (failure) => throw failure,
        (_) async {},
      );

      final configRepository = await _ref.read(
        websocketConfigRepositoryProvider(createdServer.id!).future,
      );
      final config = await configRepository.getConfig();
      final updatedServer = await serverManager.addServer(
        createdServer.copyWith(
          name: config.location_name,
          version: HaVersion.fromString(config.version),
          internalUrl: config.internal_url,
          externalUrl: config.external_url,
        ),
      );

      await serverManager.activateServer(updatedServer.id!);
    } catch (error) {
      if (createdServer?.id != null) {
        await serverManager.removeServer(
          createdServer!.id!,
          allowRemovingLast: true,
        );
      }
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true, dependencies: [authRepository, websocketConfigRepository])
LoginFlowController loginFlowController(Ref ref) {
  return LoginFlowController(ref);
}
```

This first implementation keeps the production OAuth callback in `AuthController`; the next step moves the callback into the login flow without changing behavior.

- [ ] **Step 4: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: `login_flow_controller.g.dart` is generated.

- [ ] **Step 5: Run the focused test**

Run from `app/`:

```bash
flutter test test/features/auth/application/login_flow_controller_test.dart
```

Expected: PASS.

- [ ] **Step 6: Move OAuth callback handling from `AuthController`**

Adjust `LoginFlowController.login` to accept:

```dart
Future<void> login(
  ServerUrl serverUrl, {
  required AuthResponseHandler handler,
}) async {
```

Pass `handler` into `authRepository.login`.

In `AuthController.login`, replace the action chain with:

```dart
await _ref.read(loginFlowControllerProvider).login(
  serverUrl,
  handler: (uri) async {
    final authenticateResult = await FlutterWebAuth2.authenticate(
      url: uri.toString(),
      callbackUrlScheme: 'hommie',
    );
    return Uri.parse(authenticateResult).queryParameters;
  },
);
```

Remove `CreateServerAction`, `OAuthLoginAttemptAction`, `GetConfigAction`, and `ActivateServerAction` imports from `auth_controller.dart` if they become unused.

- [ ] **Step 7: Update login flow test call sites**

Pass a handler in the test:

```dart
await controller.login(
  ServerUrl('http://example.test'),
  handler: (_) async => const <String, String>{},
);
```

- [ ] **Step 8: Run focused tests**

Run from `app/`:

```bash
flutter test test/features/auth/application/login_flow_controller_test.dart
```

Expected: PASS.

- [ ] **Step 9: Commit**

```bash
git add app/lib/features/auth/application/login_flow_controller.dart app/lib/features/auth/application/login_flow_controller.g.dart app/lib/features/auth/application/auth_controller.dart app/lib/features/auth/application/auth_controller.g.dart app/test/features/auth/application/login_flow_controller_test.dart
git commit -m "refactor: make login flow explicit"
```

---

## Task 10: Retire Legacy Session Coordinator And Raw State Dependencies

**Files:**
- Delete: `app/lib/application/session/server_session_coordinator.dart`
- Delete: `app/lib/application/session/server_session_coordinator.g.dart`
- Potentially keep: `app/lib/core/infrastructure/networking/providers/connection_state_provider.dart` as internal infrastructure.

- [ ] **Step 1: Search for legacy dependencies**

Run:

```bash
rg -n "serverSessionCoordinator|serverConnectionStateProvider|HAServerConnectionState" app/lib app/test
```

Expected: `serverConnectionStateProvider` remains only in connection/session infrastructure tests and implementation. `serverSessionCoordinator` has no production references.

- [ ] **Step 2: Delete legacy coordinator**

Run:

```bash
git rm app/lib/application/session/server_session_coordinator.dart app/lib/application/session/server_session_coordinator.g.dart
```

- [ ] **Step 3: Guard raw state provider usage**

Keep `connection_state_provider.dart` if `ActiveServerSessionController` still reads it internally. Add a file-level comment:

```dart
/// Internal transport-state bridge for active session infrastructure.
/// Feature/application providers must depend on ActiveServerSession instead.
```

- [ ] **Step 4: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: no generated references to the deleted coordinator.

- [ ] **Step 5: Run analysis**

Run from `app/`:

```bash
flutter analyze
```

Expected: `No issues found!`

- [ ] **Step 6: Commit**

```bash
git add app/lib/application/session app/lib/core/infrastructure/networking/providers/connection_state_provider.dart
git commit -m "refactor: retire legacy session coordinator"
```

---

## Task 11: Strengthen Integration Tests For Session Readiness

**Files:**
- Modify: `app/integration_test/test_bundle.dart`
- Modify: `docker/scripts/hass-init.py`
- Modify: `app/lib/ui/keys.dart`
- Modify: `app/lib/features/home/presentation/screens/home_page.dart`
- Create: `app/integration_test/step/i_see_light_card.dart`
- Create: `app/integration_test/step/i_do_not_see_home_loading_spinner.dart`
- Modify: `app/integration_test/authorization.feature`
- Modify: `app/integration_test/offline_banner.feature`
- Modify generated integration test Dart files to match feature updates.

- [ ] **Step 1: Add stable Home loading key**

In `app/lib/ui/keys.dart`, extend `HomeKeys`:

```dart
final loadingSpinner = const Key('homeLoadingSpinner');
```

In `home_page.dart`, set the initial spinner key:

```dart
body: Center(
  child: CircularProgressIndicator(key: K.home.loadingSpinner),
),
```

- [ ] **Step 2: Add light card step**

Create `app/integration_test/step/i_see_light_card.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future<void> iSeeLightCard(PatrolIntegrationTester $, String entityId) async {
  await $(Key('light_card.$entityId')).waitUntilVisible();
}
```

- [ ] **Step 3: Add no-loading step**

Create `app/integration_test/step/i_do_not_see_home_loading_spinner.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:patrol/patrol.dart';

Future<void> iDoNotSeeHomeLoadingSpinner(PatrolIntegrationTester $) async {
  expect($(K.home.loadingSpinner), findsNothing);
}
```

- [ ] **Step 4: Include offline test bundle**

Update `app/integration_test/test_bundle.dart`:

```dart
import 'authorization_test.dart' as authorization_test;
import 'offline_banner_test.dart' as offline_banner_test;
...
group('authorization_test', authorization_test.main);
group('offline_banner_test', offline_banner_test.main);
```

- [ ] **Step 5: Make shortcut login setup create an active server**

In `app/integration_test/step/i_have_successfully_logged_in.dart`, add these imports:

```dart
import 'dart:async';

import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
```

Add a server manager override to `TestProviderOverrides.instance().setOverrides([...])`:

```dart
serverManagerProvider.overrideWith(
  (ref) => _ServerManagerMock(),
),
```

Add this mock below `_CredentialsRepositoryMock`:

```dart
class _ServerManagerMock implements IServerManager {
  _ServerManagerMock();

  final _controller = StreamController<Server?>.broadcast();
  Server? _active = Server(
    id: 1,
    name: 'Home',
    baseUrl: ServerUrl(_serverUrl),
  );

  @override
  Future<Server> addServer(Server config) async {
    _active = Server(
      id: config.id ?? 1,
      name: config.name,
      baseUrl: config.baseUrl ?? ServerUrl(_serverUrl),
      internalUrl: config.internalUrl,
      externalUrl: config.externalUrl,
      version: config.version,
    );
    _controller.add(_active);
    return _active!;
  }

  @override
  Future<Server?> getActiveServer() async => _active;

  @override
  Future<List<Server>> getServers() async => [if (_active != null) _active!];

  @override
  Stream<Server?> watchActiveServer() => _controller.stream;

  @override
  Future<Server?> activateServer(int id) async {
    _controller.add(_active);
    return _active;
  }

  @override
  Future<Server?> activateNextServer({int? excludingId}) async {
    _active = null;
    _controller.add(null);
    return null;
  }

  @override
  Future<void> removeServer(int id, {bool allowRemovingLast = false}) async {
    _active = null;
    _controller.add(null);
  }
}
```

This makes every shortcut-login e2e scenario start from an explicit active server
instead of relying on persisted state from another scenario.

- [ ] **Step 6: Seed a deterministic HA fixture**

Modify `docker/scripts/hass-init.py` to write a template light config before Home Assistant starts. Add this helper:

```python
def _write_test_fixture_config(config_dir: str) -> None:
    configuration_path = os.path.join(config_dir, "configuration.yaml")
    fixture = """
input_boolean:
  kitchen_light_backing:
    name: Kitchen Light Backing

light:
  - platform: template
    lights:
      kitchen_light:
        friendly_name: Kitchen Light
        value_template: "{{ is_state('input_boolean.kitchen_light_backing', 'on') }}"
        turn_on:
          service: input_boolean.turn_on
          target:
            entity_id: input_boolean.kitchen_light_backing
        turn_off:
          service: input_boolean.turn_off
          target:
            entity_id: input_boolean.kitchen_light_backing
"""
    with open(configuration_path, "a", encoding="utf-8") as config_file:
        config_file.write(fixture)
```

Call it in `run_command` immediately after `hass = HomeAssistant(...)`:

```python
_write_test_fixture_config(os.path.join(os.getcwd(), args.config))
```

Enable default area creation by changing:

```python
# await _create_default_areas(hass)
```

to:

```python
await _create_default_areas(hass)
```

- [ ] **Step 7: Add readiness assertions to feature files**

In `authorization.feature`, after each `Then I see {K.home.page} page`, add:

```gherkin
And I do not see home loading spinner
And I see {'light.kitchen_light'} light card
```

In `offline_banner.feature`, after reconnect assertions, add:

```gherkin
And I do not see home loading spinner
And I see {'light.kitchen_light'} light card
```

- [ ] **Step 8: Update generated integration test Dart files**

If the BDD generator command is available in this repo, run it. If it is not available, manually add imports and calls:

```dart
import './step/i_see_light_card.dart';
import './step/i_do_not_see_home_loading_spinner.dart';
```

and add:

```dart
await iDoNotSeeHomeLoadingSpinner($);
await iSeeLightCard($, 'light.kitchen_light');
```

after the matching Home/reconnect steps in `authorization_test.dart` and `offline_banner_test.dart`.

- [ ] **Step 9: Run static checks**

Run from `app/`:

```bash
flutter analyze
```

Expected: `No issues found!`

- [ ] **Step 10: Commit**

```bash
git add app/integration_test app/lib/ui/keys.dart app/lib/features/home/presentation/screens/home_page.dart docker/scripts/hass-init.py
git commit -m "test: assert home sync readiness in e2e"
```

---

## Task 12: Full Verification

**Files:**
- No source edits unless a verification failure identifies a defect in the prior tasks.

- [ ] **Step 1: Run focused unit/widget tests**

Run from `app/`:

```bash
flutter test \
  test/core/infrastructure/networking/connection/server_connection_manager_test.dart \
  test/application/session/active_server_session_controller_test.dart \
  test/application/scopes/server_scope_host_test.dart \
  test/application/session/server_sync_coordinator_test.dart \
  test/features/home/home_page_controller_test.dart \
  test/features/home/home_page_test.dart \
  test/features/entities/application/entity_states_provider_test.dart \
  test/features/entities/application/entity_service_controller_test.dart \
  test/features/settings/application/hub_status_provider_test.dart \
  test/features/auth/application/login_flow_controller_test.dart
```

Expected: all tests pass.

- [ ] **Step 2: Run full Flutter test suite**

Run from `app/`:

```bash
flutter test
```

Expected: all tests pass.

- [ ] **Step 3: Run analysis**

Run from `app/`:

```bash
flutter analyze
```

Expected: `No issues found!`

- [ ] **Step 4: Run integration tests when Docker/device prerequisites are available**

From repo root:

```bash
./scripts/setup_test_env.sh
```

Then from `app/`:

```bash
patrol test -t integration_test/test_bundle.dart
```

Expected:
- fresh login reaches Home;
- seeded light card is visible;
- offline banner appears on network loss;
- cached light remains visible offline;
- banner disappears after reconnect;
- seeded light remains visible after reconnect;
- server-side revocation routes away from Home.

Clean up from repo root:

```bash
./scripts/cleanup_test_env.sh
```

- [ ] **Step 5: Commit any verification fixes**

If verification required a code fix, commit it:

```bash
git add app docker scripts
git commit -m "fix: stabilize active session verification"
```

If no fixes were required, do not create an empty commit.
