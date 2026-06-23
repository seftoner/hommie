# Auth Session Ownership Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove overlapping auth/session/server cleanup responsibilities so login, session state, sign-out, server deletion, and auth-revocation recovery each have one owner.

**Architecture:** `LoginFlowController` remains the add-server OAuth use-case. `ActiveServerSession` becomes a pure active-server session state producer and no longer deletes credentials or servers. A new `ServerLifecycleController` owns destructive server cleanup, and a new `AuthRevocationHandler` observes revoked sessions and delegates cleanup to that lifecycle controller.

**Tech Stack:** Flutter, Riverpod 3 codegen, Dart sealed classes/interfaces, existing Home Assistant websocket package, focused provider/controller tests.

> **Phase A of** [`2026-06-23-connection-architecture-consolidation-design.md`](../specs/2026-06-23-connection-architecture-consolidation-design.md) (the A → B → C sequence). This phase removes destructive cleanup from `ActiveServerSession`. Task 2's edits to `_open` and `_handleTransportState` are **interim** — Phase B later rewrites `ActiveServerSession` as a pure projection and deletes those methods, so keep the Task 2 changes minimal and do not invest in hardening them.

## Global Constraints

- **Commits:** Conventional Commits — `<type>(<scope>): <description>`, imperative, lowercase, no trailing period. Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.
- **Codegen:** after any `@riverpod`/`@freezed`/annotation change, run `dart run build_runner build --delete-conflicting-outputs` from `app/` before tests. Compile errors referencing `*.g.dart`/`*.freezed.dart` mean stale codegen — rerun it.
- **Security:** never log tokens or PII.
- **Verification gate:** `flutter analyze` prints `No issues found!` and `flutter test` passes (only the pre-existing intentionally skipped tests) before a phase is considered done.
- **Branch:** work happens on the current feature branch; `main` is protected (PRs only). Commit only when the user asks.
- **Run location:** codegen/`pub get` from repo root; `flutter test`/`flutter run` from `app/`.

---

## File Structure

**Server lifecycle ownership:**
- Create: `app/lib/application/server_lifecycle/server_lifecycle_controller.dart` - one destructive owner for sign-out and server deletion cleanup.
- Generated: `app/lib/application/server_lifecycle/server_lifecycle_controller.g.dart`.
- Test: `app/test/application/server_lifecycle/server_lifecycle_controller_test.dart`.

**Auth revocation policy:**
- Create: `app/lib/application/session/auth_revocation_handler.dart` - observes revoked session state and calls lifecycle cleanup once per server.
- Generated: `app/lib/application/session/auth_revocation_handler.g.dart`.
- Test: `app/test/application/session/auth_revocation_handler_test.dart`.

**Session state producer cleanup:**
- Modify: `app/lib/application/session/active_server_session_controller.dart` - remove `AuthController` dependency and destructive sign-out calls.
- Generated: `app/lib/application/session/active_server_session_controller.g.dart`.
- Modify: `app/test/application/session/active_server_session_controller_test.dart`.

**Auth facade and UI callers:**
- Modify: `app/lib/features/auth/application/auth_controller.dart` - keep login facade, delegate sign-out to `ServerLifecycleController`.
- Generated: `app/lib/features/auth/application/auth_controller.g.dart`.
- Create: `app/test/features/auth/application/auth_controller_test.dart`.
- Modify: `app/lib/features/settings/presentation/screens/settings_page.dart` - sign out active server through lifecycle controller.
- Modify: `app/lib/features/servers/application/servers_list_controller.dart` - delete server through lifecycle controller.
- Generated: `app/lib/features/servers/application/servers_list_controller.g.dart`.

**App bootstrap:**
- Modify: `app/lib/app.dart` - initialize `authRevocationHandlerProvider` beside `activeServerSessionProvider`.

**Dead action-chain cleanup:**
- Delete: `app/lib/features/auth/infrastructure/actions/create_server_action.dart`.
- Delete: `app/lib/features/auth/infrastructure/actions/oauth_login_attempt_action.dart`.
- Delete: `app/lib/features/auth/infrastructure/actions/get_config_action.dart`.
- Delete: `app/lib/features/auth/infrastructure/actions/activate_server_action.dart`.
- Delete: `app/lib/features/auth/infrastructure/actions/activate_server_if_exist_action.dart`.
- Delete: `app/lib/features/auth/infrastructure/actions/delete_server_action.dart`.
- Delete: `app/lib/features/auth/infrastructure/actions/sign_out_server_action.dart`.
- Delete: `app/lib/core/infrastructure/actions/action_chain.dart`.
- Delete: `app/lib/core/infrastructure/actions/action_runner.dart`.
- Delete: `app/lib/core/infrastructure/actions/haction.dart`.
- Delete: `app/lib/core/infrastructure/actions/haction_execution_context.dart`.

