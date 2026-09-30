# Flutter, Package, and SwiftPM Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Upgrade Hommie to Flutter 3.47 and compatible packages, own the staggered grid code used by `drag_arrange`, adopt standalone Material/Cupertino UI, and build iOS/macOS entirely with SPM.

**Architecture:** Keep the root pub workspace and lockfile as the single dependency graph. Move only the grid widget, tile, and render object used by `drag_arrange` into that local package. Migrate Hommie's root app and widgets to standalone design types, retain a bridge for legacy third-party widgets, and replace Apple Pods references with Flutter-generated Swift package integration.

**Tech Stack:** Flutter 3.47, Dart 3.13, `material_ui`, `cupertino_ui`, `go_router` 18, Patrol 4.10, Android Gradle, Xcode/SPM.

**Spec:** [Flutter, package, and Swift Package Manager migration design](../specs/2026-09-30-flutter-package-swiftpm-migration-design.md)

## Global Constraints

- Workspace and app minimums: Dart 3.13, Flutter 3.47; `drag_arrange` gets the same minimums and version `0.1.0`.
- Keep `drag_arrange` in the workspace; remove its `flutter_staggered_grid_view` dependency after incorporating only the used grid implementation and its MIT attribution.
- App and `drag_arrange` use standalone Material/Cupertino APIs where needed; keep `MaterialUiCompatibilityBridge` for remaining legacy third-party widgets.
- Android `compileSdk` is 37; iOS minimum is 15 for Runner, unit/UI test targets, and `AppFrameworkInfo.plist`.
- `patrol: ^4.10.0`; retain `PATROL_INTEGRATION_TEST_IOS_RUNNER(RunnerUITests)` and runtime test discovery.
- iOS and macOS have no CocoaPods build references or Podfiles; `FlutterGeneratedPluginSwiftPackage` links to app and Patrol UI-test targets where required.
- Preserve all existing unstaged dependency and macOS project changes. Stage only files owned by the current task, inspect generated diffs, and commit each task separately.

## Review Focus

1. `go_router` renders under a standalone `MaterialApp` and keeps redirect/navigation behavior; pin this in Task 3's widget test.
2. Count and extent tiles under tight width, RTL/axis direction, and drag reorder preserve layout and identity; pin this in Task 2's widget tests.
3. Secure credential replacement waits for deletion before writing and still reads the new value; pin this in Task 4's unit test.
4. Background-task registration keeps the same identifiers and callback entry point after the plugin upgrade; pin this in Task 4's registration test.
5. An iOS simulator test build links Patrol and `integration_test` into RunnerUITests without a Pods target; pin this in Task 5's Xcode build-for-testing check.

---

### Task 1: Establish the Flutter 3.47 dependency baseline

**Files:** Modify `pubspec.yaml`, `app/pubspec.yaml`, `packages/home_assistant_client/pubspec.yaml`, `pubspec.lock`, `.github/workflows/ci.yml`, `.github/workflows/release.yml`; create `docs/superpowers/reviews/2026-09-30-package-upgrade-audit.md`.

**Interfaces:** Consumes the already modified constraints and lockfile on this branch. Produces a workspace resolvable with Dart 3.13/Flutter 3.47, Patrol `^4.10.0`, and a package audit for later tasks.

