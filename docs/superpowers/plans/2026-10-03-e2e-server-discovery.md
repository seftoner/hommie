# E2E Server Discovery Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Control real HA discoverability from Dart BDD scenarios and verify discovery-to-login, manual entry and advertisement withdrawal.

**Architecture:** A small host HTTP fixture controller owns `dns-sd` on macOS or Avahi on Linux. Shell scripts manage its lifecycle; the app discovers its real records and connects through the existing Toxiproxy route to persistent Docker HA. Installed Patrol remains the test runner.

**Tech Stack:** Flutter/Dart, Patrol 4.10.0 with installed Patrol CLI, bdd_widget_test/build_runner, Python 3.11+ standard library, POSIX shell, Bonjour/Avahi, existing Docker Compose/hass-cli/Toxiproxy.

**Spec:** [Per-scenario Home Assistant discovery](../specs/2026-10-03-e2e-server-discovery-design.md).

## Global Constraints

- iOS Simulator on macOS is the primary acceptance platform.
- Linux/Android discovery is supported only after a real app/emulator probe passes.
- Use the installed Patrol CLI; keep executable lifecycle scripts in POSIX shell.
- Keep BDD source and generated tests in `app/integration_test/`.
- Preserve Compose project `homeassistant-test` and volume `homeassistant-test_ha_config`.
- Keep the hass-cli bridge for HA administration and Toxiproxy for connection faults.
- Advertise `_home-assistant._tcp.local.`; pass `_home-assistant._tcp` and `local.` separately to native publisher CLIs.
- Advertised `internal_url` equals `E2E_APP_SERVER_URL`, including the mapped proxy port.
- Run scenarios sequentially; own at most one fixture advertisement.
- Discovery is disabled before and after every scenario, including cold phases.
- No discovery provider override, canned result list, native network toggle or new test-runner CLI.

## Review Focus

- Spawned publisher never registers, exits or auto-renames: enable fails and cleans its child; Task 2 publisher/controller tests.
- Cached/in-flight records or a loading/error screen look absent: only a completed fresh scan proves absence; Task 1 controller/widget tests and Task 4 withdrawal BDD.
- Failed/interrupted scenarios leak advertisements or alter cold-start faults: next scenario starts disabled and cold verify preserves the fault; Task 3 lifecycle regressions and Task 5 interruption acceptance.
- Android HTTP works but host multicast never reaches Dart: platform support remains unverified; Tasks 1 and 5 native transport probes.
- Another real HA server has the same display name: exact fixture identity and proxy URL are required, foreign advertisements survive; Tasks 2 and 4 ownership/row tests.

---

## File map

| Files | Responsibility |
| --- | --- |
| `app/lib/features/auth/infrastructure/repositories/ha_servers_repository.dart` | Verified real PTR query and fixture TXT parsing; injectable MDnsClient factory for unit tests. |
| `app/lib/features/auth/application/servers_discovery_controller.dart` | Serialize scans and perform a fresh force refresh. |
| `app/lib/features/auth/presentation/screens/server_discovery_page.dart`, `app/lib/ui/keys.dart` | Refresh available in every state; observable loading, success and error. |
| `app/test/features/auth/{infrastructure/repositories/ha_servers_repository_test.dart,application/servers_discovery_controller_test.dart,presentation/server_discovery_page_test.dart}` | Query, fresh-scan and UI regressions. |
| `tool/e2e/discovery/publisher.py`, `tool/e2e/discovery/controller.py` | Native publisher ownership and narrow HTTP API. |
| `tool/e2e/discovery/test_publisher.py`, `tool/e2e/discovery/test_controller.py`, `tool/e2e/discovery/test_lifecycle.py` | Standard-library tests for daemon, shell configuration and process ownership. |
| `scripts/setup_test_env.sh`, `scripts/cleanup_test_env.sh` | Provision/retire the host controller alongside existing services. |
| `app/integration_test/utils/{discovery_fixture_client.dart,discovery_fixture.dart,e2e_config.dart,test_context.dart,common.dart}` | HTTP control and scenario lifecycle integration. |
| `app/test/e2e/{discovery_fixture_client_test.dart,discovery_fixture_test.dart,config_test.dart}` | Dart protocol/configuration and cleanup regressions. |
| `app/integration_test/server_discovery.feature`, generated `server_discovery_test.dart`, new discovery step files | Three BDD scenarios through the production app. |
| `app/ios/Runner/Info.plist`, `app/android/app/src/main/AndroidManifest.xml` | Only permission/declaration changes established by native probes. |
| `docs/testing.md`, `docs/developer-guide.md`, `AGENTS.md`, this plan | Document implemented prerequisites, architecture and actual acceptance evidence. |