---

## Task 1: Add Server Lifecycle Controller

**Files:**
- Create: `app/lib/application/server_lifecycle/server_lifecycle_controller.dart`
- Generated: `app/lib/application/server_lifecycle/server_lifecycle_controller.g.dart`
- Test: `app/test/application/server_lifecycle/server_lifecycle_controller_test.dart`

- [ ] **Step 1: Write the failing lifecycle tests**

Create `app/test/application/server_lifecycle/server_lifecycle_controller_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/core/infrastructure/networking/connection/i_server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/features/home/domain/repositories/i_home_view_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/home_view_repository_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:oauth2/oauth2.dart';

void main() {
  test('signOutServer disconnects, clears credentials, deletes home view, and removes server', () async {
    final connectionManager = _FakeConnectionManager();
    final authRepository = _FakeAuthRepository();
    final serverManager = _FakeServerManager(activeServer: const Server(id: 1, name: 'Home'));
    final homeViewRepository = _FakeHomeViewRepository();
    final container = _container(
      connectionManager: connectionManager,
      authRepository: authRepository,
      serverManager: serverManager,
      homeViewRepository: homeViewRepository,
    );
    addTearDown(container.dispose);

    await container.read(serverLifecycleControllerProvider).signOutServer(1);

    expect(connectionManager.disconnectCalls, [1]);
    expect(authRepository.signOutCalls, [1]);
    expect(homeViewRepository.deleteCalls, 1);
    expect(serverManager.removed, [1]);
    expect(serverManager.allowRemovingLastValues, [true]);
  });

  test('deleteServer uses the same authenticated cleanup path', () async {
    final connectionManager = _FakeConnectionManager();
    final authRepository = _FakeAuthRepository();
    final serverManager = _FakeServerManager(activeServer: const Server(id: 1, name: 'Home'));
    final homeViewRepository = _FakeHomeViewRepository();
    final container = _container(
      connectionManager: connectionManager,
      authRepository: authRepository,
      serverManager: serverManager,
      homeViewRepository: homeViewRepository,
    );
    addTearDown(container.dispose);

    await container.read(serverLifecycleControllerProvider).deleteServer(1);

    expect(connectionManager.disconnectCalls, [1]);
    expect(authRepository.signOutCalls, [1]);
    expect(homeViewRepository.deleteCalls, 1);
    expect(serverManager.removed, [1]);
  });

  test('signOutActiveServer is a no-op when no active server exists', () async {
    final connectionManager = _FakeConnectionManager();
    final authRepository = _FakeAuthRepository();
    final serverManager = _FakeServerManager(activeServer: null);
    final homeViewRepository = _FakeHomeViewRepository();
    final container = _container(
      connectionManager: connectionManager,
      authRepository: authRepository,
      serverManager: serverManager,
      homeViewRepository: homeViewRepository,
    );
    addTearDown(container.dispose);

    await container.read(serverLifecycleControllerProvider).signOutActiveServer();

    expect(connectionManager.disconnectCalls, isEmpty);
    expect(authRepository.signOutCalls, isEmpty);
    expect(homeViewRepository.deleteCalls, 0);
    expect(serverManager.removed, isEmpty);
  });

  test('signOutServer throws lifecycle exception when credential cleanup fails', () async {
    final container = _container(
      connectionManager: _FakeConnectionManager(),
      authRepository: _FakeAuthRepository(failure: const AuthFailure.storage()),
      serverManager: _FakeServerManager(activeServer: const Server(id: 1, name: 'Home')),
      homeViewRepository: _FakeHomeViewRepository(),
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(serverLifecycleControllerProvider).signOutServer(1),
      throwsA(isA<ServerLifecycleException>()),
    );
  });
}

ProviderContainer _container({
  required _FakeConnectionManager connectionManager,
  required _FakeAuthRepository authRepository,
  required _FakeServerManager serverManager,
  required _FakeHomeViewRepository homeViewRepository,
}) {
  return ProviderContainer(
    overrides: [
      serverConnectionManagerProvider.overrideWithValue(connectionManager),
      authRepositoryProvider.overrideWithValue(authRepository),
      serverManagerProvider.overrideWithValue(serverManager),
      homeViewRepositoryForServerProvider.overrideWith((_, _) => homeViewRepository),
    ],
  );
}

class _FakeConnectionManager implements IServerConnectionManager {
  final disconnectCalls = <int>[];

  @override
  void disconnect(int serverId) => disconnectCalls.add(serverId);

  @override
  Future<IHAConnection> getConnection(int serverId) => throw UnimplementedError();

  @override
  Future<void> reconnect(int serverId) async {}

  @override
  void setActiveServer(int? serverId) {}
}

class _FakeAuthRepository implements IAuthRepository {
  _FakeAuthRepository({this.failure});

  final AuthFailure? failure;
  final signOutCalls = <int>[];

  @override
  Future<Either<AuthFailure, Unit>> signOut(int serverId) async {
    signOutCalls.add(serverId);
    final failure = this.failure;
    if (failure != null) {
      return left(failure);
    }
    return right(unit);
  }

  @override
  Future<Either<AuthFailure, Credentials>> getCredentials(int serverId) async {
    return left(const AuthFailure.missingCredentials());
  }

  @override
  Future<bool> isLoggedIn(int serverId) async => false;

  @override
  Future<Either<AuthFailure, Credentials>> login({
    required int serverId,
    required String serverUrl,
    required Uri redirectUrl,
    required AuthResponseHandler handler,
  }) async {
    return left(const AuthFailure.server());
  }
}

class _FakeServerManager implements IServerManager {
  _FakeServerManager({required this.activeServer});

  Server? activeServer;
  final removed = <int>[];
  final allowRemovingLastValues = <bool>[];

  @override
  Future<Server> addServer(Server config) async => config;

  @override
  Future<Server?> getActiveServer() async => activeServer;

  @override
  Future<List<Server>> getServers() async => [
    if (activeServer != null) activeServer!,
  ];

  @override
  Stream<Server?> watchActiveServer() => const Stream.empty();

  @override
  Future<Server?> activateServer(int id) async => activeServer;

  @override
  Future<Server?> activateNextServer({int? excludingId}) async => activeServer;

  @override
  Future<void> removeServer(int id, {bool allowRemovingLast = false}) async {
    removed.add(id);
    allowRemovingLastValues.add(allowRemovingLast);
    activeServer = null;
  }
}

class _FakeHomeViewRepository implements IHomeViewRepository {
  int deleteCalls = 0;

  @override
  Future<void> delete() async {
    deleteCalls += 1;
  }

  @override
  Future<HomeViewConf?> get() async => null;

  @override
  Future<HomeViewConf> save(HomeViewConf conf) async => conf;
}
```

