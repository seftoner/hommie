# Scalable Connection Capabilities Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make connection-dependent features scalable by centralizing scoped live-connection access and exposing domain-level capabilities instead of making repositories, controllers, and widgets inspect raw connection/session state.

**Architecture:** `ServerScopeHost` is the active-server boundary. It always provides `serverScopeIdProvider` and `serverScopeServerProvider` for an active server, and it provides `serverScopeConnectionProvider` only when the session is online. Cached read repositories depend on scoped server identity and never depend on the websocket. Live commands and subscriptions depend on the scoped connection; command services use a small reader wrapper that converts a missing scoped connection into a typed command-unavailable exception. UI and page controllers consume capability providers such as `remoteCommandAvailabilityProvider`, `homeCapabilitiesProvider`, and `offlineBannerVisibilityProvider` instead of watching raw `ActiveServerSessionState` or `serverConnectionStateProvider` transport state directly.

**Tech Stack:** Flutter, Riverpod 3 codegen, Dart sealed/value classes, existing `home_assistant_websocket` package, Drift cache repositories, widget/provider tests.

---

## File Structure

**Scoped live connection contract:**
- Modify: `app/lib/core/infrastructure/networking/connection/server_scope_provider.dart` - document the sync scoped connection provider and own `NoOnlineServerConnectionException`.
- Modify: `app/lib/application/scopes/server_scope_host.dart` - throw the provider-owned `NoOnlineServerConnectionException` from the scoped connection override.
- Create: `app/lib/application/session/scoped_connection_reader.dart` - `requireScopedConnection(read)` for command services.
- Test: `app/test/application/session/scoped_connection_reader_test.dart`.

**Capability layer:**
- Create: `app/lib/application/capabilities/remote_command_availability.dart` - app-level command availability and block reasons.
- Generated: `app/lib/application/capabilities/remote_command_availability.g.dart`.
- Create: `app/lib/application/capabilities/offline_banner_visibility_provider.dart` - single source for global offline banner visibility.
- Generated: `app/lib/application/capabilities/offline_banner_visibility_provider.g.dart`.
- Test: `app/test/application/capabilities/remote_command_availability_test.dart`.
- Test: `app/test/application/capabilities/offline_banner_visibility_provider_test.dart`.

**Home view capabilities:**
- Create: `app/lib/features/home/application/home_capabilities_provider.dart` - screen-level Home policy derived from session/sync/command state.
- Generated: `app/lib/features/home/application/home_capabilities_provider.g.dart`.
- Modify: `app/lib/features/home/application/home_page_controller.dart` - consume `homeCapabilitiesProvider` instead of raw session/sync providers.
- Test: `app/test/features/home/home_capabilities_provider_test.dart`.
- Modify: `app/test/features/home/home_page_controller_test.dart`.

**Entity commands and live states:**
- Modify: `app/lib/features/entities/application/entity_service_controller.dart` - require the scoped live connection through `requireScopedConnection(_ref.read)` and throw typed command-unavailable failure while offline.
- Modify: `app/lib/features/entities/application/entity_states_provider.dart` - watch `serverScopeConnectionProvider` and stop subscriptions when the scoped connection is unavailable.
- Test: `app/test/features/entities/application/entity_service_controller_test.dart`.
- Test: `app/test/features/entities/application/entity_states_provider_test.dart`.

**UI usage:**
- Modify: `app/lib/features/entities/presentation/widgets/light_card.dart` - disable command controls through `remoteCommandAvailabilityProvider`.
- Modify: `app/lib/ui/screens/widgets/offline_container.dart` - use `offlineBannerVisibilityProvider`.
- Test: `app/test/features/entities/presentation/light_card_test.dart`.
- Test: `app/test/ui/screens/widgets/offline_container_test.dart`.

**Settings status presentation:**
- Modify: `app/lib/features/settings/application/hub_status_provider.dart` - expose a `HubConnectionStatus` view model instead of raw `ActiveServerSessionState`.
- Generated: `app/lib/features/settings/application/hub_status_provider.freezed.dart`.
- Generated: `app/lib/features/settings/application/hub_status_provider.g.dart`.
- Modify: `app/lib/features/settings/presentation/screens/hub_page.dart` - render connection labels/descriptions from `HubConnectionStatus`.
- Modify: `app/test/features/settings/application/hub_status_provider_test.dart`.

---

## Task 1: Harden Scoped Live Connection Contract

**Files:**
- Modify: `app/lib/core/infrastructure/networking/connection/server_scope_provider.dart`
- Modify: `app/lib/application/scopes/server_scope_host.dart`
- Create: `app/lib/application/session/scoped_connection_reader.dart`
- Test: `app/test/application/session/scoped_connection_reader_test.dart`
- Modify: `app/test/application/scopes/server_scope_host_test.dart`

- [ ] **Step 1: Move the offline scoped-connection exception to the provider file**

Move `NoOnlineServerConnectionException` from `app/lib/application/scopes/server_scope_host.dart` into `app/lib/core/infrastructure/networking/connection/server_scope_provider.dart`, next to `serverScopeConnectionProvider`.