Regenerate affected Riverpod `.g.dart` and BDD `_test.dart` files using existing
build_runner. Do not change the shared generic cache or replace discovery transport
unless a failing probe establishes that the selected implementation cannot work.

### Task 1: Make production discovery query and refresh verifiable

**Files:** Production discovery/controller/page/key files and their three tests in the file map; platform declarations only if the probe requires them.

**Interfaces:**
- Preserve `IHAServersRepository.getAvailableServers(): Future<List<HaServer>>`.
- Add `HAServersRepository({MDnsClient Function()? clientFactory})`; default creates the real client.
- Preserve controller `refresh(): Future<void>` and `forceRefresh(): Future<void>`; force refresh completes after a fresh successful scan or exposes its error state.
- Add keys `K.serversDiscovery.refreshButton`, `scanLoading`, `scanComplete`, `scanError`; `scanComplete` is present only for successfully completed data, including an empty list.

- [ ] **Write failing tests and a query characterization.** `emits_local_ha_ptr_question` inspects the captured query's encoded bytes and expects labels `_home-assistant`, `_tcp`, `local`, one root terminator and QTYPE `12`; this characterizes already-working normalization. `reads_fixture_txt_metadata` expects the configured proxy URL, version, UUID and a display name `Hommie E2E = Kitchen`. `stops_client_after_success_or_failure` checks cleanup. `force_refresh_waits_then_bypasses_cached_results` holds an old scan, requests refresh, returns old fixture data, then fresh data without the fixture; the final state contains only fresh data. `periodic_ticks_do_not_overlap_scan` expects one underlying scan. `disposed_scan_cannot_write_state` completes a held scan after disposal. Widget tests require a refresh action for a populated list and show `scanComplete` only after success, never while loading or after error.
- [ ] **Confirm RED.** From `app/`: `flutter test test/features/auth/infrastructure/repositories/ha_servers_repository_test.dart test/features/auth/application/servers_discovery_controller_test.dart test/features/auth/presentation/server_discovery_page_test.dart`. Expect the missing factory seam, TXT-name, refresh or key assertions to fail. Do not invent a query failure: installed library encoding already adds `local`.
- [ ] **Add the factory seam and fix TXT value splitting.** Keep the current service query unless the encoded-question regression fails. Split TXT pairs at their first `=`. The installed encoder and resolver normalize the current short name; avoid a trailing dot that this encoder would encode as an extra empty label. Keep real socket discovery intact.
- [ ] **Serialize controller scans.** Keep one active scan. Periodic refresh coalesces with it; force refresh waits for it, clears the discovery repository cache, then starts a fresh scan. Suppress publication of superseded results, show loading until the fresh scan finishes, and check `ref.mounted` after awaits. Do not add general cache infrastructure.
- [ ] **Expose refresh and completion in the UI.** Use the existing force-refresh method and disable duplicate refresh while running. Explicitly render loading during refresh; an error cannot reuse the successful completion key.
- [ ] **Confirm GREEN.** Run the three focused tests and regenerate affected Riverpod output from `app/` with `dart run build_runner build --delete-conflicting-outputs`. Run `flutter analyze` on the changed discovery/key files; require no new issues.
- [ ] **Run the first native feasibility probe.** Manually register one native service with the spec's TXT fields pointing to the existing proxy; launch the real app on iOS Simulator, find that exact name/URL, tap it and reach HA authentication. Separately verify host registration acknowledgment and proxy HTTP reachability. Record command/tool/runtime versions and whether the local-network prompt occurs. A host `dns-sd` browse result alone cannot pass this gate. Remove the temporary advertisement after the probe.
- [ ] **Probe Linux/Android when a Linux host is available.** Repeat with Avahi and record emulator version, actual raw Dart mDNS receipt, metadata and proxy/control HTTP routes. If unavailable or failing, record pending/blocker evidence and continue the primary iOS lane; do not declare Android discovery supported or silently substitute fake results. A transport replacement requires an amended design.
- [ ] **Commit** as `fix(discovery): serialize fresh scans and preserve txt values`; record the native probe outcome in this plan. Do not proceed with macOS fixture automation until the iOS feasibility gate passes.