- [ ] **Step 1: Record the baseline.** Run `git diff -- pubspec.yaml app/pubspec.yaml packages/home_assistant_client/pubspec.yaml pubspec.lock .github/workflows/ci.yml .github/workflows/release.yml` and `flutter --version`; preserve any user edits that appeared since planning.
- [ ] **Step 2: Set exact floors and Patrol constraint.** Set root/app `sdk: ">=3.13.0 <4.0.0"`, `flutter: ^3.47.0`; set `home_assistant_client` Dart floor to `>=3.13.0 <4.0.0`; set `app` Patrol to `^4.10.0`. Keep currently upgraded package constraints unless changelog review finds incompatibility.
- [ ] **Step 3: Update automation pins.** Set Flutter `3.47.5` in CI and release workflows; set release Dart `3.13.4` or remove that separate Dart setup if Flutter's bundled Dart is demonstrably the one used by all release commands.
- [ ] **Step 4: Resolve and audit.** Run `flutter pub get` and `flutter pub outdated`; raise any still-outdated direct constraint to its newest compatible release, then resolve again. Write the resolved direct-package versions, their relevant breaking changes, and any deliberate holds to `docs/superpowers/reviews/2026-09-30-package-upgrade-audit.md`. Review the lockfile's transitive upgrades for platform or SDK requirements. Task 2 removes the old staggered-grid package later.
- [ ] **Step 5: Check and commit.** Run `git diff --check`; confirm only this task's files are staged; commit `chore: align workspace with Flutter 3.47`.

### Task 2: Make `drag_arrange` self-contained

**Files:** Modify `packages/drag_arrange/pubspec.yaml`, `packages/drag_arrange/lib/src/drag_gridview.dart`, `app/pubspec.yaml`, `pubspec.lock`; create `packages/drag_arrange/lib/src/staggered_grid/staggered_grid.dart`, `staggered_grid_tile.dart`, `render_staggered_grid.dart`, `packages/drag_arrange/LICENSE.flutter_staggered_grid_view`, `packages/drag_arrange/test/staggered_grid_layout_test.dart`; update `packages/drag_arrange/README.md` attribution. Migrate other `packages/drag_arrange/lib/**/*.dart` imports selected by Flutter's design-widget fix.

**Interfaces:** Produces the unchanged `DragGridView`, `DragGridCountItem`, and `DragGridExtentItem` public API and internal `StaggeredGrid.count`, `StaggeredGridTile.count`, `StaggeredGridTile.extent` implementations. No app file imports the package today; app still declares it for future use.

- [ ] **Step 1: Add focused failing widget tests.** In `staggered_grid_layout_test.dart`, build `DragGridView` with `crossAxisCount: 2`, one `DragGridCountItem(crossAxisCellCount: 2, mainAxisCellCount: 1)` and one `DragGridExtentItem(crossAxisCellCount: 1, mainAxisExtent: 80)`. Assert both keyed children render within the viewport with the expected relative widths/heights. Add RTL/axis-direction and drag-order assertions using stable keys and the existing `DragCallbacks` interface.
- [ ] **Step 2: Run the focused tests before extraction.** `cd packages/drag_arrange && flutter test test/staggered_grid_layout_test.dart`; use any failure to establish the behavior under the current upstream implementation, then preserve a passing baseline for the copy.
- [ ] **Step 3: Incorporate only the used implementation.** Copy/adapt upstream 0.7.0 `lib/src/widgets/staggered_grid.dart`, `staggered_grid_tile.dart`, and `lib/src/rendering/staggered_grid.dart` into the three local paths above. Replace package imports with local imports and replace unnecessary `package:flutter/material.dart` imports with `package:flutter/widgets.dart` where sufficient. Keep the upstream copyright/license text and document provenance in the README.
- [ ] **Step 4: Disconnect the old package and migrate local UI imports.** Set `drag_arrange` to version `0.1.0`, Dart `>=3.13.0 <4.0.0`, Flutter `^3.47.0`; point `drag_gridview.dart` at the internal grid files; remove `flutter_staggered_grid_view` from its dependencies; set app `drag_arrange: ^0.1.0`. Apply and review `dart fix --apply --code=migrate_design_widgets` inside this package, then `flutter pub get` at the workspace root.
- [ ] **Step 5: Verify and commit.** Run `cd packages/drag_arrange && flutter test && flutter analyze`; confirm `rg 'flutter_staggered_grid_view' packages/drag_arrange/pubspec.yaml pubspec.lock` finds no dependency entry, and `git diff --check` passes. Commit `refactor: own staggered grid layout in drag_arrange`.

