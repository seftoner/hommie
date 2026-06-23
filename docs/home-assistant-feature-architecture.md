# Home Assistant Feature Architecture

Use this guide when adding features that read from or write to Home Assistant.
The goal is to keep REST, WebSocket, session state, and cached UI responsibilities
separate. Most feature bugs in this area come from opening sockets, watching raw
session state, or switching on connection enums from feature code.

## First Decision

Before writing code, classify the feature into one of these paths:

| Feature need | Use | Do not use |
|---|---|---|
| Cached data rendered online and offline | Drift/cache repositories scoped by `serverScopeIdProvider` | `IHAConnection`, active session, link state |
| One-shot REST-capable HA call | `homeAssistantApiProvider(serverId)` and `api.<resource>.*(via: HATransport.rest)` | Active WebSocket session |
| WebSocket command for the active server | `serverScopeConnectionProvider` then `HomeAssistantApi.fromConnection(connection)` | `serverConnectionManagerProvider.getConnection()` from feature code |
| Live subscription | A scoped provider that watches `serverScopeConnectionProvider`, subscribes, and disposes the `HASubscription` | Manual reconnect logic |
| Remote sync into cache | A coordinator that owns fetch/subscription and writes Drift cache | UI widgets reading WebSocket payloads directly |
| UI connection policy | `commandAvailabilityProvider` or a screen-specific projection | Raw `ActiveServerSessionState`, `ServerLinkState`, or socket state in widgets |

If a feature seems to need two paths, split it. Example: a light card reads cached
entity metadata from Drift, overlays live state from `entityStatesProvider`, and
sends commands through `EntityServiceController`.

## Ownership Rules

- The package `home_assistant_client` owns Home Assistant protocol primitives:
  typed resource APIs, raw REST/WebSocket transports, `HAConnection`, and
  `HASubscription`.
- `ServerConnectionManager` owns the active WebSocket resource. Feature code must
  not open or reconnect sockets directly.
- `serverLinkStateProvider` is the app's authoritative active-server link state.
  It is for session/projection infrastructure, not normal feature code.
- `ActiveServerSession` is a projection of active server, auth, and link state.
  Do not add destructive cleanup, socket listeners, or manual reconnect logic to it.
- `ServerLifecycleController` owns destructive server teardown: disconnect, clear
  credentials, delete cached home data, remove server, and activate next.
- `ServerScopeHost` injects the active server context. Server-dependent providers
  should depend on `serverScopeIdProvider`, `serverScopeServerProvider`, or
  `serverScopeConnectionProvider`.

## REST One-Shot Calls

Use REST when Home Assistant supports the endpoint and the operation does not
require an active WebSocket connection. Login `get_config` is the model:

```dart
final api = await ref.read(homeAssistantApiProvider(serverId).future);
final config = await api.config.get(via: HATransport.rest);
```

Rules:

- Use `homeAssistantApiProvider(serverId)` for app code. It resolves the server
  URL, token, and HTTP client.
- Pass `via: HATransport.rest` when the operation must not depend on WebSocket.
- Use `api.rest.requestJson(...)` only for endpoints that are not typed yet.
- Do not create temporary WebSocket connections for REST-capable setup or metadata
  calls.

## WebSocket Commands

Commands for the active server must use the scoped connection:

```dart
final connection = ref.read(serverScopeConnectionProvider);
await HomeAssistantApi.fromConnection(connection).services.call(
  domain: 'light',
  service: 'turn_on',
  target: const HATarget(entityIds: ['light.kitchen']),
);
```

Rules:

- Feature/application code gets the socket only from
  `serverScopeConnectionProvider`.
- Convert `ServerScopeConnectionUnavailableException` to a typed feature failure.
  For entity commands, use `RemoteCommandUnavailableException`.
- UI controls should gate on `commandAvailabilityProvider` instead of trying a
  command and interpreting low-level connection errors.
- Do not call `serverConnectionManagerProvider.getConnection()` from feature code.
  That method belongs to connection/session infrastructure.
- Do not call reconnect manually. The WebSocket orchestrator owns reconnect/backoff.