### Task 2: Own a native advertisement through a narrow host API

**Files:** Create `tool/e2e/discovery/{publisher.py,controller.py,test_publisher.py,test_controller.py}`.

**Interfaces:**
- `Publisher.start(*, service_name: str, display_name: str, port: int, txt: dict[str, str], timeout: float = 5.0) -> None` and `stop(timeout: float = 5.0) -> None`; `is_registered() -> bool` examines actual child state.
- `AdvertisementController.set_advertisement(*, enabled: bool, scenario_id: str | None = None, name: str | None = None) -> dict` and `status() -> dict`, implementing the response fields from the spec.
- `python3 tool/e2e/discovery/controller.py --config <private-config-path>` starts only the fixture HTTP service. Config keys: `run_id`, `token`, `bind_host`, `port`, `app_server_url`, `ha_version`, `state_dir`. No test-selection/execution options.

- [ ] **Write failing Python tests.** Pin native argument arrays, TXT `internal_url`/proxy port, stable run UUID and unique DNS service name. Exercise delayed acknowledgment, early exit, registration timeout, wrong/renamed instance, name containing shell punctuation, child termination escalation, later child death, repeated enable/disable and replacement conflict. Assert no process is reported enabled before acknowledgment and only the owned child is stopped.
- [ ] **Write API validation tests.** Expect `401` without the correct bearer token, `400` for unknown fields/control characters/oversized UTF-8 names/invalid scenario IDs, `409` for competing enable and `503` for failed registration. Foreign publishers remain untouched; request input cannot change configured proxy URL, commands or metadata.
- [ ] **Confirm RED.** From root: `python3 -m unittest discover -s tool/e2e/discovery -p 'test_*.py' -v`; expect missing controller/publisher APIs or failing assertions.
- [ ] **Implement the publisher adapters.** Use argument arrays with `subprocess.Popen(shell=False)`: `dns-sd -R <service_name> _home-assistant._tcp local. <port> <TXT...>` on macOS; `avahi-publish-service --domain=local <service_name> _home-assistant._tcp <port> <TXT...>` on Linux. Parse each tool's successful exact-name acknowledgment, keep output consumption bounded, detect asynchronous exit and implement owned-child stop. Use fake executable processes for automated lifecycle tests, not host-wide Bonjour/Avahi resets.
- [ ] **Implement the standard-library HTTP controller.** Apply the spec's validation, bearer token, fixed config, metadata and 5-second publisher deadlines. Serialize mutations so concurrent requests cannot create two publishers. On shutdown stop the child; privately record process identity for interrupted ownership reconciliation. Return status without tokens or publisher command output.
- [ ] **Confirm GREEN.** Repeat the Python suite. With the native publisher on macOS, exercise authenticated enable/status/disable and independently resolve the exact instance/TXT records. Require acknowledgment, correct proxy metadata and child exit; record Linux adapter tests separately from any actual Linux native evidence.
- [ ] **Commit** as `feat(e2e): add host discovery fixture controller`.

### Task 3: Connect shell lifecycle and Dart scenario controls

**Files:** Modify both shell scripts, `e2e_config.dart`, `test_context.dart`, `common.dart`, `config_test.dart`; create both discovery helpers, their tests and `tool/e2e/discovery/test_lifecycle.py`.

**Interfaces:**
- Extend `E2eTestConfig` with required `Uri discoveryControlUrl` and `String discoveryControlToken`; read `E2E_DISCOVERY_CONTROL_URL` and `E2E_DISCOVERY_CONTROL_TOKEN` without logging values.
- `DiscoveryFixtureClient({required Uri controlUrl, required String controlToken, required String runId, required Uri appServerUrl, http.Client? client, Duration timeout = const Duration(seconds: 10)})`.
- Client: `enable({required String scenarioId, required String name}): Future<void>`, `disable(): Future<void>`, `close(): void`; validate response state, run ID and configured URL.
- `DiscoveryFixture(client: DiscoveryFixtureClient, scenarioId: String)` with `prepare(ScenarioCleanup cleanup): Future<void>`, `enable(String name): Future<void>`, `disable(): Future<void>`; prepare registers cleanup before disabling stale discovery. Store it on `TestContext.discoveryFixture` and expose the current `scenarioId`.
- Shell input defaults: `E2E_DISCOVERY_PORT=18535`, `E2E_DEVICE_HOST=127.0.0.1`; write all device-facing fixture URLs using the selected host and host readiness URLs using loopback.