### Task 3: Migrate app design widgets and router root

**Files:** Modify `app/pubspec.yaml`, `app/lib/app.dart`, `app/lib/router/routes.dart`, `app/lib/ui/styles/theme.dart`, affected `app/lib/**/*.dart` and `app/test/**/*.dart` with legacy design imports; modify `app/test/features/home/home_page_test.dart` and `app/test/ui/screens/widgets/offline_container_test.dart` for coverage. Do not hand-edit generated `*.g.dart` files.

**Interfaces:** Produces a standalone `material_ui` `MaterialApp.router` whose `builder` composes `MaterialUiCompatibilityBridge` and `OfflineContainer`, retaining the current `goRouterProvider` route contract and English locale.

- [ ] **Step 1: Add the routing/bridge regression test.** Add a widget test that pumps `HommieApp` or a minimal root with the app router, asserts the initial route and a navigation/redirect reach the expected page, and asserts `OfflineContainer` still wraps routed content. Use standalone `MaterialApp` in the fixture so the type check is meaningful.
- [ ] **Step 2: Run the focused test against the old root.** `cd app && flutter test test/features/home/home_page_test.dart test/ui/screens/widgets/offline_container_test.dart`; record the baseline and the new regression assertion's failure or mismatch.
- [ ] **Step 3: Add standalone dependencies and migrate.** Add direct `material_ui` and `cupertino_ui` constraints compatible with Flutter 3.47. Run `dart fix --dry-run --code=migrate_design_widgets` and then `dart fix --apply --code=migrate_design_widgets` in `app`; review all changed imports and constructor types. Migrate `app.dart` root, router pages, themes, UI widgets, fixtures, and any localization delegates required by standalone Material/Cupertino.
- [ ] **Step 4: Compose the bridge.** In `app/lib/app.dart`, keep `routerConfig: ref.watch(goRouterProvider)`, both Hommie themes, `supportedLocales: const [Locale('en', '')]`, and route-wide offline wrapper. Put `MaterialUiCompatibilityBridge` around the routed child inside `MaterialApp.builder`; resolve any legacy public-type boundary explicitly.
- [ ] **Step 5: Verify and commit.** Run `cd app && flutter analyze` and the two focused widget-test files from Step 2. Check that `app/lib/app.dart` imports standalone Material, that no app-owned `MaterialApp` uses the legacy class, and that `git diff --check` passes. Commit `refactor: migrate app to standalone design libraries`.

### Task 4: Adapt changed package behavior and regenerate code

**Files:** Modify `app/lib/features/auth/infrastructure/repositories/secure_credentials_storage.dart`; create `app/test/features/auth/infrastructure/repositories/secure_credentials_storage_test.dart` and `app/test/core/bootstrap/background_tasks_test.dart`; inspect/modify `app/lib/core/bootstrap/background_tasks.dart`, `app/lib/features/background_task/background_task.dart`, `app/lib/ui/bgtask_debugging_page.dart`; regenerate checked-in `app/lib/**/*.g.dart` and `packages/home_assistant_client/lib/**/*.g.dart` where outputs change.

**Interfaces:** `SecureCredentialRepository.save(int serverId, Credentials credentials) -> Future<void>` continues to use `oauthCredentialsForServer:<id>` but awaits delete before write. Background tasks retain existing names, callback dispatcher, and iOS registration contract.

