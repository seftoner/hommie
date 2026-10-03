# Local E2E recovery: design

> Revised on 2026-10-02 after user review: the installed Patrol CLI owns ordinary
> test execution, targets/tags, device selection and development. The custom
> `scripts/e2e.dart`, private CLI activation, runner commands, watch/repeat and
> artifact exporter have been removed. Shell setup/cleanup owns persistent
> Docker/Toxiproxy preparation; a narrow cold-start shell flow calls Patrol twice.
> Ownership recovery lives with integration-test helpers in the app sandbox.
> [Current usage and architecture](../../testing.md) supersede the host-runner
> contracts below. The original plan and acceptance evidence remain historical.
> The next planned extension is [per-scenario mDNS discovery](2026-10-03-e2e-server-discovery-design.md),
> with its [implementation plan](../plans/2026-10-03-e2e-server-discovery.md).


Date: 2026-10-02
Status: Design agreed; implementation plan prepared. Implementation has not started.

Implementation plan: [Local E2E recovery](../plans/2026-10-02-local-e2e-recovery.md).

## Intended outcome

Restore trustworthy Patrol tests and a repeatable local workflow with **iOS
Simulator as the primary and default execution target**. Simplify the Home
Assistant fixture infrastructure. Success means real iOS mobile test runs pass
repeatedly and failures leave enough evidence to diagnose them.

Use **Toxiproxy as the single connection-loss mechanism** for offline scenarios.
Do not implement a separate Android native Wi-Fi/cellular fault path. An optional
Android run uses the same proxy and scenario contracts; it is not a prerequisite
for this recovery. Proxy outages verify HA transport loss and recovery, while OS
network-availability notifications are outside this scope.

## Evidence from the current workspace

- Flutter 3.47.5, Dart 3.13.4, Xcode 26.6, Patrol 4.10.0.
- No globally installed Patrol CLI. For diagnosis, CLI 4.8.0 was installed in
  ignored `.dart_tool/e2e-diagnostic/pub-cache`; global settings were unchanged.
- The documented `cd app && patrol test`, using that CLI, exits with:
  `Error: Directory /Users/hurricane/Development/hommie/app/patrol_test doesn't exist`.
  Configure `patrol.test_directory: integration_test` to retain the existing
  feature files, generated tests, and build-runner configuration.
- `dart analyze app/integration_test` reports no issues.
- Existing tests in `test/hass_area_manager_test.dart` and
  `test/ui/screens/widgets/offline_container_test.dart` pass: 14 tests total.
  These are helper/widget checks, not successful mobile E2E runs.
- All installed iOS simulators were shut down during inspection. No mobile
  runtime test or iOS/Android speed comparison was performed in this audit.
- The running `homeassistant-test` container uses Home Assistant 2024.12.5. Its
  image reference is unpinned. The CLI bridge had exited nine months ago; it was
  restarted and a read-only area-registry request succeeded, returning 3 areas.
- The existing `app/.patrol.env` token authenticates against the running HA API.
  The setup marker exists but `docker/hass_init_conf/.env` is missing.
- Auth and preauthenticated test helpers hardcode `http://10.0.2.2:8123`, an
  Android emulator host address. Only the CLI wrapper chooses a host by platform.
- Patrol 4.10.0's installed native implementation routes Wi-Fi, cellular, and
  airplane-mode actions through `runControlCenterAction`. That method explicitly
  throws `Control Center is not available on Simulator` for iOS Simulator.
  Source: `patrol-4.10.0/darwin/patrol/Sources/PatrolImpl/AutomatorServer/Automator/IOSAutomator.swift`,
  lines 373–464 and 1109–1112 in the resolved pub cache.
- The offline banner always exists under `AnimatedAlign`; `heightFactor` hides
  it. The E2E assertion `findsNothing` therefore disagrees with the UI contract.
- The offline-start scenario uses mocked credential and server repositories and
  does not first populate a persistent cache. It cannot prove a real cold launch
  with stored credentials and cached entities.
- The revocation scenario expects an offline banner before server discovery.
  Current session policy hides the banner when no active session remains; this
  transient assertion should not define the revocation contract.
- Setup waits for 30 seconds but checks for a 180-second timeout. It relies on
  files rather than authenticated API readiness. `((elapsed++))` is also unsafe
  under `set -e` on newer Bash versions, although this Mac's Bash 3.2 continued.