- [ ] **Write failing lifecycle/configuration tests.** Use injectable HTTP and fake local tools: prepare sends disable before enable; enable/disable confirm exact returned state; wrong run/URL, malformed JSON, non-2xx and timeout fail. Simulate callback failure and withdrawal failure: later cleanup still runs and the primary error survives. Repeated prepare repairs the previous enabled scenario. Test missing token/endpoint, distinct ports, IPv4 host alias and preservation of existing defaults.
- [ ] **Write shell ownership regressions.** A readiness failure must retain the previous dotenv; repeated setup leaves only one disabled owned controller; occupied foreign port and reused PID are never killed. Setup failure retires its newly spawned controller. Cleanup stops verified owned controller/children but retains HA volume, credentials, rollback assets and unrelated publisher processes.
- [ ] **Confirm RED.** From `app/`: `flutter test test/e2e/config_test.dart test/e2e/discovery_fixture_client_test.dart test/e2e/discovery_fixture_test.dart`. From root run the Python discovery suite. Require expected missing-interface/behavior failures.
- [ ] **Extend shell preparation.** Check locally installed Python/publisher/daemon prerequisites. Generate run ID/token and private config atomically, obtain HA version through the existing authenticated management path, retire only verified old controller ownership, start disabled and wait for authenticated readiness. Write dotenv only after all fixtures are ready. Validate all five port mappings and the device host; never source dotenv as shell code.
- [ ] **Extend shell cleanup.** Withdraw and stop the verified owned controller before Compose stop, including safe handling of already-stopped processes. Missing or ambiguous ownership must fail contextually without terminating foreign processes or deleting persistent fixture data.
- [ ] **Implement Dart helpers and harness wiring.** Prepare discovery before app launch for every scenario/phase, register withdrawal and client close in the correct reverse cleanup order, and retain existing HA journal/proxy/app cleanup. Cold verify's discovery reset must never enable the proxy or reset its persisted seed. Register cleanup before the first remote mutation.
- [ ] **Confirm GREEN.** Run the focused Dart/Python suites plus existing `test/e2e/cold_phase_test.dart` and `scenario_cleanup_test.dart`. From root run `sh -n scripts/setup_test_env.sh scripts/cleanup_test_env.sh`; run setup twice and authenticated state checks, requiring one controller and `enabled=false`. Run the ordinary installed Patrol workflow to verify existing scenarios remain passing.
- [ ] **Commit** as `feat(e2e): wire per-scenario discovery fixture controls`.

### Task 4: Add generated BDD discovery scenarios

**Files:** Create `app/integration_test/server_discovery.feature`, generated `server_discovery_test.dart`, and steps `the_test_home_assistant_is_discoverable_as.dart`, `the_test_home_assistant_is_not_discoverable.dart`, `i_see_the_discovered_home_assistant.dart`, `i_do_not_see_the_discovered_home_assistant.dart`, `i_tap_the_discovered_home_assistant.dart`, `i_refresh_server_discovery.dart`; create `app/integration_test/utils/discovery_assertions.dart` and `app/test/e2e/discovery_assertions_test.dart`.

**Interfaces:**
- Reuse configured-credential authentication, foreground/onboarding and manual-entry steps. Keep `@testMethodName: patrol`, `@testerName: $`, `@testerType: PatrolIntegrationTester`; use a separate `@discovery` line for each scenario.
- New generated step functions receive `PatrolIntegrationTester $` and, for name-bearing steps, `String name` following existing bdd_widget_test conventions. Fixture steps call `TestContext.discoveryFixture`; UI steps inspect the real screen.
- `Finder discoveredFixtureRow({required String name, required Uri url})` matches one `ListTile` containing both exact texts.
- `Future<void> refreshDiscoveryAndWait(PatrolIntegrationTester $, {Duration timeout = const Duration(seconds: 60)})` taps real refresh, observes loading and requires successful completion, failing on `scanError`. The absence step uses completed fresh scans within the same deadline until the owned row disappears.

