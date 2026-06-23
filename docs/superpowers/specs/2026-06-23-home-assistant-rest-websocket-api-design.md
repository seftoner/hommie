# Home Assistant REST and WebSocket API Design

Date: 2026-06-23
Branch: `codex/login-connection-architecture`

## Purpose

Add REST support to the Home Assistant client package without forcing app code to think in raw transport terms for normal operations. The current app heavily uses `HACommands`, but current command usage is small enough that the package can move to a cleaner resource-oriented API and eliminate `HACommands`.

The first migration target is login server initialization. `get_config` should use `GET /api/config` over REST after OAuth credentials are stored, so login does not need to open a one-shot WebSocket connection before the active server session exists.

## Constraints From HA API Research

- REST covers only a limited subset of useful HA operations.
- Many important operations remain WebSocket-only, including registries, Lovelace, repairs, system health, backup info, and subscriptions.
- Some operations have both REST and WebSocket equivalents, such as config, states, services, and service calls.
- REST-capable operations must not require an active WebSocket connection.
- WebSocket-only operations should fail clearly when the caller requests REST.
- The library must keep escape hatches for raw REST requests and raw WebSocket messages.

## Public API Shape

The primary API is resource-oriented:

```dart
final api = HomeAssistantApi(
  serverUri: Uri.parse(server.url),
  tokenProvider: tokenProvider,
);

final config = await api.config.get(via: HATransport.rest);
final states = await api.states.list();
final services = await api.services.list();

await api.services.call(
  domain: 'light',
  service: 'toggle',
  target: HATarget(entityIds: ['light.kitchen']),
);

final sub = await api.entities.subscribe();
```

Top-level client:

```dart
class HomeAssistantApi {
  HomeAssistantApi({
    required Uri serverUri,
    required HAAuthTokenProvider tokenProvider,
    HATransportDefaults defaults = const HATransportDefaults(),
  });

  late final HAConfigApi config;
  late final HAStatesApi states;
  late final HAServicesApi services;
  late final HAEntitiesApi entities;
  late final HAEventsApi events;

  late final HARestTransport rest;
  late final HAWebSocketTransport websocket;
}
```

Transport selection:

```dart
enum HATransport { rest, websocket }

class HATransportDefaults {
  const HATransportDefaults({
    this.oneShotReads = HATransport.rest,
    this.serviceCalls = HATransport.rest,
  });

  final HATransport oneShotReads;
  final HATransport serviceCalls;
}
```

Default policy:

- REST-capable one-shot reads default to REST.
- Service calls default to REST.
- Subscriptions are WebSocket-only.
- WebSocket-only registry/config internals use WebSocket.
- Callers may override per operation with `via: HATransport.rest` or `via: HATransport.websocket`.

`HACommands` is not part of the long-term public API. Existing package and app usages should migrate to resource APIs, then `HACommands` should be deleted.

## Raw Transport Escape Hatches

Typed APIs are the preferred app DX, but the library must support arbitrary REST and WebSocket requests for HA endpoints that are not typed yet.

```dart
final json = await api.rest.getJson('/api/config');

final response = await api.rest.requestJson(
  method: 'POST',
  path: '/api/services/light/toggle',
  body: {'entity_id': 'light.kitchen'},
);

final areas = await api.websocket.sendJson({
  'type': 'config/area_registry/list',
});

final sub = await api.websocket.subscribeJson({
  'type': 'subscribe_events',
  'event_type': 'state_changed',
});
```

Raw APIs should not reject unknown paths or message types. They should only normalize authentication, transport, timeout, and malformed-response failures.

## Typed Resource APIs

Initial typed resources:

```dart
class HAConfigApi {
  Future<HassConfig> get({HATransport? via});
}

class HAStatesApi {
  Future<List<HassEntity>> list({HATransport? via});
  Future<HassEntity> get(String entityId);
}

class HAServicesApi {
  Future<HassServices> list({HATransport? via});
  Future<CallServiceResponse> call({
    required String domain,
    required String service,
    HATarget? target,
    Map<String, dynamic>? serviceData,
    bool? returnResponse,
    HATransport? via,
  });
}

class HAEntitiesApi {
  HASubscription subscribe();
}

class HAEventsApi {
  HASubscription subscribe([String? eventType]);
}
```

Transport support examples:

- `config.get`: REST and WebSocket.
- `states.list`: REST and WebSocket.
- `states.get(entityId)`: REST-only initially.
- `services.list`: REST and WebSocket.
- `services.call`: REST and WebSocket.
- `entities.subscribe`: WebSocket-only.
- `events.subscribe`: WebSocket-only.

Unsupported transport requests throw `UnsupportedTransportException` before making a network call.

## Internal Architecture

The resource APIs delegate to shared transport implementations:

```dart
class HATransportBundle {
  HATransportBundle({
    required HARestTransport rest,
    required HAWebSocketTransport websocket,
    required HATransportDefaults defaults,
  });
}
```

REST transport responsibilities:

- Build requests relative to `serverUri`.
- Resolve bearer token through `tokenProvider`.
- Attach `Authorization: Bearer <token>`.
- Encode JSON request bodies.
- Decode JSON response bodies.
- Enforce request timeout.
- Map HTTP failures to package exceptions.

