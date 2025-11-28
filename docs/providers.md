# Hommie Riverpod Providers Documentation

Complete reference for all Riverpod providers in the Hommie application.

---

## Core Application Providers

### `goRouterProvider`
- **Type:** Provider<GoRouter>
- **Purpose:** Provides the main GoRouter instance for app navigation with guard-based routing.
- **Dependencies:** `BootStatusController`, `ActiveServer`, `activeAuthState`
- **Lifecycle:** `keepAlive: true`

### `bootStatusControllerProvider`
- **Type:** AsyncNotifierProvider<BootStatusController, BootStatus>
- **Purpose:** Manages application boot sequence, ensuring server state is hydrated before app navigation.
- **Dependencies:** `ActiveServer`
- **Lifecycle:** `keepAlive: true`
- **States:** `BootReady`, `BootInProgress`, `BootFailure`

### `databaseConnectionProvider`
- **Type:** Provider<Isar>
- **Purpose:** Provides Isar database instance for local persistence.
- **Dependencies:** None
- **Lifecycle:** `keepAlive: true`
- **Notes:** Must be initialized via `DatabaseInitializer.initialize()` before use.

### `parallelismExecutorProvider`
- **Type:** Provider<IParallelExecutor>
- **Purpose:** Provides parallel task execution using the Computer library for background processing.
- **Dependencies:** None
- **Lifecycle:** `keepAlive: true`

---

## Server Management Providers

### `activeServerProvider`
- **Type:** AsyncNotifierProvider<ActiveServer, Server?>
- **Purpose:** Tracks and manages the currently selected Home Assistant server.
- **API:**
  - `build()`: Loads active server from database.
  - `setActive(int serverId)`: Switches active server and updates state.
- **Dependencies:** `serverManagerProvider`
- **Lifecycle:** `keepAlive: true`

### `serverManagerProvider`
- **Type:** Provider<IServerManager>
- **Purpose:** Provides server management operations (CRUD, activation).
- **Dependencies:** `serverRepositoryProvider`
- **Lifecycle:** `keepAlive: true`

### `serverRepositoryProvider`
- **Type:** Provider<IServerRepository>
- **Purpose:** Data access layer for server persistence in Isar.
- **Dependencies:** `databaseConnection`
- **Lifecycle:** Auto-dispose

### `serversListProvider`
- **Type:** FutureProvider<List<Server>>
- **Purpose:** Provides list of all configured servers.
- **Dependencies:** `serverManager`
- **Lifecycle:** Auto-dispose

### `websocketConfigRepositoryProvider`
- **Type:** Provider<IWebsocketConfigRepository>
- **Purpose:** Repository for WebSocket configuration persistence.
- **Dependencies:** `databaseConnection`
- **Lifecycle:** Auto-dispose

---

## Authentication Providers

### `activeAuthStateProvider`
- **Type:** Provider<AsyncValue<AuthState>>
- **Purpose:** Provides authentication state for the currently active server.
- **Dependencies:** `ActiveServer`, `AuthStateMachine`
- **Lifecycle:** `keepAlive: true`
- **Returns:** `AuthState` (initial, authenticated, unauthenticated, authenticating, refreshing, revoked, failure)

### `authStateMachineProvider`
- **Type:** AsyncNotifierProvider (family, serverId)
- **Purpose:** Manages authentication state machine for a specific server.
- **Dependencies:** Server-specific
- **States:** Tracks OAuth flow, token refresh, and auth failures

### `authControllerProvider`
- **Type:** Provider<AuthFlowController>
- **Purpose:** Orchestrates authentication flows (login, logout, discovery).
- **API:**
  - `login(String serverUrl)`: Initiates OAuth login flow.
  - `logout()`: Signs out from active server.
  - `deleteServer(int serverId)`: Removes server configuration.
- **Dependencies:** `websocketConfigRepository`, `ActiveServer`, `AuthStateMachine`, `ServerConnectionState`, `goRouter`, `ServerConnectionManager`
- **Lifecycle:** Scoped

### `serverSessionCoordinatorProvider`
- **Type:** Provider<void>
- **Purpose:** Keeps the active server session healthy by (1) eagerly creating a WebSocket connection whenever a server becomes authenticated and (2) watching for auth revocations from either the credential refresh flow or the socket transport. If a revocation occurs it triggers `authFlowController.signOut` to wipe that server.
- **Dependencies:** `authState`, `ServerConnectionManager`, `ServerConnectionState`, `activeServer`, `authFlowController`
- **Lifecycle:** `keepAlive: true`

