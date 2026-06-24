# Login and Connection Session Architecture - Design

Date: 2026-06-22
Branch: `codex/login-connection-architecture`
Status: Draft for review

## Problem

Login, active-server selection, websocket connection ownership, connection state,
auth revocation, and registry sync are currently spread across several
independent pieces:

- `AuthController.login()` creates a server, completes OAuth, fetches config over
  websocket, and activates the server.
- `serverSessionCoordinatorProvider` watches auth and active server, then eagerly
  opens a connection and signs out on auth failure.
- `ServerScopeHost` opens or awaits another connection and injects
  `serverScopeConnectionProvider`.
- Feature controllers such as area/entity sync watch
  `serverConnectionStateProvider` and then read `serverScopeConnectionProvider`.
- Home decides loading by combining cached entity emptiness with sync controller
  state.

This makes connection readiness a cross-cutting concern that leaks into feature
controllers. It also creates races because "connected" is global active-server
state while the connection object used by scoped providers is injected through a
separate async widget path. The result is fragile login behavior: after login the
app can reach Home while registry sync has not safely completed, producing an
indefinite spinner when no entities are cached.

## Goal

Create one clear session boundary for everything related to the active Home
Assistant server:

- login activates a server only after credentials and server metadata are valid;
- one owner manages the active server websocket lifecycle;
- connection state is exposed as session state, not as a raw global enum for
  every feature to interpret;
- initial area/entity sync runs from one coordinator after the session is online;
- Home can distinguish connecting, offline-with-cache, initial-sync, sync-failed,
  synced-empty, and ready-with-data;
- feature controllers no longer contain `ref.watch(serverConnectionStateProvider)`.

The first implementation should stabilize the active-server path only. Multi-server
background connections, background sync queues, and advanced offline mutation
queues remain out of scope.

## Current Failure Modes

### Split Connection Ownership

`serverConnectionManagerProvider.getConnection(serverId)` is called by config
fetch, session coordination, server scope injection, and websocket repositories.
The manager stores established orchestrators, but it does not represent an
in-flight connection as a shared resource. Concurrent calls can create competing
orchestrators or observe different readiness moments.

### Global State Plus Scoped Connection

`serverConnectionStateProvider` represents the active server's transport state.
`serverScopeConnectionProvider` represents the actual connection object injected
for server-scoped code. Because these are separate mechanisms, a feature can see
`connected` and still read an unavailable or stale scoped connection.

### Feature Controllers Know Too Much

Area sync, entity sync, live entity states, hub status, and offline UI all read
raw connection state. Each controller must decide when to start, stop, retry, or
render offline. That duplicates lifecycle rules and makes future controllers easy
to get wrong.

### E2E Coverage Does Not Catch Sync Readiness

The existing Patrol tests mostly assert route and banner visibility. `K.home.page`
is present on the loading scaffold, so a test can pass while Home still shows a
spinner. The offline banner tests are not included in `test_bundle.dart`, and the
Home Assistant docker fixture does not create deterministic areas/entities for a
post-login sync assertion.

## Proposed Architecture

Use three explicit layers:

1. `LoginFlowController` owns the one-shot login transaction.
2. `ActiveServerSessionController` owns active server session state and the
   active websocket resource.
3. `ServerSyncCoordinator` owns initial registry sync and registry update
   subscriptions for the active online session.

Feature controllers consume session/sync summaries and cached repositories. They
do not consume raw connection state.

```text
Auth UI
  -> LoginFlowController
      -> create temporary server
      -> OAuth
      -> fetch server config using a one-shot authenticated connection
      -> persist metadata + credentials
      -> activate server

activeServerProvider + authStateProvider
  -> ActiveServerSessionController
      -> connect / reconnect active server
      -> expose session state
      -> handle auth failure and sign-out
      -> provide the active connection to infrastructure only

ActiveServerSession.online
  -> ServerSyncCoordinator
      -> initial area sync
      -> initial entity/device registry sync
      -> registry update subscriptions
      -> expose initial sync status

Home / features
  -> cached repositories + sync/session summaries
```

## Components

### LoginFlowController

`LoginFlowController` replaces the login use of the generic action chain for this
critical path. It should keep the transaction explicit and rollback-safe:

1. Create a non-active server row from the entered URL.
2. Complete OAuth and store credentials scoped to the new server id.
3. Open a temporary authenticated connection for server config only.
4. Fetch HA config and persist server name/version/internal/external URL.
5. Close the temporary connection.
6. Activate the server.

