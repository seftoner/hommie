# Flutter, package, and Swift Package Manager migration — Design

Date: 2026-09-30
Branch: `chore/upgrade-flutter-and-packages`
Status: Proposed for review

## Goal and scope

Upgrade Hommie to Flutter 3.47 and the newest compatible direct and transitive
packages, migrate the app and local `drag_arrange` package to the standalone
Material and Cupertino libraries, make `drag_arrange` independent of the stale
`flutter_staggered_grid_view` package, and build the iOS and macOS apps with
Swift Package Manager (SPM) alone. Make `patrol: ^4.10.0` explicit, remove
both platforms' CocoaPods integrations, and raise the iOS deployment target to
15.

This is one coordinated migration because the Flutter UI split, `go_router` 18,
Patrol's SPM support, and plugin build requirements interact. Preserve the
package upgrade edits already present on the branch and review the resolved
versions again before implementation is complete. The user confirmed that no
released Hommie build used the older secure-storage format, so no installed-user
data migration is required.

## Current state and findings

- The installed stable SDK is Flutter 3.47.5 with Dart 3.13.4. The workspace and
  app still declare Flutter `^3.44.3` and Dart `>=3.12.2`; `drag_arrange` declares
  older minima. The earlier `flutter pub upgrade --major-versions` changed app
  and local package constraints plus the root lockfile, but those edits are not
  committed. The lockfile already resolves Patrol 4.10.0 while the app's direct
  constraint remains `^4.6.1`.
- Flutter 3.47 makes standalone `material_ui` and `cupertino_ui` available as an
  opt-in migration. The old Flutter imports still compile. `go_router` 18 has
  moved to standalone Material and checks the ancestor `MaterialApp` type from
  that library. Hommie's root `MaterialApp.router` currently comes from
  `package:flutter/material.dart`, so a clean analyzer result alone does not
  establish correct router behavior.
- `dart fix --dry-run --code=migrate_design_widgets` proposes 49 changes in the
  app and 10 in `drag_arrange`. Third-party `flutter_hooks` still uses legacy UI
  imports. A compatibility bridge is needed around legacy widgets until their
  dependencies migrate.
- `drag_arrange` is the owner's own local library. Its grid uses only
  `StaggeredGrid.count`, `StaggeredGridTile.count`, and
  `StaggeredGridTile.extent` from `flutter_staggered_grid_view` 0.7.0. The
  upstream package's last published release is roughly three years old. The
  implementation of those APIs spans three interdependent source files
  (widget, tile, and render object; about 700 lines), rather than two isolated
  widget files. The app currently declares `drag_arrange` but never imports it;
  only the package's own tests import it. The home screen renders `SliverList`.
- The macOS Xcode project already contains `FlutterGeneratedPluginSwiftPackage`
  alongside Pods build phases and xcconfig includes. The iOS project still has
  Pods integration and needs Flutter's SPM project setup. Both Podfiles and
  lockfiles are tracked. All currently resolved native-build plugins on these
  platforms provide `Package.swift`. `path_provider_foundation` has no Swift
  package but is marked `native_build: false` in Flutter's plugin metadata.
- The `pod` executable is currently unusable because its Homebrew shim invokes
  Ruby 4 without a matching CocoaPods gem. Removing Pods references directly
  from the projects is viable; installing CocoaPods solely to deintegrate it is
  unnecessary. Patrol's Swift package brings in CocoaAsyncSocket through SPM.
- The iOS project still targets iOS 13, while Flutter's `integration_test` Swift
  package requires iOS 15. Generated Patrol tests import `integration_test`.
  The user approved an iOS 15 minimum. The macOS deployment targets satisfy the
  resolved Swift package requirements.

## Dependency and source migration

Set the workspace and app environment floors to Dart 3.13 and Flutter 3.47.
Set `drag_arrange` to the same floors because its public source will use the
standalone UI API. Give `drag_arrange` a new minor version (`0.1.0`) and update
the app's local dependency constraint to match the compatibility break.
`home_assistant_client` can raise its Dart floor to 3.13 for its Freezed 4
development workflow; `computer` need not change its supported SDK range
unless its source or dependencies require it.

Keep `drag_arrange` in the workspace as a maintained local library. Bring only
the staggered-grid implementation that it uses into that package: the grid
widget, tile parent-data widget, and render-object layout code. Do not copy the
upstream masonry, quilted, woven, staired, or aligned grid implementations.
Adapt the three files to local imports and Flutter's foundation/widgets/rendering
libraries; remove the `flutter_staggered_grid_view` dependency from
`drag_arrange/pubspec.yaml` and the workspace lockfile. Preserve the upstream
MIT license and attribution with the copied source. Keep the existing
`DragGridView` API and verify count and extent tile layout, drag ordering,
axis direction, and constraint behavior before treating the extraction as
complete. This makes the maintained library independent of an unmaintained
package while keeping the fork limited to code it actually uses.

Add direct `material_ui` and `cupertino_ui` dependencies where their APIs are
used. Apply Flutter's design-widget migration to the app and `drag_arrange`,
then inspect each changed import and symbol by hand. Migrate `HommieApp`'s root
`MaterialApp.router`, route builders, themes, and all app-owned widgets and
tests to the standalone types. Avoid mixing identically named legacy and
standalone types at public boundaries. Keep the imports narrow where a file
needs only Flutter foundation or widgets APIs.

Place `MaterialUiCompatibilityBridge` in `MaterialApp.builder` around the route
content and `OfflineContainer`, preserving the latter's current coverage of
all routes. The bridge supplies standalone theme and localization context to
legacy third-party widgets. It cannot reconcile incompatible public types, so
resolve any API type errors at the caller or temporarily retain a legacy
boundary for the affected widget. Revisit and remove the bridge when the
remaining third-party widgets migrate. Hommie currently supports English only;
retain its locale setting and add any standalone localization delegates required
by the migrated app.