Also fix the stale doc comment in `server_scope_provider.dart`. The provider is synchronous, so the example should read:

```dart
@Riverpod(dependencies: [serverScopeConnection])
IHAConnection myLiveConnectionConsumer(Ref ref) {
  final connection = ref.watch(serverScopeConnectionProvider);
  return connection;
}
```

- [ ] **Step 2: Keep `ServerScopeHost` as the only override owner**

Update `app/lib/application/scopes/server_scope_host.dart` so it imports `NoOnlineServerConnectionException` from `server_scope_provider.dart` and no longer declares the exception itself:

```dart
serverScopeConnectionProvider.overrideWith((_) {
  if (connection == null) {
    throw const NoOnlineServerConnectionException();
  }
  return connection;
}),
```

- [ ] **Step 3: Add a focused test for the missing scoped connection**

In `app/test/application/scopes/server_scope_host_test.dart`, add a widget probe that reads `serverScopeConnectionProvider` while the active server is offline and verifies it throws `NoOnlineServerConnectionException`.

Use a probe like this:

```dart
class _ConnectionFailureProbe extends ConsumerWidget {
  const _ConnectionFailureProbe();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    try {
      ref.watch(serverScopeConnectionProvider);
      return const Text('connected');
    } on NoOnlineServerConnectionException {
      return const Text('offline');
    }
  }
}
```

Then add the test:

```dart
testWidgets('scoped connection throws while active server is offline', (
  tester,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(
            activeServer: Server(id: 7, name: 'Home'),
          ),
        ),
      ],
      child: const MaterialApp(
        home: ServerScopeHost(child: _ConnectionFailureProbe()),
      ),
    ),
  );

  expect(find.text('offline'), findsOneWidget);
});
```

- [ ] **Step 4: Add the scoped command reader tests**

Create `app/test/application/session/scoped_connection_reader_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/scoped_connection_reader.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';

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
  test('requireScopedConnection returns scoped connection', () {
    final connection = _FakeConnection();
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWithValue(connection),
      ],
    );
    addTearDown(container.dispose);

    expect(requireScopedConnection(container.read), same(connection));
  });

  test('requireScopedConnection converts missing scoped connection', () {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWith(
          (_) => throw const NoOnlineServerConnectionException(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(
      () => requireScopedConnection(container.read),
      throwsA(isA<RemoteCommandUnavailableException>()),
    );
  });
}
```

- [ ] **Step 5: Run the scoped connection tests and verify they fail**

Run from `app/`:

```bash
flutter test test/application/session/scoped_connection_reader_test.dart test/application/scopes/server_scope_host_test.dart
```

Expected: FAIL because `scoped_connection_reader.dart` does not exist and the exception has not moved yet.

- [ ] **Step 6: Add `scoped_connection_reader.dart`**

Create `app/lib/application/session/scoped_connection_reader.dart`:

```dart
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:riverpod/riverpod.dart';

final class RemoteCommandUnavailableException implements Exception {
  const RemoteCommandUnavailableException({this.cause});

  final Object? cause;

  @override
  String toString() {
    return 'Remote command is unavailable while the scoped server connection is not online.';
  }
}

IHAConnection requireScopedConnection(
  T Function<T>(ProviderListenable<T> provider) read,
) {
  try {
    return read(serverScopeConnectionProvider);
  } on NoOnlineServerConnectionException catch (error) {
    throw RemoteCommandUnavailableException(cause: error);
  } on UnimplementedError catch (error) {
    throw RemoteCommandUnavailableException(cause: error);
  }
}
```

- [ ] **Step 7: Run tests**

Run from `app/`:

```bash
flutter test test/application/session/scoped_connection_reader_test.dart test/application/scopes/server_scope_host_test.dart
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add app/lib/core/infrastructure/networking/connection/server_scope_provider.dart app/lib/application/scopes/server_scope_host.dart app/lib/application/session/scoped_connection_reader.dart app/test/application/session/scoped_connection_reader_test.dart app/test/application/scopes/server_scope_host_test.dart
git commit -m "feat: define scoped live connection contract"
```

---

## Task 2: Add Remote Command Availability

**Files:**
- Create: `app/lib/application/capabilities/remote_command_availability.dart`
- Generated: `app/lib/application/capabilities/remote_command_availability.g.dart`
- Test: `app/test/application/capabilities/remote_command_availability_test.dart`

- [ ] **Step 1: Write the failing availability tests**

Create `app/test/application/capabilities/remote_command_availability_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/capabilities/remote_command_availability.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
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

void main() {
  test('commands are available when active session is online', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: _FakeConnection(),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final availability = container.read(remoteCommandAvailabilityProvider);

    expect(availability.canSend, isTrue);
    expect(availability.reason, RemoteCommandBlockReason.none);
  });

  test('commands are blocked while offline', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(activeServer: Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    final availability = container.read(remoteCommandAvailabilityProvider);

    expect(availability.canSend, isFalse);
    expect(availability.reason, RemoteCommandBlockReason.offline);
  });

  test('commands are blocked while connecting', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const ConnectingServerSession(Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    final availability = container.read(remoteCommandAvailabilityProvider);

    expect(availability.canSend, isFalse);
    expect(availability.reason, RemoteCommandBlockReason.connecting);
  });

  test('commands are blocked after auth revocation', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const AuthRevokedServerSession(Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    final availability = container.read(remoteCommandAvailabilityProvider);

    expect(availability.canSend, isFalse);
    expect(availability.reason, RemoteCommandBlockReason.authRevoked);
  });
}
```