- Cleanup deletes the root `.patrol.env` instead of `app/.patrol.env`. Execution
  inspection found no `/config` mount: HA data lives in the container's writable
  layer, while host-side markers have a separate lifecycle. Removing the container
  can erase that data. Named-volume adoption must first preserve this actual layout
  with a private config backup and local rollback image, then verify the copy.
- HA bootstrap imports private HA internals and performs external onboarding
  integration setup. The HA image, Python base image, and `homeassistant-cli`
  installation are unpinned, so rebuilding can change the fixture contract.
  The bridge's direct Python requirements have version pins, but its transitive
  dependency resolution is not locked.

## Fixture-control rationale

The user introduced hass-cli because the application's custom WebSocket client
was incomplete and its reliability was uncertain. The CLI offered a more trusted,
broad administrative interface and avoided maintaining a second long-lived
connection/reconnection implementation in the test harness. This is a deliberate
independent control and verification path, not an accidental infrastructure layer.

Preserve this independence during recovery. E2E fixtures must not use Hommie's
own `home_assistant_client` for administrative mutations or expected-state
verification: a shared protocol defect could affect both the application and the
test's expected result. A future direct-API helper would need an independent,
verified implementation and a concrete benefit before replacing the CLI.

## Required Patrol and BDD migrations

Retain `app/integration_test` as the canonical E2E directory. Patrol 4 changed
its default to `patrol_test` to distinguish Patrol tests from Flutter integration
tests in its IDE tooling; its supported custom-directory setting preserves the
existing structure. No feature or step-directory rename is required.

1. **Configure discovery.** Add `test_directory: integration_test` to the existing
   `patrol` section of `app/pubspec.yaml`, preserving the app name and platform
   identifiers. Retain the default `_test.dart` suffix, which matches the BDD
   generator's output. Ensure test, develop, and build commands use this same
   configuration instead of assuming `patrol_test`.

   ```yaml
   patrol:
     app_name: hommie
     test_directory: integration_test
     # Existing android, ios, and macos configuration stays here.
   ```

2. **Preserve Gherkin generation.** Keep `bdd_widget_test` and build_runner as
   the generation pipeline. `app/build.yaml` must continue to include
   `integration_test/**`, retain `stepFolderName: ../integration_test/step`, and
   set `includeIntegrationTestBinding: false`. Keep the features' existing
   `@testMethodName: patrol`, `@testerName: $`, and
   `@testerType: PatrolIntegrationTester` annotations. The custom `patrol()`
   wrapper must continue forwarding callbacks, tags, skip values, and automator
   configuration to `patrolTest`. Do not introduce a separate Cucumber runtime.

3. **Regenerate before bundling.** Edit `.feature` files and shared step helpers;
   regenerate their `*_test.dart` output with build_runner from `app`. Only then
   let Patrol generate its suite bundle. The runner must perform generation or
   verify generated output is current before executing tests. Keep scenario
   names, hooks, and tags intact unless a scenario contract is intentionally
   changed elsewhere in this design.

   ```text
   .feature → bdd_widget_test/build_runner → *_test.dart
            → Patrol-generated test_bundle.dart → native test execution
   ```

4. **Correct generated-file ownership.** Add the exact
   `app/integration_test/test_bundle.dart` path to the root `.gitignore` and
   remove that bundle from Git tracking while allowing Patrol to recreate it
   locally. The existing root `integration_test/test_bundle.dart` ignore rule
   does not cover this tracked app file. Continue tracking the BDD-generated
   scenario tests according to the repository's existing convention; they are
   distinct from Patrol's disposable suite bundle.

5. **Pin and validate the CLI.** Resolve Patrol CLI 4.8.0 for the existing
   Patrol 4.10.0 package through the local runner. Update documentation and
   editor tasks to use the runner instead of an unspecified global CLI. Verify
   default discovery and explicit target/tag selection against the generated
   BDD tests.

6. **Preserve completed native migrations.** Existing helpers already use
   `$.platform` and `PlatformAutomatorConfig`; maintain those APIs rather than
   reintroducing deprecated `$.native` calls. Preserve the iOS SwiftPM linkage
   and current `PATROL_INTEGRATION_TEST_IOS_RUNNER(RunnerUITests)` runtime runner.
   Keep build-time test discovery disabled for this recovery; it is an optional
   feature with a different native runner contract. Validate the existing runner
   through an actual Patrol build/run, since the earlier Xcode compile check
   alone did not verify mobile test execution.

