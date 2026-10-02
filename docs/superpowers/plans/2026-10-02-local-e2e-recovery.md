# Local E2E Recovery Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restore real, repeatable Patrol E2E runs on iOS Simulator, including HA connection loss and persisted offline cold launch, through one local command.

**Architecture:** Keep the existing HTTP hass-cli bridge as the independent fixture and verification path. Extend the existing persistent `homeassistant-test` Compose project with Toxiproxy; the application connects through its TCP route while administrative traffic bypasses it. A host-side Dart runner owns readiness, simulator selection, generation, execution, interruption recovery, and artifacts; Gherkin steps own scenario mutations and assertions.

**Tech Stack:** Flutter 3.47.5 / Dart 3.13.4 baseline, Patrol 4.10.0 / CLI 4.8.0, bdd_widget_test, build_runner, Docker Compose, HA 2024.12.5, hass-cli 0.9.6, FastAPI, Toxiproxy 2.12.0, Dart HTTP and standard-library host tooling.

**Spec:** [2026-10-02-local-e2e-recovery-design.md](../specs/2026-10-02-local-e2e-recovery-design.md)

## Global Constraints

- iOS Simulator is the primary and default execution target; Android execution is optional and is not an acceptance prerequisite.
- Toxiproxy is the single connection-loss mechanism. No native Wi-Fi/cellular fault implementation or Connectivity/session mocks.
- Keep `app/integration_test`, `test_directory: integration_test`, the `_test.dart` suffix, and the existing BDD generation annotations and binding option.
- Keep `RemoteHassCli`, `docker/web-server`, and an independent hass-cli administration path; never use the application's `home_assistant_client` as the fixture oracle.
- Keep project `homeassistant-test`; no second stack, project rename, per-scenario container recreation, or implicit data reset.
- Preserve existing HA data and management credentials when adopting a named `/config` volume. Normal stop preserves data; reset is explicit and scoped.
- Defaults: direct HA `8123`, bridge `3000`, app proxy `18124`, proxy control `18474`; route `hommie_ha`, listener `0.0.0.0:18124`, upstream `homeassistant:8123`.
- Default simulator host `127.0.0.1`; optional Android emulator host `10.0.2.2`. Centralize `appServerUrl`, `fixtureControlUrl`, and `faultControlUrl`.
- Management credentials are separate from the app session. Delete exact owned IDs, reconcile abandoned test resources, and attempt all cleanup operations after failures.
- Keep Patrol's iOS SwiftPM linkage and runtime `PATROL_INTEGRATION_TEST_IOS_RUNNER(RunnerUITests)`. Do not enable build-time test discovery or introduce a Cucumber runtime.
- Track BDD-generated scenario tests; ignore and untrack `app/integration_test/test_bundle.dart`. Generate BDD output before Patrol bundling.
- Serialize local runs, bound waits and subprocesses, propagate nonzero exits, and redact tokens/passwords from retained output.
- Implement local repeat/watch rails now. Scheduling remains a later user decision after the suite is green.

## Review Focus

1. Missing credential files beside a populated HA volume must recover from verified existing credentials or fail clearly, never silently reprovision the user (Task 3).
2. A timed-out mutation may already have succeeded; report uncertainty and reconcile before another mutation, with no automatic retry (Task 2).
3. Crash between resource creation and cleanup registration must leave enough ownership evidence for the next run without deleting unrelated resources (Task 5).
4. iOS Keychain credentials can outlive app uninstallation; ordinary scenarios must reset their own credentials while the cold-start pair preserves them (Tasks 5 and 8).
5. Interruption during a fault or child process must restore the route, retain the original failure, and prevent a concurrent runner from starting (Task 9).

---

## File Structure and Shared Contracts

This is one recovery plan because backend readiness, mobile fixture control, and offline assertions together produce the usable E2E workflow. Tasks still have independent verification gates. Source changes in `app/lib` are not planned; a product bug exposed by a real run needs its own reproducer and smallest justified fix.

| Files | Responsibility |
| --- | --- |
| `scripts/e2e.dart`, `scripts/e2e.sh` | Root entrypoint and portable shell launcher; resolve repo root from the script location |
| `scripts/e2e/config.dart`, `scripts/e2e/process_runner.dart` | Validated runner options, pinned CLI resolution, bounded subprocess lifecycle |
| `scripts/e2e/backend_fixture.dart` | Existing Compose project, migration, authenticated readiness, proxy reconciliation, ownership journal |
| `scripts/e2e/simulator.dart`, `scripts/e2e/patrol_runner.dart` | Deterministic iOS selection and explicit Patrol invocations |
| `scripts/e2e/cold_start.dart`, `scripts/e2e/artifacts.dart`, `scripts/e2e/watch.dart` | Paired cold launch, redacted artifacts, serialized watch triggers |
| `scripts/setup_test_env.sh`, `scripts/cleanup_test_env.sh` | Compatibility wrappers for explicit backend start/stop; reset requires its own command |
| `docker/docker-compose.yml`, `docker/Dockerfile.hass-cli-web`, `docker/web-server/requirements*.txt` | Pinned persistent fixture and bridge build |
| `docker/web-server/hass_cli_web.py`, `docker/web-server/tests/test_hass_cli_web.py` | Argument-array bridge, bounded execution, sanitized errors and regression checks |
| `docker/scripts/hass-init.py`, `docker/scripts/hass-entrypoint.sh` | Single version-pinned first-run bootstrap adapter |
| `app/integration_test/utils/e2e_config.dart`, `remote_hass_cli.dart`, `fault_proxy_client.dart` | Mobile endpoint configuration and independent HTTP control clients |
| `app/integration_test/utils/test_context.dart`, `scenario_cleanup.dart`, `hass_token_manager.dart`, `hass_area_manager.dart`, `app_state.dart` | Scenario ownership, guaranteed cleanup, and real persisted app state |
| Existing features/steps and new cold-start features/steps | User flows and bounded visible outcomes; regenerate Dart output |
| `app/test/e2e/*_test.dart`, existing `app/test/hass_area_manager_test.dart` | Host runner and mobile helper failure-contract tests |
| `.gitignore`, `app/pubspec.yaml`, `.vscode/tasks.json`, `docs/testing.md`, `docker/hass-cli.md` | Discovery, generated ownership, editor entrypoint, operational instructions |