- [ ] **Step 2: Run the lifecycle tests and verify they fail**

Run from `app/`:

```bash
flutter test test/application/server_lifecycle/server_lifecycle_controller_test.dart
```

Expected: FAIL because `server_lifecycle_controller.dart` does not exist.

- [ ] **Step 3: Add `ServerLifecycleController`**

Create `app/lib/application/server_lifecycle/server_lifecycle_controller.dart`:

```dart
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/home/infrastructure/providers/home_view_repository_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_lifecycle_controller.g.dart';

abstract interface class IServerLifecycleController {
  Future<void> signOutActiveServer();
  Future<void> signOutServer(int serverId);
  Future<void> deleteServer(int serverId);
}

final class ServerLifecycleException implements Exception {
  const ServerLifecycleException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() {
    final cause = this.cause;
    if (cause == null) {
      return message;
    }
    return '$message Cause: $cause';
  }
}

final class ServerLifecycleController implements IServerLifecycleController {
  const ServerLifecycleController(this._ref);

  final Ref _ref;

  @override
  Future<void> signOutActiveServer() async {
    final activeServer = await _ref.read(serverManagerProvider).getActiveServer();
    final serverId = activeServer?.id;
    if (serverId == null) {
      return;
    }
    await signOutServer(serverId);
  }

  @override
  Future<void> signOutServer(int serverId) {
    return _removeAuthenticatedServer(serverId);
  }

  @override
  Future<void> deleteServer(int serverId) {
    return _removeAuthenticatedServer(serverId);
  }

  Future<void> _removeAuthenticatedServer(int serverId) async {
    _ref.read(serverConnectionManagerProvider).disconnect(serverId);

    final signOutResult = await _ref.read(authRepositoryProvider).signOut(serverId);
    signOutResult.match(
      (failure) => throw ServerLifecycleException(
        'Failed to clear credentials for server $serverId.',
        failure,
      ),
      (_) {},
    );

    await _ref.read(homeViewRepositoryForServerProvider(serverId)).delete();
    await _ref.read(serverManagerProvider).removeServer(
      serverId,
      allowRemovingLast: true,
    );
  }
}

@Riverpod(
  keepAlive: true,
  dependencies: [
    serverConnectionManager,
    authRepository,
    serverManager,
  ],
)
IServerLifecycleController serverLifecycleController(Ref ref) {
  return ServerLifecycleController(ref);
}
```