- [ ] **Step 2: Run the test and verify it fails**

Run from `app/`:

```bash
flutter test test/application/capabilities/remote_command_availability_test.dart
```

Expected: FAIL because the capability provider file and types do not exist.

- [ ] **Step 3: Add the remote command availability provider**

Create `app/lib/application/capabilities/remote_command_availability.dart`:

```dart
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_command_availability.g.dart';

enum RemoteCommandBlockReason {
  none,
  noActiveServer,
  connecting,
  offline,
  authRevoked,
}

final class RemoteCommandAvailability {
  const RemoteCommandAvailability._({
    required this.canSend,
    required this.reason,
  });

  const RemoteCommandAvailability.available()
    : this._(canSend: true, reason: RemoteCommandBlockReason.none);

  const RemoteCommandAvailability.blocked(this.reason) : canSend = false;

  final bool canSend;
  final RemoteCommandBlockReason reason;
}

@Riverpod(keepAlive: true, dependencies: [ActiveServerSession])
RemoteCommandAvailability remoteCommandAvailability(Ref ref) {
  final session = ref.watch(activeServerSessionProvider);

  return switch (session) {
    OnlineServerSession() => const RemoteCommandAvailability.available(),
    OfflineServerSession() => const RemoteCommandAvailability.blocked(
      RemoteCommandBlockReason.offline,
    ),
    ConnectingServerSession() || ResolvingServerSession() =>
      const RemoteCommandAvailability.blocked(
        RemoteCommandBlockReason.connecting,
      ),
    AuthRevokedServerSession() => const RemoteCommandAvailability.blocked(
      RemoteCommandBlockReason.authRevoked,
    ),
    NoActiveServerSession() => const RemoteCommandAvailability.blocked(
      RemoteCommandBlockReason.noActiveServer,
    ),
  };
}
```

- [ ] **Step 4: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: generates `app/lib/application/capabilities/remote_command_availability.g.dart`.

- [ ] **Step 5: Run the availability test**

Run from `app/`:

```bash
flutter test test/application/capabilities/remote_command_availability_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/application/capabilities/remote_command_availability.dart app/lib/application/capabilities/remote_command_availability.g.dart app/test/application/capabilities/remote_command_availability_test.dart
git commit -m "feat: expose remote command availability"
```

---

## Task 3: Move Entity Commands Behind The Scoped Connection

**Files:**
- Modify: `app/lib/features/entities/application/entity_service_controller.dart`
- Generated: `app/lib/features/entities/application/entity_service_controller.g.dart`
- Test: `app/test/features/entities/application/entity_service_controller_test.dart`

- [ ] **Step 1: Update entity service tests to use scoped connection overrides**

In `app/test/features/entities/application/entity_service_controller_test.dart`, replace success-test overrides of `activeServerSessionProvider` with `serverScopeConnectionProvider.overrideWithValue(conn)`.

Modify the existing offline test to simulate the scoped connection being unavailable:

```dart
  test('call fails with typed command failure while scoped connection is offline', () async {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWith(
          (_) => throw const NoOnlineServerConnectionException(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(entityServiceControllerProvider);

    await expectLater(
      controller.call('light.kitchen', 'toggle'),
      throwsA(isA<RemoteCommandUnavailableException>()),
    );
  });
```

Use these imports instead of active session imports:

```dart
import 'package:hommie/application/session/scoped_connection_reader.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
```

- [ ] **Step 2: Run the entity service test and verify it fails**

Run from `app/`:

```bash
flutter test test/features/entities/application/entity_service_controller_test.dart
```

Expected: FAIL because `EntityServiceController` still reads `activeServerSessionProvider` and throws `ConnectionClosedError`.

- [ ] **Step 3: Update the entity service controller**

Replace the session check in `app/lib/features/entities/application/entity_service_controller.dart` with the scoped connection reader:

```dart
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/scoped_connection_reader.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_service_controller.g.dart';

class EntityServiceController {
  EntityServiceController(this._ref);

  final Ref _ref;

  Future<void> call(
    String entityId,
    String service, {
    String? domainOverride,
    Map<String, dynamic>? data,
  }) async {
    final connection = requireScopedConnection(_ref.read);
    final domain = domainOverride ?? entityId.split('.').first;

    await HACommands.callService(
      connection,
      domain: domain,
      service: service,
      target: entityId,
      serviceData: data,
    );
  }
}

@Riverpod(dependencies: [serverScopeConnection])
EntityServiceController entityServiceController(Ref ref) {
  return EntityServiceController(ref);
}
```

- [ ] **Step 4: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: updates `app/lib/features/entities/application/entity_service_controller.g.dart`.

- [ ] **Step 5: Run the entity service test**