### `serversDiscoveryControllerProvider`
- **Type:** AsyncNotifierProvider<ServersDiscoveryController, List<HaServer>>
- **Purpose:** Discovers Home Assistant servers on local network via mDNS.
- **Dependencies:** `haServersRepository`
- **Lifecycle:** Auto-dispose with periodic refresh (10s interval)

### `authRepositoryProvider`
- **Type:** Provider<IAuthRepository>
- **Purpose:** Authentication data access (OAuth flows, token management).
- **Dependencies:** None
- **Lifecycle:** Auto-dispose

### `credentialsRepositoryProvider`
- **Type:** Provider<ICredentialRepository>
- **Purpose:** Secure credential storage using FlutterSecureStorage.
- **Dependencies:** None
- **Lifecycle:** Auto-dispose

### `haServersRepositoryProvider`
- **Type:** Provider<IHAServersRepository>
- **Purpose:** Home Assistant server discovery repository.
- **Dependencies:** None
- **Lifecycle:** Auto-dispose

---

## Network & Connection Providers

### `serverConnectionManagerProvider`
- **Type:** NotifierProvider<ServerConnectionManager, void>
- **Purpose:** Manages WebSocket connections to Home Assistant servers, connection pooling, and lifecycle.
- **API:**
  - `getConnection(int serverId)`: Returns HAConnection for specific server.
  - `invalidateConnection(int serverId)`: Closes and recreates connection.
- **Dependencies:** `ActiveServer`, `ServerConnectionState`, `serverConfig`, `serverAuthToken`
- **Lifecycle:** `keepAlive: true`

### `serverConnectionProvider`
- **Type:** FutureProvider<HAConnection> (family, serverId)
- **Purpose:** Provides WebSocket connection for a specific server.
- **Dependencies:** `ServerConnectionManager`
- **Lifecycle:** `keepAlive: true`

### `connectionStateProvider`
- **Type:** NotifierProvider<ConnectionState, HAServerConnectionState>
- **Purpose:** Tracks global network connection state.
- **States:** `unknown`, `connected`, `disconnected`, `connecting`, `reconnecting`, `authFailure`
- **Dependencies:** None
- **Lifecycle:** `keepAlive: true`

### `serverConnectionStateProvider`
- **Type:** NotifierProvider<ServerConnectionState, HAServerConnectionState>
- **Purpose:** Alias/wrapper for connection state management.
- **Dependencies:** `connectionState`
- **Lifecycle:** Scoped

### `httpClientProvider`
- **Type:** Provider<http.BaseClient>
- **Purpose:** Provides HTTP client for REST API calls.
- **Dependencies:** None
- **Lifecycle:** Auto-dispose

### `serverConfigProvider`
- **Type:** FutureProvider<ServerConfig> (family, serverId)
- **Purpose:** Provides server configuration (URL, name, etc.) for a specific server.
- **Dependencies:** `serverManager`
- **Lifecycle:** Auto-dispose

### `serverAuthTokenProvider`
- **Type:** FutureProvider<Credentials?> (family, serverId)
- **Purpose:** Provides OAuth credentials for a specific server.
- **Dependencies:** `credentialsRepository`
- **Lifecycle:** Auto-dispose

---

## Server-Scoped Providers

### `serverScopeConnectionProvider`
- **Type:** FutureProvider<HAConnection>
- **Purpose:** Scoped provider for current server connection. Must be overridden in ProviderScope.
- **Dependencies:** None (must be overridden)
- **Usage:** All server-dependent providers should depend on this instead of direct server access.

### `serverScopeIdProvider`
- **Type:** Provider<int>
- **Purpose:** Scoped provider for current server ID. Must be overridden in ProviderScope.
- **Dependencies:** None (must be overridden)

### `serverScopeServerProvider`
- **Type:** Provider<Server>
- **Purpose:** Scoped provider for current server object. Must be overridden in ProviderScope.
- **Dependencies:** None (must be overridden)

---

## Feature Providers

### `areasControllerProvider`
- **Type:** AsyncNotifierProvider<AreasController, List<AreaEntity>>
- **Purpose:** Manages Home Assistant area entities for the active server.
- **Dependencies:** `serverScopeConnection`
- **Lifecycle:** Auto-dispose, server-specific