- [ ] **Step 4: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: generates `app/lib/application/server_lifecycle/server_lifecycle_controller.g.dart`.

- [ ] **Step 5: Run lifecycle tests**

Run from `app/`:

```bash
flutter test test/application/server_lifecycle/server_lifecycle_controller_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/application/server_lifecycle/server_lifecycle_controller.dart app/lib/application/server_lifecycle/server_lifecycle_controller.g.dart app/test/application/server_lifecycle/server_lifecycle_controller_test.dart
git commit -m "feat: add server lifecycle controller"
```

---

## Task 2: Remove Destructive Sign-Out From Active Session

**Files:**
- Modify: `app/lib/application/session/active_server_session_controller.dart`
- Generated: `app/lib/application/session/active_server_session_controller.g.dart`
- Modify: `app/test/application/session/active_server_session_controller_test.dart`

- [ ] **Step 1: Update active session tests to assert state only**

In `app/test/application/session/active_server_session_controller_test.dart`:

1. Remove the import:

```dart
import 'package:hommie/features/auth/application/auth_controller.dart';
```

2. Delete `_FakeAuthController`.

3. Change `makeContainer` to remove the `authController` parameter and override:

```dart
  ProviderContainer makeContainer({
    required Server? activeServer,
    required AuthState authState,
    _AuthStateSource? authStateSource,
    _FakeConnectionManager? connectionManager,
  }) {
    final manager = connectionManager ?? _FakeConnectionManager();
    final source = authStateSource ?? _AuthStateSource(authState);

    return ProviderContainer(
      overrides: [
        serverManagerProvider.overrideWithValue(
          _FakeServerManager(activeServer),
        ),
        authStateProvider.overrideWith((_) => source.value),
        serverConnectionManagerProvider.overrideWithValue(manager),
      ],
    );
  }
```

4. Rename and change the three destructive-sign-out tests:

```dart
test('maps auth failure connection state to revoked session', () async {
  final container = makeContainer(
    activeServer: server,
    authState: AuthState.authenticated(credentials()),
  );
  addTearDown(container.dispose);

  await waitForSession(container, (state) => state is OnlineServerSession);

  container.read(serverConnectionStateProvider.notifier).setAuthFailure();

  final state = await waitForSession(
    container,
    (state) => state is AuthRevokedServerSession,
  );
  expect(state, isA<AuthRevokedServerSession>());
});

test('maps auth failure during open to revoked session', () async {
  final manager = _FakeConnectionManager(
    error: AuthenticationError('bad token'),
  );
  final container = makeContainer(
    activeServer: server,
    authState: AuthState.authenticated(credentials()),
    connectionManager: manager,
  );
  addTearDown(container.dispose);

  final state = await waitForSession(
    container,
    (state) => state is AuthRevokedServerSession,
  );

  expect(state, isA<AuthRevokedServerSession>());
});

test('maps token resolution failure during open to revoked session', () async {
  final manager = _FakeConnectionManager(
    error: ConnectionError(
      'Failed to resolve token: AuthFailure.unauthenticated()',
    ),
  );
  final container = makeContainer(
    activeServer: server,
    authState: AuthState.authenticated(credentials()),
    connectionManager: manager,
  );
  addTearDown(container.dispose);

  final state = await waitForSession(
    container,
    (state) => state is AuthRevokedServerSession,
  );

  expect(state, isA<AuthRevokedServerSession>());
});
```