Importing `integration_test` in a generated file is not itself a migration
failure. The required binding rule is that generated scenarios must not call
`IntegrationTestWidgetsFlutterBinding.ensureInitialized()`; Patrol owns binding
initialization. The existing BDD option already enforces that rule.

## Selected architecture — agreed decision

**Implement the existing HTTP hass-cli bridge plus Toxiproxy, with persistent
Home Assistant services and test-owned data cleanup, targeting iOS Simulator by
default.** This is the selected architecture, not a recommendation awaiting a
choice among alternatives.

The implementation must retain `RemoteHassCli` and the independently implemented
HA administration path, harden argument serialization, timeouts, readiness, error
handling, and cleanup, and add Toxiproxy for every connection-loss scenario.
Gherkin steps use one platform-independent fault helper. Native network toggles
are not part of this implementation.

Reasons for the decision:

1. hass-cli provides an administrative and verification implementation independent
   of the custom WebSocket client under test. The user introduced it deliberately
   when the app client was incomplete and its reliability was uncertain.
2. Gherkin steps need to mutate live HA state during scenarios, including token
   revocation while Hommie's real connection is active. The bridge supports this
   from Dart on the simulator and preserves administrative access for cleanup.
3. Reusing the running backend avoids repeated startup and reauthentication work.
   Each test owns and cleans its mutable data; container reset is explicit.
4. Toxiproxy provides a separately controlled real transport interruption on iOS
   Simulator while HA and the CLI management path remain operational. It also
   exercises Hommie's actual reconnect behavior when the route is restored.
5. One proxy mechanism makes the offline scenarios portable and keeps iOS
   Simulator as the default, without requiring an Android emulator or maintaining
   two different fault implementations.

## Alternatives considered and not selected

- **Independent direct-API fixture helper:** could remove subprocess and CLI-output
  translation, but adds protocol/authentication maintenance and replaces the
  trusted control path. Reusing the app client weakens verification independence.
  Do not implement this replacement during E2E recovery.
- **Fresh preconfigured HA container per scenario:** stronger baseline isolation,
  with additional startup and reauthentication work. This lifecycle can coexist
  with CLI administration, but mid-scenario revocation still needs a live control
  path. Do not recreate the backend per scenario in the routine local workflow.

## Responsibility boundaries

```text
Local runner → Docker Compose lifecycle, readiness, simulator selection, Patrol
Patrol app → TCP fault proxy → real Home Assistant HTTP/WebSocket APIs
Test fixture helper → HTTP CLI bridge → hass-cli → Home Assistant admin API
Test fault helper → proxy control API
```

The app uses its normal connection, session, sync, database, and credential code.
The CLI bridge's HA connection and proxy control API bypass the faulted app route,
so setup and cleanup remain reachable during a simulated HA outage. Device
networking stays enabled; only the application's HA route is interrupted.

Docker lifecycle stays on the Mac. Mobile tests receive URLs and test credentials;
they do not receive the Docker socket or commands for container management.

Home Assistant, the CLI bridge, and the fault proxy remain running across
scenarios and routine local runs. The runner checks and starts missing services;
it does not restart Docker, recreate containers, or reset the HA volume for each
test. Stopping or resetting the fixture is an explicit maintenance operation.

Gherkin step implementations execute fixture setup, verification, and cleanup
from Dart on the simulator/device through the HTTP CLI bridge. hass-cli executes
administrative commands with a management token separate from Hommie's test
session token, connects directly to HA, and remains usable after revocation of
the app's token. Hommie's existing user connection stays alive until HA terminates
it or the app responds to the revocation. Creating/deleting areas or tokens is
an HA API operation and does not require Docker access from the device.

Tests register cleanup as resources are created and delete only their own
resources. Cleanup is idempotent and runs after assertion failures. Since an app
process crash can prevent teardown, the next run reconciles resources carrying
the fixture's test-run namespace before starting scenarios. Proxy restoration and
fixture cleanup are both registered for teardown; a failure in either operation
must not prevent the other cleanup steps or replace the original test failure.

## Backend fixture and configuration

- Extend the existing `docker/docker-compose.yml` project, `homeassistant-test`,
  with Toxiproxy. It is already the dedicated test environment. Reuse this project
  across scenarios and routine runs; do not introduce a second `hommie-e2e` stack
  or require a project rename for this work.
- Use an explicit named test `/config` volume for predictable persistence. When
  adopting it, preserve the current HA data and management credentials; a volume
  change must not silently reset the instance. Full reset remains an explicit
  maintenance operation.
