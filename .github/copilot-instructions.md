## Project Overview

Hommie is a Flutter (Dart 3.6+) multi‑platform client for Home Assistant focusing on fast, offline‑aware control and a polished UX. Targets iOS, Android, macOS (desktop adaptations in progress); Windows/Linux not primary yet. Communicates mainly via Home Assistant WebSocket API plus REST for setup and discovery.

## Tech & Key Libraries
- Flutter SDK ~3.27 (stable), Dart >=3.6 <4.0
- State: Riverpod (providers + codegen via `riverpod_generator`), hooks_riverpod, freezed, json_serializable
- Navigation: go_router (+ builder)
- Data persistence: Isar (primary local cache), plus shared_preferences & secure storage
- Background & tasks: workmanager (Android), platform background APIs (planned iOS BGTaskScheduler)
- Networking: http/dio (currently http + planned migration?), web_socket_channel, multicast_dns for discovery
- Auth & security: oauth2, flutter_secure_storage; tokens must never be logged
- Testing: flutter_test, mockito, patrol (integration / end‑to‑end), bdd_widget_test (BDD style), integration_test
- Code quality: custom_lint + analysis_options, riverpod_lint, flutter_lints

## Repository Layout (selected)
- `lib/` core app code
  - `main.dart` entrypoint; `app.dart` root widget
  - `features/` feature‑oriented structure (add new feature via VS Code task: Create Feature Folder -> domain/application/infrastructure/presentation)
  - `core/` cross‑cutting primitives (utils, constants, foundational widgets) (confirm before adding new cross‑cutting code)
  - `providers/` higher‑level or global providers (consider co‑locating with a feature when feasible)
  - `router/` navigation setup (go_router)
  - `services/` external service facades (auth, discovery, HA API, logging)
  - `ui/` shared design system components (theming, reusable widgets)
- `integration_test/` patrol / integration specs (+ `.feature` BDD files)
- `test/` unit & widget tests (mocks, data samples, utils)
- `scripts/` helper shell scripts (test env setup / teardown)
- `docker/` local HA & ancillary services for integration tests (creates `.patrol.env`)
- `docs/` workflow & testing guides
- `analysis_options.yaml` lints (enforced in CI/local)

## Build & Run (General)
Always run these from repo root unless stated.
1. Install Flutter (stable) & ensure `flutter doctor` is clean.
2. Dependencies: `flutter pub get` (ALWAYS after pubspec changes).
3. Codegen & watchers (Riverpod / freezed / json): either
   - Continuous: `dart run build_runner watch --delete-conflicting-outputs` (preferred during development), or
   - One‑off before commits: `dart run build_runner build --delete-conflicting-outputs`
4. Launch app (example): `flutter run -d macos` (or other device id).
5. Hot reload/hot restart as usual. Keep build_runner watcher running to avoid stale generated code.

If generated files are missing or stale (compile errors referencing *.g.dart / *.freezed.dart / router files), rerun step 3.

## Testing
Unit & Widget Tests:
- Command: `flutter test` (ensure codegen step 3 completed first to avoid missing part errors).

Integration / Patrol Tests (requires Docker + local HA):
1. Ensure Docker daemon running.
2. `chmod +x scripts/setup_test_env.sh scripts/cleanup_test_env.sh` (first time)
3. `./scripts/setup_test_env.sh` (creates containers & `.patrol.env` with HASS_TOKEN) – wait for success message.
4. Run: `patrol test` (CLI must be installed: `dart pub global activate patrol_cli`; run `patrol doctor` once).
5. Cleanup (optional): `./scripts/cleanup_test_env.sh`.

Common failures:
- Missing `.patrol.env`: re‑run setup script.
- Port conflicts (8123 / 3000): stop other processes.
- Stale generated code: re‑run build_runner.

## Linting & Quality
- Automatic IDE lints come from `analysis_options.yaml` and `riverpod_lint`/`custom_lint` plugin.
- Manual check: `flutter analyze`.
- Style highlights: prefer single quotes, const constructors, no `print` (use `logger`), avoid unused params, small immutable state objects.

