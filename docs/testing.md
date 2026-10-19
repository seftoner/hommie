# End-to-end testing

Install Flutter/Dart, Xcode with an iPhone Simulator runtime, Docker Desktop,
[Patrol CLI](https://pub.dev/packages/patrol_cli), and `jq` locally. The verified
baseline is Flutter 3.47+, Dart 3.13+, Patrol CLI 4.8.0 and Patrol 4.10.0. Run
`patrol doctor` to check the native toolchain. The repository does not install,
activate, or resolve a separate CLI copy.

Prepare the persistent fixture from the repository root:

```sh
./scripts/setup_test_env.sh
```

Then run the installed CLI from `app/`, selecting an iPhone Simulator through
Patrol's device option or prompt:

```sh
cd app
patrol test --no-uninstall
```

Patrol reads the generated, ignored `app/.patrol.env` automatically. Keep
`--no-uninstall` so a subsequent test can recover an interrupted scenario's
ownership journal from the app sandbox. Scenarios explicitly clear actual
SQLite/Keychain state; uninstall is not the cleanup mechanism.

Use Patrol's own commands, target/tag filters, device selection and development
workflow. See [Patrol documentation](https://patrol.leancode.co/documentation).
There is no repository test-runner CLI, custom watch command, or private pub
cache. The VS Code `patrol: run tests` task also calls `patrol` directly.

BDD source remains in `app/integration_test/` with handwritten steps and helpers.
Generate tests using build_runner from `app/`; commit the generated `_test.dart`
files. Write each Gherkin tag on its own line. Patrol's runtime runner discovers
tests; cold phases are skipped in ordinary runs.
iOS is the primary local platform; Android can use the same proxy/bridge
with emulator-reachable endpoints in `.patrol.env`.

## Controlled discovery

Each BDD scenario has a fresh `DiscoveryFixture` and Riverpod container.
`haServersRepositoryProvider` wraps that fixture in the production
`CachedHAServersRepository`; discovery defaults to an empty list. The production
controller and screen still run. The discovered fixture's address is
`E2E_APP_SERVER_URL`, so selection leads to real HA OAuth, credential storage,
SQLite persistence and connections through Toxiproxy.

Configure the result before the foreground step mounts the app:

```gherkin
Given a home assistant server is discoverable as {'Hommie E2E'}
And the application is running in the foreground
```

For manual entry:

```gherkin
Given no home assistant servers are discoverable
And the application is running in the foreground
```

`authorization.feature` covers sign-in through the discovered row and the
existing manual-entry flow. Row assertions match both name and proxy URL.
Selection uses the reusable `When I tap on {'Hommie E2E'}` step, which taps a
unique visible text label and fails on ambiguous labels.
The no-server assertion waits for the successful `No servers found.` state;
loading and errors cannot satisfy it. Fixture and cache state end with the
scenario container. The production cache is retained; focused tests use the
real controller's force refresh to read changed fixture results.

On iOS, the credential step uses HA's `Show password` control before typing the
configured password, avoiding XCTest's intermittent secure-field focus failure
during repeated sign-ins. It continues through real OAuth.

These cases control discovery input. They do not verify mDNS packets, TXT
parsing, multicast reachability or platform permissions. There are no additional
host services, ports, dotenv keys or publisher prerequisites for routine BDD.

### Separate real mDNS smoke check

When changing discovery networking or platform permissions, prepare the existing
fixture and register one `_home-assistant._tcp` service in the `local.` domain
using the host's `dns-sd` on macOS or `avahi-publish-service` on Linux. Supply
`location_name`, `uuid`, a valid `version`, and `internal_url` pointing to the
device-reachable Toxiproxy URL, including its mapped port.

Launch the ordinary production app with `flutter run` from `app/`, without the
BDD discovery override. Verify that the exact published name and proxy URL
appear, tap the row and reach the real HA authentication form. Stop the owned
publisher afterward. This is a separate manual check; no per-scenario publisher
controller or runner is needed.

Record the tested host, device/emulator/runtime and publisher versions, actual
app discovery and HTTP reachability separately. Native mDNS on iOS and
Linux/Android remains unverified by the controlled-discovery BDD tests.

## Persistent fixture

The shell setup starts only missing services in `homeassistant-test`, checks HA
management authentication and bridge health, ensures the fixture areas and
`light.kitchen_light`, and reconciles the `hommie_ha` Toxiproxy route. It writes
credentials/endpoints/run ID to owner-only `.patrol.env`. `curl`, `jq`, Docker
Compose and the already-installed Patrol are the only host tools it uses.

HA `/config` remains in `homeassistant-test_ha_config`. Original areas, management
credentials and container state survive ordinary repeated runs. If an old
container has not been migrated to this volume, setup fails without replacing
it. The completed migration's private config backup, rollback image and
`.dart_tool/e2e/volume-migration.json` remain available; automatic migration/reset
commands were removed with the custom runner.

```mermaid
flowchart LR
  Shell[Shell setup] --> Docker[Persistent Compose fixture]
  Patrol[Installed Patrol CLI] --> Test[Dart Gherkin scenarios]
  Test --> Bridge[HTTP hass-cli bridge]
  Bridge --> HA[Home Assistant]
  Test --> Control[Toxiproxy control API]
  App[App HA connection] --> Proxy[Toxiproxy data route]
  Proxy --> HA
```

The simulator never invokes Docker. Semantic loss/recovery steps disable/enable
the proxy route. The independent hass-cli bridge reaches HA directly, so token
revocation, fixture verification and cleanup stay usable during app outages.
This models losing reachability to HA; no native Wi-Fi/cellular toggle is used.

Each scenario shares one CLI client and one proxy client, closed by the common
wrapper. The ownership journal handles token/area cleanup once, including after
an interrupted run; area steps use the CLI only for independent reads.
Cleanup failures report reasons with configured credentials redacted and retain
the original assertion or cleanup stack.

Scenario teardown restores the proxy, removes exact owned tokens/areas and
clears actual SQLite/Keychain data. A small journal in the app's support directory
records baseline ownership before mutations. If native execution is interrupted,
the next ordinary run restores the route and reconciles pending journals before
starting a scenario. Ambiguous OAuth ownership fails with the journal retained.
Run scenarios sequentially against this shared fixture.

Stop services without deleting the volume or credentials:

```sh
./scripts/cleanup_test_env.sh
```

Ports default to 8123 (HA), 3000 (bridge), 18124 (app proxy), 18474 (proxy control).
`E2E_HA_PORT`, `E2E_BRIDGE_PORT`, `E2E_PROXY_PORT`, `E2E_CONTROL_PORT` can override
host mappings; each must be distinct. Stop services before changing mappings.

Fixture YAML merges preserve helpers/lights and unrelated `!include` tags.
Duplicate keys, fixture-name collisions and includes directly under
`input_boolean` or `light` fail before writing. First-time serialization removes
comments; retain the original configuration backup.

## Cold launch

A real cold launch needs host actions between two app processes. The narrow
`scripts/test_cold_start.sh` script calls the installed Patrol twice, preserving
the app, terminating seed, disabling the proxy before verify, and checking the
same run's checkpoint with different process IDs. Pass an already booted iPhone
Simulator UDID as its sole argument. There are no alternate target/device/filter
options. Checkpoint evidence is under ignored `.dart_tool/cold-start/`.

Verify reads persisted SQLite/Keychain without login or reseeding, restores the
connection and cleans up the owned seed session. Shell exit traps restore the
route on failure/interruption. Pending journal recovery occurs on the next
ordinary Patrol run if a process was killed before teardown.

## Diagnostics

Use Patrol's console output and native result paths. The custom artifact
exporter has been removed. Original `.xcresult` diagnostics can contain typed
credentials and must remain private. Flutter failure images remain inside the
simulator app support directory. Inspect and redact evidence before sharing it.

The original recovery baseline passed three complete iOS suites (21 native
executions). Those historical results are recorded in the recovery plan. Current
verification after simplification is recorded separately there. No schedule or
native E2E CI lane is installed.