- Initially pin HA 2024.12.5, matching the current working instance. This is a
  recovery baseline, not an endorsement of it as the current HA release. Upgrading
  HA is a separate verified fixture change. Record and pin the CLI version from
  the working bridge image before rebuilding; pin its Python base and transitive
  dependencies, and pin the chosen proxy version too.
- Preserve existing host ports for direct HA (`8123`) and the CLI bridge (`3000`).
  Add app proxy port `18124` and proxy control port `18474`. The runner validates
  availability and accepts explicit overrides.
- Default device host: `127.0.0.1` on iOS Simulator. An optional Android emulator
  override uses `10.0.2.2` with the same proxy and control endpoints. Physical
  devices require an explicit reachable host.
- Centralize `appServerUrl`, `fixtureControlUrl`, and `faultControlUrl`; feature
  scenarios must not embed platform-specific addresses. Configure the bridge's
  internal HA URL separately so it bypasses the app's fault proxy.
- Keep first-run HA provisioning in one pinned bootstrap adapter. Remove optional
  online integrations, wait for authenticated HTTP and WebSocket readiness, and
  verify deterministic areas and `light.kitchen_light` before launching Patrol.
  Any remaining private HA imports must be confined to this adapter.
- Marker presence is never sufficient readiness evidence. Setup must reconcile
  a missing environment file with backend state rather than accepting stale data.
- A normal stop preserves fixture state. An explicit reset removes only this
  test project's volume and generated credentials. No blanket Docker pruning.

The Compose project name scopes the test containers, default network, and named
volumes so lifecycle commands target this environment. The existing
`homeassistant-test` name already supplies that boundary. A second project would
create another stack, with additional data/credential migration and port allocation,
without providing a necessary benefit for this single shared local fixture.
If parallel environments are needed later, their project names, published ports,
and writable bind-mount paths must all be separated; changing only the project
name does not isolate host ports or shared host files.

## Fixture helpers and failure handling

Retain `RemoteHassCli`, `docker/web-server`, and the token/area managers as the
fixture-control path. Keep scenario-facing Dart methods such as create/revoke
token and list/delete area; hide CLI details within the helpers.

Change the bridge request from a command string parsed with `split()` to an
argument array. Pass that array to subprocess execution without a shell; JSON
payloads and names containing spaces must remain single arguments. Give CLI
execution and HTTP requests bounded timeouts, distinguish HTTP/CLI failures from
HA `success: false` responses, and propagate contextual errors without logging
credentials. Blocking subprocess work must not stall the async HTTP server.
Do not add automatic retries for mutations with an uncertain completion state;
reconcile resources through the CLI before retrying.

Identify created tokens/areas by this run rather than deleting the first matching
global name. Validate creation, mutation, and cleanup through CLI-backed reads
independently of the app's cache and WebSocket library. Include bridge readiness
and an authenticated read-only CLI command in runner preflight.

Keep existing BDD features and generate their Dart tests through build_runner.
Treat Patrol's `test_bundle.dart` as generated output instead of a manually
maintained suite list.

Toxiproxy is the selected fault mechanism. Its TCP route carries both HTTP and
WebSocket traffic to HA. Disable that route to terminate existing app connections
and reject reconnects; re-enable it for recovery. Verify established-socket
termination in a fixture smoke check before trusting banner scenarios. Restore
the proxy in test teardown and in the runner's interruption/failure cleanup.

Do not mock `Connectivity`, session state, or the connection to make iOS tests
pass. Proxy outages exercise transport loss while the simulator's OS connectivity
remains available. The same fault helper applies to optional Android runs.

## Fault proxy infrastructure and Gherkin control

Compose runs three persistent services on the same internal network:

| Service | Host endpoint | Internal destination / purpose |
| --- | --- | --- |
| Home Assistant | `8123` for host preflight | `homeassistant:8123`; real backend |
| hass-cli HTTP bridge | `3000` | Bridge port `3000`; CLI goes directly to `homeassistant:8123` |
| Toxiproxy app route | `18124` | TCP listener `0.0.0.0:18124`, upstream `homeassistant:8123` |
| Toxiproxy control API | `18474` | Toxiproxy port `8474`; independent HTTP administration |