5. Replace `revoked auth state signs out once` with:

```dart
test('revoked auth state maps to revoked session without cleanup side effects', () async {
  final authStateSource = _AuthStateSource(const AuthState.revoked());
  final container = makeContainer(
    activeServer: server,
    authState: authStateSource.value,
    authStateSource: authStateSource,
  );
  addTearDown(container.dispose);

  final state = await waitForSession(
    container,
    (state) => state is AuthRevokedServerSession,
  );

  expect(state, isA<AuthRevokedServerSession>());
});
```

- [ ] **Step 2: Run the active session test and verify it fails**

Run from `app/`:

```bash
flutter test test/application/session/active_server_session_controller_test.dart
```

Expected: FAIL because `ActiveServerSession` still depends on `authControllerProvider` and still calls sign-out.

- [ ] **Step 3: Remove destructive cleanup from `ActiveServerSession`**

Modify `app/lib/application/session/active_server_session_controller.dart`:

1. Remove this import:

```dart
import 'package:hommie/features/auth/application/auth_controller.dart';
```

2. Remove `authController` from the provider dependency list.

3. Remove these fields:

```dart
  final _signedOutServerIds = <int>{};
  bool _signingOut = false;
```

4. Remove this block from `_setInputs`:

```dart
    if (nextServerId != null && nextAuthenticated) {
      _signedOutServerIds.remove(nextServerId);
    }
```

5. In `_stateForCurrentInputs`, change revoked handling to:

```dart
    if (auth is Revoked) {
      return _remember(AuthRevokedServerSession(server));
    }
```

6. In `_open`, change both auth-failure branches to publish state only:

```dart
    } on AuthenticationError {
      if (_isCurrent(serverId, revision) && _hasAuthenticatedSession) {
        _publish(AuthRevokedServerSession(server));
      }
    } catch (error, stackTrace) {
      if (isConnectionAuthenticationFailure(error) &&
          _isCurrent(serverId, revision) &&
          _hasAuthenticatedSession) {
        _publish(AuthRevokedServerSession(server));
        return;
      }
```

7. In `_handleTransportState`, change auth failure handling to:

```dart
      case HAServerConnectionState.authFailure:
        _publish(AuthRevokedServerSession(server));
```

8. Delete `_triggerSignOut`.

- [ ] **Step 4: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: updates `app/lib/application/session/active_server_session_controller.g.dart`.

- [ ] **Step 5: Run active session tests**

Run from `app/`:

```bash
flutter test test/application/session/active_server_session_controller_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/application/session/active_server_session_controller.dart app/lib/application/session/active_server_session_controller.g.dart app/test/application/session/active_server_session_controller_test.dart
git commit -m "refactor: keep active session side-effect free"
```

---

## Task 3: Add Auth Revocation Handler

**Files:**
- Create: `app/lib/application/session/auth_revocation_handler.dart`
- Generated: `app/lib/application/session/auth_revocation_handler.g.dart`
- Test: `app/test/application/session/auth_revocation_handler_test.dart`
- Modify: `app/lib/app.dart`

- [ ] **Step 1: Write the failing revocation handler tests**

Create `app/test/application/session/auth_revocation_handler_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/auth_revocation_handler.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

class _FakeLifecycleController implements IServerLifecycleController {
  final signOutCalls = <int>[];

  @override
  Future<void> deleteServer(int serverId) async {}

  @override
  Future<void> signOutActiveServer() async {}

  @override
  Future<void> signOutServer(int serverId) async {
    signOutCalls.add(serverId);
  }
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

void main() {
  test('signs out revoked server once', () async {
    final lifecycle = _FakeLifecycleController();
    final container = ProviderContainer(
      overrides: [
        serverLifecycleControllerProvider.overrideWithValue(lifecycle),
        activeServerSessionProvider.overrideWithValue(
          const AuthRevokedServerSession(Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    container.read(authRevocationHandlerProvider);
    await container.pump();
    container.read(authRevocationHandlerProvider);
    await container.pump();

    expect(lifecycle.signOutCalls, [1]);
  });

  test('does not sign out online session', () async {
    final lifecycle = _FakeLifecycleController();
    final container = ProviderContainer(
      overrides: [
        serverLifecycleControllerProvider.overrideWithValue(lifecycle),
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: _FakeConnection(),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    container.read(authRevocationHandlerProvider);
    await container.pump();

    expect(lifecycle.signOutCalls, isEmpty);
  });
}
```