## Live Subscriptions

Live state providers should subscribe only while a scoped connection exists and
clean up on dispose or connection replacement:

```dart
@Riverpod(dependencies: [serverScopeConnection])
class ExampleLiveState extends _$ExampleLiveState {
  HASubscription? _sub;
  StreamSubscription<dynamic>? _events;

  @override
  ExampleState build() {
    final connection = ref.watch(serverScopeConnectionProvider);
    ref.onDispose(() {
      unawaited(_stop());
    });

    _sub = HomeAssistantApi.fromConnection(connection).events.subscribe(
      'state_changed',
    );
    _events = _sub!.stream.listen(_handleEvent);
    return const ExampleState.initial();
  }

  Future<void> _stop() async {
    await _events?.cancel();
    if (_sub != null && !_sub!.isDisposed) {
      await _sub!.dispose();
    }
  }
}
```

Rules:

- Watch `serverScopeConnectionProvider`, not raw session or socket state.
- Treat connection absence as an offline state, empty live overlay, or typed
  unavailable failure depending on the feature.
- Dispose `StreamSubscription` and `HASubscription`.
- Use identity checks only inside providers that own a live subscription and need
  to avoid re-subscribing to the same connection object.
- Never implement reconnect timers in a feature provider.

## Sync To Cache

For data that should survive offline mode, use a coordinator pattern:

1. Start when `ActiveServerSession` is online.
2. Fetch remote data through `HomeAssistantApi.fromConnection(connection)` or a
   small remote repository that wraps that API.
3. Write normalized data to Drift repositories with `serverId`.
4. Subscribe to HA update events and refresh affected cache.
5. Stop subscriptions when the session goes offline or the connection changes.
6. UI reads cache and a small sync-status projection, not remote payload streams.

`ServerSyncCoordinator` is the reference implementation for registry data.

## UI Policy

Widgets should not understand transport lifecycle details.

Use:

- `commandAvailabilityProvider` to enable/disable controls that send commands.
- `hubStatusProvider` for settings/hub connection display.
- Cached repositories and live state overlays for visible HA data.
- Small screen-specific projection providers only when a screen has distinct policy.

Avoid:

- `ref.watch(activeServerSessionProvider)` in ordinary feature widgets.
- `ref.watch(serverLinkStateProvider)` outside connection/session projections.
- Switching on `HASocketState`, `ServerLinkState`, or connection errors in UI.

## Raw Escape Hatches

Typed `HomeAssistantApi` resources are preferred. Raw transports are allowed when
Home Assistant supports an endpoint/message that is not typed yet:

```dart
final result = await api.rest.requestJson(
  method: 'GET',
  path: '/api/history/period',
);

final areas = await api.websocket.sendJson({
  'type': 'config/area_registry/list',
});
```

When using a raw request:

- Keep it behind a repository or coordinator, not directly in widgets.
- Add a focused test that asserts the HA path/message type and error behavior.
- Prefer promoting repeated raw calls into typed `home_assistant_client` resources.

## Test Expectations

Every new Home Assistant feature should test the chosen path:

- REST one-shot: request method/path, bearer-token behavior when relevant, and no
  WebSocket dependency.
- WebSocket command: succeeds with `serverScopeConnectionProvider` overridden and
  returns a typed unavailable failure when the scoped connection is absent.
- Live subscription: subscribes only with a scoped connection, applies events, and
  disposes old subscriptions on connection replacement/offline.
- Cache-backed UI: renders cached data without a WebSocket connection.
- UI policy: disabled/enabled states come from projection providers, not raw socket
  state.

Useful architecture guard sweeps before finishing:

```bash
rg "getConnection\\(" app/lib/features app/lib/ui
rg "serverLinkStateProvider|HASocketState|ActiveServerSessionState" app/lib/features app/lib/ui
rg "home_assistant_client" app/lib/features app/lib/application app/lib/core
```

The first two commands should return only deliberate infrastructure/projection
uses. The third command is for reviewing whether a feature is using the package
from the correct layer.