- [ ] **Write the three feature scenarios from the spec.** Positive discovers/taps/authenticates to home; hidden verifies fixture absence then manually reaches authentication; withdrawal sees the row, disables discovery on the open page and refreshes until it disappears. Enable before app discovery starts. Match name plus the configured proxy URL; never require the entire list to be empty.
- [ ] **Write assertion regressions.** Widget fixtures containing a same-name foreign server at another URL must not match; unrelated servers may remain during absence. Loading or error cannot satisfy absence. A fixture remaining past 60 seconds fails, and delayed disappearance after completed fresh scans passes. Inject short deadlines for tests rather than sleeping for real DNS TTLs.
- [ ] **Generate and confirm RED.** From `app/`, run `dart run build_runner build --delete-conflicting-outputs` to generate the BDD target and missing step stubs. Run `flutter test test/e2e/discovery_assertions_test.dart` and the installed Patrol CLI with its own discovery selection/device options. Missing semantics/assertions must fail; record native failures separately from helper failures. Implement handwritten step files in the next step; never edit generated `_test.dart` directly.
- [ ] **Implement the steps and assertions.** Keep raw HTTP/native publisher details in helpers. Ensure each new scan starts through real refresh and finishes successfully; if DNS cache retains a withdrawn record, repeat completed fresh scans within the single 60-second budget. Fail immediately on discovery errors. Grant the local-network prompt through Patrol only when present.
- [ ] **Confirm GREEN.** Run the assertion unit tests, analyze new helpers/steps, regenerate BDD output and run discovery scenarios through the installed Patrol CLI on iOS Simulator. Require real HA authentication and correct row URL. Inspect generated `_test.dart` to confirm all three scenarios use the common lifecycle wrapper.
- [ ] **Commit** as `test(e2e): cover real home assistant discovery scenarios`.

### Task 5: Verify order independence, recovery and documentation

**Files:** Modify `docs/testing.md`, `docs/developer-guide.md`, `AGENTS.md` and this plan with acceptance evidence; retain generated tests from Task 4.

**Interfaces:** Use existing setup/cleanup shell scripts, installed `patrol test --no-uninstall`, and `scripts/test_cold_start.sh <booted-iOS-Simulator-UDID>`. Do not add a runner, watch/repeat command or duplicate Patrol's selection reference.

- [ ] **Run local checks.** From root run Python discovery tests and shell syntax checks. From `app/`, regenerate code, run `flutter test` and analyze changed files. Require no introduced analysis errors and a passing app suite; document any unrelated pre-existing analyzer failures.
- [ ] **Run real iOS acceptance.** Run positive → hidden and hidden → positive using Patrol's own selection, then withdrawal and two ordinary full-suite runs. Each completed scenario must leave discovery disabled. Record Simulator/OS/Patrol versions, native scenario counts and outcomes, not credential-bearing raw logs.
- [ ] **Verify interruption recovery.** Kill the test app after its advertisement is acknowledged; confirm the next ordinary scenario disables it before launch and still completes successfully. Separately stop/crash the host controller and rerun setup: verify acknowledged ownership reconciliation or a clear bounded failure, never a foreign-process kill. Retest existing cold launch; seed/verify retain distinct processes and verify starts with Toxiproxy off.
- [ ] **Audit preservation.** Confirm no owned advertisement/controller children remain after cleanup, unrelated publishers survive, proxy is restored after ordinary tests, owned HA tokens/areas/journals are reconciled, and baseline HA resources/configuration/volume remain intact.
- [ ] **Verify Linux/Android on a real Linux host.** Run the three BDD cases with Avahi, configured emulator-reachable HTTP endpoints and recorded emulator networking evidence. If the host is unavailable or raw multicast fails, label this acceptance gate pending/blocked with the specific reason; iOS completion does not imply Linux acceptance.
- [ ] **Update operational documentation.** Add the actual Python/native-publisher prerequisites, planned port/configuration now implemented, host controller diagram, semantic BDD examples, disable/reset behavior and hard-kill limitations. Keep Patrol's docs as the CLI reference; record the tested platform matrix and any pending Linux evidence. Do not reintroduce SPM migration troubleshooting or instructions to install a private CLI.
- [ ] **Commit** as `docs(e2e): document discovery fixtures and acceptance evidence` after verifying links, documented paths and commands.

## Acceptance record

At plan creation: no controller/helper/scenario implementation, no native mDNS
acceptance on either platform. Populate this section during execution with Task 1
probe evidence, native scenario results, interruption/cold-launch preservation,
and the Linux/Android gate status. Mark pending gates explicitly; do not convert
them into passing claims or routine skipped scenarios.