WebSocket transport responsibilities:

- Open and own WebSocket connection when needed.
- Authenticate using the same `tokenProvider`.
- Send one-shot JSON messages with generated ids.
- Manage pending command responses and timeouts.
- Create subscriptions and dispose them correctly.
- Map HA error responses and connection failures to package exceptions.

The existing `HAConnection`, `ConnectionOrchestrator`, `HASubscription`, and message types can be reused internally, but the public app-facing entry point becomes `HomeAssistantApi`.

## Login Data Flow

Current login flow uses a one-shot WebSocket config repository. Replace that with REST config fetch:

```dart
final api = ref.read(homeAssistantApiProvider(server.id!));
final config = await api.config.get(via: HATransport.rest);
```

Flow:

1. `LoginFlowController` creates a temporary server.
2. OAuth login stores credentials.
3. `HomeAssistantApi` resolves server URL and token for that temporary server.
4. `api.config.get(via: HATransport.rest)` calls `GET /api/config`.
5. Server metadata is updated from `HassConfig`.
6. Active server is activated.
7. The normal active server WebSocket session starts separately through the connection manager.

This removes one-shot WebSocket creation from login initialization and prevents login from depending on active WebSocket session state.

## Error Model

Package exceptions:

```dart
sealed class HAApiException implements Exception {}

class HAAuthenticationException extends HAApiException {}
class HAConnectionException extends HAApiException {}

class HAHttpException extends HAApiException {
  HAHttpException({
    required this.statusCode,
    this.body,
  });

  final int statusCode;
  final Object? body;
}

class HAWebSocketException extends HAApiException {}
class UnsupportedTransportException extends HAApiException {}
```

Rules:

- REST `401` and `403` map to `HAAuthenticationException`.
- REST non-2xx responses map to `HAHttpException`.
- REST timeout or socket failures map to `HAConnectionException`.
- WebSocket authentication failures map to `HAAuthenticationException`.
- WebSocket HA error responses map to `HAWebSocketException`.
- Unsupported typed transport requests map to `UnsupportedTransportException`.
- Raw APIs preserve HA response body details where possible.

## Migration Plan

Migration should be staged:

1. Add `HomeAssistantApi`, REST transport, WebSocket transport adapter, typed `config.get`, and raw escape hatches.
2. Migrate login initialization from `websocketConfigRepositoryProvider` to `api.config.get(via: HATransport.rest)`.
3. Add typed APIs for states, services, entity subscriptions, and event subscriptions.
4. Migrate app usages from `HACommands`:

```dart
HACommands.getConfig(connection)      -> api.config.get()
HACommands.getStates(connection)      -> api.states.list()
HACommands.getServices(connection)    -> api.services.list()
HACommands.callService(connection...) -> api.services.call(...)
HACommands.subscribeEntities(conn)    -> api.entities.subscribe()
HACommands.subscribeEvents(conn, ...) -> api.events.subscribe(...)
```

5. Delete `HACommands` once package and app usages are gone.
6. Remove one-shot WebSocket config repository if no longer needed.

## Testing Strategy

Package tests:

- REST transport attaches bearer token.
- REST transport builds paths relative to `serverUri`.
- REST transport sends JSON bodies for POST/PUT requests.
- REST transport decodes JSON objects and arrays.
- REST transport maps `401`/`403` to `HAAuthenticationException`.
- REST transport maps non-2xx responses to `HAHttpException`.
- REST timeout/socket errors map to `HAConnectionException`.
- WebSocket raw send attaches generated ids and returns response payloads.
- WebSocket raw subscription returns `HASubscription`.
- `config.get(via: rest)` calls `GET /api/config`.
- `config.get(via: websocket)` sends `{type: get_config}`.
- `states.list` honors transport defaults and per-call override.
- `services.call` honors transport defaults and per-call override.
- Subscription APIs reject `via: rest` or do not expose a REST option.
- Unsupported transport failures happen before network calls.
- Raw REST accepts arbitrary method/path/body.
- Raw WebSocket accepts arbitrary message maps.

App tests:

- Login config fetch uses REST and does not open a one-shot WebSocket.
- Login rollback still clears credentials and removes the temporary server when REST config fetch fails.
- Existing entity subscription behavior remains WebSocket-based.
- Existing light service call behavior remains covered after migration.
- No active WebSocket is required for login `get_config`.

Red-green discipline:

- Each migrated operation gets a failing test before production changes.
- Transport-selection tests must fail for the wrong transport before implementation.
- Login migration must prove WebSocket factory/orchestrator is not invoked.

## Non-Goals

- Do not type every HA REST endpoint in the first pass.
- Do not type all 340 WebSocket message types.
- Do not make REST and WebSocket appear equivalent where HA does not support both.
- Do not introduce automatic fallback between transports unless explicitly designed later. A failed REST request should not silently retry on WebSocket without caller consent.

## Open Decisions

- Package naming can remain `home_assistant_websocket` for the first implementation, but a future rename to `home_assistant_api` would better match the new scope.

## Decided

- `HACommands` does not need a compatibility layer. Delete it once package and app usages have migrated to the resource API.
