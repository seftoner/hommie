# 1. Repo Audit (Concise)

## Current folder map & dependency flow
- `lib/main.dart` bootstraps logging/database before mounting a single `ProviderScope`, then hands off to `HommieApp` for routing and UI. 【F:lib/main.dart†L1-L38】
- `lib/app.dart` wraps routing in a `ServerScopeWidget` and `OfflineContainer`, binding navigation and connection state observers at app scope. 【F:lib/app.dart†L11-L49】
- `lib/services/networking` centralizes connection orchestration, scoped providers, and connection status broadcasting. 【F:lib/services/networking/server_scope_provider.dart†L1-L53】【F:lib/services/networking/server_connection_manager.dart†L1-L240】
- `lib/features` holds feature-specific application/infrastructure code, with authentication orchestrated via task chains and navigation coordination. 【F:lib/features/auth/application/server_auth_controller.dart†L1-L128】【F:lib/features/auth/application/server_auth_navigation_coordinator.dart†L1-L74】
- Persistence and configuration live under `lib/services/database` and `lib/features/servers/infrastructure`, exposing repositories to the rest of the app. 【F:lib/services/database/database_provider.dart†L1-L46】【F:lib/features/servers/infrastructure/server_manager.dart†L1-L63】

## Top 10 risks/smells
1. **P0 – Server scope fallback throws:** The fallback overrides in `ServerScopeWidget` still throw, so any feature that reads scoped dependencies without an active server crashes instead of entering a safe offline/onboarding flow. 【F:lib/features/servers/infrastructure/widgets/server_scope_widget.dart†L43-L68】
2. **P0 – Auth controller fire-and-forget sign out:** `ServerAuthController.initialize` calls `signOut(serverId)` without awaiting it, leading to overlapping task chains and non-deterministic state when tokens are invalid. 【F:lib/features/auth/application/server_auth_controller.dart†L40-L67】
3. **P0 – Navigation coordinator leaks listeners:** `_handleServerSelection` attaches a new `ref.listen` to `serverAuthControllerProvider` on every server switch without cancellation, so multiple listeners fire and race navigation. 【F:lib/features/auth/application/server_auth_navigation_coordinator.dart†L33-L43】
4. **P1 – Async `build` in keepAlive manager:** `ServerConnectionManager.build` is declared `void` yet performs `await`ed work, meaning initialization errors are dropped and provider readiness is nondeterministic. 【F:lib/services/networking/server_connection_manager.dart†L29-L49】
5. **P1 – Application layer coupled to infrastructure tasks:** `ServerAuthController` (application) orchestrates infrastructure task objects directly, blurring layer boundaries and making reuse across platforms harder. 【F:lib/features/auth/application/server_auth_controller.dart†L70-L120】
6. **P1 – Connection banner ignores auth failures:** `OfflineContainer` only surfaces `disconnected` and `reconnecting`, so revoked tokens leave the UI blank instead of prompting re-auth. 【F:lib/ui/screens/widgets/offline_container.dart†L15-L49】【F:lib/services/networking/connection_state_provider.dart†L20-L74】
7. **P1 – Server switch doesn’t rehydrate repositories:** `ActiveServer.setActive` flips DB state but does not invalidate per-server caches, so consumers keep stale data until manual refresh. 【F:lib/features/servers/infrastructure/providers/active_server_provider.dart†L8-L32】
8. **P2 – Database initializer is global singleton:** `DatabaseInitializer` exposes mutable static state accessed via provider overrides, complicating tests and multi-instance scenarios. 【F:lib/services/database/database_provider.dart†L8-L46】
9. **P2 – Scoped connection overrides create nested async gaps:** The override for `serverScopeConnectionProvider` awaits another provider inside override, causing rebuild loops when connections flap; a dedicated server scope container would be safer. 【F:lib/features/servers/infrastructure/widgets/server_scope_widget.dart†L72-L95】
10. **P2 – Connection manager lacks background polling:** `ServerConnectionManager` only tracks websocket state; there is no fallback REST polling/backoff integration for background, leaving offline sync undefined. 【F:lib/services/networking/server_connection_manager.dart†L78-L239】

# 2. Target Folder Structure (code block)
```
lib/
  app/
    boot.dart            # Entry orchestration (logging, db, migrations)
    app_scope.dart       # ProviderScope composition & observers
  core/
    analytics/           # Logging, tracing, crash reporting
    error_handling/      # Error mapper & boundaries
    execution/           # Task runners, background jobs
    utils/               # Shared utilities (logger wrappers, formatters)
  domain/
    auth/                # Entities, value objects, use cases (pure Dart)
    connection/
    servers/
    features/...         # Feature-level entities/use-cases
  application/
    auth/                # Facades, state machines, coordinators
    connection/
    servers/
    features/...         # Feature orchestrators, Riverpod-agnostic services
  infrastructure/
    database/            # Isar schemas, DAOs, migrations
    networking/          # REST/WS clients, DTO mappers
    persistence/         # Token store, cache adapters
    features/...         # Repository impls per feature
  presentation/
    router/              # GoRouter config & guards
    providers/           # Riverpod 3 generated providers (scoped wrappers)
    screens/             # Widgets, view models
    components/
    theme/
  shared/
    widgets/
    localization/
```

