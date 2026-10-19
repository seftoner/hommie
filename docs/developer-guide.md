# Developer Guide

This comprehensive guide contains detailed workflows, setup instructions, and best practices for new developers joining the Hommie project.

## Project Overview

Hommie is a Flutter (Dart 3.13+) multi‑platform client for Home Assistant focusing on fast, offline‑aware control and a polished UX. Targets iOS, Android, macOS (desktop adaptations in progress); Windows/Linux not primary yet. Communicates mainly via Home Assistant WebSocket API plus REST for setup and discovery.

## Complete Tech Stack & Libraries

- **Flutter SDK** ^3.47.0, Dart >=3.13.0 <4.0 (see the workspace `pubspec.yaml`)
- **State Management**: Riverpod (codegen via `riverpod_generator`), hooks_riverpod, freezed, json_serializable
- **Navigation**: go_router (+ builder)
- **Data Persistence**: Drift (SQLite, primary local cache), plus shared_preferences & secure storage
- **Background & Tasks**: workmanager (Android), platform background APIs (planned iOS BGTaskScheduler)
- **Networking**: http/dio (currently http + planned migration?), web_socket_channel, multicast_dns for discovery
- **Auth & Security**: oauth2, flutter_secure_storage; tokens must never be logged
- **Testing**: flutter_test, mockito, patrol (integration / end‑to‑end), bdd_widget_test (BDD style), integration_test
- **Code Quality**: custom_lint + analysis_options, riverpod_lint, flutter_lints

## Repository Layout (Complete)

```
app/lib/
├── main.dart                 # entrypoint
├── app.dart                  # root widget
├── features/                 # feature‑oriented structure
│   └── [feature]/
│       ├── domain/           # entities, repositories, value objects
│       ├── application/      # controllers, use cases
│       ├── infrastructure/   # data sources, implementations
│       └── presentation/     # screens, widgets
├── core/                     # cross‑cutting primitives
├── application/              # app-level scopes and session lifecycle
├── router/                   # navigation setup (go_router)
├── config/                   # app configuration
└── ui/                       # shared design system components

app/integration_test/         # patrol / integration specs (+ .feature BDD files)
app/test/                    # unit & widget tests (mocks, data samples, utils)
scripts/                     # helper shell scripts (test env setup / teardown)
docker/                      # local HA & ancillary services for integration tests
docs/                        # workflow & testing guides
analysis_options.yaml       # lints (enforced in CI/local)
```

## Complete Build & Run Workflow

Resolve workspace dependencies from the repository root. Run build_runner, analysis, tests and app commands from `app/`.

### Initial Setup
1. Install Flutter (stable) & ensure `flutter doctor` is clean
2. From the repository root, resolve dependencies with `flutter pub get` after pubspec changes.
3. Change to the application package: `cd app`.
4. Codegen & watchers (Riverpod / freezed / json): either
   - **Continuous**: `dart run build_runner watch --delete-conflicting-outputs` (preferred during development)
   - **One‑off before commits**: `dart run build_runner build --delete-conflicting-outputs`
5. Launch app (example): `flutter run -d macos` (or other device id)
6. Hot reload/hot restart as usual. Keep build_runner watcher running to avoid stale generated code

### Troubleshooting
If generated files are missing or stale (compile errors referencing *.g.dart / *.freezed.dart / router files), rerun the codegen step.

## Complete Testing Guide

### Unit & Widget Tests
- **Command**: `flutter test` (run from `app/` after codegen to avoid missing part errors)

### Integration / Patrol Tests

Use the locally installed Patrol CLI with Docker Desktop, Xcode/iPhone Simulator
and `jq`; check the native toolchain with `patrol doctor`. Prepare the persistent
HA/Toxiproxy fixture with `./scripts/setup_test_env.sh` from the repository root,
then run `patrol test --no-uninstall` from `app/`. Patrol reads
`app/.patrol.env` automatically. Optional `./scripts/cleanup_test_env.sh` stops
services while preserving configuration and credentials.

See [end-to-end testing](testing.md) for fixture lifecycle, owned cleanup,
cold-launch verification and troubleshooting. Use Patrol's own device/target/tag
options; the repository does not provide an alternative runner CLI.

### Common Test Failures
- **Missing `app/.patrol.env`**: rerun fixture setup from the repository root.
- **Port conflicts**: check HA 8123, bridge 3000, proxy 18124 and control 18474.
- **Stale generated code**: rerun build_runner from `app/`.

## MCP (Model Context Protocol) Setup & Advanced Usage