### `homeDataControllerProvider`
- **Type:** AsyncNotifierProvider<HomeDataController, Map<String, dynamic>>
- **Purpose:** Provides home dashboard data for the active server.
- **Dependencies:** `serverScopeConnection`, `serverScopeId`
- **Lifecycle:** Auto-dispose, server-specific

### `homePageControllerProvider`
- **Type:** AsyncNotifierProvider<HomePageController, HomePageState>
- **Purpose:** Manages home page UI state and interactions.
- **Dependencies:** Server-specific
- **Lifecycle:** Auto-dispose

### `logsListControllerProvider`
- **Type:** AsyncNotifierProvider<LogsListController, LogsListState>
- **Purpose:** Manages paginated logs list in settings.
- **API:**
  - `build()`: Loads initial page of logs.
  - `loadMoreLogs()`: Loads next page.
- **Dependencies:** `logsRepository`
- **Lifecycle:** Auto-dispose

### `logsControlerProvider`
- **Type:** AsyncNotifierProvider<LogsControler, void>
- **Purpose:** Handles log management actions (clear, export).
- **Dependencies:** None
- **Lifecycle:** Auto-dispose

### `sensorsListProvider`
- **Type:** FutureProvider<List<Sensor>>
- **Purpose:** Provides list of device sensors (battery, connection state).
- **Dependencies:** None
- **Lifecycle:** Auto-dispose

---

## Repository Providers

### `logsRepositoryProvider`
- **Type:** FutureProvider<ILogsRepository>
- **Purpose:** Data access for application logs.
- **Dependencies:** None
- **Lifecycle:** Auto-dispose

### `serverSettingsProvider`
- **Type:** Provider<IServerSettingsRepository>
- **Purpose:** Repository for server-specific settings persistence.
- **Dependencies:** `databaseConnection`
- **Lifecycle:** Auto-dispose

---

## Flow & Orchestration Providers

### `flowRunnerProvider`
- **Type:** AsyncNotifierProvider<FlowRunnerNotifier, FlowState>
- **Purpose:** Manages multi-step flows (onboarding, configuration wizards).
- **API:**
  - `start(FlowDefinition)`: Begins a flow.
  - `next()`: Advances to next step.
  - `back()`: Returns to previous step.
  - `cancel()`: Cancels flow.
- **Dependencies:** `ActiveServer`, `toastService`
- **Lifecycle:** `keepAlive: true`

### `toastServiceProvider`
- **Type:** Provider<ToastService>
- **Purpose:** Provides toast notification service for user feedback.
- **Dependencies:** None
- **Lifecycle:** Scoped

---

## Dependency Patterns

### Explicit Dependencies
Use `@Riverpod(dependencies: [...])` to declare provider dependencies:
```dart
@Riverpod(dependencies: [serverScopeConnection])
class MyController extends _$MyController { ... }
```

### Transitive Dependencies
Riverpod automatically tracks transitive dependencies via `allTransitiveDependencies`.

### Keep-Alive Providers
Providers marked `keepAlive: true` persist across widget rebuilds and navigation:
- Core infrastructure (router, database, connections)
- Global state (active server, boot status)
- Connection managers

### Auto-Dispose Providers
Most feature and UI providers auto-dispose when no longer watched:
- Controllers
- Repositories
- UI state

### Scoped Providers
Server-scoped providers (`serverScope*`) enable automatic refresh on server switch.
Must be overridden in a `ProviderScope` when active server changes.

---

## Provider Lifecycle Events

- `ref.onDispose()`: Cleanup when provider is disposed
- `ref.onCancel()`: When last listener is removed (auto-dispose only)
- `ref.onResume()`: When listener is re-added after cancel
- `ref.listen()`: React to provider changes
- `ref.invalidate()`: Force provider rebuild

---

## Best Practices

1. **Read vs Watch**: Use `ref.read()` in event handlers, `ref.watch()` in build methods.
2. **Family Parameters**: Use family providers for parameterized data (e.g., `serverId`).
3. **Error Handling**: Always handle `AsyncError` states in UI.
4. **Scoping**: Use scoped providers for server-specific data to enable automatic refresh.
5. **Testing**: Override providers in tests using `ProviderScope.overrides`.