# 3. Provider Graph & Scopes (bullet list + short diagram)
- **App-scope providers:**
  - `bootStatusProvider` (init state), `activeServerIdProvider`, `availableServersProvider`, `connectionSupervisorProvider`, `serverSessionCoordinatorProvider`.
  - Long-lived singletons: logging, analytics, background scheduler.
- **Server-scope providers (families keyed by serverId):**
  - `haClientProvider(serverId)`, `tokenStoreProvider(serverId)`, `restClientProvider(serverId)`, `wsClientProvider(serverId)`, `lightsRepositoryProvider(serverId)`.
  - Each depends on `serverScope(serverId)` container to access credentials/config.
- **UI-scope overrides:**
  - `serverScopeContainerProvider` returns `ProviderContainer` seeded with server families, invalidated on switch.

Diagram:
```
[AppScope]
  ├─ activeServerIdProvider
  ├─ connectionSupervisorProvider
  └─ serverScopeContainerProvider ──> [ServerScope(serverId)]
        ├─ haClientProvider(serverId)
        ├─ tokenStoreProvider(serverId)
        └─ featureRepoProvider(serverId)
```

# 4. Initialization Sequence (numbered)
1. **Cold start:** Initialize logging & crash reporting → load persisted settings/database migrations → hydrate `bootStatusProvider`.
2. Resolve last active server (if any); prewarm token cache and schedule credential refresh.
3. Build root `ProviderScope` with observers and pass deterministic overrides for database/logger/background scheduler.
4. Mount `AppShell` which listens to `bootStatusProvider`; render splash/onboarding until boot succeeds.
5. When an active server exists, mount `ServerScopeHost` that creates a nested `ProviderScope` seeded with the selected serverId.
6. Kick off `connectionSupervisorProvider` to start websocket (foreground) or REST polling (background) with retry/backoff.
7. Initialize `authStateMachineProvider(serverId)`; load cached credentials and trigger validation/refresh.
8. On warm start, skip boot, resume from cached `bootStatusProvider` and reuse persisted `serverScopeContainer` unless tokens expired.

# 5. Auth & Revocation State Machine (diagram + events)
```
[Unauthenticated]
   │ loginSuccess
   ▼
[Authenticated]
   │ wsRevoked / rest401
   ▼
[Revoked]
   │ purgeComplete
   ▼
[Unauthenticated]

[Authenticated] --tokenExpiring--> [Refreshing] --refreshOk--> [Authenticated]
                                 └─refreshFail--> [Revoked]

Events:
- `loginSuccess(serverId, tokens)`
- `refreshOk(tokens)` / `refreshFail(error)`
- `wsRevoked(code)` / `rest401()`
- `userSignOut()` / `purgeComplete()`
```

# 6. Offline-First Data Flow (read/write paths)
- **Reads:** UI → `FeatureViewModel` → `FeatureRepository(serverId)` →
  1. Attempt cache (`Isar` via `cacheStoreProvider(serverId)`),
  2. If stale, enqueue remote fetch with connectivity guard,
  3. Stream merged cache updates back to UI.
- **Writes:** UI → `CommandUseCase` → `FeatureRepository(serverId)` →
  1. Persist intent into `outboxQueueProvider(serverId)` with timestamp & retry policy,
  2. Execute immediately if online; otherwise background worker drains queue when connectivity resumes,
  3. Conflict resolution via domain policy (e.g., last-write-wins for lights, manual merge for scenes).
- **Background sync:** `syncSchedulerProvider` polls features with TTL/backoff matrix (e.g., status TTL 5s foreground WS, 60s background REST) and updates caches consistently.

# 7. Server-Scoped DI Examples (code blocks)
```dart
// Active server source of truth
@Riverpod(keepAlive: true)
class ActiveServerId extends _$ActiveServerId {
  @override
  Future<int?> build() async => _serverRepo.loadActiveId();
  Future<void> set(int? serverId) async {
    await _serverRepo.persistActiveId(serverId);
    state = AsyncData(serverId);
  }
}
```
```dart
// Server scope container
@riverpod
ProviderContainer serverScopeContainer(ServerScopeContainerRef ref) {
  final activeId = ref.watch(activeServerIdProvider).value;
  if (activeId == null) return ProviderContainer();
  return ProviderContainer(overrides: [
    serverScopeIdProvider.overrideWithValue(activeId),
    haClientProvider(activeId),
    tokenStoreProvider(activeId),
  ]);
}
```
```dart
// Scoped client families
@Riverpod(dependencies: [tokenStore, serverConfig])
HomeAssistantClient haClient(HaClientRef ref, int serverId) {
  final token = ref.watch(tokenStoreProvider(serverId));
  final config = ref.watch(serverConfigProvider(serverId));
  return HomeAssistantClient(config, token);
}
```
```dart
// UI consumption
@Riverpod(dependencies: [serverScopeContainer])
FeatureRepository activeLightsRepository(Ref ref) {
  final scope = ref.watch(serverScopeContainerProvider);
  return scope.read(lightsRepositoryProvider(ref.watch(activeServerIdProvider).value!));
}
```