Run from `app/`:

```bash
flutter test test/features/entities/application/entity_service_controller_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/features/entities/application/entity_service_controller.dart app/lib/features/entities/application/entity_service_controller.g.dart app/test/features/entities/application/entity_service_controller_test.dart
git commit -m "refactor: route entity commands through scoped connection"
```

---

## Task 4: Move Live Entity State Subscription To Scoped Connection

**Files:**
- Modify: `app/lib/features/entities/application/entity_states_provider.dart`
- Generated: `app/lib/features/entities/application/entity_states_provider.g.dart`
- Test: `app/test/features/entities/application/entity_states_provider_test.dart`

- [ ] **Step 1: Update entity states tests to use scoped connection overrides**

Modify `app/test/features/entities/application/entity_states_provider_test.dart` so online tests override `serverScopeConnectionProvider.overrideWithValue(connection)` instead of `activeServerSessionProvider`.

Rename the offline test and simulate the scoped connection being unavailable:

```dart
test('does not subscribe while scoped connection is unavailable', () async {
  final container = ProviderContainer(
    overrides: [
      serverScopeConnectionProvider.overrideWith(
        (_) => throw const NoOnlineServerConnectionException(),
      ),
    ],
  );
  addTearDown(container.dispose);

  expect(container.read(entityStatesProvider), isEmpty);
});
```

- [ ] **Step 2: Run the entity states test before implementation**

Run from `app/`:

```bash
flutter test test/features/entities/application/entity_states_provider_test.dart
```

Expected: PASS before implementation; this is a safety baseline. The production change should preserve behavior while removing the raw session dependency.

- [ ] **Step 3: Update `entity_states_provider.dart` to use `serverScopeConnectionProvider`**

Change imports in `app/lib/features/entities/application/entity_states_provider.dart`:

```dart
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
```

Remove:

```dart
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
```

Change the provider annotation and build method:

```dart
@Riverpod(dependencies: [serverScopeConnection])
class EntityStates extends _$EntityStates {
  HASubscription? _sub;
  StreamSubscription<dynamic>? _events;
  IHAConnection? _connection;
  Map<String, EntityStateValue> _current = const {};

  @override
  Map<String, EntityStateValue> build() {
    ref.onDispose(() {
      unawaited(_stop());
    });

    final IHAConnection connection;
    try {
      connection = ref.watch(serverScopeConnectionProvider);
    } on NoOnlineServerConnectionException {
      _current = const {};
      unawaited(_stop());
      return const {};
    }

    if (identical(_connection, connection) && _sub != null) {
      return _current;
    }

    unawaited(_stop());
    _connection = connection;
    _current = const {};
    try {
      _sub = HACommands.subscribeEntities(connection);
      _events = _sub!.stream.listen((update) {
        if (update is StatesUpdates) {
          _current = applyStatesUpdate(_current, update);
          state = _current;
        }
      });
    } catch (_) {
      _current = const {};
    }

    return _current;
  }

  Future<void> _stop() async {
    final events = _events;
    final sub = _sub;
    _events = null;
    _sub = null;
    _connection = null;

    await events?.cancel();
    if (sub != null && !sub.isDisposed) {
      await sub.dispose();
    }
  }
}
```

- [ ] **Step 4: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: updates `app/lib/features/entities/application/entity_states_provider.g.dart`.

- [ ] **Step 5: Run the entity states test**

Run from `app/`:

```bash
flutter test test/features/entities/application/entity_states_provider_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/features/entities/application/entity_states_provider.dart app/lib/features/entities/application/entity_states_provider.g.dart app/test/features/entities/application/entity_states_provider_test.dart
git commit -m "refactor: subscribe entity states through scoped connection"
```

---

## Task 5: Add Home Capabilities And Remove Raw Session Logic From Home Controller

**Files:**
- Create: `app/lib/features/home/application/home_capabilities_provider.dart`
- Generated: `app/lib/features/home/application/home_capabilities_provider.g.dart`
- Modify: `app/lib/features/home/application/home_page_controller.dart`
- Generated: `app/lib/features/home/application/home_page_controller.g.dart`
- Test: `app/test/features/home/home_capabilities_provider_test.dart`
- Modify: `app/test/features/home/home_page_controller_test.dart`

- [ ] **Step 1: Write failing Home capability tests**

