# Home Assistant REST and WebSocket API Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a resource-oriented Home Assistant API client that supports REST and WebSocket transports, migrate login `get_config` to REST, and remove direct app/package usage of `HACommands`.

**Architecture:** Introduce `HomeAssistantApi` as the package entry point. Resource APIs (`config`, `states`, `services`, `entities`, `events`) delegate to `HARestTransport` and `HAWebSocketTransport`; app login uses a Riverpod provider that constructs the API with server URL, OAuth token, and HTTP client. Existing live-session WebSocket behavior stays intact by wrapping `IHAConnection` in the WebSocket transport.

**Tech Stack:** Dart 3.9, Flutter/Riverpod 3, `package:http`, `package:test`, `flutter_test`, existing `home_assistant_websocket` models and connection classes.

---

### Task 1: Package API Surface And REST Transport

**Files:**
- Create: `packages/home_assistant_websocket/lib/src/api/home_assistant_api.dart`
- Create: `packages/home_assistant_websocket/lib/src/api/ha_api_exceptions.dart`
- Create: `packages/home_assistant_websocket/lib/src/api/transports/ha_rest_transport.dart`
- Create: `packages/home_assistant_websocket/test/ha_rest_transport_test.dart`
- Modify: `packages/home_assistant_websocket/lib/home_assistant_websocket.dart`
- Modify: `packages/home_assistant_websocket/pubspec.yaml`

- [ ] **Step 1: Write failing REST transport tests**

```dart
test('getJson attaches bearer token and builds server-relative path', () async {
  final client = MockClient((request) async {
    expect(request.method, 'GET');
    expect(request.url, Uri.parse('http://ha.test/api/config'));
    expect(request.headers['authorization'], 'Bearer token-1');
    return http.Response('{"location_name":"Kitchen"}', 200);
  });
  final transport = HARestTransport(
    serverUri: Uri.parse('http://ha.test'),
    tokenProvider: () async => 'token-1',
    client: client,
  );

  final json = await transport.getJson('/api/config');

  expect(json, {'location_name': 'Kitchen'});
});

test('requestJson sends JSON bodies for POST requests', () async {
  final client = MockClient((request) async {
    expect(request.method, 'POST');
    expect(request.headers['content-type'], contains('application/json'));
    expect(await request.readAsString(), '{"entity_id":"light.kitchen"}');
    return http.Response('{"ok":true}', 200);
  });
  final transport = HARestTransport(
    serverUri: Uri.parse('http://ha.test'),
    tokenProvider: () async => 'token-1',
    client: client,
  );

  final json = await transport.requestJson(
    method: 'POST',
    path: '/api/services/light/toggle',
    body: {'entity_id': 'light.kitchen'},
  );

  expect(json, {'ok': true});
});

test('maps authentication and HTTP failures to package exceptions', () async {
  final authTransport = HARestTransport(
    serverUri: Uri.parse('http://ha.test'),
    tokenProvider: () async => 'token-1',
    client: MockClient((_) async => http.Response('no', 401)),
  );

  await expectLater(
    authTransport.getJson('/api/config'),
    throwsA(isA<HAAuthenticationException>()),
  );

  final failingTransport = HARestTransport(
    serverUri: Uri.parse('http://ha.test'),
    tokenProvider: () async => 'token-1',
    client: MockClient((_) async => http.Response('{"error":"bad"}', 500)),
  );

  await expectLater(
    failingTransport.getJson('/api/config'),
    throwsA(isA<HAHttpException>()),
  );
});
```

- [ ] **Step 2: Run REST tests and confirm RED**

Run: `dart test packages/home_assistant_websocket/test/ha_rest_transport_test.dart`

Expected: fails because `HARestTransport` and exception classes do not exist.

- [ ] **Step 3: Implement REST transport and exports**

Add `http: ^1.2.2` to the package dependencies. Implement `HARestTransport` with `getJson` and `requestJson`, bearer auth, JSON encoding/decoding, server-relative path resolution, and exception mapping. Export API and exception files from `home_assistant_websocket.dart`.

- [ ] **Step 4: Run REST tests and confirm GREEN**

Run: `dart test packages/home_assistant_websocket/test/ha_rest_transport_test.dart`

Expected: all REST transport tests pass.

### Task 2: Resource APIs And WebSocket Transport Adapter