- [ ] **Step 2: Run the revocation handler test and verify it fails**

Run from `app/`:

```bash
flutter test test/application/session/auth_revocation_handler_test.dart
```

Expected: FAIL because `auth_revocation_handler.dart` does not exist.

- [ ] **Step 3: Add `auth_revocation_handler.dart`**

Create `app/lib/application/session/auth_revocation_handler.dart`:

```dart
import 'dart:async';

import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_revocation_handler.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [ActiveServerSession, serverLifecycleController],
)
void authRevocationHandler(Ref ref) {
  final handledServerIds = <int>{};

  ref.listen(activeServerSessionProvider, (_, next) {
    if (next is AuthRevokedServerSession) {
      final serverId = next.activeServer.id;
      if (serverId != null && handledServerIds.add(serverId)) {
        unawaited(
          ref.read(serverLifecycleControllerProvider).signOutServer(serverId),
        );
      }
      return;
    }

    if (next is OnlineServerSession) {
      final serverId = next.activeServer.id;
      if (serverId != null) {
        handledServerIds.remove(serverId);
      }
    }
  }, fireImmediately: true);
}
```

- [ ] **Step 4: Initialize the revocation handler at app startup**

Modify `app/lib/app.dart`:

```dart
import 'package:hommie/application/session/auth_revocation_handler.dart';
```

Change `_ServiceInitializer`:

```dart
@Dependencies([ActiveServerSession, authRevocationHandler])
class _ServiceInitializer extends ConsumerWidget {
  const _ServiceInitializer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(activeServerSessionProvider);
    ref.watch(authRevocationHandlerProvider);
    return child;
  }
}
```

- [ ] **Step 5: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: generates `app/lib/application/session/auth_revocation_handler.g.dart`.

- [ ] **Step 6: Run revocation handler tests**

Run from `app/`:

```bash
flutter test test/application/session/auth_revocation_handler_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/application/session/auth_revocation_handler.dart app/lib/application/session/auth_revocation_handler.g.dart app/lib/app.dart app/test/application/session/auth_revocation_handler_test.dart
git commit -m "feat: handle auth revocation outside session state"
```

---

## Task 4: Route Auth And Server UI Through Lifecycle Controller

**Files:**
- Modify: `app/lib/features/auth/application/auth_controller.dart`
- Generated: `app/lib/features/auth/application/auth_controller.g.dart`
- Create: `app/test/features/auth/application/auth_controller_test.dart`
- Modify: `app/lib/features/settings/presentation/screens/settings_page.dart`
- Modify: `app/lib/features/servers/application/servers_list_controller.dart`
- Generated: `app/lib/features/servers/application/servers_list_controller.g.dart`

- [ ] **Step 1: Write AuthController facade tests**

Create `app/test/features/auth/application/auth_controller_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/login_flow_controller.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';

class _FakeLifecycleController implements IServerLifecycleController {
  final signOutCalls = <int>[];

  @override
  Future<void> deleteServer(int serverId) async {}

  @override
  Future<void> signOutActiveServer() async {}

  @override
  Future<void> signOutServer(int serverId) async {
    signOutCalls.add(serverId);
  }
}

class _FakeLoginFlowController extends LoginFlowController {
  _FakeLoginFlowController() : super(_FakeRef());

  final loginCalls = <ServerUrl>[];

  @override
  Future<void> login(
    ServerUrl serverUrl, {
    required AuthResponseHandler handler,
  }) async {
    loginCalls.add(serverUrl);
  }
}

class _FakeRef implements Ref {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  test('signOut delegates to server lifecycle controller', () async {
    final lifecycle = _FakeLifecycleController();
    final container = ProviderContainer(
      overrides: [
        serverLifecycleControllerProvider.overrideWithValue(lifecycle),
        loginFlowControllerProvider.overrideWithValue(_FakeLoginFlowController()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(authControllerProvider).signOut(1);

    expect(lifecycle.signOutCalls, [1]);
  });
}
```

- [ ] **Step 2: Run AuthController test and verify it fails**

Run from `app/`:

```bash
flutter test test/features/auth/application/auth_controller_test.dart
```

Expected: FAIL because `AuthController.signOut` still uses the action chain.