### VS Code Setup (GitHub Copilot)
1. Ensure Dart Code extension v3.116+
2. Enable MCP in VS Code settings:
   ```json
   "dart.mcpServer": true
   ```
3. MCP server auto-registers with VS Code MCP API

### Cursor Setup
Add to `.cursor/mcp.json` (project) or `~/.cursor/mcp.json` (global):
```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server", "--force-roots-fallback"]
    }
  }
}
```

### Gemini CLI Setup
Add to `~/.gemini/settings.json` (global) or `.gemini/settings.json` (project):
```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

### Advanced MCP Usage Patterns
- **Runtime Debugging**: "Analyze current runtime errors and suggest fixes"
- **Performance Analysis**: "Check for performance issues in widget tree"
- **Dependency Analysis**: "Analyze dependency graph and suggest optimizations"
- **Code Review**: "Review this code for architecture compliance"
- **Migration Assistance**: "Help migrate this code to new Riverpod patterns"

## Complete Architecture Guide

### Home Assistant API And Connection Rules

When adding Home Assistant features, follow
[`docs/home-assistant-feature-architecture.md`](home-assistant-feature-architecture.md).
For endpoint-level Home Assistant REST, WebSocket, and mobile-app webhook
research, see [`docs/home-assistant-api-research.md`](home-assistant-api-research.md).
For login, logout, token revocation, and offline-mode policy, see
[`docs/auth-session-lifecycle.md`](auth-session-lifecycle.md).
The short version:

- REST-capable one-shot calls use `homeAssistantApiProvider(serverId)` and should
  not require an active WebSocket connection.
- Active-server WebSocket commands and subscriptions use
  `serverScopeConnectionProvider` plus `HomeAssistantApi.fromConnection`.
- Cached reads use Drift/cache repositories scoped by `serverScopeIdProvider` and
  must render without a socket.
- UI code reads projection providers such as `commandAvailabilityProvider` or
  `hubStatusProvider`; ordinary widgets should not switch on raw session, link, or
  socket state.
- Feature code must not call `serverConnectionManagerProvider.getConnection()` or
  implement reconnect timers. Connection ownership stays in the networking/session
  infrastructure.

### Value Objects Implementation
```dart
abstract class ValueObject<T> {
  const ValueObject();
  T get value;
  String? get validate;
  @override
  String toString() => value.toString();
}

class ServerUrl extends ValueObject<String> {
  factory ServerUrl(String input) => ServerUrl._(input, _validate(input));
  const ServerUrl._(this._value, this._error);
  
  final String _value;
  final String? _error;
  
  @override
  String get value => _value;
  
  @override
  String? get validate => _error;
  
  static String? _validate(String input) {
    if (Uri.tryParse(input) != null) return null;
    return 'Invalid URL format';
  }
}
```

### Repository Implementation Pattern
```dart
class ServerRepository implements IServerRepository {
  const ServerRepository(this._httpClient, this._localStorage);
  
  final HttpClient _httpClient;
  final LocalStorage _localStorage;
  
  @override
  Future<List<ServerEntity>> getServers() async {
    try {
      // Try local cache first
      final cached = await _localStorage.getServers();
      if (cached.isNotEmpty) return cached;
      
      // Fallback to network
      final response = await _httpClient.get('/servers');
      final servers = (response.data as List)
          .map((json) => ServerEntity.fromJson(json))
          .toList();
      
      // Cache for offline use
      await _localStorage.saveServers(servers);
      return servers;
    } catch (e) {
      throw ServerFailure.connection(e.toString());
    }
  }
}
```

### Failure Handling Pattern
```dart
@freezed
sealed class ServerFailure with _$ServerFailure implements Exception {
  const factory ServerFailure.network([String? message]) = NetworkFailure;
  const factory ServerFailure.timeout() = TimeoutFailure;
  const factory ServerFailure.unauthorized() = UnauthorizedFailure;
  const factory ServerFailure.notFound([String? message]) = NotFoundFailure;
  const factory ServerFailure.unknown([String? message]) = UnknownFailure;
}
```

## Routing & Navigation

### Route Configuration
- **Central config** in `router/`
- When adding a new screen: 
  1. Create the feature (if new)
  2. Add route entry + typed params
  3. Regenerate code if using builders
  4. Write a simple navigation test if critical

### Navigation Patterns
```dart
// Route definition
@TypedGoRoute<ServerDetailsRoute>(
  path: '/server/:id',
)
class ServerDetailsRoute extends GoRouteData {
  const ServerDetailsRoute({required this.id});
  final String id;
  
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ServerDetailsPage(serverId: id);
  }
}

