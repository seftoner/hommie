# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Hommie is a Flutter multi-platform client for Home Assistant (iOS, Android, macOS primary; Windows/Linux untested). It talks to Home Assistant mainly over the WebSocket API, with REST used for setup and mDNS discovery.

This repo is a **Dart pub workspace** (monorepo). The root `pubspec.yaml` declares the workspace members:
- `app/` — the Flutter application (package name `hommie`). Almost all work happens here.
- `packages/home_assistant_websocket` — HA WebSocket client (`IHAConnection`, messages, transport).
- `packages/computer` — isolate-based parallel task executor (used via `IParallelExecutor`).
- `packages/drag_arrange` — drag-to-reorder UI widget.

> ⚠️ **Docs can lag the code.** The app uses **Drift** (`app/lib/core/database/`) for local persistence — note it migrated from Isar, so ignore any lingering Isar references you find. Some docs also list older SDK versions. Trust the code and `pubspec.yaml` over the prose docs when they conflict.

## Commands

Run codegen-dependent commands from the repo root (`flutter pub get` resolves the whole workspace); run `flutter test` / `flutter run` from `app/`.

```bash
flutter pub get                                              # after any pubspec change (root)
dart run build_runner watch --delete-conflicting-outputs    # keep running during dev (from app/)
dart run build_runner build --delete-conflicting-outputs    # one-off codegen before commits
flutter analyze                                              # lints (flutter_lints + custom_lint + riverpod_lint)
flutter test                                                 # unit + widget tests (run codegen first)
flutter test test/value_objects/server_url_test.dart        # single test file
flutter run -d macos                                         # launch (swap device id)
```

Codegen drives `*.g.dart` / `*.freezed.dart` (Riverpod, freezed, json_serializable, drift, go_router_builder). Compile errors referencing those files almost always mean stale codegen — rerun build_runner.

### Integration tests (Patrol + Docker)

Requires Docker and a local HA instance on ports 8123 / 3000.

```bash
dart pub global activate patrol_cli && patrol doctor        # one-time
./scripts/setup_test_env.sh                                 # spins up HA, writes .patrol.env with token
patrol test                                                 # run integration specs (from app/)
./scripts/cleanup_test_env.sh                               # tear down
```

BDD specs live in `app/integration_test/` as `.feature` files with step implementations under `integration_test/step/` (bdd_widget_test + patrol). See `docs/testing.md`.

## Architecture

### Clean / DDD layering (enforced per feature)

Each feature under `app/lib/features/<feature>/` has four layers with **inward-only** dependencies:

```
presentation/ → application/ → domain/ ← infrastructure/
```

- `domain/` — entities (`@freezed`), value objects (validation wrappers like `ServerUrl`, `HaVersion`), and `I`-prefixed repository interfaces. Depends on **nothing** Flutter/Riverpod/platform.
- `application/` — controllers (one per operation), state as `AsyncValue<T>`. May depend on `domain` only.
- `infrastructure/` — implements domain repository interfaces, converts platform exceptions to domain failures, exposes a `providers.dart` facade.
- `presentation/` — screens/widgets. Consumes `application` + `domain` via Riverpod; pattern-matches sealed `AsyncValue` with `switch`.

Do not import `presentation` into `domain`/`application`, and keep `BuildContext`/widgets out of those layers. `app/lib/core/` holds cross-cutting primitives (database, networking, logging, parallelism, bootstrap) following the same layering.

### State management — Riverpod with codegen

Providers are generated via `@riverpod` / `@Riverpod(dependencies: [...])` and co-located with their feature. Declare dependencies explicitly so the scope-override machinery works. `app/lib/main.dart` boots the app inside a single `ProviderScope`; `bootstrap()` runs before `runApp`.

### Server-scoped providers (key pattern)

The app supports multiple HA servers, one active at a time. Server-specific data must **not** read the active server directly — instead it depends on scoped providers that are overridden per active server:

- `serverScopeId`, `serverScopeServer`, `serverScopeConnection` are placeholder providers meant to be **overridden** in a nested `ProviderScope`.
- `app/lib/application/scopes/server_scope_host.dart` (`ServerScopeHost`) hosts that nested scope: it watches `activeServerProvider`, obtains an `IHAConnection` from `serverConnectionManagerProvider`, and injects the overrides. When no server is active it keeps the tree mounted with an unavailable connection rather than crashing consumers.
- Feature controllers (e.g. `areasControllerProvider`, `homeDataControllerProvider`) depend on `serverScopeConnection` so they automatically rebuild when the active server switches.

When adding server-dependent data, depend on the `serverScope*` providers — never on `activeServer` directly.

### Connection & session lifecycle

- `serverConnectionManagerProvider` owns WebSocket connections per server (`getConnection`, `invalidateConnection`).
- `serverSessionCoordinatorProvider` (watched in `app.dart`) keeps the active session healthy: eagerly connects on auth, and on auth revocation (from credential refresh or socket transport) triggers sign-out to wipe that server.
- Auth is an OAuth state machine (`authStateMachineProvider`, `activeAuthStateProvider`) with tokens stored in `flutter_secure_storage`. **Never log tokens or PII.**
- `goRouterProvider` (`app/lib/router/`) is guard-based, gated on `BootStatusController` (boot sequence) + active server + auth state.

### Persistence — Drift

`app/lib/core/database/database.dart` defines `AppDatabase` (`@DriftDatabase`) with tables in `tables.dart` (servers, areas, devices, home-view configs, and their join/config tables). Cascade deletes and `PRAGMA foreign_keys = ON` are enabled. Accessed via `databaseConnectionProvider` in `core/infrastructure/database/`. Repositories (e.g. `DriftServerRepository`) live in each feature's `infrastructure/`.

## Conventions

- **Commits:** Conventional Commits — `<type>(<scope>): <description>`, imperative present tense, no trailing period, lowercase description. Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.
- **Branches:** off `main`; `feature/ABC-123-desc`, `fix/ABC-123-desc`, `hotfix/ABC-123-desc`. `main` is protected — PRs only.
- **Tests required:** new features must have test coverage (`docs/development_workflow.md`).
- Entities are immutable `@freezed` classes, JSON-mapped with `@JsonSerializable(fieldRename: FieldRename.snake)`.