Create `app/test/features/home/home_capabilities_provider_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/server_sync_coordinator.dart';
import 'package:hommie/application/session/server_sync_state.dart';
import 'package:hommie/features/home/application/home_capabilities_provider.dart';
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

void main() {
  test('online ready Home can control entities and is not loading', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: _FakeConnection(),
          ),
        ),
        serverSyncCoordinatorProvider.overrideWithValue(const SyncReady()),
      ],
    );
    addTearDown(container.dispose);

    final capabilities = container.read(homeCapabilitiesProvider);

    expect(capabilities.canControlEntities, isTrue);
    expect(capabilities.isOffline, isFalse);
    expect(capabilities.isInitialDataLoading, isFalse);
    expect(capabilities.syncFailure, isNull);
  });

  test('connecting Home reports initial data loading', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const ConnectingServerSession(Server(id: 1, name: 'Home')),
        ),
        serverSyncCoordinatorProvider.overrideWithValue(
          const InitialSyncRunning(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final capabilities = container.read(homeCapabilitiesProvider);

    expect(capabilities.canControlEntities, isFalse);
    expect(capabilities.isInitialDataLoading, isTrue);
  });

  test('offline Home keeps cached reads visible but blocks commands', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(activeServer: Server(id: 1, name: 'Home')),
        ),
        serverSyncCoordinatorProvider.overrideWithValue(
          const SyncOfflineWithCache(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final capabilities = container.read(homeCapabilitiesProvider);

    expect(capabilities.canControlEntities, isFalse);
    expect(capabilities.isOffline, isTrue);
    expect(capabilities.isInitialDataLoading, isFalse);
  });

  test('sync failure is surfaced for empty-cache presentation', () {
    final error = StateError('sync failed');
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: _FakeConnection(),
          ),
        ),
        serverSyncCoordinatorProvider.overrideWithValue(SyncFailed(error)),
      ],
    );
    addTearDown(container.dispose);

    final capabilities = container.read(homeCapabilitiesProvider);

    expect(capabilities.syncFailure, same(error));
  });
}
```

- [ ] **Step 2: Run the capability test and verify it fails**

Run from `app/`:

```bash
flutter test test/features/home/home_capabilities_provider_test.dart
```

Expected: FAIL because `home_capabilities_provider.dart` does not exist.

- [ ] **Step 3: Add `HomeCapabilities` provider**

Create `app/lib/features/home/application/home_capabilities_provider.dart`:

```dart
import 'package:hommie/application/capabilities/remote_command_availability.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/server_sync_coordinator.dart';
import 'package:hommie/application/session/server_sync_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_capabilities_provider.g.dart';

final class HomeCapabilities {
  const HomeCapabilities({
    required this.canControlEntities,
    required this.isOffline,
    required this.isInitialDataLoading,
    required this.syncFailure,
  });

  final bool canControlEntities;
  final bool isOffline;
  final bool isInitialDataLoading;
  final Object? syncFailure;
}

@Riverpod(
  dependencies: [
    remoteCommandAvailability,
    ActiveServerSession,
    ServerSyncCoordinator,
  ],
)
HomeCapabilities homeCapabilities(Ref ref) {
  final commandAvailability = ref.watch(remoteCommandAvailabilityProvider);
  final session = ref.watch(activeServerSessionProvider);
  final syncState = ref.watch(serverSyncCoordinatorProvider);

  return HomeCapabilities(
    canControlEntities: commandAvailability.canSend,
    isOffline: session is OfflineServerSession,
    isInitialDataLoading:
        syncState is InitialSyncRunning ||
        session is ConnectingServerSession ||
        session is ResolvingServerSession,
    syncFailure: syncState is SyncFailed ? syncState.error : null,
  );
}
```

- [ ] **Step 4: Update `HomePageController` to use Home capabilities**

Modify `app/lib/features/home/application/home_page_controller.dart` imports:

```dart
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/home/application/cached_areas_provider.dart';
import 'package:hommie/features/home/application/home_capabilities_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
```

Change the provider dependencies:

```dart
@Riverpod(
  dependencies: [
    serverScopeServer,
    cachedAreas,
    cachedEntities,
    homeCapabilities,
  ],
)
class HomePageController extends _$HomePageController {
```

Change `build()`:

```dart
  @override
  HomePageState build() {
    final server = ref.watch(serverScopeServerProvider);
    final capabilities = ref.watch(homeCapabilitiesProvider);
    final areas =
        ref.watch(cachedAreasProvider).asData?.value ?? const <Area>[];
    final entities =
        ref.watch(cachedEntitiesProvider).asData?.value ?? const [];

    final sections = groupEntitiesByArea(areas, entities);
    final isInitialSyncing =
        entities.isEmpty && capabilities.isInitialDataLoading;

    return HomePageState(
      isEditing: _isEditing,
      serverName: server.name,
      tabs: _tabsFromAreas(areas),
      sections: sections,
      isInitialSyncing: isInitialSyncing,
      isOffline: capabilities.isOffline,
      syncFailure: capabilities.syncFailure,
    );
  }
```

- [ ] **Step 5: Update Home controller test overrides**

In `app/test/features/home/home_page_controller_test.dart`, replace direct `activeServerSessionProvider` and `serverSyncCoordinatorProvider` overrides for controller tests with the concrete `homeCapabilitiesProvider.overrideWithValue` overrides listed below.

Use this helper in the test file:

```dart
HomeCapabilities homeCapabilities({
  bool canControlEntities = true,
  bool isOffline = false,
  bool isInitialDataLoading = false,
  Object? syncFailure,
}) {
  return HomeCapabilities(
    canControlEntities: canControlEntities,
    isOffline: isOffline,
    isInitialDataLoading: isInitialDataLoading,
    syncFailure: syncFailure,
  );
}
```

For the existing "initial sync" test, override:

```dart
homeCapabilitiesProvider.overrideWithValue(
  homeCapabilities(isInitialDataLoading: true),
),
```