Public runner contract: `./scripts/e2e.sh [test|backend|smoke]`, default `test`; options `--device`, `--target`, `--tags`, `--repeat N`, `--watch`, `--develop`, and `--timeout-seconds`. This runner commissions iOS Simulator; retain existing Android Patrol configuration for optional manual execution with the same mobile helpers, without adding an Android runner lane. Backend subcommands: `start`, `stop`, `migrate-config`, `reset --confirm-test-data-reset`. `smoke` checks fixture transport without launching the mobile suite. Invalid combinations fail before mutation; `--develop` requires one ordinary target and cannot select the cold-start pair.

Use `E2E_APP_SERVER_URL`, `E2E_FIXTURE_CONTROL_URL`, `E2E_FAULT_CONTROL_URL`, `E2E_RUN_ID`, `E2E_COLD_PHASE` (`none|seed|verify`), `HASS_TOKEN`, `HASS_USERNAME`, and `HASS_PASSWORD` in an ignored, atomically written define file. Preserve `HASS_TOKEN` as the management token. Host-side port overrides update Compose publication and all derived endpoints together. Ignored runtime state lives under `.dart_tool/e2e/`; artifacts under `.dart_tool/e2e/runs/<timestamp>-<runId>/`. Definitions and ownership journals are not copied into shared artifacts.

Defaults to implement, adjustable through runner configuration: CLI subprocess 20 seconds; bridge request 25 seconds; proxy request 5 seconds; readiness 180 seconds; UI outcome 20 seconds; whole run 30 minutes. A timeout at any level must identify the stage and return failure rather than extending indefinitely.

## Task 1: Restore Patrol Discovery and Define the Local Entry Point

**Files:** Modify `app/pubspec.yaml`, `.gitignore`; create `scripts/e2e.dart`, `scripts/e2e.sh`, `scripts/e2e/config.dart`, `scripts/e2e/process_runner.dart`, `app/integration_test/utils/e2e_config.dart`, `app/test/e2e/config_test.dart`, `app/test/e2e/process_runner_test.dart`.

**Interfaces:**
- Produces `E2eConfig.parse(List<String> args, Map<String,String> env, Directory repoRoot)` with immutable `platform = 'ios'`, device override, target/tag filters, repeat count, deadlines, and endpoint fields.
- Produces `ProcessRunner.run(String executable, List<String> args, {required Directory cwd, required Duration timeout, Map<String,String>? environment}) -> Future<ProcessResult>`; accepts an injectable process launcher for tests and exposes cancellation.
- Produces mobile `E2eTestConfig.fromEnvironment()` with `Uri appServerUrl`, `Uri fixtureControlUrl`, `Uri faultControlUrl`, management credentials, run ID, and cold phase. Runtime validation must not depend on Dart assertions being enabled.
- CLI activation resolves 4.8.0 into `.dart_tool/e2e/pub-cache`; activation's `PUB_CACHE` override does not replace the user's global configuration or Flutter's normal dependency cache.