## State Management & Patterns (Concise Rules)
- Use Riverpod providers for all external services & app state. Prefer `@riverpod` codegen.
- Derive read‑only values with plain `Provider`; mutable domain logic in `Notifier` / `AsyncNotifier`.
- UI subscribes via `ref.watch` with `.select(...)` to minimize rebuilds. Keep provider scopes granular.
- Represent async UI state with `AsyncValue<T>`; handle loading/error/empty states explicitly.
- Co‑locate provider + model + notifier inside the feature folder. Global providers only for cross‑cutting concerns (e.g., auth token, router).
- Avoid exposing mutable collections directly; return immutable snapshots (freezed data classes) and perform mutations inside notifiers.

## Routing
- go_router central config in `router/`. When adding a new screen: create the feature (if new), add route entry + typed params, regenerate code if using builders, write a simple navigation test if critical.

## Data & Offline Strategy
- Persist critical HA state locally (Isar). Reads should prefer local cache then refresh in background (optimistic UI). If offline, surface cached data + an offline banner (see existing offline banner test for pattern).

## Security & Secrets
- Never log tokens or PII. Use `flutter_secure_storage` for HA tokens. Redact secret fields in diagnostics. Treat `.patrol.env` only for local testing (not committed).

## Feature Development Checklist (Generalized)
1. Create / update feature folder via task (domain, application, infrastructure, presentation).
2. Define models (freezed) + providers (annotated) + generated code (run build_runner).
3. Implement UI with loading/error/empty states.
4. Add unit tests for notifiers & widget test for main UI path; add/update integration test if cross‑feature behavior.
5. Run: build_runner (clean), flutter analyze, flutter test, (optional) patrol test.
6. Ensure no debug prints; commit using Conventional Commit message.

## Commit & Branch Conventions
- Branch: `feature/<ticket>-short-desc` or `fix/…`, etc. (See `docs/development_workflow.md`).
- Commits follow Conventional Commits (e.g., `feat(auth): add biometric unlock`).

## Adding Dependencies
- Prefer lightweight, maintained packages. Justify large or binary heavy deps in PR description. Run `flutter pub get` then re‑run build_runner if codegen impacted.

## Common Pitfalls & Remedies
- Build fails with missing part file: run build_runner (step 3).
- Patrol tests hang: verify Docker containers healthy (`docker compose ps` in `docker/`).
- Slow rebuilds: ensure selective watching (close extra IDE windows) & keep provider scopes tight.
- Rebuild storm in UI: add `.select` to narrow watched fields or split provider state.

## Validation Before PR
Run sequentially (stop on first failure):
1. `flutter pub get`
2. `dart run build_runner build --delete-conflicting-outputs`
3. `flutter analyze`
4. `flutter test`
5. (Optional integration) Setup env + `patrol test`

Ensure: no analyzer warnings you introduced, tests green, generated files committed, no secrets.

## When to Search vs Trust Instructions
Default: trust these instructions. Only perform broad searches if:
- Adding a feature whose pattern is not described above
- Modifying an area with no existing analogous provider/widget
- Encountering a build/test error not covered under Common Pitfalls

## Do / Avoid Summary
Do: co‑locate feature code; use generated Riverpod providers; handle all AsyncValue states; keep state small & immutable; write tests early.
Avoid: printing secrets; adding global singletons; bypassing providers for direct static access; large PRs without tests; committing without running codegen.

## Quick Reference Commands
- Install deps: `flutter pub get`
- Watch codegen: `dart run build_runner watch --delete-conflicting-outputs`
- One‑off codegen: `dart run build_runner build --delete-conflicting-outputs`
- Analyze: `flutter analyze`
- Unit/widget tests: `flutter test`
- Integration setup: `./scripts/setup_test_env.sh`
- Integration run: `patrol test`
- Cleanup env: `./scripts/cleanup_test_env.sh`

These instructions are repository‑wide and task‑agnostic. Keep them concise; update if toolchain or structure changes.

Trust this file; search only if necessary due to gaps or contradictions.
