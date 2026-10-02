# E2E hass-cli bridge

The test bridge intentionally uses hass-cli as an independent Home Assistant fixture/admin client. It avoids relying on the app's WebSocket connection/reconnection code to establish its own test oracle. Docker lifecycle is controlled only by the Mac runner; Gherkin steps call the bridge over HTTP from Dart on the simulator.

`POST /cli` accepts exactly `{ "args": ["raw", "ws", "config/area_registry/list"], "token": "<management token>" }`. Arguments are passed as a subprocess array, with the token in `HASS_TOKEN` environment; shell strings and extra fields are rejected. The response contains `exit_code`, `stdout`, `stderr`. Check both CLI exit status and the HA WebSocket `success` result. `GET /health` supplies readiness. Mutations have a bounded server timeout and are never blindly retried: timeout means outcome unknown and requires an owned-resource lookup.

The container reaches HA directly (`homeassistant:8123`). App requests go through Toxiproxy, so disconnecting the app does not interrupt admin actions or cleanup. Keep control endpoints local to this dedicated fixture.

Example hass-cli argument arrays:

```dart
['raw', 'ws', 'config/area_registry/create', '--json={"name":"Hommie E2E <run> Initial"}']
['raw', 'ws', 'auth/long_lived_access_token', '--json={"lifespan":1,"client_name":"Hommie E2E <run> scenario1"}']
['raw', 'ws', 'auth/refresh_tokens']
['raw', 'ws', 'auth/delete_refresh_token', '--json={"refresh_token_id":"<exact owned ID>"}']
```

Scenario cleanup registers resources immediately after creation and removes only exact owned IDs or the current run namespace. The host ownership journal handles native interruption. Never revoke all tokens or remove all areas; management credentials and pre-existing HA data must survive tests.

See [local testing](../docs/testing.md) for commands, persistent volume migration, proxy control, diagnostics and recovery.