If any step before activation fails, rollback deletes the temporary server and
clears credentials. Activation becomes the point where the app is allowed to
start the long-lived active session.

### ActiveServerSessionController

`ActiveServerSessionController` is a keep-alive Riverpod notifier that watches
`activeServerProvider` and `authStateProvider`. It is the only component allowed
to set the active long-lived connection.

It exposes a sealed state:

```dart
sealed class ActiveServerSessionState {
  const ActiveServerSessionState();
}

final class NoActiveServerSession extends ActiveServerSessionState {}
final class ResolvingServerSession extends ActiveServerSessionState {}
final class ConnectingServerSession extends ActiveServerSessionState {
  final Server server;
}
final class OnlineServerSession extends ActiveServerSessionState {
  final Server server;
  final IHAConnection connection;
}
final class OfflineServerSession extends ActiveServerSessionState {
  final Server server;
  final Object? cause;
}
final class AuthRevokedServerSession extends ActiveServerSessionState {
  final Server server;
}
```

Rules:

- No active server -> `NoActiveServerSession`.
- Active server with valid credentials -> connect and transition through
  `ConnectingServerSession`.
- Authenticated websocket -> `OnlineServerSession`.
- Transport failure that can reconnect -> `OfflineServerSession`, while keeping
  cached app data usable.
- Auth failure -> `AuthRevokedServerSession`, then trigger sign-out once.
- Active server switch -> dispose previous active connection before opening the
  next one.

This controller replaces `serverSessionCoordinatorProvider` and should be the
only writer of active session state.

### Connection Resource

Refactor `IServerConnectionManager` into a narrower active-session resource. The
manager must be idempotent:

- one active connection attempt per server id;
- concurrent callers receive the same in-flight future;
- reconnect replaces the resource atomically;
- stale state events from an old orchestrator are ignored;
- auth-failure events are surfaced distinctly from transient disconnects.

General feature code should not call `getConnection(serverId)`. Direct connection
access remains limited to session infrastructure and websocket-backed
repositories created inside an online session.

### ServerScopedConnection Provider

Keep scoped providers, but change what they represent:

- `serverScopeIdProvider` and `serverScopeServerProvider` remain simple scoped
  values.
- `serverScopeConnectionProvider` is overridden only when
  `ActiveServerSessionState` is online.
- Offline UI should not receive an `UnavailableHAConnection` as if it were a real
  connection. Consumers that need a websocket should be mounted only in an online
  session or should call a repository that returns a domain failure.

This removes the current "placeholder connection" ambiguity.

### ServerSyncCoordinator

`ServerSyncCoordinator` watches `activeServerSessionProvider`.

When the session becomes online:

1. Start area registry subscription.
2. Start entity and device registry subscriptions.
3. Run initial area sync and entity sync.
4. Mark initial sync complete only after both initial syncs finish.

When the session becomes offline:

- cancel remote subscriptions;
- preserve cached data;
- expose offline sync status rather than reverting to "not started".

When the session reconnects:

- recreate subscriptions;
- rerun initial sync for the new connection;
- update status to ready or failure.

Expose:

```dart
sealed class ServerSyncState {
  const ServerSyncState();
}

final class SyncIdle extends ServerSyncState {}
final class InitialSyncRunning extends ServerSyncState {}
final class SyncReady extends ServerSyncState {}
final class SyncOfflineWithCache extends ServerSyncState {}
final class SyncFailed extends ServerSyncState {
  final Object error;
}
```

The existing area and entity sync controllers should stop being public feature
dependencies. The implementation can keep their internal logic as private helper
classes, but `ServerSyncCoordinator` becomes the only public provider that starts
and stops registry sync for the active session.

### Feature Controllers

Feature controllers should use domain-level inputs:

- cached repositories for persisted data;
- `activeServerSessionSummaryProvider` for coarse online/offline/auth state;
- `serverSyncStateProvider` for initial sync readiness;
- operation controllers that return domain failures when offline.

Controllers should not watch `serverConnectionStateProvider`. That provider
should either disappear or become an internal implementation detail used only by
session infrastructure and `OfflineContainer` replacement logic.

Home should compute:

- `isInitialSyncing`: no cached entities and `InitialSyncRunning`;
- `isOffline`: session is offline;
- `syncFailure`: sync failed and no cache is available;
- `empty`: sync ready and no renderable entities exist.

This prevents an indefinite spinner when sync is not running or has failed.
The only providers allowed to read raw websocket state are session
infrastructure providers. New feature/application providers must not depend on
`serverConnectionStateProvider`.