For the existing "offline cached sections" test, override:

```dart
homeCapabilitiesProvider.overrideWithValue(
  homeCapabilities(isOffline: true, canControlEntities: false),
),
```

For the existing "sync failure" test, override:

```dart
final error = StateError('sync failed');
homeCapabilitiesProvider.overrideWithValue(
  homeCapabilities(syncFailure: error),
),
```

- [ ] **Step 6: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: generates `home_capabilities_provider.g.dart` and updates `home_page_controller.g.dart`.

- [ ] **Step 7: Run Home tests**

Run from `app/`:

```bash
flutter test test/features/home/home_capabilities_provider_test.dart test/features/home/home_page_controller_test.dart test/features/home/home_page_test.dart
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add app/lib/features/home/application/home_capabilities_provider.dart app/lib/features/home/application/home_capabilities_provider.g.dart app/lib/features/home/application/home_page_controller.dart app/lib/features/home/application/home_page_controller.g.dart app/test/features/home/home_capabilities_provider_test.dart app/test/features/home/home_page_controller_test.dart
git commit -m "feat: add home capabilities"
```

---

## Task 6: Use Command Capabilities In Light Card

**Files:**
- Modify: `app/lib/features/entities/presentation/widgets/light_card.dart`
- Test: `app/test/features/entities/presentation/light_card_test.dart`

- [ ] **Step 1: Add failing offline command-disabled widget test**

Add this test to `app/test/features/entities/presentation/light_card_test.dart`:

```dart
  testWidgets('online-unavailable commands disable the switch', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            const OfflineServerSession(
              activeServer: Server(id: 1, name: 'Home'),
            ),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: LightCard(
              entity: HaEntity(
                entityId: 'light.kitchen',
                domain: 'light',
                name: 'Kitchen',
              ),
              state: EntityStateValue(state: 'off'),
            ),
          ),
        ),
      ),
    );

    final switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.onChanged, isNull);
  });
```

- [ ] **Step 2: Run the light card test and verify it fails**

Run from `app/`:

```bash
flutter test test/features/entities/presentation/light_card_test.dart
```

Expected: FAIL because `LightCard` only checks entity state availability, not command availability.

- [ ] **Step 3: Update `LightCard` to consume command availability**

Modify `app/lib/features/entities/presentation/widgets/light_card.dart` imports:

```dart
import 'package:hommie/application/capabilities/remote_command_availability.dart';
```

Update `build()` before returning `Card`:

```dart
    final canSendCommands = ref.watch(
      remoteCommandAvailabilityProvider.select(
        (availability) => availability.canSend,
      ),
    );
```

Update the `Switch`:

```dart
        trailing: Switch(
          value: _isOn,
          onChanged: _unavailable || !canSendCommands
              ? null
              : (_) => unawaited(_toggle()),
        ),
```

- [ ] **Step 4: Run the light card test**

Run from `app/`:

```bash
flutter test test/features/entities/presentation/light_card_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/entities/presentation/widgets/light_card.dart app/test/features/entities/presentation/light_card_test.dart
git commit -m "feat: disable entity commands when offline"
```

---

## Task 7: Move Offline Banner Logic Behind Capability Provider

**Files:**
- Create: `app/lib/application/capabilities/offline_banner_visibility_provider.dart`
- Generated: `app/lib/application/capabilities/offline_banner_visibility_provider.g.dart`
- Modify: `app/lib/ui/screens/widgets/offline_container.dart`
- Test: `app/test/application/capabilities/offline_banner_visibility_provider_test.dart`
- Modify: `app/test/ui/screens/widgets/offline_container_test.dart`

- [ ] **Step 1: Write failing offline banner provider tests**

Create `app/test/application/capabilities/offline_banner_visibility_provider_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/capabilities/offline_banner_visibility_provider.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
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

void main() {
  test('banner is visible while offline', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(activeServer: Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(offlineBannerVisibilityProvider), isTrue);
  });

  test('banner is visible while connecting', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const ConnectingServerSession(Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(offlineBannerVisibilityProvider), isTrue);
  });

  test('banner is hidden while online', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: _FakeConnection(),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(offlineBannerVisibilityProvider), isFalse);
  });
}
```

- [ ] **Step 2: Run the provider test and verify it fails**

Run from `app/`:

```bash
flutter test test/application/capabilities/offline_banner_visibility_provider_test.dart
```

Expected: FAIL because the provider file does not exist.

- [ ] **Step 3: Add the offline banner visibility provider**

Create `app/lib/application/capabilities/offline_banner_visibility_provider.dart`:

```dart
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'offline_banner_visibility_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [ActiveServerSession])
bool offlineBannerVisibility(Ref ref) {
  final session = ref.watch(activeServerSessionProvider);
  return session is OfflineServerSession || session is ConnectingServerSession;
}
```

- [ ] **Step 4: Update `OfflineContainer`**

