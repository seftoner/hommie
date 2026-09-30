# Flutter 3.47 package upgrade audit

Date: 2026-09-30
Branch: `chore/upgrade-flutter-and-packages`
Status: In progress; update with source, native build, and test results before integration.

## Resolution baseline

- Installed SDK: Flutter 3.47.5, Dart 3.13.4 (`flutter --version`). Root and app now require Dart `>=3.13.0 <4.0.0` and Flutter `^3.47.0`.
- The root lockfile initially changed 102 package entries versus the branch's original lockfile (96 updated, 6 added). `flutter pub get` succeeds. `flutter pub outdated` reports all direct dependencies current and all locked packages at the newest **resolvable** versions.
- `flutter pub outdated` still lists newer incompatible releases for `freezed`, `test`, 7 runtime transitive packages and 8 dev transitive packages. No dependency override is planned merely to force those versions; recheck after the standalone UI and grid extraction change the graph.
- CI and release workflows were pinned to Flutter 3.44.3; both move to 3.47.5. The separate release Dart 3.12.2 setup is removed so release commands use the Dart bundled with Flutter 3.47.5.

## App-facing and platform changes

| Package | Resolved change | Finding and required action |
| --- | --- | --- |
| `go_router` | 17.3.0 → 18.0.2 | 18.0 migrates to standalone `material_ui`/`cupertino_ui`. Hommie's root `MaterialApp` must use the same standalone type; check route redirects and page presentation. |
| `permission_handler` | 12.0.3 → 13.0.2 | 13.0 raises Android compile SDK to 37. 13.0.2 also changes guidance for permanent denial: inspect onboarding's use of `status` versus `request()` and check actual permission flows. |
| `flutter_secure_storage` | 10.3.1 → 11.2.0 | 11 removes deprecated Android cipher and shared-preferences options, requires Android API 24 minimum and compile SDK 37. Hommie uses default options. The user confirmed no released installs need old-data migration. Fix the existing unawaited delete/write race and check credential replacement. |
| `workmanager` | 0.9.0+3 → 0.10.10 | 0.10 raises the Flutter minimum to 3.38. Existing `initialize`, `registerPeriodicTask`, and dispatcher APIs remain; inspect Apple and Android native registration and scheduling after SPM conversion. |
| `freezed` | 3.2.6-dev.1 → 4.0.1 | 4.0 removes support for `final` in constructor parameters under Dart 3.13. No such constructor syntax was found in app-owned Freezed declarations; regenerate and review output. |
| `drift` / `drift_dev` | 2.34.x → 2.35.0 | The documented breaking API is a web `MessagePort` extension not used here. Regenerate Drift code and check database compilation. |
| Riverpod runtime and generator | 3.3.2/4.0.4 → 3.4.3/4.0.9 | Runtime 3.4 deprecates `SyncProviderTransformerMixin`, which app code does not use. Regenerate providers and check analyzer output. |
| `go_router_builder` | 4.3.1 → 4.5.0 | Regenerate typed routes and review changed output against the existing route classes. |
| `patrol` | 4.7.0-dev.3 → 4.10.0 | 4.10 adds optional static discovery; retain runtime `PATROL_INTEGRATION_TEST_IOS_RUNNER(RunnerUITests)`. Link its Swift package to the iOS UI-test target; macOS SPM support was fixed in 4.9. |
| `flutter_staggered_grid_view` | Remains 0.7.0 until extraction | Last published release is old; `drag_arrange` uses only its staggered-grid widget, tile, and renderer. Move those files locally with MIT attribution, then remove the dependency. |

## Remaining resolved changes

The rest of the initial lockfile changes are federated plugin implementations and platform interfaces (`connectivity_plus`, secure storage, permission handler, share, shared preferences, URL launcher, Workmanager); Flutter UI libraries (`material_ui`, `cupertino_ui`, `material_symbols_icons`); code-generation/analyzer tooling (`analyzer`, `build_runner`, `source_gen`, `json_serializable`, Mockito and related packages); and Dart/native utilities (`sqlite3`, `sqlparser`, `vector_math`, `xml`, `uuid`, `win32`, `objective_c`, `jni` and related packages). Their app-facing risk is covered by the specific source, generated-code and platform checks above; no additional app API migration has been identified from the changed packages. Recheck plugin Swift package manifests and final lockfile after native builds.

`freezed` 4.0.2, `test` 1.32.0, `cross_file` 0.4.0, `dbus` 0.8.0, `material_color_utilities` 0.13.1, `nm` 0.6.0, `package_config` 3.0.0, `test_api` 0.7.14, `window_to_front` 1.0.0, and newer analyzer/build transitive packages are outside the currently resolvable graph. Keep them at the resolver's version unless a dependent package gains support during this migration.

## Implementation verification

Initial `cd app && flutter analyze --no-pub` exited 1 with 21 `extraneous_modifier` errors in old `*.freezed.dart` output generated before Dart 3.13 / Freezed 4. Regeneration removed those errors. It also updated typed-route generated calls with `hasOverriddenOnExit: false` and refreshed Drift/Riverpod output; no app-owned route or database declaration changed. The new build_runner ignores the removed `--delete-conflicting-outputs` option, so subsequent runs omit it.

After regeneration, `cd app && flutter analyze --no-pub` reported zero errors and seven warnings. The deprecated lint rule and six warning sites were corrected so the same command now reports `No issues found!`. `cd packages/home_assistant_client && flutter analyze --no-pub` also reports no issues. App tests before the warning cleanup: 233 passed, 2 debug-only tests skipped; rerun after the cleanup before the task is complete. Client tests: 51 passed. The new secure-storage test failed against the old implementation because `write` ran before `delete` completed, then passed after `save` awaited delete and wrote before caching.

Workmanager's resolved Apple Swift package exposes module `workmanager_apple` and `WorkmanagerPlugin.registerPeriodicTask(withIdentifier:earliestBeginInSeconds:)`. Hommie's `AppDelegate.swift` still imports the old `workmanager` module and calls the deprecated `frequency:` overload; update both during iOS SPM integration. The Dart task identifier matches the iOS `Info.plist` and AppDelegate registration string. A Dart test that only repeats those string literals would not exercise scheduling; the native build and a device/simulator scheduling check are the relevant verification.

Pending: standalone UI tests/analyzer, Android API 37 build and permission flow, iOS/macOS SPM builds without Pods, RunnerUITests build-for-testing, native background scheduling, and any available Patrol run. Record exact commands and results here as tasks finish.

## Sources

- Package changelogs from the resolved pub cache: `go_router`, `permission_handler`, `flutter_secure_storage`, `workmanager`, `freezed`, `drift`, `riverpod`, and `patrol`.
- [Flutter standalone UI migration](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)
- [Flutter SPM app migration](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers)
- [Patrol changelog](https://pub.dev/packages/patrol/changelog)