The package audit drives these additional changes:

| Dependency | Breaking-change finding | Design response |
| --- | --- | --- |
| `go_router` 18 | Uses standalone Material, including the `MaterialApp` ancestor check. | Migrate the root app and exercise redirect, navigation, and page transitions. |
| `permission_handler` 13 | Requires Android compile SDK 37. Flutter 3.47's default is 36; local SDKs currently stop at 36.1. | Install API 37 and set `compileSdk` explicitly to 37. Review permission behavior on Android. |
| `flutter_secure_storage` 11 | Drops deprecated Android encryption options and legacy formats. Hommie uses default options; there are no released installs to migrate. | Keep the current key contract and await `SecureCredentialRepository.save`'s delete before writing, then check save/read/delete. |
| `workmanager` 0.10 | Requires a newer Flutter and changes native integration. Current Dart callback APIs remain available. | Review Android and Apple registration/scheduling after SPM conversion; exercise a scheduled task where possible. |
| Freezed 4, Riverpod 3/4 tooling, `go_router_builder`, Drift 2.35, and other generators | Code generation and analyzer output can change even where handwritten APIs compile. Drift's identified extension break is web-only and unused here. | Regenerate checked-in code with the resolved versions; review generated diffs and fix source or annotations if needed. |
| Patrol 4.10 | Supports SPM on iOS and macOS. Version 4.10 adds optional static test discovery. | Raise the direct constraint to `^4.10.0`; retain the existing runtime `PATROL_INTEGRATION_TEST_IOS_RUNNER(RunnerUITests)` macro. |

Review every changed direct dependency and resolved transitive package for
release-note constraints before finalizing the lockfile. For packages without
an app-facing API or native integration change, record that finding in the
implementation review instead of making speculative source edits. Keep the
root workspace lockfile as the single resolved dependency record.

## CocoaPods-free Apple builds

Enable `flutter.config.enable-swift-package-manager: true` in the app pubspec.
Set iOS 15 consistently on the Runner app, RunnerTests/RunnerUITests targets,
project build settings, and `Flutter/AppFrameworkInfo.plist`. Let Flutter set
up the iOS `FlutterGeneratedPluginSwiftPackage` reference, then inspect the
Xcode project and explicitly link that generated package to both Runner and
RunnerUITests as Patrol's extension-package guidance requires. Keep the
existing macOS generated Swift package integration and verify its package
resolution. Pin generated `Package.resolved` files where appropriate for
reproducible Xcode builds.

Remove the iOS and macOS Podfiles and Podfile.lock files, Pods target references,
Pods build phases, Pod-linked frameworks, xcconfig Pods includes, and generated
Pods directories or symlinks. Inspect each Xcode project for residual
`PODS_ROOT`, `Pods_`, and `pod` references. Preserve unrelated build settings,
Flutter's generated config includes, signing settings, and the Patrol native
test target. CocoaAsyncSocket remains only as an SPM-resolved Patrol dependency.
Do not enable Patrol's optional build-time test discovery; the current runtime
test runner is adequate and avoids an unnecessary migration variable.

## Implementation order and acceptance

1. Finish the package constraint and SDK-floor updates. Resolve dependencies,
   review package changelogs, extract the used staggered-grid implementation
   into `drag_arrange`, and capture the final lockfile.
2. Migrate the standalone UI imports and root app; resolve compatibility
   boundaries and regenerate Dart source.
3. Set Android compile SDK 37 and the Apple deployment/build settings. Enable
   and inspect Flutter-generated SPM integration, then remove CocoaPods from
   both Xcode projects and their configs.
4. Verify the app at each platform boundary: dependency resolution and outdated
   report; analyzer with no new errors; relevant Dart/widget tests; Android
   build with API 37; iOS simulator and macOS builds without CocoaPods; and an
   Xcode build-for-testing of RunnerUITests with Patrol and `integration_test`.
   Exercise navigation, theming, credentials, and background registration.
   Run a Patrol end-to-end test if a compatible CLI and test service are
   available; otherwise report the compile-only limit explicitly.

Completion means direct constraints and the lockfile reflect the newest
compatible package set, `drag_arrange` has no `flutter_staggered_grid_view`
dependency, migrated app code uses standalone Material/Cupertino types,
iOS/macOS Xcode projects build through SPM without Pods references, and the
supported iOS minimum is consistently 15. Record any plugin or test
environment limitation with its exact failing command and output.

## Tradeoffs and risks

The iOS 15 floor drops iOS 13 and 14 support, as approved. The compatibility
bridge is temporary and may not cover a third-party API that exposes legacy
Material types. SPM package fetching and Android API 37 installation depend on
local network/tool availability. Generated Xcode project edits can be undone
by Flutter regeneration if the SPM setup is incomplete, so check the generated
projects after a clean package resolution. Keep the existing uncommitted
package edits separate from this design-document commit.

## References

- [Flutter Material and Cupertino split](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)
- [Flutter SPM app migration](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers)
- [Flutter pubspec configuration](https://docs.flutter.dev/tools/pubspec)
- [Patrol changelog](https://pub.dev/packages/patrol/changelog)
- [Patrol compatibility table](https://patrol.leancode.co/documentation/compatibility-table)
- [Patrol extension packages and SPM](https://patrol.leancode.co/documentation/native/extension-packages)
- [flutter_staggered_grid_view releases](https://pub.dev/packages/flutter_staggered_grid_view/versions)
- [flutter_staggered_grid_view MIT license](https://github.com/letsar/flutter_staggered_grid_view/blob/master/LICENSE)