# 8. Sample Feature Repository (interface + impl snippets)
```dart
// domain/application/features/lights/lights_repository.dart
abstract class LightsRepository {
  Stream<LightsState> watch();
  Future<void> toggle(LightId id, bool enabled);
}
```
```dart
// infrastructure/features/lights/isar_lights_repository.dart
class IsarLightsRepository implements LightsRepository {
  IsarLightsRepository(this._cache, this._client);
  final LightsCacheDao _cache;
  final LightsRestClient _client;

  @override
  Stream<LightsState> watch() => _cache.watchState();

  @override
  Future<void> toggle(LightId id, bool enabled) async {
    await _cache.queueCommand(id, enabled);
    await _client.toggle(id, enabled);
  }
}
```
```dart
// presentation/providers/lights_providers.dart
@Riverpod(dependencies: [serverScopeContainer])
class LightsViewModel extends _$LightsViewModel {
  @override
  Stream<LightsState> build() {
    final repo = ref.watch(activeLightsRepositoryProvider);
    return repo.watch();
  }

  Future<void> toggle(LightId id, bool enabled) async {
    final repo = ref.read(activeLightsRepositoryProvider);
    await repo.toggle(id, enabled);
  }
}
```

# 9. Routing & Guards (rules + pseudocode)
- **Rules:**
  - Splash until `bootStatusProvider` is `ready`.
  - Onboarding stack when `activeServerId == null`.
  - Authenticated shell when `authState == authenticated`.
  - Forced logout route when `authState == revoked`.
  - Server switch triggers `go('/servers/select')` and waits for `serverScopeContainer` refresh before resuming previous route.
- **Guard pseudocode:**
```dart
GoRoute(
  path: '/home',
  redirect: (context, state) {
    final boot = ref.read(bootStatusProvider);
    if (!boot.ready) return '/splash';
    final serverId = ref.read(activeServerIdProvider).value;
    if (serverId == null) return '/onboarding';
    final auth = ref.read(authStateProvider(serverId));
    if (auth.isRevoked) return '/reauth';
    if (!auth.isAuthenticated) return '/login';
    return null;
  },
);
```

# 10. Observability Hooks
- Wrap `ProviderScope` with `ProviderObserver` logging transitions and tracing spans for key providers (`authState`, `connectionSupervisor`, feature repos).
- Central `LogSink` broadcasting to console, file, and remote telemetry with correlation IDs per server.
- Error boundary widgets to capture uncaught Flutter errors and surface user-friendly banners.
- Instrument REST/WS clients with interceptors that emit structured events (latency, payload size, retry counts) tied to active serverId.

# 11. Testing Matrix
| Layer | Tests | Tools |
| --- | --- | --- |
| Domain | Use case & value object units | `dart test`, pure Dart mocks |
| Application | State machine golden tests (auth, connection, sync) | `state_machine_test`, fake providers |
| Infrastructure | REST/WS integration against fake HA server | `package:http/testing`, custom WS harness |
| Presentation | Widget & navigation tests with scoped providers | `flutter_test`, `golden_toolkit` |
| Offline | Cache/outbox replay simulations | Isar in-memory adapter, time control |
| E2E | `integration_test` with fake server & background task scheduler | Device/emulator farm |

# 12. Migration Plan (Phased)
1. **Phase 1 – Scaffolding & guards:** Introduce `bootStatusProvider`, `activeServerIdProvider`, and `ServerScopeHost`; refactor routing to new guard pipeline while keeping existing repositories. Checklist: unit tests for new providers, smoke test login/logout. Rollback: revert to previous `ServerScopeWidget` + router.
2. **Phase 2 – Server-scoped DI & auth machine:** Implement serverId families (`haClient`, `tokenStore`, repo wrappers) and migrate auth/navigation to new state machine. Checklist: auth unit tests, token revocation simulation, server switch acceptance. Rollback: restore old auth controller providers.
3. **Phase 3 – Offline-first repositories & observability:** Layer cache/outbox abstractions, retrofit key features (lights, areas) to new repositories, add telemetry hooks and background sync scheduler. Checklist: offline mode manual QA, integration tests with fake server, log ingestion verification. Rollback: feature-level toggles to fall back to legacy repositories while keeping new DI in place.
