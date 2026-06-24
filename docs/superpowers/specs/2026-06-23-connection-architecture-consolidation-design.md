# Connection Architecture Consolidation — Design

Date: 2026-06-23
Branch: `codex/login-connection-architecture`

## Purpose

Consolidate the connection/login/session work into one coherent target and finish
the half that was never completed. This spec supersedes parts of
[`2026-06-22-login-connection-session-architecture-design.md`](2026-06-22-login-connection-session-architecture-design.md)
and absorbs the two existing implementation plans:

- `docs/superpowers/plans/2026-06-23-auth-session-ownership-cleanup.md`
- `docs/superpowers/plans/2026-06-23-scalable-connection-capabilities.md`

It produces **three sequenced implementation plans (A → B → C)**, not one, because
the combined scope is too large for a single plan.

## Lineage: what exists, what's missing

The 2026-06-22 design introduced the right top-level layering and most of it
shipped:

- `LoginFlowController` owns the one-shot login transaction. **Done, and good.**
- `ActiveServerSession` (`active_server_session_controller.dart`) owns active-server
  session state. **Exists, but does too much** (see root cause).
- `ServerSyncCoordinator` owns initial registry sync + subscriptions. **Done.**
- Scoped providers (`serverScopeId/Server/Connection`) exist. **Done, but unused by
  features** — only `ServerScopeHost` consumes `serverScopeConnectionProvider`.

Two things the predecessor called for were **never finished**, and they are the
source of the remaining pain:

1. It said `serverConnectionStateProvider` should "disappear or become an internal
   implementation detail" and be retired. It was **not** retired — the global
   `HAServerConnectionState` enum is still a live hop between the manager and the
   session, and the session reconciles it against its own connect future.
2. It said feature controllers should stop reading raw connection/session state.
   They still do: entity commands, entity-state subscription, hub status, Home, and
   the offline banner all read `activeServerSessionProvider` directly.

This spec supersedes **one** decision from the predecessor: it said the session
controller should "handle auth failure and sign-out." Experience since then (the
race-hardening commits) shows that mixing session-state production with destructive
cleanup is a mistake. **Destruction moves to a dedicated owner.**

## Root cause

A REST call is request/response: self-contained `AsyncValue<T>` you can model and
forget. A websocket is a long-lived resource whose state machine is driven by the
network and the server. The app's job is to **observe and project** that external
machine — but the current code repeatedly tries to **re-derive** it.

That single mistake produces the concrete root causes this spec targets:

- **RC1 — Two overlapping connection state machines.** The transport lifecycle is
  modeled correctly once in the `home_assistant_websocket` package
  (`ConnectionOrchestrator`: connect, backoff, auto-reconnect, heartbeat, auth-fail
  stop). It is then re-modeled a second time in `ActiveServerSession` by merging the
  `getConnection()` future with the transport-state stream. Reconciling two views of
  one socket is what forces the revision counters and race guards.
- **RC2 — Imperative effects inside a reactive build.** `build()` /
  `_stateForCurrentInputs()` call `setActiveServer()` / `getConnection()` as side
  effects of a derive, so the notifier is both reducer and effect-runner.
- **RC3 — Observe + destroy in one place.** The session producer also deletes
  credentials/servers on revocation (`_triggerSignOut`).
- **RC4 — A single global transport enum for a multi-server app.**
  `serverConnectionStateProvider` is one value, updated only for the active server,
  used purely as an internal hop.
- **RC5 — State-representation sprawl.** Four types already express "is the link
  up?" — `HASocketState` (pkg) → `HAServerConnectionState` (app global) →
  `ActiveServerSessionState` (session) → partially `ServerSyncState`. Two
  `AuthState` variants (`refreshing`, `authenticating`) are **never emitted** by
  `authStateProvider` (the only source) yet must be handled in every switch.
- **RC6 — Connection passed by value through multiple holders.** The manager owns
  `IHAConnection`, but it is also embedded in `OnlineServerSession`, then re-exposed
  by `serverScopeConnectionProvider`; identity checks (`identical(_connection, …)`)
  leak into consumers.

## Decisions (locked)

