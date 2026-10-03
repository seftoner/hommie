# Per-scenario Home Assistant discovery: design

Date: 2026-10-03
Status: Revised after user review; simplified implementation planned.

This revision replaces the host HTTP discovery-controller proposal committed in
`ab6cac6`. Use a Dart discovery fixture for regular BDD tests, with a separate
manual real-mDNS smoke check. Implementation has not started.

Implementation plan: [E2E server discovery](../plans/2026-10-03-e2e-server-discovery.md).
[Current testing workflow](../../testing.md) remains authoritative for installed
Patrol, Docker HA, the hass-cli bridge and Toxiproxy.

## Chosen approach

Override `haServersRepositoryProvider` in each scenario's existing Riverpod
container. Return the production `CachedHAServersRepository` wrapping a small
`DiscoveryFixture` that implements `IHAServersRepository`. Keep the production
controller and discovery UI. BDD setup chooses a discovered server or an empty
list before the app is mounted.

The discovered server points to `E2E_APP_SERVER_URL`, so tapping it exercises real
HA OAuth, credentials, persistence and connections through Toxiproxy. The fake
controls discovery results only. This verifies selection and authentication with
controlled discovery input; it does not verify multicast or platform permissions.

## Constraints

- iOS Simulator remains the primary local E2E platform.
- Use installed Patrol and the existing `app/integration_test/` BDD/codegen workflow.
- Override only the discovery repository; authentication, persistence and HA transport remain real.
- Each scenario gets a fresh fixture and container; discovery defaults to an empty list.
- Keep the production discovery controller and `CachedHAServersRepository` behavior.
- Configure discovery before mounting the app; use the existing force refresh for focused cache tests.
- Preserve the persistent Docker HA fixture, hass-cli administration and Toxiproxy faults.
- Add no host controller, Python daemon, discovery HTTP API, dotenv keys or native prerequisites to routine BDD.
- Keep real mDNS verification separate and record its actual platform evidence.

## Fixture and scope

Add one `DiscoveryFixture` under `app/integration_test/utils/` with
`setServers(List<HaServer>)`, `clear()` and
`Future<List<HaServer>> getAvailableServers()`. Copy inputs and return immutable
snapshots so caller mutation cannot alter a scenario. The fixture starts empty.

`TestContext.begin()` creates a fresh fixture and an overridden `ProviderContainer`
then passes it to the existing `E2eAppState(container: ...)`. The foreground step
already mounts `UncontrolledProviderScope` with this same container. Existing
cleanup disposes it; context clearing drops the fixture reference. Retain the
real database/secure-storage reset and HA ownership journal.

The populated BDD step constructs one `HaServer` with name `Hommie E2E`, URI and
`internalUrl` equal to `config.appServerUrl`, UUID `e2e-discovery`, and sample
metadata version `2024.12.5`. The version is intentional fake discovery metadata,
not a claim about the running fixture's version. The hidden step clears the list.
Neither step changes HA, credentials or the fault proxy.

Retain the 15-second production cache. A focused test changes the fake after an
initial fetch and calls the real controller's `forceRefresh()` to verify the new
list is read. Routine scenarios populate/clear before mounting, so they need no
cache wait, controller replacement or new refresh UI. No live-withdrawal native
BDD scenario is required in this revision.

## BDD coverage

Extend `authorization.feature` rather than creating a parallel sign-in feature:

1. **Sign in through a discovered server:** configure the fake server before
   launch, complete onboarding, see the row with exact name and proxy URL, tap it,
   reach the real HA credentials form, sign in and reach home.
2. **Enter address manually and sign in:** retain the existing scenario, explicitly
   configure no discovery results, wait for the existing `No servers found.`
   successful empty state, and continue through manual entry and real sign-in.

Name-only matching is insufficient; a same-name row with another URI must not
satisfy the positive assertion or be tapped. The empty-state assertion must fail
on loading, populated results or `Error discovering servers.`. Give asynchronous
UI assertions a 20-second deadline and use pumping rather than fixed sleeps.
Test both execution orders and retain the existing sign-out, revocation, offline,
area and cold-launch coverage.

## Separate real discovery check

A manual smoke check starts a native publisher on the host, launches the ordinary
production app without the test override, verifies the exact published name and
proxy URL, and taps through to real HA authentication. Stop that publisher after
the check. Use `dns-sd` on macOS and Avahi on Linux when testing those platforms.
Record multicast receipt and HTTP reachability separately. This does not need
per-scenario host control or a new test runner.

This check is useful when changing discovery code, network dependencies or
platform permissions; it is not a prerequisite for the controlled BDD cases.
Do not describe iOS or Linux/Android mDNS as verified until the corresponding
real-app check runs. The installed `multicast_dns` 0.3.3+1 already adds the local
domain to the current short service query; no query rename is prescribed here.

## Existing test audit

The current tree has no mocked-discovered-server selection BDD case. The existing
manual-entry scenario visits discovery but then enters the address itself.
Searches of locally available Git history and the original sign-in feature found:

- `TestProviderOverrides` existed and was removed in `07f840b` during E2E isolation.
- Old `i_have_successfully_logged_in.dart` mocked credentials/settings/server
  manager; it did not supply discovery results or select a discovered row.
- A historical `ha_servers_repository_test.dart` accepted either a list or an
  exception, so it did not prove a server was discovered; it was removed in
  `5eee785`.

Reuse the current per-scenario container and authentication steps. Do not restore
that shared override singleton or the old authentication/persistence mocks.