Modify `app/lib/ui/screens/widgets/offline_container.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/application/capabilities/offline_banner_visibility_provider.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/screens/widgets/offline_banner.dart';

class OfflineContainer extends ConsumerWidget {
  final Widget? child;

  const OfflineContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showBanner = ref.watch(offlineBannerVisibilityProvider);

    return Column(
      children: [
        ClipRect(
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            heightFactor: showBanner ? 1.0 : 0.0,
            child: OfflineBanner(key: K.common.offlineBanner),
          ),
        ),
        Expanded(child: child ?? const SizedBox.shrink()),
      ],
    );
  }
}
```

- [ ] **Step 5: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: generates `offline_banner_visibility_provider.g.dart`.

- [ ] **Step 6: Run offline banner tests**

Run from `app/`:

```bash
flutter test test/application/capabilities/offline_banner_visibility_provider_test.dart test/ui/screens/widgets/offline_container_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/application/capabilities/offline_banner_visibility_provider.dart app/lib/application/capabilities/offline_banner_visibility_provider.g.dart app/lib/ui/screens/widgets/offline_container.dart app/test/application/capabilities/offline_banner_visibility_provider_test.dart app/test/ui/screens/widgets/offline_container_test.dart
git commit -m "refactor: derive offline banner from capability provider"
```

---

## Task 8: Move Settings Hub Status Behind A View Model

**Files:**
- Modify: `app/lib/features/settings/application/hub_status_provider.dart`
- Generated: `app/lib/features/settings/application/hub_status_provider.freezed.dart`
- Generated: `app/lib/features/settings/application/hub_status_provider.g.dart`
- Modify: `app/lib/features/settings/presentation/screens/hub_page.dart`
- Modify: `app/test/features/settings/application/hub_status_provider_test.dart`

- [ ] **Step 1: Update the Hub status provider test first**

Modify `app/test/features/settings/application/hub_status_provider_test.dart` so the existing test asserts a mapped connection view model instead of raw session state:

```dart
test('maps active session state into hub connection status', () async {
  final container = ProviderContainer(
    overrides: [
      activeServerSessionProvider.overrideWithValue(
        const OfflineServerSession(activeServer: Server(id: 1, name: 'Home')),
      ),
      authStateProvider.overrideWith(
        (_) => const AuthState.unauthenticated(),
      ),
      deviceInfoRepositoryProvider.overrideWithValue(
        _FakeDeviceInfoRepository(),
      ),
    ],
  );
  addTearDown(container.dispose);

  final state = await container.read(hubStatusProvider.future);

  expect(state.server?.name, 'Home');
  expect(state.connection.kind, HubConnectionKind.disconnected);
  expect(state.connection.label, 'Disconnected');
  expect(state.connection.description, 'Not connected to server');
  expect(state.isOffline, isTrue);
  expect(state.deviceName, 'Test device');
});
```

- [ ] **Step 2: Run the Hub status test and verify it fails**

Run from `app/`:

```bash
flutter test test/features/settings/application/hub_status_provider_test.dart
```

Expected: FAIL because `HubConnectionKind` and `HubConnectionStatus` do not exist.

- [ ] **Step 3: Add the Hub connection view model**

Modify `app/lib/features/settings/application/hub_status_provider.dart`:

```dart
enum HubConnectionKind {
  connected,
  connecting,
  authFailure,
  disconnected,
  unknown,
}

@freezed
sealed class HubConnectionStatus with _$HubConnectionStatus {
  const factory HubConnectionStatus({
    required HubConnectionKind kind,
    required String label,
    required String description,
    Server? server,
  }) = _HubConnectionStatus;
}

@freezed
sealed class HubStatusState with _$HubStatusState {
  const factory HubStatusState({
    required HubConnectionStatus connection,
    required AuthState authState,
    required String deviceName,
  }) = _HubStatusState;
}

extension HubStatusStateX on HubStatusState {
  Server? get server => connection.server;

  bool get isOnline => connection.kind == HubConnectionKind.connected;
  bool get isOffline => connection.kind == HubConnectionKind.disconnected;
}
```

Add this mapper in the same file:

```dart
HubConnectionStatus _hubConnectionStatus(ActiveServerSessionState state) {
  return switch (state) {
    OnlineServerSession(:final activeServer) => HubConnectionStatus(
      kind: HubConnectionKind.connected,
      label: 'Connected',
      description: 'Connected to Home Assistant',
      server: activeServer,
    ),
    ConnectingServerSession(:final activeServer) => HubConnectionStatus(
      kind: HubConnectionKind.connecting,
      label: 'Connecting',
      description: 'Connecting to server',
      server: activeServer,
    ),
    ResolvingServerSession() => const HubConnectionStatus(
      kind: HubConnectionKind.connecting,
      label: 'Connecting',
      description: 'Resolving active server',
    ),
    AuthRevokedServerSession(:final activeServer) => HubConnectionStatus(
      kind: HubConnectionKind.authFailure,
      label: 'Auth failure',
      description: 'Authentication required',
      server: activeServer,
    ),
    OfflineServerSession(:final activeServer) => HubConnectionStatus(
      kind: HubConnectionKind.disconnected,
      label: 'Disconnected',
      description: 'Not connected to server',
      server: activeServer,
    ),
    NoActiveServerSession() => const HubConnectionStatus(
      kind: HubConnectionKind.unknown,
      label: 'Unknown',
      description: 'Connection status unknown',
    ),
  };
}
```