1. **One active connection at a time.** Switching the active server tears down the
   previous socket (today's behavior). `ServerLinkState` is a single provider, not a
   per-server family. Multiple concurrent connections are a non-goal.
2. **Online state carries the live `IHAConnection`, but through a single channel.**
   The connection flows out of the link-state stream only — there is no parallel
   `getConnection()` future in the session. This removes the dual-source race (RC1)
   with minimal churn (vs. switching all consumers to connection-by-id).
3. **Remove the unreachable `AuthState.refreshing` and `AuthState.authenticating`.**
   Verified never produced by `authStateProvider`. Token refresh is handled silently
   inside the oauth2 layer; there is no token-refresh UX that needs to surface them.

## Target architecture

**Principle: observe the connection, don't re-derive it. One authoritative
per-active-server link state; session, sync, and capabilities are pure projections
off it. No component reconstructs the socket lifecycle.**

| Component | Role in target | Change |
|---|---|---|
| `ConnectionOrchestrator` (pkg) | Sole source of transport truth: connect, backoff, auto-reconnect, heartbeat, auth-fail stop | unchanged |
| `ServerConnectionManager` | Owns the one active connection resource; opens/closes; idempotent in-flight dedup | maps `HASocketState` directly to `ServerLinkState` and publishes it; `reconnect()` deleted; global-enum callback removed |
| **`serverLinkStateProvider`** | The single connection-lifecycle type | **new** — replaces `serverConnectionStateProvider` |
| `ActiveServerSession` | Pure projection `(activeServer, authState, serverLinkState)` → `ActiveServerSessionState` | rewritten — no `_open`, no transport listener, no `_sessionRevision`/`_connectingAttempt`/`_publish`-vs-`_remember`, no sign-out |
| `ServerLifecycleController` | Sole owner of destructive teardown (disconnect + clear creds + delete home view + remove server) | **new** (Phase A) |
| `AuthRevocationHandler` | Observes `AuthRevokedServerSession` → lifecycle once per server | **new** (Phase A) |
| `AuthController` | UI facade: delegates login to `LoginFlowController`, sign-out to lifecycle | simplified (Phase A) |
| `ServerSyncCoordinator` | online → subscribe + sync to cache; offline → cache | role unchanged |
| `serverScope{Id,Server,Connection}` | Server-scoped injection boundary | now actually consumed by features (Phase C) |
| Capability projections | `commandAvailability` + hub view-model + 1-line banner | trimmed Phase C |

### The single connection-lifecycle type

```dart
sealed class ServerLinkState {
  const ServerLinkState();
}

final class LinkConnecting extends ServerLinkState {
  const LinkConnecting();
}

final class LinkOnline extends ServerLinkState {
  const LinkOnline(this.connection);
  final IHAConnection connection;
}

final class LinkReconnecting extends ServerLinkState {
  const LinkReconnecting();
}

final class LinkOffline extends ServerLinkState {
  const LinkOffline({this.cause});
  final Object? cause;
}

final class LinkAuthFailed extends ServerLinkState {
  const LinkAuthFailed();
}

final class LinkIdle extends ServerLinkState {
  // Initial/default value before the active server's first connection attempt
  // has emitted (analogous to today's HAServerConnectionState.unknown).
  const LinkIdle();
}
```

The manager drives this provider for the active server only. `HASocketState` is
mapped to it directly inside the manager; the `HAServerConnectionState` enum is
deleted.

The session resolves inputs in a fixed precedence: inputs still loading →
`ResolvingServerSession`; no active server → `NoActiveServerSession` (link state is
not consulted); otherwise consult auth + link state per the table below. Because of
this precedence, `LinkIdle` in the table only ever applies when an authenticated
active server has just been set and the first connect has not yet emitted — so it
maps to `ConnectingServerSession`.

### Session as a pure projection

`ActiveServerSession.build()` watches three inputs and pattern-matches. Its **only**
side effect is one idempotent command — telling the manager which server is active —
which the manager dedups (`if (_activeServerId == serverId) return`). All session
state arrives by reading `serverLinkStateProvider`; the connection object arrives via
`LinkOnline.connection`.

Mapping (active server present, `serverId != null`):

| auth state | link state | → session state |
|---|---|---|
| Authenticated | `LinkOnline(c)` | `OnlineServerSession(server, c)` |
| Authenticated | `LinkConnecting` / `LinkIdle` (just set active) | `ConnectingServerSession(server)` |
| Authenticated | `LinkReconnecting` / `LinkOffline` | `OfflineServerSession(server, cause)` |
| Authenticated | `LinkAuthFailed` | `AuthRevokedServerSession(server)` |
| Revoked | any | `AuthRevokedServerSession(server)` |
| Unauthenticated / Failure | any | `NoActiveServerSession` |

Inputs still resolving (`AsyncLoading`) → `ResolvingServerSession`. No active server
→ `NoActiveServerSession` (and active server set to `null` on the manager).

This deletes the entire race-guard apparatus: `_open`, `_handleTransportState`,
`_connectingAttempt`, `_sessionRevision`, `_isCurrent`, `_lastSession`, the
`_publish`/`_remember` split, `_signedOutServerIds`, `_signingOut`,
`_triggerSignOut`. The notifier becomes a small pure function plus one idempotent
`setActiveServer` call.

### Connection lifetime ownership

- The **manager** owns the live `IHAConnection` and its socket-state subscription.
- The **session** reads the connection from `LinkOnline` and exposes it on
  `OnlineServerSession`.
- The **scope host** injects `OnlineServerSession.connection` into
  `serverScopeConnectionProvider`; that provider is the single accessor for
  feature/infrastructure code that needs the socket.

One owner, one accessor — no general feature code calls `getConnection()`.

## Phases

### Phase A — Ownership cleanup (= the auth-session-ownership-cleanup plan)

Delivered essentially as written in that plan:

- Add `ServerLifecycleController` (disconnect → clear credentials → delete home view
  → remove server → activate next), the sole destructive owner.
- Add `AuthRevocationHandler` that reacts to `AuthRevokedServerSession` and delegates
  to the lifecycle controller once per server (idempotency via a handled-id set).
- Strip destructive cleanup from `ActiveServerSession` (`_triggerSignOut`,
  `_signedOutServerIds`, `_signingOut`, the `authController` dependency).
- `AuthController.signOut`, settings sign-out, and server-list delete all route
  through the lifecycle controller.
- Delete the 11-file action-chain framework (used by one method).

Outcome: the session no longer destroys anything; the worst coupling (RC3) is gone
and the notifier shrinks before the bigger rewrite.

### Phase B — Collapse transport + session-as-projection (the missing middle)

This is the part neither existing plan covers and the real fix for RC1/RC2/RC4.

- Introduce `ServerLinkState` + `serverLinkStateProvider`.
- Rewire `ServerConnectionManager` to map `HASocketState` → `ServerLinkState` and
  publish it for the active server (replacing the `setState`/`ServerConnectionState`
  callback wiring). The manager keeps its existing idempotent in-flight dedup and
  versioning.
- Delete `serverConnectionStateProvider` / `HAServerConnectionState` and the dead
  `IServerConnectionManager.reconnect()`.
- Rewrite `ActiveServerSession` as the pure projection above.
- Remove the unreachable `AuthState.refreshing` / `AuthState.authenticating`
  variants and their switch arms (router, session, hub).

Outcome: one observed connection-lifecycle type; the session is a small pure map;
the race-guard bookkeeping is deleted.

### Phase C — Consumer decoupling (= the scalable-connection-capabilities plan, trimmed)

The high-value half of that plan, simplified by Phase B:

- Entity commands (`entity_service_controller.dart`) acquire the socket via
  `serverScopeConnectionProvider`; when unavailable they throw a single typed
  command-unavailable failure. **No third exception type** — with Phase B the scoped
  provider can return the typed unavailable directly, collapsing the
  `UnimplementedError` → `NoOnlineServerConnectionException` →
  `RemoteCommandUnavailableException` chain.
- Live entity-state subscription (`entity_states_provider.dart`) watches
  `serverScopeConnectionProvider` instead of raw session state.
- Cached-read providers depend only on scoped **server identity**, never the socket,
  so they render online and offline.
- Add **one** `commandAvailability` projection (`canSend` + reason) for UI gating
  (e.g. light card switch).
- Replace the hub page's raw `ActiveServerSessionState` with a `HubConnectionStatus`
  view-model.
- Reduce the offline banner to a one-line projection.
- **Skip** the per-screen capability proliferation (`homeCapabilitiesProvider` as a
  separate type, `offlineBannerVisibilityProvider` as its own file). Home computes
  its flags inline from session + sync as it does today; add a screen-specific
  capability provider only when a screen has genuinely distinct policy.
- Keep the architecture-guard checks (rg sweeps) that forbid feature/UI code from
  watching raw transport/session state.

Outcome: the "easy to use" end state — a feature author asks one question (below) and
never switches on a connection enum.

## Redundancy removed

1. `IServerConnectionManager.reconnect()` — dead (package owns reconnection). Deleted
   in Phase B.
2. `HAServerConnectionState` global enum — redundant hop and multi-server hazard.
   Replaced by `serverLinkStateProvider` in Phase B.
3. The action-chain framework (11 files) — used by one method. Deleted in Phase A.
4. `AuthState.refreshing` / `authenticating` — unreachable. Removed in Phase B.
5. Dual "go Online" paths in the session (`_open` success vs. `handleTransportState`)
   — collapsed in Phase B.
6. Session race-guard fields — deleted in Phase B.

## Data flows (updated ownership)

### Fresh login
URL → `LoginFlowController` (add temporary server → OAuth → fetch config → disconnect
→ persist metadata → activate) → `activeServer` + `authState` resolve → manager
connects the active server, publishes `LinkConnecting` → `LinkOnline(c)` → session
projects `Online` → `ServerSyncCoordinator` runs initial sync → Home renders cache.

### App start with existing server
`activeServer` emits persisted server; `authState` resolves credentials; manager
connects; link state drives session; sync runs or reports offline-with-cache.

### Network loss and recovery
Package orchestrator drops → `LinkOffline`/`LinkReconnecting` → session `Offline`;
sync cancels subscriptions, keeps cache; banner shows. Orchestrator reconnects (its
own backoff) → `LinkOnline(c)` → session `Online` → sync reruns. Cache stays visible
throughout. The app never initiates reconnection itself.

### Server-side token revocation
Socket reports auth failure → manager publishes `LinkAuthFailed` (or `authState`
becomes `Revoked` at credential eval) → session projects `AuthRevokedServerSession` →
`AuthRevocationHandler` calls `ServerLifecycleController.signOutServer(id)` once →
credentials cleared, home view deleted, server removed, next server activated →
`authState`/`activeServer` change → session reprojects → router leaves Home.

## Testing strategy

Each phase is test-driven, mirroring the existing plans.

- **Phase A:** lifecycle controller (disconnect/clear/delete/remove ordering;
  failure surfaces a lifecycle exception; no-op with no active server); revocation
  handler (signs out a revoked server once; ignores online); session asserts state
  only, no cleanup side effects; auth-controller facade delegates sign-out.
- **Phase B:** manager maps each `HASocketState` to the right `ServerLinkState` and
  publishes for the active server only; stale socket events ignored; session
  projection table above (no server, connecting, online, offline, reconnecting,
  auth-failed, revoked, resolving); active-server switch tears down the previous
  socket; removal of dead auth states leaves analyzer clean.
- **Phase C:** entity command throws the single typed unavailable failure when the
  scoped connection is absent and succeeds when present; entity-state subscription
  starts only with a scoped connection; `commandAvailability` reasons; hub
  view-model mapping; banner visibility; architecture-guard rg sweeps return only
  the allowed files.
- Full `flutter analyze` + `flutter test` clean after each phase;
  `home_assistant_websocket` package `dart analyze` + `dart test` clean after
  Phase B.

## Risks and mitigations

- **Phase B is the highest-risk step** (rewrites the session + manager wiring).
  Mitigation: land Phase A first (smaller notifier), keep the existing session
  state-transition tests as the safety net, and do B behind the unchanged
  `ActiveServerSessionState` public type so consumers don't move until Phase C.
- **Revoke → activate-next cascade** is reactive across providers. Mitigation: add an
  integration-level test that revokes the active server and asserts the next server
  becomes active (not only unit tests of the controller in isolation).
- **`setActiveServer` as a build side effect** remains (now single and idempotent).
  Mitigation: assert idempotency in a manager test; document it as the one allowed
  effect.

## Non-goals

- Multiple concurrent server websocket connections (decision 1).
- Offline command queueing / conflict resolution.
- Rewriting the `home_assistant_websocket` package beyond the manager↔link-state
  mapping.
- Full redesign of settings/hub pages beyond the connection-status view-model.
- Re-litigating the login transaction (`LoginFlowController` stays as-is).

## Design notes for future features

When adding a feature, pick one path and never switch on a connection enum:

1. **Cached read** — use Drift/cache repositories scoped by `serverScopeId`; do not
   inject the websocket; render online and offline.
2. **Remote command** — call a command service that acquires the socket via the
   scoped connection and returns a typed unavailable failure when offline; UI gates
   on `commandAvailability`.
3. **Remote sync** — put subscription + initial fetch under a coordinator that writes
   to cache; the live subscription watches `serverScopeConnectionProvider`; UI reads
   cache + sync summary.
4. **UI connection policy** — read `commandAvailability` or a screen-specific
   capability provider; never watch `activeServerSessionProvider` or transport state
   directly.