## Data Flow

### Fresh Login

```text
user submits URL
  -> LoginFlowController.login(url)
  -> OAuth succeeds
  -> config fetched with temporary connection
  -> server persisted and activated
  -> ActiveServerSessionController sees active authenticated server
  -> online session emitted
  -> ServerSyncCoordinator runs initial sync
  -> Home renders cached synced content or synced-empty state
```

### App Start With Existing Server

```text
activeServerProvider emits persisted active server
authStateProvider resolves credentials
ActiveServerSessionController connects
ServerSyncCoordinator syncs or reports offline-with-cache
Router/Home render from session + sync states
```

### Network Loss And Recovery

```text
orchestrator reports disconnect
ActiveServerSessionController -> OfflineServerSession
ServerSyncCoordinator cancels subscriptions, preserves cache
Offline UI shows banner/status
orchestrator reconnects
ActiveServerSessionController -> OnlineServerSession
ServerSyncCoordinator reruns initial sync and subscriptions
Home keeps cached content throughout
```

### Server-Side Token Revocation

```text
websocket reports auth failure
ActiveServerSessionController -> AuthRevokedServerSession
sign-out runs once
connection disposed
credentials cleared
server removed or next server activated
router leaves Home
```

## Router And UI Behavior

The router should be gated by auth/server existence, not by sync completion.
Home should render session/sync states explicitly:

- no active server -> onboarding/servers discovery;
- connecting -> connection progress;
- online + initial sync -> initial sync progress;
- online + sync ready + data -> normal Home;
- online + sync ready + empty -> empty state;
- offline + cache -> cached Home with offline banner/status;
- offline + no cache -> offline empty/error state;
- auth revoked -> route away after sign-out.

This avoids treating Home route presence as proof that the app is usable.

## E2E Test Requirements

Update the integration environment so connection tests can prove real readiness:

1. Include `offline_banner_test.dart` in `test_bundle.dart`.
2. Seed a deterministic Home Assistant fixture with at least one area and one
   light entity.
3. Add e2e steps:
   - "I see light card `<entity_id>`";
   - "I do not see the initial home loading spinner";
   - "Home has completed initial sync".
4. Replace fixed sleeps after reconnect with condition-based waits for the
   expected UI state.
5. Ensure "logged in" setup creates or verifies an active server in app storage,
   not only credential overrides.

Required scenarios:

- fresh OAuth login reaches Home and renders the seeded light;
- launch with existing credentials reaches Home and renders the seeded light;
- network loss shows offline state while cached light remains visible;
- network restore hides offline state and the seeded light remains operational;
- launch offline with cached server shows offline-with-cache, then recovers and
  syncs;
- server-side token revocation signs out exactly once and routes away from Home.

## Migration Plan

1. Add `ActiveServerSessionState` and `ActiveServerSessionController` behind the
   existing providers.
2. Make connection acquisition idempotent by memoizing in-flight connection
   futures and ignoring stale orchestrator events.
3. Convert `ServerScopeHost` to read session state rather than starting its own
   connection future.
4. Add `ServerSyncCoordinator` and move area/entity sync startup into it.
5. Update Home to consume sync/session summaries instead of public sync
   controllers.
6. Replace feature-level `serverConnectionStateProvider` reads with session or
   domain operation APIs.
7. Retire or internalize `serverConnectionStateProvider`.
8. Strengthen integration tests with deterministic fixture and readiness
   assertions.

## Testing

Unit tests:

- connection manager returns one in-flight future for concurrent requests;
- stale connection events do not overwrite active session state;
- auth failure transitions to auth-revoked and triggers sign-out once;
- transient disconnect transitions to offline, then online after reconnect;
- active server switch disposes the previous connection.

Provider tests:

- `ActiveServerSessionController` state transitions for no server, valid
  credentials, missing credentials, auth revoked, connect failure, reconnect;
- `ServerSyncCoordinator` starts sync only for online sessions;
- sync coordinator cancels subscriptions on offline and reruns sync on reconnect;
- Home state mapping for initial sync, offline-with-cache, sync failure,
  synced-empty, and ready-with-data.

Integration tests:

- e2e scenarios listed above, backed by seeded HA area/light fixtures.

## Non-Goals

- Multi-server background websocket connections.
- Offline command queueing or conflict resolution.
- Rewriting the lower-level `home_assistant_websocket` package beyond the
  connection resource semantics needed by the active session.
- Full redesign of settings/hub pages.