Toxiproxy's traffic listener and control API belong to the same service. Disabling
one named traffic route does not stop its container or its control API. The runner
creates or reconciles the `hommie_ha` route before launching scenarios and ensures
it starts enabled. Hommie's configured server URL uses the route's published port,
so both its HA HTTP requests and WebSocket connections traverse that route.

Use a small test-only `FaultProxyClient` based on Dart HTTP, independent of the
application's HA client. No extra custom HTTP wrapper or Docker command is needed:
Toxiproxy already exposes the necessary control API.

- `disconnectFromHa()` sends `POST /proxies/hommie_ha` to `faultControlUrl` with
  `{"enabled": false}`. Check the HTTP response and returned disabled state.
  Disabling the route closes established proxied sockets and stops new connections.
  The running Hommie app must detect the loss through its actual transport code.
- `restoreHaRoute()` sends the same request with `{"enabled": true}`. Check the
  response and enabled state. This makes HA reachable again; Hommie's own reconnect
  logic must establish a new connection. Enabling the route is not evidence that
  the app has already recovered.
- Give control requests bounded timeouts and contextual errors. Register route
  restoration in teardown before applying a fault. Restoration is idempotent,
  and runner preflight reconciles the route after an interrupted prior run.

The BDD flow is:

```gherkin
Scenario: Cached home survives Home Assistant connection loss
  Given the client is connected to Home Assistant
  And the cached kitchen light is visible
  When the client loses connection to Home Assistant
  Then I should see the offline banner
  And the cached kitchen light is visible
  When Home Assistant becomes reachable again
  Then the client reconnects to Home Assistant
  And I should not see the offline banner
```

The loss step awaits `disconnectFromHa()`. Banner/cache assertions then wait for
the application outcome with a bounded deadline. The reachability step awaits
`restoreHaRoute()`; the reconnect assertion observes the application's recovery.
Migrate existing offline features and their step helpers from device Wi-Fi/cellular
actions to these connection-loss/reachability steps, then regenerate the BDD Dart
tests. Do not retain a second native fault implementation or branch by platform
inside these steps. Tests are serialized because they share this named route and
backend.

## Scenarios and isolation

The primary iOS Simulator suite covers real sign-in, sign-out, server-side revocation,
area creation/rename/deletion, server loss/recovery with cached entities, and
cold launch while the server is unreachable. Avoid credential/server repository
mocks in these scenarios; normal storage and session behavior must be exercised.

For cached-offline cold launch, use an explicit two-phase runner flow: launch and
authenticate online, wait for the seeded entity to persist, terminate the app,
disable the app route, then launch a second target preserving the same storage.
Assert the cached entity and visible banner, restore the route, and assert live
recovery. Merely calling `pumpWidget` or foregrounding an app is not a cold launch.
Ordinary tests reset app state independently; the paired cold-start phases preserve
storage intentionally and clean it afterwards. Account for iOS Keychain state
separately from database/app uninstallation when validating isolation.

All loss/recovery and cached offline-start scenarios use Toxiproxy. Restore its
route in teardown and reconcile it before the next run, including after a failed
cold-start phase. Optional Android execution reuses these same scenarios and
helpers; there is no separate Android offline lane.

Banner assertions verify rendered visibility and bounded disappearance, not key
absence. Replace fixed sleeps with bounded polling of UI/backend outcomes.
Revocation verifies removal of the active authenticated session and its stored
credentials. The current router first opens onboarding; completing that existing
flow must lead to discovery. An offline banner is not required on the logged-out
screen. Sign-out uses the current Settings-page action.

## Local workflow

Provide one root-level runner that defaults to iOS Simulator without requiring a
platform argument or an Android emulator. Select a configured available iOS
Simulator deterministically and allow an explicit device override; do not commit
a machine-specific simulator UDID. Include a target or tag filter, repetition,
and a development/watch mode. An optional platform override may use the existing
Android configuration and the same Toxiproxy helper. The runner owns toolchain
checks, pinned Patrol CLI 4.8.0 resolution, backend startup, readiness, fault reset,
generated test freshness, execution, artifact capture, and exit-code propagation.

Update VS Code's test task to invoke that runner with its default iOS target.
Documentation must give a working default iOS command from the repo root and an
equivalent command from any working directory.
Normal development runs reuse the healthy backend and simulator rather than
resetting or rebuilding them unnecessarily. Serialize runs because they share a
fixture and proxy; reject a second run clearly instead of racing mutable state.