Update the provider return:

```dart
return HubStatusState(
  connection: _hubConnectionStatus(sessionState),
  authState: authState,
  deviceName: deviceName,
);
```

- [ ] **Step 4: Update the Hub page to stop importing session state**

Modify `app/lib/features/settings/presentation/screens/hub_page.dart`:

```dart
subtitle: status.connection.description,
value: status.connection.label,
```

Remove `_connectionLabel` and `_connectionDescription` from the file. Remove the direct import of `active_server_session_state.dart` if it becomes unused.

- [ ] **Step 5: Run code generation**

Run from `app/`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: updates `hub_status_provider.freezed.dart` and `hub_status_provider.g.dart`.

- [ ] **Step 6: Run the Hub status test**

Run from `app/`:

```bash
flutter test test/features/settings/application/hub_status_provider_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/features/settings/application/hub_status_provider.dart app/lib/features/settings/application/hub_status_provider.freezed.dart app/lib/features/settings/application/hub_status_provider.g.dart app/lib/features/settings/presentation/screens/hub_page.dart app/test/features/settings/application/hub_status_provider_test.dart
git commit -m "refactor: expose settings connection status view model"
```

---

## Task 9: Architecture Guard And Verification

**Files:**
- No production edits unless verification finds a defect.

- [ ] **Step 1: Check feature/UI code no longer watches raw transport or session state for UI policy**

Run from repo root:

```bash
rg --glob '!*.g.dart' --glob '!*.freezed.dart' "serverConnectionStateProvider|HAServerConnectionState|activeServerSessionProvider|ActiveServerSessionState|OnlineServerSession|OfflineServerSession|ConnectingServerSession|AuthRevokedServerSession" app/lib/features app/lib/ui
```

Expected allowed matches:

```text
app/lib/features/home/application/home_capabilities_provider.dart
app/lib/features/settings/application/hub_status_provider.dart
```

If this command reports raw transport/session usage in `app/lib/features/**/presentation/**`, `app/lib/ui/**`, or feature page controllers other than the two allowed files, move that logic behind a capability/view-model provider before continuing.

- [ ] **Step 2: Check command services and live subscriptions use the scoped connection**

Run from repo root:

```bash
rg --glob '!*.g.dart' --glob '!*.freezed.dart' "requireScopedConnection|serverScopeConnectionProvider|activeServerSessionProvider|serverConnectionStateProvider" app/lib/features/entities app/lib/features/home app/lib/features/settings
```

Expected:
- command services use `requireScopedConnection`;
- live subscriptions use `serverScopeConnectionProvider` directly;
- cached repositories do not use websocket connection providers;
- UI widgets consume capability providers rather than raw session providers.
- raw `activeServerSessionProvider` matches are limited to capability/view-model providers such as `home_capabilities_provider.dart` and `hub_status_provider.dart`, not entity command/subscription providers.

- [ ] **Step 3: Run focused tests**

Run from `app/`:

```bash
flutter test \
  test/application/session/scoped_connection_reader_test.dart \
  test/application/capabilities/remote_command_availability_test.dart \
  test/application/capabilities/offline_banner_visibility_provider_test.dart \
  test/features/entities/application/entity_service_controller_test.dart \
  test/features/entities/application/entity_states_provider_test.dart \
  test/features/entities/presentation/light_card_test.dart \
  test/features/home/home_capabilities_provider_test.dart \
  test/features/home/home_page_controller_test.dart \
  test/features/home/home_page_test.dart \
  test/features/settings/application/hub_status_provider_test.dart \
  test/ui/screens/widgets/offline_container_test.dart
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
- `flutter test` passes with only the existing skipped debug tests.

- [ ] **Step 5: Run websocket package verification**

Run from `packages/home_assistant_websocket/`:

```bash
dart analyze
dart test
```

Expected:
- `dart analyze` prints `No issues found!`
- `dart test` passes.

- [ ] **Step 6: Commit verification fixes only if needed**

If verification required code changes:

```bash
git add app packages/home_assistant_websocket
git commit -m "fix: verify connection capability architecture"
```

If verification required no code changes, do not create an empty commit.

---

## Design Notes For Future Features

When adding a new feature, choose one of these paths:

1. Cached read feature:
   - use Drift/cache repositories;
   - do not inject websocket connection;
   - render cached data online and offline.

2. Remote command feature:
   - call a command service;
   - command service uses `requireScopedConnection(_ref.read)`;
   - UI disables the command through `remoteCommandAvailabilityProvider` or a screen-specific capability provider.

3. Remote sync feature:
   - put subscription and initial fetch under `ServerSyncCoordinator` or a dedicated sync coordinator;
   - live subscription code watches `serverScopeConnectionProvider`;
   - sync writes to cache;
   - UI reads cache and sync/capability summaries.

4. UI connection policy:
   - create a screen-specific capability provider;
   - do not watch `activeServerSessionProvider` directly in widgets or page controllers.