**Files:**
- Create: `packages/home_assistant_websocket/lib/src/api/transports/ha_websocket_transport.dart`
- Create: `packages/home_assistant_websocket/test/home_assistant_api_test.dart`
- Modify: `packages/home_assistant_websocket/lib/src/api/home_assistant_api.dart`
- Modify: `packages/home_assistant_websocket/test/send_ha_command_messages_test.dart`
- Modify: `packages/home_assistant_websocket/test/ha_connection_test.dart`
- Delete: `packages/home_assistant_websocket/lib/src/api/commands/ha_commands.dart`

- [ ] **Step 1: Write failing resource API tests**

```dart
test('config.get via REST calls GET /api/config', () async {
  final api = HomeAssistantApi(
    serverUri: Uri.parse('http://ha.test'),
    tokenProvider: () async => 'token-1',
    httpClient: MockClient((request) async {
      expect(request.url.path, '/api/config');
      return http.Response(configJson, 200);
    }),
  );

  final config = await api.config.get(via: HATransport.rest);

  expect(config.location_name, 'Kitchen');
});

test('config.get via WebSocket sends get_config over wrapped connection', () async {
  final api = HomeAssistantApi.fromConnection(connection);
  final future = api.config.get(via: HATransport.websocket);
  final sent = await fakeSocket.nextSentWhere(
    (message) => message is HARequestMessage && message.type == 'get_config',
  );

  fakeSocket.addIncoming(configResponseJson);

  expect(sent.toPayload(id: 2), {'id': 2, 'type': 'get_config'});
  expect((await future).location_name, 'Kitchen');
});

test('services.call via WebSocket preserves legacy target payload', () async {
  final api = HomeAssistantApi.fromConnection(connection);
  final future = api.services.call(
    domain: 'light',
    service: 'turn_on',
    target: const HATarget(entityIds: ['light.kitchen']),
    serviceData: {'brightness': 101},
  );

  final sent = await fakeSocket.nextSentWhere(
    (message) => message is ServiceCallMessage,
  );

  expect(sent.toPayload(id: 2), {
    'id': 2,
    'type': 'call_service',
    'domain': 'light',
    'service': 'turn_on',
    'target': {'entity_id': ['light.kitchen']},
    'service_data': {'brightness': 101},
  });

  fakeSocket.addIncoming(callServiceResponseJson);
  expect(await future, isA<CallServiceResponse>());
});
```

- [ ] **Step 2: Run API tests and confirm RED**

Run: `dart test packages/home_assistant_websocket/test/home_assistant_api_test.dart`

Expected: fails because `HomeAssistantApi`, `HATransport`, and `HAWebSocketTransport` are incomplete or missing.

- [ ] **Step 3: Implement typed resource APIs**

Implement `HomeAssistantApi`, `HATransport`, `HATransportDefaults`, `HAConfigApi`, `HAStatesApi`, `HAServicesApi`, `HAEntitiesApi`, and `HAEventsApi`. REST defaults should cover one-shot reads and service calls. `HomeAssistantApi.fromConnection(IHAConnection)` should create a WebSocket-only API for existing live-session app code.

- [ ] **Step 4: Remove `HACommands` package tests and migrate assertions**

Update package tests to call `HomeAssistantApi.fromConnection(connection).states.list()`, `.config.get()`, `.services.list()`, `.services.call()`, `.entities.subscribe()`, and `.events.subscribe()` instead of `HACommands.*`. Delete `ha_commands.dart` after no package/app imports remain.

- [ ] **Step 5: Run package tests and confirm GREEN**

Run: `dart test packages/home_assistant_websocket/test`

Expected: all package tests pass.

### Task 3: App Login REST API Provider

**Files:**
- Create: `app/lib/core/infrastructure/networking/providers/home_assistant_api_provider.dart`
- Create: `app/lib/core/infrastructure/networking/providers/home_assistant_api_provider.g.dart` via build runner
- Modify: `app/lib/features/auth/application/login_flow_controller.dart`
- Modify: `app/test/features/auth/application/login_flow_controller_test.dart`
- Delete: `app/lib/features/servers/infrastructure/providers/websocket_config_repository_provider.dart`
- Delete: `app/lib/features/servers/infrastructure/providers/websocket_config_repository_provider.g.dart`
- Delete: `app/lib/features/servers/domain/repositories/i_websocket_config_repository.dart`
- Delete: `app/test/features/servers/infrastructure/providers/websocket_config_repository_provider_test.dart`

