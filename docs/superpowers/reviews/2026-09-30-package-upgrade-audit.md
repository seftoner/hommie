# Flutter 3.47 package upgrade audit

Date: 2026-09-30–2026-10-01
Branch: `chore/upgrade-flutter-and-packages`
Status: Native migration verified; device behavior and Patrol runtime checks remain.

## Resolution baseline

- Installed SDK: Flutter 3.47.5, Dart 3.13.4 (`flutter --version`). Root and app now require Dart `>=3.13.0 <4.0.0` and Flutter `^3.47.0`.
- The root lockfile initially changed 102 package entries versus the branch's original lockfile (96 updated, 6 added). Final `flutter pub get` and `flutter pub upgrade` succeed. On 2026-10-01, newly available `drift`/`drift_dev` 2.35.1, `jni` 1.1.0, `jni_flutter` 1.0.4, `objective_c` 9.6.2, and `cli_util` 0.6.0 were resolved. Final `flutter pub outdated` reports every direct dependency current and every locked package at its newest **resolvable** version.
- The remaining 16 newer versions are outside the compatible graph: `freezed`, `test`, `cross_file`, `dbus`, `material_color_utilities`, `nm`, `package_config`, `test_api`, `window_to_front`, `_fe_analyzer_shared`, `analysis_server_plugin`, `analyzer`, `analyzer_plugin`, `equatable`, `source_gen`, and `test_core`. No override is used to force mutually incompatible versions.
- CI and release workflows were pinned to Flutter 3.44.3; both move to 3.47.5. The separate release Dart 3.12.2 setup is removed so release commands use the Dart bundled with Flutter 3.47.5.

## App-facing and platform changes

| Package | Resolved change | Finding and required action |
| --- | --- | --- |
| `go_router` | 17.3.0 → 18.0.2 | 18.0 uses standalone `material_ui`/`cupertino_ui`. Hommie's root, routes, theme, and owned widgets now use standalone design types; a compatibility bridge supplies legacy third-party widgets. A widget test covers route navigation under the standalone root and `OfflineContainer`. |
| `permission_handler` | 12.0.3 → 13.0.2 | 13.0 raises Android compile SDK to 37. Hommie checks `Permission.backgroundRefresh.status` in background registration and its debug page; onboarding does not call `request()` or rely on the changed permanent-denial result. Android compile succeeds with SDK 37.0. Runtime permission flow remains a device check. |
| `flutter_secure_storage` | 10.3.1 → 11.2.0 | 11 removes deprecated Android cipher and shared-preferences options, requires Android API 24 minimum and compile SDK 37. Hommie uses default options. The user confirmed no released installs need old-data migration. Credential replacement now awaits deletion before writing and caching, covered by a unit test. |
| `workmanager` | 0.9.0+3 → 0.10.10 | 0.10 raises the Flutter minimum to 3.38. Dart task identifiers and entry point remain; the iOS delegate imports `workmanager_apple` and uses `earliestBeginInSeconds:`. iOS and Android builds compile; actual scheduling still needs a device run. |
| `freezed` | 3.2.6-dev.1 → 4.0.1 | 4.0 removes support for `final` in constructor parameters under Dart 3.13. No such constructor syntax was found in app-owned Freezed declarations; regenerated output compiles and passes analysis. |
| `drift` / `drift_dev` | 2.34.x → 2.35.1 | The documented breaking API is a web `MessagePort` extension not used here. Regeneration under 2.35.1 made no tracked semantic changes; app database tests pass. Web support will be handled in a separate plan. |
| Riverpod runtime and generator | 3.3.2/4.0.4 → 3.4.3/4.0.9 | Runtime 3.4 deprecates `SyncProviderTransformerMixin`, which app code does not use. Regenerated providers pass analysis and tests. |
| `go_router_builder` | 4.3.1 → 4.5.0 | Regenerated typed routes add `hasOverriddenOnExit: false`; navigation tests pass. |
| `patrol` | 4.7.0-dev.3 → 4.10.0 | Kept runtime `PATROL_INTEGRATION_TEST_IOS_RUNNER(RunnerUITests)` and linked the generated Swift package to the UI-test target. Added guarded defaults for Patrol's `CLEAR_PERMISSIONS`/`FULL_ISOLATION` macros so plain Xcode test builds compile while CLI overrides remain possible. `build-for-testing` passes. |
| `flutter_staggered_grid_view` | 0.7.0 → removed | Incorporated only the grid widget, tile, and renderer used by `drag_arrange` locally with MIT attribution. Layout, RTL, and drag-order widget tests pass. |
| `material_ui` / `cupertino_ui` | 1.5.0 / 1.1.1 | The app uses standalone imports and a legacy bridge. Route, theme, and widget checks pass. |