// Navigation usage
void navigateToServer(String id) {
  ServerDetailsRoute(id: id).go(context);
}
```

## Data & Offline Strategy

### Caching Strategy
- **Persist critical HA state locally** (Drift / SQLite)
- **Reads should prefer local cache** then refresh in background (optimistic UI)
- **If offline**, surface cached data + an offline banner
- See existing offline banner test for implementation pattern

### Drift Database Patterns
Tables are declared in `app/lib/core/database/tables.dart` and registered on
`AppDatabase` (`@DriftDatabase`) in `app/lib/core/database/database.dart`. Foreign
keys are enabled (`PRAGMA foreign_keys = ON`) and relationships use cascade deletes.

```dart
class ServerEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get url => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  TextColumn get version => text().nullable()();
}
```

Map between Drift rows/companions and domain entities inside the feature's
`infrastructure/` repository (e.g. `DriftServerRepository`); never expose Drift
types from `domain/` or `application/`.

## Security & Secrets Management

### Security Rules
- **Never log tokens or PII**
- **Use `flutter_secure_storage`** for HA tokens
- **Redact secret fields** in diagnostics
- **Treat `.patrol.env`** only for local testing (not committed)

### Token Management Pattern
```dart
class TokenRepository {
  static const _tokenKey = 'ha_access_token';
  static const _refreshTokenKey = 'ha_refresh_token';
  
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _tokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }
  
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }
  
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
```

## Complete Feature Development Workflow

### 1. Feature Folder Creation
Use VS Code task: "Create Feature Folder" to generate:
```
features/new_feature/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── failures/
├── application/
├── infrastructure/
│   ├── repositories/
│   ├── datasources/
│   └── providers/
└── presentation/
    ├── screens/
    └── widgets/
```

### 2. Domain Layer Implementation
- Define entities using `@freezed` + `@JsonSerializable`
- Create value objects for validation
- Define repository interfaces
- Create failure types

### 3. Infrastructure Layer Implementation
- Implement repository interfaces
- Create data sources (local/remote)
- Add mappers between DTOs and entities
- Create `providers.dart` facade

### 4. Application Layer Implementation
- Create operation-specific controllers
- Use `AsyncValue<T>` for state management
- Handle exceptions with try/catch
- Declare dependencies explicitly

### 5. Presentation Layer Implementation
- Use sealed `AsyncValue` pattern matching
- Implement form validation with value objects
- Use `.select()` for granular state watching
- Handle loading/error/empty states

### 6. Testing Implementation
- Unit tests for controllers
- Widget tests for UI components
- Integration tests for cross-feature behavior

### 7. Final Steps
- Run build_runner, analyze, test
- Ensure no debug prints
- Use Conventional Commit messages

## Commit & Branch Conventions

### Branch Naming
- `feature/<ticket>-short-desc`
- `fix/<ticket>-short-desc`
- `refactor/<description>`
- `docs/<description>`

### Commit Messages (Conventional Commits)
```
feat(auth): add biometric unlock support
fix(servers): resolve connection timeout issue
refactor(providers): migrate to new Riverpod patterns
docs(api): update authentication flow documentation
test(integration): add server discovery tests
```

## Adding Dependencies

### Guidelines
- **Prefer lightweight, maintained packages**
- **Justify large or binary heavy deps** in PR description
- **Run `flutter pub get`** after pubspec changes
- **Re‑run build_runner** if codegen impacted

### Dependency Evaluation Checklist
- [ ] Package is actively maintained
- [ ] Good documentation and examples
- [ ] Compatible with current Flutter/Dart versions
- [ ] Reasonable size and dependencies
- [ ] Strong community support or official backing

## Common Pitfalls & Remedies

### Build Issues
- **Build fails with missing part file**: run `dart run build_runner build --delete-conflicting-outputs`
- **Stale generated code**: restart build_runner watcher

### Testing Issues
- **Patrol tests hang**: verify Docker containers healthy (`docker compose ps` in `docker/`)
- **Missing test environment**: run `./scripts/setup_test_env.sh`

### Performance Issues
- **Slow rebuilds**: ensure selective watching, close extra IDE windows, keep provider scopes tight
- **Rebuild storm in UI**: add `.select` to narrow watched fields or split provider state

### Provider Issues
- **Circular dependencies**: review provider dependency graph
- **Memory leaks**: ensure proper disposal and use autoDispose where appropriate

## Pre-PR Validation Workflow

Run sequentially (stop on first failure):
1. From the repository root: `flutter pub get`.
2. From `app/`: `dart run build_runner build --delete-conflicting-outputs`.
3. From `app/`: `flutter analyze`.
4. From `app/`: `flutter test`.
5. Optional E2E: prepare the fixture from the root, then use installed Patrol from `app/` (see [testing](testing.md)).

### Validation Checklist
- [ ] No analyzer warnings introduced
- [ ] All tests passing
- [ ] Generated files committed
- [ ] No secrets or debug prints
- [ ] Follows architecture patterns
- [ ] Documentation updated if needed

## Complete Command Reference

### Development Commands
```bash
# Dependencies (repository root)
flutter pub get