- [ ] **Step 1: Add the secure-storage ordering test.** Use a fake `FlutterSecureStorage` whose `delete` returns a held `Completer<void>`. Call `save(7, credentials)`, assert no write occurred, complete deletion, await save, then assert event order `['delete:oauthCredentialsForServer:7', 'write:oauthCredentialsForServer:7']` and successful read after clearing the repository cache in a new instance.
- [ ] **Step 2: Run the focused test to see the old race.** `cd app && flutter test test/features/auth/infrastructure/repositories/secure_credentials_storage_test.dart`; expect the ordering assertion to fail before the fix.
- [ ] **Step 3: Fix credential replacement.** Make `save` `async`, await `_storage.delete(key: _credentialKey(serverId))`, then await `_storage.write(...)`. Keep cached credentials consistent with the result of the write; update the cache only after a successful write.
- [ ] **Step 4: Check Workmanager behavior.** In `background_tasks_test.dart`, assert `simplePeriodicTask == 'com.hommie.workmanager.simplePeriodicTask'` and `iOSBackgroundAppRefresh == 'com.hommie.workmanager.sendSensorData'`. Inspect that `callbackDispatcher` retains `@pragma('vm:entry-point')` and compare 0.10's registration and Apple callback requirements against `background_tasks.dart`, `background_task.dart`, and the native app delegates. Record native registration behavior in the audit; change source only for a documented API mismatch.
- [ ] **Step 5: Regenerate and verify.** Run `cd app && dart run build_runner build --delete-conflicting-outputs` and the same command in `packages/home_assistant_client`. Review generated diffs for Freezed, Riverpod, Drift, and router builder. Run the focused credential test, relevant background test if added, and `flutter analyze` in both packages. Commit `fix: adapt upgraded package behavior and generators`.

### Task 5: Raise Android SDK and migrate iOS to SPM

**Files:** Modify `app/android/app/build.gradle`, `app/pubspec.yaml`, `app/ios/Runner.xcodeproj/project.pbxproj`, `app/ios/Flutter/AppFrameworkInfo.plist`, `app/ios/Flutter/Debug.xcconfig`, `app/ios/Flutter/Release.xcconfig`; delete `app/ios/Podfile`, `app/ios/Podfile.lock`; add generated iOS `Package.resolved` if Flutter/Xcode creates a stable one. Preserve `app/ios/RunnerUITests/RunnerUITests.m` and inspect iOS app delegate files for Workmanager requirements.

**Interfaces:** Android builds with `compileSdkVersion 37`. iOS Runner, RunnerTests, and RunnerUITests have deployment target 15; Runner and RunnerUITests link `FlutterGeneratedPluginSwiftPackage` and the Patrol test target retains its macro.

- [ ] **Step 1: Set SDK prerequisites.** Set `compileSdkVersion 37` in `app/android/app/build.gradle`; install Android platform API 37 with the local SDK manager if absent. Add nested `flutter: config: enable-swift-package-manager: true` to the app pubspec, retaining `uses-material-design: true` unless the standalone package documentation requires a change.
- [ ] **Step 2: Generate iOS SPM integration.** Set all iOS deployment targets and `AppFrameworkInfo.plist` to 15. Run `flutter pub get` from the workspace root and `cd app && flutter build ios --config-only --no-codesign --debug` to create Flutter's Swift package project integration without requiring a complete Pods build. Inspect the generated project reference before removing Pods.
- [ ] **Step 3: Link app and UI-test packages.** Ensure Runner and RunnerUITests target dependencies/frameworks include `FlutterGeneratedPluginSwiftPackage`; keep the `patrol` import and existing `PATROL_INTEGRATION_TEST_IOS_RUNNER(RunnerUITests)` macro. Ensure the `integration_test` Swift package reaches the test build through that generated product.
- [ ] **Step 4: Remove iOS CocoaPods integration.** Remove Podfile/lock, Pods groups, target references, framework links, script phases, `PODS_ROOT` settings, and Pods xcconfig includes from the iOS project/config files. Remove ignored generated `Pods/` and `.symlinks/` only after confirming they are generated and not user edits. Verify `rg -n 'PODS_ROOT|Pods_|Podfile|pod install' app/ios/Runner.xcodeproj app/ios/Flutter` returns no active build reference.
- [ ] **Step 5: Verify platform builds and commit.** Run `cd app && flutter build apk --debug`, `flutter build ios --simulator --no-codesign`, and `xcodebuild -project ios/Runner.xcodeproj -scheme Runner -configuration Debug -destination 'generic/platform=iOS Simulator' build-for-testing CODE_SIGNING_ALLOWED=NO`. The last command must compile RunnerUITests with Patrol and `integration_test` via SPM. Run `git diff --check` and commit `build: replace iOS CocoaPods with SwiftPM`.