## Remaining resolved changes

The other lockfile changes are federated plugin implementations and platform interfaces (`connectivity_plus`, secure storage, permission handler, share, shared preferences, URL launcher, Workmanager); Flutter UI libraries (`material_ui`, `cupertino_ui`, `material_symbols_icons`); code-generation/analyzer tooling (`analyzer`, `build_runner`, `source_gen`, `json_serializable`, Mockito and related packages); and Dart/native utilities (`sqlite3`, `sqlparser`, `vector_math`, `xml`, `uuid`, `win32`, `objective_c`, `jni` and related packages). No further app API migration emerged from source review, generated output, analysis, tests, or native compilation.

The 16 versions listed above remain outside the resolver's compatible graph. The branch keeps the resolver's versions instead of applying overrides. The removed `flutter_staggered_grid_view` has no lockfile or local package reference.

## Implementation verification

Initial `cd app && flutter analyze --no-pub` exited 1 with 21 `extraneous_modifier` errors in old `*.freezed.dart` output generated before Dart 3.13 / Freezed 4. Regeneration removed those errors. It also updated typed-route generated calls with `hasOverriddenOnExit: false` and refreshed Drift/Riverpod output; no app-owned route or database declaration changed. The new build_runner ignores the removed `--delete-conflicting-outputs` option, so subsequent runs omit it.

After regeneration, `cd app && flutter analyze --no-pub` reported zero errors and seven warnings. The deprecated lint rule and six warning sites were corrected. On the final 2.35.1 dependency graph, all four packages report `No issues found!` from `flutter analyze --no-pub`. Their `flutter test --no-pub` runs pass: app 234 passed and 2 debug-only tests skipped; `drag_arrange` 4 passed; `home_assistant_client` 51 passed; `computer` 19 passed. The new secure-storage test failed against the old implementation because `write` ran before `delete` completed, then passed after `save` awaited delete and wrote before caching.

The Android API 37 debug APK, macOS Release app, and iOS simulator Runner all build after the final lockfile resolution (`cd app && flutter build apk --debug --no-pub`; `cd app && flutter build macos --no-pub`; `cd app && flutter build ios --simulator --no-codesign --no-pub`). `xcodebuild -project ios/Runner.xcodeproj -scheme Runner -configuration Debug -destination 'generic/platform=iOS Simulator' -clonedSourcePackagesDirPath "$PWD/build/ios/SourcePackages" BUILD_DIR="$PWD/build/ios" CODE_SIGNING_ALLOWED=NO build-for-testing` ends with `** TEST BUILD SUCCEEDED **` and links the Patrol and `integration_test` Swift packages into `RunnerUITests`. iOS uses `workmanager_apple` and `registerPeriodicTask(withIdentifier:earliestBeginInSeconds:)`; the Dart task identifier matches the iOS registration and plist.

Repository hygiene checks pass: `git diff --check` reports no whitespace errors; targeted `rg` finds no CocoaPods build references in iOS/macOS project and Flutter configuration files, no old Material/Cupertino imports in app-owned or `drag_arrange` library sources, and no `flutter_staggered_grid_view` dependency in the lockfile. Android prints Flutter's future-support warnings for AGP 8.13.2 and Kotlin 2.2.20 and Java's source/target 8 warning. iOS prints a future UIScene lifecycle warning. These do not fail the current builds.

Native permission requests, background task scheduling, and Patrol end-to-end behavior still need device or simulator runtime verification. The `patrol` CLI is not installed here, and no Home Assistant test service is configured in this workspace, so this audit makes compile-only claims for Patrol. Web is currently unsupported; `app/web` and the web release workflow still exist. Their removal belongs to the next plan, as requested by the user.

## Sources

- Package changelogs from the resolved pub cache: `go_router`, `permission_handler`, `flutter_secure_storage`, `workmanager`, `freezed`, `drift`, `riverpod`, and `patrol`.
- [Flutter standalone UI migration](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)
- [Flutter SPM app migration](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers)
- [Patrol changelog](https://pub.dev/packages/patrol/changelog)
