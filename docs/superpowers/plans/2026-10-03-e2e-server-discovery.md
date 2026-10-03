# E2E Server Discovery Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Cover discovered-server selection and manual entry with controlled discovery data while keeping real HA authentication.

**Architecture:** A fresh Dart fixture supplies discovery results through a repository override in each scenario's existing Riverpod container. Keep the production cached repository, controller and UI, and connect to real Docker HA through Toxiproxy. Real mDNS has a separate manual smoke check.

**Tech Stack:** Existing Flutter/Dart, Riverpod, Patrol, bdd_widget_test/build_runner and Docker HA/hass-cli/Toxiproxy; no new dependencies.

**Spec:** [Per-scenario Home Assistant discovery](../specs/2026-10-03-e2e-server-discovery-design.md).

> Revised after user review: supersedes the host-controller plan in `ab6cac6`.
> Implement the tasks below in the existing `codex/local-e2e-recovery` branch.

## Global Constraints

- iOS Simulator remains the primary local E2E platform.
- Use installed Patrol and the existing `app/integration_test/` BDD/codegen workflow.
- Override only the discovery repository; authentication, persistence and HA transport remain real.
- Each scenario gets a fresh fixture and container; discovery defaults to an empty list.
- Keep the production discovery controller and `CachedHAServersRepository` behavior.
- Configure discovery before mounting the app; use the existing force refresh for focused cache tests.
- Preserve the persistent Docker HA fixture, hass-cli administration and Toxiproxy faults.
- Add no host controller, Python daemon, discovery HTTP API, dotenv keys or native prerequisites to routine BDD.
- Keep real mDNS verification separate and record its actual platform evidence.

## Review Focus

- Populated results leak into the next scenario: fresh fixture/container starts empty; Task 1 isolation test and Task 3 order acceptance.
- Loading/error is mistaken for no servers: absence requires successful empty-state UI; Task 2 assertion regressions.
- Another server shares the fixture name: match the exact name and configured proxy URL; Task 2 row/tap regressions.
- A caller mutates fixture input or cache hides changed results: immutable snapshots and real force refresh; Task 1 fixture/cache tests.
- A broad override accidentally bypasses OAuth, persistence or offline faults: discovery-only scope and real HA flow remain required; Tasks 1 and 3 persistence/cold checks.

---

## File map

| Files | Responsibility |
| --- | --- |
| `app/integration_test/utils/discovery_fixture.dart` | Small `IHAServersRepository` fake with copied immutable results. |
| `app/integration_test/utils/test_context.dart` | Fresh fixture and discovery-only provider override per scenario. |
| `app/test/e2e/discovery_fixture_test.dart`, `app/test/e2e/app_state_test.dart` | Fixture/cache isolation and preserved real persistence. |
| `app/integration_test/authorization.feature`, generated `authorization_test.dart` | Add discovered sign-in; strengthen existing manual-entry scenario. |
| `app/integration_test/step/a_home_assistant_server_is_discoverable_as.dart`, `no_home_assistant_servers_are_discoverable.dart`, `i_see_the_discovered_home_assistant.dart`, `i_tap_the_discovered_home_assistant.dart`, `i_see_no_discovered_home_assistant_servers.dart` | Five semantic fixture/row/empty-state steps. |
| `app/integration_test/utils/discovery_assertions.dart`, `app/test/e2e/discovery_assertions_test.dart` | Exact row selection and successful empty-state assertions. |
| `docs/testing.md`, this plan | Coverage boundary, native smoke instructions and actual acceptance evidence. |

No production discovery/UI refactor is planned. Existing `E2eAppState`, foreground
step, common cleanup and Docker scripts already provide the required lifecycle.
The audit in the spec found no existing discovered-server selection case to reuse;
reuse the manual-entry and configured-credential steps instead.

### Task 1: Add an isolated Dart discovery fixture

**Files:** Create `discovery_fixture.dart` and `discovery_fixture_test.dart` at the paths above; modify `test_context.dart` and extend `app_state_test.dart`.

**Interfaces:**
- `DiscoveryFixture implements IHAServersRepository` with `void setServers(List<HaServer> servers)`, `void clear()` and `Future<List<HaServer>> getAvailableServers()`.
- `TestContext.discoveryFixture` exposes the active scenario fixture.
- Preserve `TestContext.begin(String scenarioId)`; add optional `E2eTestConfig? config` only as a test seam: `begin(String scenarioId, {E2eTestConfig? config})`.
- Each begin creates `CachedHAServersRepository(baseRepository: fixture)` through `haServersRepositoryProvider.overrideWith(...)` in a fresh `ProviderContainer`, retaining `retry: (_, _) => null`, then passes it to `E2eAppState(container: ...)`.

