# Auth, Logout, And Offline Lifecycle

This document defines when Hommie may clear credentials, remove a server, or
keep the user offline-but-signed-in. The central rule is:

**Automatic logout is destructive and must happen only when Home Assistant
explicitly proves that the token was revoked or invalidated on the server side.**

Manual sign-out and manual server deletion are the other destructive paths.
Offline mode, reconnect failures, local storage issues, and missing local
credentials must not be treated as server-side token revocation.

## Ownership

| Area | Owner | Responsibility |
| --- | --- | --- |
| OAuth login and stored credentials | `AuthRepository`, `LoginFlowController` | Save credentials after login, refresh expired credentials, clear credentials on explicit sign-out. |
| WebSocket connection lifecycle | `ConnectionOrchestrator`, `ServerConnectionManager` | Connect, reconnect, publish link state, stop retrying on confirmed auth failure. |
| Session projection | `ActiveServerSession` | Project active server + auth state + link state into user-facing session state. |
| Destructive cleanup | `ServerLifecycleController` | Disconnect, clear credentials, delete cached home view, remove server. |
| Automatic revocation handling | `AuthRevocationHandler` | Observe `AuthRevokedServerSession` and invoke destructive cleanup once per server. |

## Case Matrix

| Case | App behavior | Clear credentials / remove server? |
| --- | --- | --- |
| Manual sign out | Disconnect, revoke token best-effort, clear credentials, delete cached home view, remove server. | Yes |
| Manual delete server | Run the same destructive lifecycle as sign out. | Yes |
| Home Assistant WebSocket returns `auth_invalid` | Treat as server-side token revocation. Publish auth-failed link/session and run revocation cleanup. | Yes |
| OAuth refresh returns invalid token / invalid grant | Treat as server-side token revocation. | Yes |
| Network unavailable | Mark connection offline, pause reconnect attempts, keep cached server/home data. | No |
| Network returns | Retry active connection. | No |
| Socket closes, Home Assistant restarts, transport error, timeout | Publish offline/reconnecting and retry through the connection manager/orchestrator. | No |
| Token refresh fails because the server is unreachable, offline, or times out | Keep stored credentials for offline access. Do not use an expired access token for WebSocket auth. | No |
| Missing local credentials | Treat as a local unauthenticated/offline condition, not proof of server-side revocation. | No |
| Credential storage failure | Surface auth failure UI/error state without destructive logout. | No |
| Entity subscription sees a closed socket during reconnect | Return empty live states and wait for the next online connection. | No |
| Login succeeds | Save credentials, activate server, connect. | No logout |
| Login is cancelled or fails | Do not save credentials. | No logout |

## Revocation Versus Offline Failure

Only these signals may be mapped to an automatic logout:

- Home Assistant WebSocket authentication response is explicitly invalid
  (`auth_invalid` / auth failure).
- OAuth refresh fails with an invalid-token style authorization error.

These signals must remain non-destructive:

- `AuthFailure.connection()`
- `AuthFailure.server()`
- `AuthFailure.storage()`
- `AuthFailure.missingCredentials()`
- connection open cancellation
- socket closure without an auth-failure type
- command or subscription attempts against a connection that closed during
  reconnect

When a non-destructive failure occurs, the user may see offline UI or an auth
error route depending on the projection, but the app must not revoke tokens,
clear credentials, delete cached home data, or remove the server automatically.

## Offline Token Handling

Expired credentials are allowed to keep the app signed in for cached/offline
reads when token refresh fails due to connectivity or server availability.
However, expired access tokens must not be sent to Home Assistant during a new
WebSocket authentication attempt. Doing so can produce `auth_invalid` and turn a
temporary offline condition into a false logout.

The connection factory should therefore:

1. Resolve credentials through the auth repository.
2. Convert `InvalidToken` into an authentication failure.
3. Convert connection/server/storage/missing-credentials failures into ordinary
   connection failures.
4. Reject expired credentials before WebSocket authentication.

## UI And Feature Rules

- Cached reads should continue to render offline when possible.
- Live-only subscriptions should return empty state while disconnected.
- Feature code should use scoped server providers and projection providers. It
  should not start reconnect timers or call the connection manager directly.
- Widgets must not infer logout from offline state.

## Tests To Keep

Regression coverage should include:

- auth-failed link state triggers `AuthRevokedServerSession`;
- missing local credentials publish offline, not auth failed;
- token-resolution connection failures publish offline, not auth failed;
- expired credentials are rejected before WebSocket authentication;
- entity state subscription returns empty if the connection closes before
  subscription setup;
- manual sign-out still runs destructive lifecycle cleanup.