Use timestamped ignored run directories for runner/HA/Patrol logs, native test
results, and relevant failure screenshots. Redact tokens and passwords. Configure
whole-run and readiness timeouts so unattended runs return an actionable failure.

The verified Patrol iOS implementation logs native text-entry values inside
`.xcresult` diagnostics even when console test steps are hidden. Keep the original
bundle in the private ignored build/run area, record its exact path, and export
sanitized native diagnostics, issues, and safe failure attachments into shareable
artifacts. Do not copy an untouched credential-bearing bundle into those exports.
This preserves native evidence without pretending that console redaction also
sanitizes Apple's binary result store.

The first repeatability rail is a single local command plus watch/repeat mode.
Scheduled unattended execution should use that same verified runner after its
mobile suite passes; a timing/notification preference is needed before selecting
a schedule. Do not add a schedule that repeatedly runs a broken suite.

## Acceptance checks

1. Default Patrol discovery includes authorization, areas, and offline tests
   from `app/integration_test`. Explicit target/tag selection works with the
   generated BDD tests. Regeneration preserves expected scenario names, hooks,
   and tags; a second generation without source changes produces no further
   changes. Generated scenarios do not initialize Flutter's integration binding,
   and Patrol's suite bundle is ignored and untracked.
2. Setup succeeds with a fresh test volume and with an already-running healthy
   instance. A stale marker or missing environment file produces repair or a
   clear error. A timeout fails nonzero with service diagnostics.
3. CLI-backed token/area operations work against pinned HA and report HTTP, CLI,
   and HA API errors. Names/JSON with spaces survive argument serialization;
   hung commands fail within the configured timeout. Fixture verification does
   not depend on the app's WebSocket library. Revoking the app's token leaves the
   management token usable for verification and cleanup.
4. The iOS proxy cuts an established WebSocket, leaves the CLI bridge's HA access
   and proxy control access alive, and restores connections. An interrupted run
   restores the route.
5. Actual iOS mobile runs pass the scenario contracts above, including persisted
   cache across a true app termination/relaunch.
6. Offline features use one `FaultProxyClient` and the shared named route for
   connection loss and recovery, including cold launch. No native Wi-Fi/cellular
   actions or platform-specific fault branches remain in those steps. The root
   runner and VS Code task default to iOS Simulator and work without an Android
   emulator.
7. Three consecutive routine iOS suite runs pass with independent state. Record
   first-build and warm-run timing; do not claim a speed advantage without data.
8. Helper/widget tests, targeted analysis, and existing auth/session regression
   tests remain green. Regenerating feature tests produces no unexplained changes.
9. The root runner and VS Code task propagate failures and retain useful artifacts.
10. Gherkin steps create and clean up their fixture data from the simulator.
    A failing assertion still triggers cleanup, and a subsequent run can remove
    abandoned resources after a process crash. Routine scenarios/runs reuse the
    running HA/CLI-bridge/proxy services without container or volume recreation.
11. The runner consistently targets the existing `homeassistant-test` Compose
    project. Adding the proxy and adopting named-volume persistence preserves
    existing HA data and credentials. Recovery does not create a second fixture
    stack, rename the existing project, or silently reset its data.

## References

- [Patrol CLI changelog](https://pub.dev/packages/patrol_cli/changelog): changed
  default test directory, current CLI release, and relevant iOS/SPM fixes.
- [Patrol migration guide](https://patrol.leancode.co/native-to-platform-migration):
  retaining `integration_test` through `test_directory` and current platform APIs.
- [Patrol 4.0 announcement](https://leancode.co/blog/patrol-4-0-release): the IDE
  discovery rationale for the new default directory and custom-directory support.
- [bdd_widget_test documentation](https://pub.dev/packages/bdd_widget_test):
  Patrol integration, custom test annotations, and disabling integration binding
  initialization during generation.
- [Patrol compatibility table](https://patrol.leancode.co/documentation/compatibility-table):
  supported package/CLI combinations.
- [Patrol feature parity](https://patrol.leancode.co/documentation/native/feature-parity):
  broad platform support; the installed Swift source establishes Simulator limits.
- [Home Assistant WebSocket API](https://developers.home-assistant.io/docs/api/websocket/):
  authentication, request IDs, and structured success/error responses.
- [Toxiproxy](https://github.com/Shopify/toxiproxy): TCP fault injection controlled
  through a separate HTTP API.
- [Docker Compose project names](https://docs.docker.com/compose/how-tos/project-name/):
  project-scoped environments and explicit project-name selection.