- [ ] **Write failing tests.** `starts_empty` expects `[]`; `returns_immutable_copied_results` changes the input list after setup and verifies the stored server survives and returned lists cannot be mutated. `new_scenario_does_not_inherit_results` begins two scenarios with supplied config and expects the second repository to return `[]`. `force_refresh_reads_changed_fixture` listens to the real discovery controller, loads one server, clears the fake, calls `forceRefresh()` and expects successful empty data without a 15-second wait. Extend the in-memory DB/secure-storage app-state test to use this discovery override while verifying real session persistence/reset still works.
- [ ] **Confirm RED.** From `app/`: `flutter test test/e2e/discovery_fixture_test.dart test/e2e/app_state_test.dart`. Require missing-fixture/interface or behavior failures.
- [ ] **Implement the fixture and scope.** Copy lists on set/read. Allocate one fixture and cached wrapper per scenario; expose it through context, configure the provider before mounting, and drop its reference on clear. Let existing app-state cleanup dispose the container; unit tests dispose their test containers and injected DB explicitly. Keep credentials, server manager and networking providers real.
- [ ] **Confirm GREEN.** Repeat the two test files. Check the cache-refresh test uses the real controller/cache wrapper, retains a provider subscription while awaiting, and disposes it afterward; no timer waits or notifier mock.
- [ ] **Commit** as `test(e2e): isolate discovery results per scenario`.

### Task 2: Cover discovered and manual sign-in in existing BDD

**Files:** Modify `authorization.feature`; generate `authorization_test.dart`; create the five step files, `discovery_assertions.dart` and its test from the file map.

**Interfaces:**
- `aHomeAssistantServerIsDiscoverableAs(PatrolIntegrationTester $, String name)` populates the fixture with URI/internal URL from `config.appServerUrl`, UUID `e2e-discovery` and fake version `2024.12.5`.
- `noHomeAssistantServersAreDiscoverable(PatrolIntegrationTester $)` clears it before mounting.
- Name-bearing assertion/tap steps take `(PatrolIntegrationTester $, String name)`; the empty-state step takes only `$`.
- `Finder discoveredServerRow({required String name, required Uri url})` matches one `ListTile` containing both exact texts.
- `Future<void> waitForNoDiscoveredServers(WidgetTester tester, {Duration timeout = const Duration(seconds: 20)})` requires visible `No servers found.` and no server rows; loading/error do not pass. Row steps also use the 20-second deadline and existing Patrol pumping conventions.

- [ ] **Write BDD scenarios.** Add `Sign in through a discovered server`: configure `Hommie E2E`, launch/complete onboarding, see its exact row, tap, enter real configured credentials and reach `K.home.page`. Strengthen existing manual sign-in with an explicit empty-discovery Given before foreground launch and successful empty-state Then before manual entry. Preserve existing tags/steps and add a separate `@discovery` tag to each of these two cases.
- [ ] **Write assertion regressions.** A same-name row at another URL does not match or get selected; the matching row's callback receives the configured URL. Empty success passes, loading/error/populated states do not, and delayed empty success is awaited. Use short injected deadlines for negative unit tests.
- [ ] **Generate and confirm RED.** From `app/`, run `dart run build_runner build --delete-conflicting-outputs`; retain generated step stubs until tests prove missing behavior. Run `flutter test test/e2e/discovery_assertions_test.dart`; missing helpers/stub semantics must fail. Never edit generated `_test.dart` by hand.
- [ ] **Implement steps and helpers.** Keep fixture changes before app mounting. Reuse existing onboarding, HA web-form, configured credentials and login steps. Match row name plus proxy URL; wait for successful empty UI rather than merely a missing row. Do not add a refresh toolbar, native publisher or controller override.
- [ ] **Confirm GREEN.** Run assertion tests, regenerate code and analyze changed integration helpers/steps. Run the two scenarios on iOS Simulator through installed Patrol using its own selection/device options; require real HA authentication and home in both. Inspect generated output to verify both use the common `patrol` lifecycle.
- [ ] **Commit** as `test(e2e): cover discovered server sign-in`.

### Task 3: Verify existing coverage and document the boundary

**Files:** Modify `docs/testing.md` and this plan with results. Update general guides only if an existing documented requirement actually changes.

**Interfaces:** Keep installed `patrol test --no-uninstall`, existing setup/cleanup scripts and `scripts/test_cold_start.sh <booted-iOS-Simulator-UDID>`; add no runner or environment contract.

- [ ] **Run checks.** From `app/`, regenerate code, run `flutter test` and analyze changed files. Require no introduced issues; record unrelated pre-existing analyzer failures separately.
- [ ] **Run native regression acceptance.** Exercise discovered → manual and manual → discovered, then the ordinary full suite on iOS. Run existing cold-launch acceptance and audit HA owned-token/area cleanup, persisted-state cleanup and proxy restoration. Only controlled discovery results may differ; real auth/DB/connection behavior must still pass.
- [ ] **Document implemented coverage.** Update `docs/testing.md` with the discovery-only override, default empty fixture, two semantic BDD cases and the fact that mDNS/permissions/TXT parsing are outside their coverage. Retain Patrol as the CLI reference and existing local prerequisites.
- [ ] **Document a separate manual real-mDNS smoke check.** Start one host `dns-sd`/Avahi advertisement with the proxy URL, launch the production app without the test override, inspect the exact discovered row, tap to HA authentication and stop the owned publisher. Record actual platform/tool evidence when run; mark unrun lanes pending. This check adds no routine BDD dependency or completion gate for mocked-discovery acceptance.
- [ ] **Commit** as `docs(e2e): document controlled discovery coverage` after verifying paths, local links and working-directory instructions.

## Acceptance record

At revision: documentation only; controlled-discovery implementation and native
BDD acceptance are pending. Current/reachable Git history was searched for prior
mocked-discovery coverage; the related historical helpers/test are recorded in
the spec. Populate this section with actual BDD/regression results during execution.
Real iOS and Linux/Android mDNS smoke checks remain separately unverified.
