# home_assistant_client

A Dart client for Home Assistant REST and WebSocket APIs.

The package exposes a typed API for common Home Assistant operations and raw
transport escape hatches for API calls that are not wrapped yet.

## Import

```dart
import 'package:home_assistant_client/home_assistant_client.dart';
```

## REST usage

Use the REST constructor when the operation does not require an active WebSocket
connection.

```dart
final api = HomeAssistantApi(
  serverUri: Uri.parse('http://homeassistant.local:8123'),
  tokenProvider: () async => accessToken,
);

final config = await api.config.get();
final states = await api.states.list();
final kitchen = await api.states.get('light.kitchen');

await api.services.call(
  domain: 'light',
  service: 'turn_on',
  target: const HATarget(entityIds: ['light.kitchen']),
  serviceData: {'brightness': 180},
);
```

The default REST-backed client uses REST for one-shot reads and service calls.
WebSocket-only APIs, such as event subscriptions, are unavailable from this
constructor and throw `UnsupportedTransportException`.

## WebSocket usage

Use `HAConnection` when you need a long-lived Home Assistant WebSocket session,
subscriptions, or WebSocket-only commands.

```dart
final connection = HAConnection(
  HAConnectionOption(
    serverUrl: Uri.parse('http://homeassistant.local:8123'),
    fetchAuthToken: () async => token,
  ),
);

await connection.connect();

final api = HomeAssistantApi.fromConnection(connection);

final services = await api.services.list();
final result = await api.services.call(
  domain: 'light',
  service: 'toggle',
  target: const HATarget(entityIds: ['light.kitchen']),
);

final subscription = api.events.subscribe('state_changed');
final streamSubscription = subscription.stream.listen((event) {
  // Handle Home Assistant event payloads here.
});

await streamSubscription.cancel();
await subscription.dispose();
await connection.close();
```

`fetchAuthToken` returns an `HAAuthToken`. Your app owns that implementation, so
it can read tokens from secure storage, refresh them before connecting, and
decide how expired tokens are handled.

## Choosing a transport per call

Some typed APIs support both REST and WebSocket. Pass `via` when you need a
specific transport.

```dart
final config = await api.config.get(via: HATransport.rest);
final states = await api.states.list(via: HATransport.websocket);
final services = await api.services.list(via: HATransport.rest);
```

The selected transport must exist on the `HomeAssistantApi` instance. A
REST-created client cannot run WebSocket calls, and a connection-created client
cannot run REST calls.

## Raw REST requests

Use `api.rest.requestJson` when Home Assistant supports an HTTP endpoint that is
not wrapped by the typed API yet.

```dart
final history = await api.rest.requestJson(
  method: 'GET',
  path: '/api/history/period',
);

final response = await api.rest.requestJson(
  method: 'POST',
  path: '/api/services/light/turn_on',
  body: {
    'entity_id': 'light.kitchen',
    'brightness': 128,
  },
);
```

The REST transport automatically adds:

- `Authorization: Bearer <token>`
- `Accept: application/json`
- `Content-Type: application/json` when a body is present

Non-2xx responses throw `HAHttpException`. Authentication failures throw
`HAAuthenticationException`. Network failures throw `HAConnectionException`.

## Raw WebSocket requests

Use `api.websocket.sendJson` or `api.websocket.subscribeJson` for WebSocket
messages that are not wrapped yet.

```dart
final areas = await api.websocket.sendJson({
  'type': 'config/area_registry/list',
});

final entityUpdates = api.websocket.subscribeJson({
  'type': 'subscribe_entities',
});

final listener = entityUpdates.stream.listen((event) {
  // Handle entity update payloads here.
});

await listener.cancel();
await entityUpdates.dispose();
```

Raw WebSocket payloads must include a non-empty `type`. The connection layer
assigns command ids automatically, so do not include `id` unless you are working
directly at a lower level.

## Common typed API

```dart
await api.config.get();
await api.states.list();
await api.states.get('light.kitchen');
await api.services.list();
await api.services.call(domain: 'light', service: 'turn_off');
api.entities.subscribe(entityIds: ['light.kitchen']);
api.events.subscribe('state_changed');
```

## Logging

`HAConnectionOption` uses `PrintLogger` by default. Use
`HAConnectionOption.withLogger` to provide an app logger or disable logging.

```dart
final options = HAConnectionOption.withLogger(
  serverUrl: Uri.parse('http://homeassistant.local:8123'),
  fetchAuthToken: () async => token,
  customLogger: const NoOpLogger(),
);
```