- [x] **Step 1: Add meaningful configuration/process failure tests.** Cover default iOS endpoints, explicit endpoint overrides (including an optional manually run Android emulator's host), URI/port validation, paths containing spaces, invalid repeat/deadline, missing credentials, and a hanging child. Pin assertions such as:

  ```dart
  expect(config.platform, 'ios');
  expect(config.appServerUrl.toString(), 'http://127.0.0.1:18124');
  expect(config.faultControlUrl.port, 18474);
  expect(timedOutChildWasTerminated, isTrue);
  expect(errorText, isNot(contains(managementToken)));
  ```

- [x] **Step 2: Run `cd app && flutter test test/e2e/config_test.dart test/e2e/process_runner_test.dart`.** Expect failure because the contracts do not exist; distinguish that from a toolchain failure.
- [x] **Step 3: Implement the contracts and discovery migration.** Add `test_directory: integration_test`; keep app/platform identifiers and BDD configuration. Add exact bundle and runtime ignores; `git rm --cached app/integration_test/test_bundle.dart`. The shell wrapper uses quoted paths and `exec`; the Dart entrypoint derives repo root independently of cwd. Resolve the local CLI by its activation package config and `bin/main.dart`, running Flutter subprocesses with the normal environment. Add `--help` and backend/test dispatch, with unimplemented stages failing explicitly until later tasks supply them.
- [x] **Step 4: Verify generation and native discovery.** Run helper tests and `cd app && dart run build_runner build --delete-conflicting-outputs` twice. The second run produces no additional scenario changes; no generated scenario calls `IntegrationTestWidgetsFlutterBinding.ensureInitialized()`. Verify local CLI `--version` is 4.8.0; run its `build ios --simulator -t integration_test/authorization_test.dart` from `app`. Expect successful Patrol/Xcode build using the existing runtime runner; this is a build gate, not a passing E2E claim.
- [x] **Step 5: Commit the scoped migration and runner foundation** with `test: restore Patrol discovery and local E2E configuration`; include only this task's files and intentional regenerated differences.

## Task 2: Harden the Independent CLI Bridge

**Files:** Modify `docker/web-server/hass_cli_web.py`, `requirements.txt`, `docker/Dockerfile.hass-cli-web`, `app/integration_test/utils/remote_hass_cli.dart`, token/area manager call sites; create `docker/web-server/requirements.lock.txt`, `docker/web-server/requirements-dev.txt`, `docker/web-server/tests/test_hass_cli_web.py`, `app/test/e2e/remote_hass_cli_test.dart`; update existing `app/test/hass_area_manager_test.dart` fakes.

**Interfaces:**
- `/cli` request becomes `{ "args": ["raw","ws",...], "token": "..." }`; response retains `stdout`, `stderr`, `exit_code`. `/health` indicates bridge process availability, not HA readiness.
- Replace singleton initialization/token mutation with `RemoteHassCli({required Uri fixtureControlUrl, required String managementToken, http.Client? client, Duration timeout = const Duration(seconds: 25)})`.
- Preserve `execute(List<String> args) -> Future<Either<CommandError,CommandResult>>`; produce `executeWs(String type, {Map<String,Object?>? payload}) -> Future<Object?>`, validating HA `success` before returning `result`. Callers use this for structured HA commands.
- `CommandError` identifies transport, HTTP, invalid-response, CLI, or HA failure without retaining credentials in its printable form. `CommandResult` keeps the existing three fields.

- [ ] **Step 1: Add regression cases for serialization and uncertain failure.** Python tests use an injected subprocess boundary, not Docker: a spaced/Unicode name and JSON remain one argument; HTTP validation rejects a string command; timeout terminates the child; `/health` responds during a slow command; errors omit a sentinel token. Dart tests cover non-200 HTML, malformed JSON, CLI nonzero, HTTP timeout, and CLI exit 0 with `{"success":false,"error":{"code":"invalid_token"}}`. Assert the timed-out mutation was sent once, and subsequent reconciliation is a separate caller operation.
- [ ] **Step 2: Run `python -m unittest discover -s tests -v` in an isolated Python 3.11 bridge test container with the pinned dev requirements, and `cd app && flutter test test/e2e/remote_hass_cli_test.dart test/hass_area_manager_test.dart`.** Expect the old string interface and unchecked responses to fail the cases; do not depend on the Mac's different Python version.
- [ ] **Step 3: Implement argument-array transport and bounded execution.** Use shell-free subprocess execution with the 20-second deadline; offload blocking work from the async HTTP loop. Pass the management token through the CLI's supported environment configuration and sanitize stdout/stderr before errors or logs are emitted. Serialize payloads with `jsonEncode`, never string splitting or shell joining; update every call site/fake together. Do not retry mutations automatically.
- [ ] **Step 4: Pin the working build.** Baseline hass-cli is **0.9.6**, verified from the existing running bridge during planning. Retain its direct FastAPI 0.104.1 / uvicorn 0.24.0 / pydantic 2.5.1 pins; generate and commit a complete transitive lock for the Python 3.11 container and an immutable resolved Python base-image digest before rebuilding. Resolve dev test dependencies in the dev requirements. Rebuild only the bridge once and prove the locked image executes area-registry listing and a temporary spaced-name mutation against HA; delete the exact temporary ID.
- [ ] **Step 5: Re-run the Python/Dart failure tests and inspect sanitized live responses.** Expect all cases green, structured HA failures rejected, one mutation attempt on timeout, and no credentials in diagnostics.
- [ ] **Step 6: Commit** with `test: harden and pin the hass-cli fixture bridge`.

## Task 3: Make the Existing Backend Persistent and Readiness Verifiable

**Files:** Modify `docker/docker-compose.yml`, `docker/scripts/hass-init.py`, `docker/scripts/hass-entrypoint.sh`, `scripts/setup_test_env.sh`, `scripts/cleanup_test_env.sh`; create `scripts/e2e/backend_fixture.dart`, `app/test/e2e/backend_fixture_test.dart`; extend entrypoint/config/process modules from Task 1.

**Interfaces:**
- Consumes Task 1 process/config contracts and Task 2 bridge wire protocol.
- Produces `BackendFixture.start()`, `stop()`, `migrateConfigVolume()`, `reset({required bool confirmed})`, `waitUntilReady()`, and `reconcileProxy()`, all `Future<void>`. Constructor accepts config, process runner, and injectable HTTP client/clock.
- Named volume key `ha_config` resolves inside `homeassistant-test`. `migrate-config` is an explicit, one-time maintenance command; routine start refuses an unmigrated populated anonymous volume with an actionable message.
- `/config/.hommie-e2e-initialized` becomes the canonical bootstrap marker. Host credential files are derived outputs; marker presence alone never establishes readiness.

- [ ] **Step 1: Write fake-process/HTTP tests for fresh, healthy, stale, and failing fixtures.** Include healthy-volume + missing host env + valid `app/.patrol.env`, invalid/missing credentials with a populated volume, bridge unhealthy, HA auth rejected, missing `light.kitchen_light`, readiness deadline, and unrelated occupied ports. Assert no reset/reprovision command runs in the stale cases and diagnostics redact sentinel secrets.
- [ ] **Step 2: Run `cd app && flutter test test/e2e/backend_fixture_test.dart`.** Expect failures until the lifecycle/readiness contract exists.
- [ ] **Step 3: Implement preservation before changing the active volume.** `migrate-config` inspects the exact current HA `/config` mount, stops only this test project's services, copies the complete config to the named volume with permissions intact, verifies copied files, then starts the project against it. Keep the old anonymous volume and a private rollback record until authentication and fixture checks pass. Do not print auth files or remove the source volume automatically. Preserve existing management credentials; if none are recoverable, fail with a repair instruction rather than resetting HA.
- [ ] **Step 4: Pin and provision the fixture.** Pin `homeassistant/home-assistant:2024.12.5` and the locked bridge; add Toxiproxy **2.12.0** from Shopify's GHCR image, resolving its immutable manifest digest during implementation. Publish the four configured ports and mount `ha_config:/config`. Remove external onboarding integrations from the single bootstrap adapter. Use pipeline failure propagation and atomic marker/env writes; bootstrap runs only on a genuinely fresh config and seeds the three areas plus `light.kitchen_light` idempotently.
- [ ] **Step 5: Implement authenticated readiness and compatibility wrappers.** Validate direct HA HTTP, independently authenticated WebSocket response, bridge `/health`, CLI area-registry result, and light state before declaring readiness. Repair derived env from a validated existing token when available. Start/check missing services without force-recreation; normal `stop` preserves volume, markers, and credentials. `reset --confirm-test-data-reset` targets only the named test volume and generated files, including the correct `app/.patrol.env`. Reset cannot run while a suite holds the lock.
- [ ] **Step 6: Verify both preservation and first-run setup.** Run `./scripts/e2e.sh backend migrate-config` once, then `backend start` twice; record that existing HA credentials/data survive and service IDs remain stable across healthy starts. Test fresh bootstrap using a temporary named volume in the **same** project during explicit maintenance, with the preserved volume reattached afterwards; never erase the user's current fixture to run this check. Readiness failures return nonzero within 180 seconds. Re-run backend unit tests.
- [ ] **Step 7: Commit** with `test: preserve and verify the persistent HA fixture`.

## Task 4: Prove Real Proxy Faults and Add the Mobile Control Helper

**Files:** Create `app/integration_test/utils/fault_proxy_client.dart`, `app/test/e2e/fault_proxy_client_test.dart`; extend `scripts/e2e/backend_fixture.dart`, entrypoint, and backend tests.

**Interfaces:**
- Produces `FaultProxyClient({required Uri faultControlUrl, http.Client? client, Duration timeout = const Duration(seconds: 5)})`, with `Future<void> disconnectFromHa()` and `restoreHaRoute()`.
- Consumes Task 3 `reconcileProxy()`; produces `BackendFixture.smokeConnectionLoss() -> Future<void>` used by `./scripts/e2e.sh smoke`.
- `POST /proxies/hommie_ha` sends only `enabled: false|true`; helper validates HTTP status and returned name/enabled state. Creation/reconciliation stays in the host runner.

- [ ] **Step 1: Add helper tests for disable/restore, wrong returned state, missing route, malformed response, and timeout.** Assert exact route and JSON body, bounded errors, idempotent restoration, and no application HA-client dependency. Backend tests pin preflight repair of an absent, disabled, or misconfigured route.
- [ ] **Step 2: Run `cd app && flutter test test/e2e/fault_proxy_client_test.dart test/e2e/backend_fixture_test.dart`.** Expect the missing helper/smoke contract to fail.
- [ ] **Step 3: Implement control and smoke verification.** Reconcile `hommie_ha` to the fixed internal listener/upstream and enabled state. Smoke opens an authenticated real WebSocket through `appServerUrl`, disables the route, observes that established socket closing and a new connection failing, proves a read-only CLI operation and proxy control still work, then restores the route and authenticates a new proxied connection. Use Dart's standard WebSocket client on the host; do not use Hommie's package. Register restoration before disabling the route.
- [ ] **Step 4: Run `./scripts/e2e.sh smoke` against the preserved fixture and helper tests.** Expect real established-socket termination, management access during outage, and successful restoration. Service/container IDs must not change. Force a smoke assertion failure and confirm restoration still occurs.
- [ ] **Step 5: Commit** with `test: control and verify HA faults through Toxiproxy`.

## Task 5: Give Each Scenario Real Storage and Owned Cleanup

**Files:** Modify `app/integration_test/utils/test_context.dart`, `hass_token_manager.dart`, `hass_area_manager.dart`, `common.dart`, existing access/login/cleanup/revocation/area cleanup steps, and the cleanup hooks in all three existing features; create `app/integration_test/utils/scenario_cleanup.dart`, `app/integration_test/utils/app_state.dart`, `app/test/e2e/scenario_cleanup_test.dart`, `app/test/e2e/hass_token_manager_test.dart`, `app/test/e2e/app_state_test.dart`; extend area tests and host ownership reconciliation. Delete `app/integration_test/utils/test_provider_overrides.dart` after its final consumer is removed, and replace the skipped, unsafe global-deletion debug tests in `app/test/hass_cli_test.dart` with the new owned-token test suite.

**Interfaces:**
- Produces `ScenarioCleanup.register(String label, Future<void> Function() action)` and `run() -> Future<List<CleanupFailure>>`; runs all actions once in reverse order and reports every failure. `CleanupFailure` contains label, error, and stack trace. The Patrol wrapper registers it with `addTearDown` before scenario work.
- Produces `HassTokenRef(String id, String accessToken)` and `HassTokenManager.createLongLivedToken({required String clientName}) -> Future<HassTokenRef>`, `deleteById(String id) -> Future<bool>`, `list() -> Future<List<HassRefreshToken>>`. `HassRefreshToken` contains ID, user ID, client name, and client ID, using the fields supported by pinned HA. All commands use the fixed management token from Task 2; revocation deletes the app's exact token ID.
- Scenario context holds config, cleanup, owned IDs, and area names `Hommie E2E <runId> <scenarioId> Initial|Renamed`; no global fixed-name deletion.
- Produces `E2eAppState.reset()`, `seedSession({required Uri serverUrl, required String accessToken})`, `waitForCachedEntity(String entityId)`, all `Future<void>`. Use real database/server/credential repositories and `bootstrap()`; no provider overrides or in-memory credential/server replacements.

- [ ] **Step 1: Add ownership and cleanup failure tests.** Cover duplicate names with different IDs, already-deleted tokens, HA `success:false`, assertion failure, cleanup action throwing, and a crash journal containing owned plus unrelated resources. Assert every registered cleanup is attempted, only owned IDs are deleted, and the management token is retained. Add repository-backed seed/read/reset tests with a SQLite test executor and mocked storage plugin channels; the actual iOS storage/Keychain proof remains in the mobile gates. Assert cleanup removes this app's credential keys rather than assuming uninstall clears Keychain.
- [ ] **Step 2: Run the new tests plus `test/hass_area_manager_test.dart`.** Expect the old first-match deletion and mock-backed login setup to fail the contracts.
- [ ] **Step 3: Implement per-scenario ownership and actual persisted setup.** Namespace harness-created tokens/areas and register cleanup immediately. For UI-created areas, record the intended unique name before the action and resolve its exact returned registry ID afterwards; reconciliation may match only the reserved namespace. For UI OAuth login, take a management-side token-ID baseline before login and record the exact new refresh-token ID after it; require one match for the reserved test user/client and fail on ambiguity. Before each Patrol invocation, persist a host-side journal with run ID, namespace, existing token IDs, test user/client identity, and start time, so a crash before registration can be reconciled. An ambiguous snapshot difference is reported for repair, never resolved by deleting an arbitrary token; no extra bridge control endpoint is needed.
- [ ] **Step 4: Make teardown independent of Gherkin `After` completion.** Move destructive cleanup from generated `finally`/`After` hooks into the wrapper's registered teardown, so a cleanup exception cannot mask the original assertion. The wrapper retains the original assertion/stack; cleanup failures are attached diagnostics and fail an otherwise successful scenario. `performCleanup`, if retained as an explicit step, delegates to idempotent cleanup and records failures without replacing an existing test failure. Initialize logger/background tasks through actual bootstrap, remove repository mocks, close provider/database resources, and reset app-owned database/preferences/credential keys before ordinary tests. Cold phases defer this reset/cleanup under the explicit phase contract in Task 8.
- [ ] **Step 5: Verify real failure recovery.** Run helper tests, create namespaced fixture resources, deliberately fail after creation, then confirm CLI reads show them removed. Simulate a stale ownership journal and restart preflight; abandoned owned resources disappear while baseline areas/tokens survive. Check app-state reset twice and management authentication after app-token revocation.
- [ ] **Step 6: Commit** with `test: isolate E2E state and guarantee owned cleanup`.

## Task 6: Restore Real iOS Authorization and Area Flows

**Files:** Modify `app/integration_test/authorization.feature`, `areas.feature`, their generated tests, existing login/onboarding/area/revocation/foreground steps; create `step/i_enter_the_home_assistant_address.dart`, `step/the_active_session_is_removed.dart`, `scripts/e2e/simulator.dart`, `scripts/e2e/patrol_runner.dart`, `app/test/e2e/patrol_runner_test.dart`. Extend the root `test` dispatch.

**Interfaces:**
- Consumes endpoint/state/ownership contracts from Tasks 1–5.
- Produces `SimulatorDevice` with ID, name, runtime, and booted-state fields; `IosSimulator.select({String? device}) -> Future<SimulatorDevice>` and `bootAndWait(SimulatorDevice) -> Future<void>`. Explicit ID/name wins, otherwise choose an available booted iPhone, then newest available iOS runtime + deterministic iPhone name/ID ordering. Never select a physical device or prompt interactively by default.
- Produces `PatrolRunner.runTargets(List<String> targets, {required SimulatorDevice device, required File defines, String? tags, bool preserveApp = false}) -> Future<int>`; use CLI 4.8.0, explicit `--device`, and `--dart-define-from-file`. The device override is machine-local, not a committed UDID.

- [ ] **Step 1: Update feature contracts and runner tests.** Manual-address entry uses configured proxy URL and configurable test credentials. Sign-out exercises real storage; revocation asserts discovery routing plus absent active session/credentials, without requiring a transient banner. Areas use context-owned names and independent remote verification. Runner tests cover a shut-down simulator, multiple available runtimes, absent selected device, target/tag propagation, and explicit child exit code 7.
- [ ] **Step 2: Regenerate BDD tests, run runner tests, and attempt the focused iOS scenarios.** Expect current address/mocks/revocation contract to fail before restoration; capture the actual failure rather than interpreting a build as a passed test.
- [ ] **Step 3: Implement the minimal scenario and iOS execution changes.** Preserve UI actions and stable keys, fix native WebView interactions only where a real iOS run demonstrates a mismatch, replace fixed sleeps with bounded readiness/UI observations, and verify session removal using actual repository/provider state. Suppress credential values in native text-entry logs and validate retained logs contain neither password nor session/management tokens. Implement configured iOS selection/boot, generation-before-bundling, exact targets, and failure propagation. Keep ordinary app-state reset within Task 5's wrapper.
- [ ] **Step 4: Run `./scripts/e2e.sh --target authorization --tags quick`, then all authorization tests and `./scripts/e2e.sh --target areas`.** Expect actual Simulator UI sign-in, sign-out, exact-token revocation, and area create/rename/delete with independent CLI checks. Analyze changed helpers and run existing auth/session/area regression tests. Investigate any app bug with a reproducer; do not loosen scenario assertions to obtain green output.
- [ ] **Step 5: Commit** with `test: restore iOS authorization and area E2E flows`.

## Task 7: Migrate Offline Scenarios to One Proxy Mechanism

**Files:** Modify `app/integration_test/offline_banner.feature`, generated test, visible-banner assertions and light-card step; create `step/the_client_loses_connection_to_home_assistant.dart`, `step/home_assistant_becomes_reachable_again.dart`, `step/the_client_reconnects_to_home_assistant.dart`, `app/test/e2e/offline_assertions_test.dart`; delete device-loses/regains-connectivity steps when unreferenced.

**Interfaces:**
- Loss step `theClientLosesConnectionToHomeAssistant(PatrolIntegrationTester $) -> Future<void>` calls Task 4 `disconnectFromHa()` after registering restoration.
- Reachability step `homeAssistantBecomesReachableAgain(PatrolIntegrationTester $) -> Future<void>` calls `restoreHaRoute()`; reconnect assertion waits on real app connection/session and UI outcomes.
- Banner assertions use rendered/clipped visibility under `AnimatedAlign` with the 20-second bound. Element presence alone is insufficient for either appearance or disappearance.

- [ ] **Step 1: Write the loss/recovery feature and a banner visibility regression.** Online home and `light.kitchen_light` are visible; outage shows banner and retains the cached light; restored route yields a live session and hides banner. The helper test must include a mounted banner clipped by `heightFactor: 0`, and a delayed hide animation; absence of a widget is not required.
- [ ] **Step 2: Generate and run `cd app && flutter test test/e2e/offline_assertions_test.dart test/ui/screens/widgets/offline_container_test.dart`, then the focused proxy scenario.** Expect the old `findsNothing` assertion/native toggles to fail the new contract.
- [ ] **Step 3: Implement semantic steps with the one fault helper.** Remove native network actions and fixed 2/3/5-second sleeps from these flows. Use bounded UI polling that observes actual rendering and bounded real-session recovery. Retain the mounted-banner product behavior; do not change UI to accommodate a test. Move the old mock-based offline-launch scenario to the paired contract in Task 8.
- [ ] **Step 4: Run `./scripts/e2e.sh --target offline_banner` on iOS.** Expect live WebSocket loss, visible banner, cached card retained, and real reconnection. While disconnected, CLI verification and cleanup remain usable. Confirm `rg 'disableWifi|disableCellular|enableWifi|enableCellular' app/integration_test` has no active fault steps and BDD regeneration is stable.
- [ ] **Step 5: Commit** with `test: exercise offline recovery through Toxiproxy on iOS`.

## Task 8: Prove Persisted Offline Cold Launch Across Processes

**Files:** Create `app/integration_test/cold_start_seed.feature`, `cold_start_verify.feature`, their generated tests, `step/the_kitchen_light_is_persisted.dart`, `step/the_existing_persisted_session_is_used.dart`, `scripts/e2e/cold_start.dart`, `app/test/e2e/cold_start_runner_test.dart`; extend common wrapper, real app-state helper, backend journal, and runner target selection.

**Interfaces:**
- Produces `ColdStartRunner.run({required SimulatorDevice device, required File defines}) -> Future<int>`; pair is one logical test and one ownership scope.
- Seed scenario carries `@cold_start` and `@cold_seed`; verify carries `@cold_start` and `@cold_verify`, as scenario tags forwarded to `patrol()`. Seed requires `E2E_COLD_PHASE=seed`, initializes real stored session/cache, and intentionally defers owned-token/storage cleanup. Verify requires `verify` and skips all seed/reset/login operations. The wrapper combines its phase gate with the caller's existing skip value; it skips phase-only scenarios during ordinary discovery and ordinary scenarios during a phase run.
- Each phase runs through Task 6 `runTargets(..., preserveApp: true)` and explicitly passes `--no-uninstall`. Keep `FULL_ISOLATION=0`, `CLEAR_PERMISSIONS=0`, and runtime discovery; do not use manifest-dependent `test-without-building --only`.

- [ ] **Step 1: Add a runner sequence test with failure injection.** Assert order: seed → successful persisted-state checkpoint → host `simctl terminate` of the configured app → route disabled → verify launched with no uninstall/reset → restore → cleanup. Seed failure must prevent offline verification; verify failure/timeout must still restore and reconcile. Both phases use the same device, run ID, app bundle ID, and owned session; the phase defines are atomically updated between invocations.
- [ ] **Step 2: Run `cd app && flutter test test/e2e/cold_start_runner_test.dart`.** Expect missing paired coordination to fail; retain the test's event-order assertion.
- [ ] **Step 3: Implement the two actual Patrol targets.** Seed authenticates using real repositories/UI, waits for `light.kitchen_light` in the persisted database, and returns without removing its token/data. Host terminates the app and verifies it is no longer running before disabling the route. Verify launches against the same persisted sandbox/Keychain, performs no login/seeding, proves cached home and visible banner while HA is unreachable, then restores the route and proves live recovery. Reinstall of an updated test binary must demonstrably preserve data; a `pumpWidget` or foreground action within one process cannot satisfy this task.
- [ ] **Step 4: Wire default and filtered execution.** Default suite runs the three ordinary features and this paired flow. `--target cold_start` selects the pair; `--target offline_banner` selects the connection-loss feature only. Phase targets are not independently user-selectable. Tags select the logical cold pair together; `--develop` rejects it. Pair cleanup runs on success/failure and before the next ordinary scenario, including Keychain-owned keys.
- [ ] **Step 5: Run `./scripts/e2e.sh --target cold_start` twice on iOS.** Retain separate seed/verify native results, termination/relaunch timestamps or process evidence, and the persisted-cache observation. Prove no credential/server mocks, no second online authentication in verify, no management-token revocation, and clean state after the pair. If Patrol's runtime runner cannot preserve the sandbox as expected, report the actual failure and revise this task explicitly; do not replace the contract with warm launch or enable static discovery silently.
- [ ] **Step 6: Commit** with `test: verify cached offline cold launch across iOS processes`.

## Task 9: Finish Local Repeat/Watch Rails and Failure Artifacts

**Files:** Create `scripts/e2e/artifacts.dart`, `scripts/e2e/watch.dart`, `app/test/e2e/runner_lifecycle_test.dart`, `app/test/e2e/artifacts_test.dart`; extend runner/config/process/backend/patrol modules; modify `.vscode/tasks.json`, `docs/testing.md`, `docker/hass-cli.md`, `.gitignore`.

**Interfaces:**
- Produces one atomic ownership lock at `.dart_tool/e2e/run.lock` containing PID/run ID/start time; second runs fail clearly. Reclaim a stale lock only after confirming its owner is no longer alive, restoring the route, and reconciling its journal.
- Produces `RunArtifacts.capture({required String runId, required int exitCode, required List<FileSystemEntity> nativeResults, required Map<String,Object?> metadata}) -> Future<void>` and `redact(String text, Iterable<String> secrets) -> String` used before output is persisted. Constructor receives the run directory and known secret values; metadata includes target/device, tool versions, stage durations, and primary/cleanup errors.
- Produces watch mode that coalesces changes under app `lib`, integration `.feature`/step/utils, relevant build/pubspec files, and fixture scripts into one queued run; ignores generated files, `.dart_tool`, builds, and artifacts.

- [ ] **Step 1: Add interruption/concurrency/artifact tests.** Fake child failures/timeouts/SIGINT/SIGTERM must trigger route restoration and every cleanup attempt, keep the primary exit, terminate children, and release lock after capture. A live second runner never starts Compose/Patrol; a stale owner is reconciled. Test sentinel token/password redaction, failing artifact capture, overlapping watch events, and ignored generated-file changes. Assert exactly three runs for `--repeat 3` and no continuing repeat after failure.
- [ ] **Step 2: Run `cd app && flutter test test/e2e/runner_lifecycle_test.dart test/e2e/artifacts_test.dart`.** Expect incomplete runner cleanup/logging rails to fail the contracts.
- [ ] **Step 3: Implement the full local workflow.** Default `test` performs toolchain checks, locking, backend readiness/reconciliation, generation, deterministic iOS execution, cold pair, and artifact capture. Add fail-fast repeat, serialized watch, and single-target Patrol develop with the same preflight/fault cleanup. Forward target/tag filters consistently, including phase-only discovery rules. Bound readiness and whole run; terminate active children before cleanup to prevent further mutations. Use process argument arrays, never a constructed shell command containing secrets.
- [ ] **Step 4: Capture useful evidence without credentials.** Retain runner/bridge/HA/proxy logs, target/device/version/timing/exit metadata, native `.xcresult` bundles, and relevant failure screenshots. Copy results from the actual run paths, not an arbitrary newest stale bundle. Scrub credentials before writing log streams; validate sentinel redaction, including error bodies and native attachments. A capture failure is secondary to a test failure but fails an otherwise successful run. Keep generated define files private and excluded from artifacts.
- [ ] **Step 5: Update user entrypoints and operational docs.** VS Code `patrol: run tests` invokes `${workspaceFolder}/scripts/e2e.sh` with default iOS; add a watch task. Document root and absolute-path commands, device selection, targets/tags, repeat/watch/develop, explicit migration/stop/reset, crash recovery, artifacts, and the scope of proxy outages. Explain that fixtures execute through the bridge from Dart, while only the Mac runner controls Docker. Do not add a schedule.
- [ ] **Step 6: Verify normal and failure paths end to end.** Run from repo root and another cwd; force one assertion failure, SIGINT during outage, and a second concurrent invocation. Confirm actionable nonzero status, route restoration, preserved service/volume IDs, cleanup, and retained sanitized native evidence. Confirm the next ordinary default run succeeds without manual repair. Re-run focused runner tests.
- [ ] **Step 7: Commit** with `test: add repeatable local iOS E2E rails and diagnostics`.

## Task 10: Demonstrate Recovery and Record the Completion Gate

**Files:** Update `docs/testing.md` with verified commands and measured timings; record completion evidence in `docs/superpowers/plans/2026-10-02-local-e2e-recovery.md`. No new product behavior is planned.

**Interfaces:** Consumes the complete runner. Produces reviewable results for all eleven spec acceptance checks, with any remaining failures explicitly listed.

- [ ] **Step 1: Run focused regressions and generation verification.** From `app`, run all new `test/e2e` tests, `test/hass_area_manager_test.dart`, `test/ui/screens/widgets/offline_container_test.dart`, `test/application/session`, `test/features/auth`, `test/core/infrastructure/networking/connection`, and the existing settings area widget/controller tests. Run bridge Python tests in its pinned test environment. Analyze changed Dart files, regenerate BDD output twice, and check `git diff --check`. Expect green checks, stable generation, and no tracked Patrol bundle.
- [ ] **Step 2: Run `./scripts/e2e.sh --repeat 3` with the default iOS suite.** Each iteration includes authorization, areas, loss/recovery, and the cold pair with independent state. Record first-build and warm-run durations and artifact paths; do not claim an Android speed advantage without a separate measured comparison.
- [ ] **Step 3: Audit each acceptance check against real evidence.** Check discovery/filters, healthy and fresh fixture readiness, preserved migrated data, bridge failure contracts, established-socket interruption, cold-process persistence, single fault mechanism/default iOS, repeated runs, regression suite, artifacts/exits, owned crash cleanup, and unchanged Compose project. Confirm no residual namespaced resources, invalidated management token, disabled route, or changed baseline data.
- [ ] **Step 4: Resolve any demonstrated failures with a targeted regression and rerun affected checks.** Changes to app behavior require their own failing reproducer and scoped fix; mark added paths and the reason in completion evidence. Do not broaden tests once checks pass without a new concern. Do not claim completion with skipped mobile/cold-start gates.
- [ ] **Step 5: Commit verified documentation/evidence** with `docs: record restored local iOS E2E workflow`; do not create an empty commit if there are no changes.

## Self-Review and Execution Notes

- Spec coverage: Tasks 1/6 restore discovery and native execution; 2 hardens independent administration; 3 preserves and provisions the fixture; 4 proves proxy faults; 5 owns data and storage; 7/8 restore offline contracts; 9 supplies local rails and diagnostics; 10 covers every acceptance check.
- Interfaces: `execute(List<String>)` is migrated with all callers/fakes in Task 2; route naming/endpoints stay consistent; Task 8 uses the same `runTargets` and state contracts without introducing a second fault helper.
- Review focus: All five conditions above have an owning test or explicit live verification gate. Do not substitute test-double results for mobile execution or data-preservation evidence.
- Scope: No new fixture architecture, OS network lane, HA upgrade, schedule, or static Patrol runner. CLI 0.9.6 was read from the running bridge; lock/base digests are resolved and verified before rebuilding. [Toxiproxy 2.12.0 release](https://github.com/Shopify/toxiproxy/releases/tag/v2.12.0) and [its Docker/API documentation](https://github.com/Shopify/toxiproxy/blob/v2.12.0/README.md) support the selected proxy baseline and enabled-route API.
- Before implementation, read the spec and use the worktree skill if isolation is needed. The existing live Compose fixture is shared external state even when Git work is isolated; serialize it and resolve its config/bind paths explicitly.
- Recommended execution: native implementation in this session, followed by an independent whole-branch review. The tasks share endpoints, ownership, and lifecycle contracts, so one implementer can preserve that continuity; the real iOS and cold-start gates provide the final evidence.

## Completion Evidence

To be filled during execution with actual commands, results, timings, and artifact paths. Planning has not executed or passed the restored mobile suite.