### Task 6: Finish the macOS SPM conversion

**Files:** Modify `app/macos/Runner.xcodeproj/project.pbxproj`, `app/macos/Flutter/Flutter-Debug.xcconfig`, `app/macos/Flutter/Flutter-Release.xcconfig`; delete `app/macos/Podfile`, `app/macos/Podfile.lock`; inspect/track the canonical macOS `Package.resolved` under the Xcode project/workspace. Preserve generated `app/macos/Flutter/GeneratedPluginRegistrant.swift` unless regenerated by Flutter.

**Interfaces:** The existing macOS `FlutterGeneratedPluginSwiftPackage` remains linked to Runner; all macOS build configurations and RunnerTests use SPM without Pods.

- [ ] **Step 1: Reconcile current user edits.** Inspect `git diff -- app/macos/Runner.xcodeproj/project.pbxproj app/macos/Podfile.lock app/macos/Flutter/GeneratedPluginRegistrant.swift` and both untracked `Package.resolved` paths before changing them; preserve intended changes.
- [ ] **Step 2: Remove macOS Pods integration.** Remove tracked Podfile/lock, Pods groups, Pod frameworks, Pods xcconfig base configurations/includes, and Pods script phases while retaining the existing Swift package reference. Inspect RunnerTests target separately. Remove ignored generated Pods artifacts only after checking their origin; keep the canonical SPM resolution file and avoid duplicate pins.
- [ ] **Step 3: Verify and commit.** Confirm `rg -n 'PODS_ROOT|Pods_|Podfile|pod install' app/macos/Runner.xcodeproj app/macos/Flutter` finds no active build reference. Run `cd app && flutter build macos` and `git diff --check`. Commit `build: remove macOS CocoaPods integration`.

### Task 7: Complete the cross-platform upgrade audit

**Files:** Update `docs/superpowers/reviews/2026-09-30-package-upgrade-audit.md` with final versions, checks, and limits; update `pubspec.lock` if final resolution changed. Touch source only to fix a concrete failure found below.

**Interfaces:** Produces the final review record and a branch ready for integration review; no new public API.

- [ ] **Step 1: Resolve and inspect final dependency set.** Run `flutter pub get`, `flutter pub outdated`, and inspect `pubspec.lock` for `patrol 4.10.x`, standalone UI libraries, and absence of `flutter_staggered_grid_view`. Document any package not at its newest compatible version and why.
- [ ] **Step 2: Verify Dart packages.** Run `flutter analyze` and `flutter test` in `app`, `packages/drag_arrange`, `packages/home_assistant_client`, and `packages/computer`; compare any warnings with the branch baseline and record them.
- [ ] **Step 3: Verify user flows/platforms.** Recheck Android, iOS simulator, macOS, and Xcode RunnerUITests build commands from Tasks 5–6. Run a compatible Patrol end-to-end test if the CLI and Home Assistant test service are available; otherwise record the exact compile-only evidence. Check navigation, theme, credential replacement, and background registration behavior with their focused checks.
- [ ] **Step 4: Check repository hygiene.** Run `git diff --check`, `git status --short`, and targeted `rg` for Pods references and stale UI imports. Record commands/results in the audit and commit `docs: record Flutter migration verification`.

## Execution notes

The current checkout already has uncommitted package changes, a modified macOS Xcode project and Pod lockfile, and untracked SwiftPM resolution files. Do not reset or overwrite them. Some SDK downloads and SPM resolution need network access. If a required tool or test service is unavailable, finish all independent tasks and report the blocked command with its output.