- [ ] **Step 3: Simplify `AuthController`**

Modify `app/lib/features/auth/application/auth_controller.dart` imports to:

```dart
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/features/auth/application/login_flow_controller.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
```

Change dependencies:

```dart
@Dependencies([loginFlowController, serverLifecycleController])
class AuthController {
```

Change `signOut`:

```dart
  Future<void> signOut(int serverId) {
    return ref.read(serverLifecycleControllerProvider).signOutServer(serverId);
  }
```

Change the provider annotation:

```dart
@Riverpod(
  keepAlive: true,
  dependencies: [loginFlowController, serverLifecycleController],
)
AuthController authController(Ref ref) {
  return AuthController(ref);
}
```

- [ ] **Step 4: Route Settings sign-out directly through lifecycle**

Modify `app/lib/features/settings/presentation/screens/settings_page.dart`:

1. Replace imports:

```dart
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
```

Remove:

```dart
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
```

2. Change the dependency annotation:

```dart
@Dependencies([serverLifecycleController])
class SettingsPage extends ConsumerWidget {
```

3. Change the sign-out button handler:

```dart
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(serverLifecycleControllerProvider)
                  .signOutActiveServer();
            },
```

- [ ] **Step 5: Route server deletion through lifecycle**

Modify `app/lib/features/servers/application/servers_list_controller.dart`:

```dart
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'servers_list_controller.g.dart';

@Riverpod(dependencies: [serverManager, serverLifecycleController])
class ServersListController extends _$ServersListController {
  @override
  Future<List<Server>> build() async {
    final serverManager = ref.watch(serverManagerProvider);
    return serverManager.getServers();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final serverManager = ref.read(serverManagerProvider);
    try {
      final servers = await serverManager.getServers();
      state = AsyncData(servers);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> addServer(Server server) async {
    final serverManager = ref.read(serverManagerProvider);
    await serverManager.addServer(server);
    await refresh();
  }

  Future<void> removeServer(int serverId) async {
    await ref.read(serverLifecycleControllerProvider).deleteServer(serverId);
    await refresh();
  }
}
```

- [ ] **Step 6: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: updates `auth_controller.g.dart` and `servers_list_controller.g.dart`.

- [ ] **Step 7: Run focused tests**

Run from `app/`:

```bash
flutter test test/features/auth/application/auth_controller_test.dart
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add app/lib/features/auth/application/auth_controller.dart app/lib/features/auth/application/auth_controller.g.dart app/test/features/auth/application/auth_controller_test.dart app/lib/features/settings/presentation/screens/settings_page.dart app/lib/features/servers/application/servers_list_controller.dart app/lib/features/servers/application/servers_list_controller.g.dart
git commit -m "refactor: route server cleanup through lifecycle controller"
```

---

## Task 5: Delete Dead Action Chain Code

**Files:**
- Delete: `app/lib/features/auth/infrastructure/actions/create_server_action.dart`
- Delete: `app/lib/features/auth/infrastructure/actions/oauth_login_attempt_action.dart`
- Delete: `app/lib/features/auth/infrastructure/actions/get_config_action.dart`
- Delete: `app/lib/features/auth/infrastructure/actions/activate_server_action.dart`
- Delete: `app/lib/features/auth/infrastructure/actions/activate_server_if_exist_action.dart`
- Delete: `app/lib/features/auth/infrastructure/actions/delete_server_action.dart`
- Delete: `app/lib/features/auth/infrastructure/actions/sign_out_server_action.dart`
- Delete: `app/lib/core/infrastructure/actions/action_chain.dart`
- Delete: `app/lib/core/infrastructure/actions/action_runner.dart`
- Delete: `app/lib/core/infrastructure/actions/haction.dart`
- Delete: `app/lib/core/infrastructure/actions/haction_execution_context.dart`

- [ ] **Step 1: Verify no production imports remain**

Run from repo root:

```bash
rg "ActionChain|ActionRunner|HAction|CreateServerAction|OAuthLoginAttemptAction|GetConfigAction|ActivateServerAction|ActivateServerIfExistAction|DeleteServerAction|SignOutServerAction" app/lib --glob '!*.g.dart' --glob '!*.freezed.dart'
```

Expected: no output after Task 4.

- [ ] **Step 2: Delete action-chain files**

Delete these files:

```text
app/lib/features/auth/infrastructure/actions/create_server_action.dart
app/lib/features/auth/infrastructure/actions/oauth_login_attempt_action.dart
app/lib/features/auth/infrastructure/actions/get_config_action.dart
app/lib/features/auth/infrastructure/actions/activate_server_action.dart
app/lib/features/auth/infrastructure/actions/activate_server_if_exist_action.dart
app/lib/features/auth/infrastructure/actions/delete_server_action.dart
app/lib/features/auth/infrastructure/actions/sign_out_server_action.dart
app/lib/core/infrastructure/actions/action_chain.dart
app/lib/core/infrastructure/actions/action_runner.dart
app/lib/core/infrastructure/actions/haction.dart
app/lib/core/infrastructure/actions/haction_execution_context.dart
```

- [ ] **Step 3: Verify deletion did not leave imports**

Run from repo root:

```bash
rg "core/infrastructure/actions|features/auth/infrastructure/actions|ActionChain|ActionRunner|HAction" app/lib app/test --glob '!*.g.dart' --glob '!*.freezed.dart'
```

Expected: no output.

- [ ] **Step 4: Commit**

```bash
git add -A app/lib/features/auth/infrastructure/actions app/lib/core/infrastructure/actions
git commit -m "refactor: remove unused auth action chain"
```

---

## Task 6: Final Architecture Guard And Verification

**Files:**
- No production edits unless verification finds a defect.

- [ ] **Step 1: Verify ownership boundaries**

Run from repo root:

```bash
rg --glob '!*.g.dart' --glob '!*.freezed.dart' "authControllerProvider|serverLifecycleControllerProvider|activeServerSessionProvider|serverConnectionStateProvider|removeServer\\(|signOut\\(" app/lib/application app/lib/features
```

Expected:
- `active_server_session_controller.dart` does not import or read `authControllerProvider`.
- `auth_revocation_handler.dart` is the only file that reacts to `AuthRevokedServerSession` by calling lifecycle cleanup.
- `settings_page.dart`, `servers_list_controller.dart`, and `auth_controller.dart` call `serverLifecycleControllerProvider` for destructive cleanup.
- `login_flow_controller.dart` owns add-server login and rollback only.

- [ ] **Step 2: Verify old action chain is gone**

Run from repo root:

```bash
rg "ActionChain|ActionRunner|HAction|haction|features/auth/infrastructure/actions" app/lib app/test
```

Expected: no output.

- [ ] **Step 3: Run focused tests**

Run from `app/`:

```bash
flutter test \
  test/application/server_lifecycle/server_lifecycle_controller_test.dart \
  test/application/session/auth_revocation_handler_test.dart \
  test/application/session/active_server_session_controller_test.dart \
  test/features/auth/application/auth_controller_test.dart \
  test/features/auth/application/login_flow_controller_test.dart
```

Expected: all focused tests pass.

- [ ] **Step 4: Run full app verification**

Run from `app/`:

```bash
flutter analyze
flutter test
```

Expected:
- `flutter analyze` prints `No issues found!`
- `flutter test` passes with only existing intentionally skipped tests.

- [ ] **Step 5: Commit verification fixes only if needed**

If verification required code changes:

```bash
git add app
git commit -m "fix: verify auth session ownership cleanup"
```

If verification required no code changes, do not create an empty commit.

---

## Final Ownership Rules

After this plan:

1. `LoginFlowController`
   - adds a temporary server;
   - performs OAuth;
   - fetches Home Assistant config;
   - updates server metadata;
   - activates the server;
   - rolls back incomplete login.

2. `ActiveServerSession`
   - reads active server and auth state;
   - opens or closes the active websocket session through `ServerConnectionManager`;
   - publishes `ActiveServerSessionState`;
   - does not delete credentials, servers, or cached view data.

3. `AuthRevocationHandler`
   - watches session state;
   - reacts to `AuthRevokedServerSession`;
   - delegates cleanup once per server to `ServerLifecycleController`.

4. `ServerLifecycleController`
   - disconnects server connection;
   - clears/revokes credentials through `IAuthRepository.signOut`;
   - deletes server-specific home view config;
   - removes the server and lets `ServerManager` activate the next server.

5. `AuthController`
   - remains a UI facade for auth entry points;
   - delegates login to `LoginFlowController`;
   - delegates sign-out to `ServerLifecycleController`.