# Application commands
cd app

# Code Generation
dart run build_runner watch --delete-conflicting-outputs  # Continuous
dart run build_runner build --delete-conflicting-outputs  # One-off

# Analysis & Testing
flutter analyze
flutter test
flutter test --coverage

# App Running
flutter run -d macos
flutter devices              # list IDs for other simulators/devices
# Pass the selected device ID to flutter run -d

# Integration Testing (currently in app/)
../scripts/setup_test_env.sh
patrol test --no-uninstall
../scripts/cleanup_test_env.sh

# MCP Server (debugging)
dart mcp-server
```

### Docker Commands (Integration Testing)

From the repository root:

```bash
# Prepare the persistent fixture and Patrol environment
./scripts/setup_test_env.sh

# Inspect the existing project
docker compose -f docker/docker-compose.yml -p homeassistant-test ps

# Stop services while retaining configuration and credentials
./scripts/cleanup_test_env.sh
```

The HA named volume is persistent test data. Routine cleanup stops services;
volume deletion is an explicit destructive maintenance action, not normal test
teardown. See [testing](testing.md).

## When to Search vs Trust Instructions

### Default: Trust the Architecture Guide
Follow the patterns and examples in `.github/copilot-instructions.md` for:
- Standard CRUD operations
- Common UI patterns
- Provider setup
- State management

### When to Search Broader Codebase
Only perform searches when:
- Adding a feature whose pattern is not described
- Modifying an area with no existing analogous provider/widget
- Encountering a build/test error not covered in Common Pitfalls
- Working with complex integrations (WebSocket, Auth flows)

## Best Practices Summary

### Do
- Co‑locate feature code in domain/application/infrastructure/presentation structure
- Use generated Riverpod providers with `@riverpod` annotation
- Handle all AsyncValue states (loading/error/data/empty)
- Keep state small & immutable using freezed data classes
- Write tests early and often
- Use value objects for form validation
- Follow sealed pattern matching for AsyncValue

### Avoid
- Printing secrets or PII to logs
- Adding global singletons that bypass providers
- Bypassing providers for direct static access
- Large PRs without adequate test coverage
- Committing without running codegen
- Using mutable state objects
- Ignoring loading and error states in UI

## Troubleshooting Guide

### Common Error Messages
1. **"Could not find a part file"** → Run build_runner
2. **"Provider not found"** → Check provider dependencies and imports
3. **"Patrol test timeout"** → Verify Docker containers and .patrol.env
4. **"Widget overflow"** → Use MCP: "Fix layout overflow errors"
5. **"State is null"** → Handle AsyncValue loading state properly

### Performance Debugging
1. Use Flutter Inspector for widget tree analysis
2. Use `.select()` to minimize rebuilds
3. Profile with `flutter run --profile`
4. Use MCP: "Analyze widget tree for performance issues"

### Integration Test Debugging
1. From the root, inspect service logs with `docker compose -f docker/docker-compose.yml -p homeassistant-test logs`; keep credential-bearing diagnostics private.
2. Verify `app/.patrol.env` exists and contains valid credentials without printing them
3. Ensure Home Assistant is accessible on localhost:8123
4. Use MCP: "Debug integration test failures"

## Resources & Documentation

### Official Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Go Router Documentation](https://pub.dev/packages/go_router)
- [Drift Documentation](https://drift.simonbinder.eu/)

### Project-Specific Docs
- `docs/development_workflow.md` - Git workflow and PR process
- `docs/testing.md` - Detailed testing strategies
- `docs/multiple_server_support.md` - Multi-server architecture
- `docs/ha_connection_improvements.md` - WebSocket connection patterns

### MCP Resources
- [Dart MCP Server Documentation](https://dart.dev/tools/mcp-server)
- [Model Context Protocol Specification](https://modelcontextprotocol.io/)

Remember: This guide is comprehensive but the AI assistant should primarily follow the concise patterns in `.github/copilot-instructions.md` for day-to-day development tasks.