- [ ] **Step 1: Write failing login tests for REST config**

Update `login_flow_controller_test.dart` to override `homeAssistantApiProvider` instead of `websocketConfigRepositoryProvider`. Add a fake `HomeAssistantApi`/transport seam that returns `_config()` or throws. Keep the rollback tests and assert config fetch does not call the connection manager.

- [ ] **Step 2: Run login tests and confirm RED**

Run: `flutter test app/test/features/auth/application/login_flow_controller_test.dart`

Expected: fails because login still depends on `websocketConfigRepositoryProvider`.

- [ ] **Step 3: Implement app provider and login migration**

Create `homeAssistantApiProvider(serverId)` that reads `serverConfigProvider(serverId)`, `serverAuthTokenProvider(serverId)`, and `httpClientProvider`, then constructs `HomeAssistantApi(serverUri: ..., tokenProvider: ..., httpClient: ...)`. Change login to read `homeAssistantApiProvider(server.id!)` and call `api.config.get(via: HATransport.rest)`.

- [ ] **Step 4: Remove one-shot WebSocket config provider**

Delete the WebSocket config repository interface, provider, generated file, and test once all imports are gone. Update `loginFlowControllerProvider` dependencies to reference `homeAssistantApi`.

- [ ] **Step 5: Run build runner**

Run: `dart run build_runner build --delete-conflicting-outputs`

Expected: generated Riverpod files reflect `homeAssistantApiProvider` and login dependency changes.

- [ ] **Step 6: Run login tests and confirm GREEN**

Run: `flutter test app/test/features/auth/application/login_flow_controller_test.dart`

Expected: login tests pass with REST config provider overrides.

### Task 4: Remove App `HACommands` Usage

**Files:**
- Modify: `app/lib/application/session/server_sync_coordinator.dart`
- Modify: `app/lib/features/entities/application/entity_states_provider.dart`
- Modify: `app/lib/features/entities/application/entity_service_controller.dart`
- Modify: `app/lib/features/servers/infrastructure/repositories/websocket_repository.dart`
- Modify: `packages/home_assistant_websocket/lib/src/connection/connection_orchestrator.dart`

- [ ] **Step 1: Write/adjust failing tests for migrated app command callers**

Update existing tests that verify service calls, entity subscriptions, and sync subscriptions to keep asserting the same behavior while calls go through `HomeAssistantApi.fromConnection`.

- [ ] **Step 2: Run targeted app tests and confirm RED where imports changed**

Run: `flutter test app/test/features/entities/application/entity_service_controller_test.dart app/test/features/entities/application/entity_states_provider_test.dart app/test/application/session/server_sync_coordinator_test.dart`

Expected: fails until app code no longer imports `HACommands`.

- [ ] **Step 3: Replace command calls**

Use `HomeAssistantApi.fromConnection(connection)` in each app caller:

```dart
final api = HomeAssistantApi.fromConnection(connection);
await api.services.call(
  domain: domain,
  service: service,
  target: HATarget(entityIds: [entityId]),
  serviceData: data,
);
```

Use `api.entities.subscribe()` and `api.events.subscribe(eventType)` for subscriptions. Use `connection.sendMessage(const PingMessage())` for heartbeat and repository ping.

- [ ] **Step 4: Run targeted app tests and confirm GREEN**

Run: `flutter test app/test/features/entities/application/entity_service_controller_test.dart app/test/features/entities/application/entity_states_provider_test.dart app/test/application/session/server_sync_coordinator_test.dart`

Expected: targeted app tests pass.

### Task 5: Final Verification And Commit

**Files:**
- All modified package/app files from previous tasks.

- [ ] **Step 1: Run package tests**

Run: `dart test packages/home_assistant_websocket/test`

Expected: all package tests pass.

- [ ] **Step 2: Run targeted app tests**

Run: `flutter test app/test/features/auth/application/login_flow_controller_test.dart app/test/features/entities/application/entity_service_controller_test.dart app/test/features/entities/application/entity_states_provider_test.dart app/test/application/session/server_sync_coordinator_test.dart`

Expected: targeted app tests pass.

- [ ] **Step 3: Run analyzers**

Run: `dart analyze packages/home_assistant_websocket`

Expected: no package analyzer errors.

Run: `flutter analyze app`

Expected: no app analyzer errors.

- [ ] **Step 4: Commit**

```bash
git add -- .
git commit -m "feat: add rest home assistant api"
```
