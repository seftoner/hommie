# Area Management E2E Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Cover Settings-based Home Assistant area create, rename, and delete with a deterministic end-to-end test that drives the app UI and verifies remote Home Assistant state through the existing hass-cli web wrapper.

**Architecture:** Keep the test deterministic by owning fixed test data, cleaning it up before and after the scenario, and verifying source-of-truth state through Home Assistant instead of only checking UI text. Add stable UI keys for the Areas flow, add a small integration-test area helper around `RemoteHassCli`, then write one BDD scenario that exercises create, rename, and delete through the app.

**Tech Stack:** Flutter, Patrol integration tests, `bdd_widget_test`, Riverpod test overrides, Home Assistant test container, `hass-cli-web`, Home Assistant WebSocket raw commands.

---

## File Structure

- Modify `app/lib/ui/keys.dart`
  - Add `K.settings.areasItem`.
  - Add `K.areas` with page, create button, name field, save button, delete dialog, and delete confirm button keys.
- Modify `app/lib/features/settings/presentation/screens/settings_page.dart`
  - Attach `K.settings.areasItem` to the Settings `Areas` row.
- Modify `app/lib/features/settings/presentation/screens/areas_page.dart`
  - Attach `K.areas.page` to the page scaffold.
  - Attach `K.areas.createButton` to the add action.
  - Attach `K.areas.nameField` and `K.areas.saveButton` to create/rename dialogs.
  - Attach `K.areas.deleteDialog` and `K.areas.deleteConfirmButton` to the delete confirmation.
- Modify `app/test/features/settings/presentation/settings_page_test.dart`
  - Assert the Areas row is addressable by key.
- Modify `app/test/features/settings/presentation/areas_page_test.dart`
  - Assert the Areas page, create action, dialogs, and delete dialog expose stable keys.
- Create `app/integration_test/utils/hass_area_manager.dart`
  - Provide deterministic area list/create/delete helpers using the existing `RemoteHassCli`.
- Create integration step files under `app/integration_test/step/`
  - Navigation and UI actions for area create, rename, delete.
  - Remote Home Assistant assertions and cleanup.
- Create `app/integration_test/areas.feature`
  - One scenario covering create -> remote verify -> rename -> remote verify -> delete -> remote verify.
- Generate `app/integration_test/areas_test.dart` and update `app/integration_test/test_bundle.dart` through `build_runner`.

## Deterministic Test Data

- Initial area name: `E2E_Area_Initial`
- Renamed area name: `E2E_Area_Renamed`
- Cleanup matches by either `area_id` or `name`.
- The scenario must cleanup before the UI flow and after the UI flow.
- The app performs create, rename, and delete.
- `hass-cli-web` performs setup cleanup and source-of-truth assertions only.

## Task 1: Add Stable Areas UI Keys

**Files:**
- Modify: `app/lib/ui/keys.dart`
- Modify: `app/lib/features/settings/presentation/screens/settings_page.dart`
- Modify: `app/lib/features/settings/presentation/screens/areas_page.dart`
- Test: `app/test/features/settings/presentation/settings_page_test.dart`
- Test: `app/test/features/settings/presentation/areas_page_test.dart`

- [x] **Step 1: Write failing widget assertions for Areas keys**

In `app/test/features/settings/presentation/settings_page_test.dart`, add an assertion to the existing settings page test that verifies:

```dart
expect(find.byKey(K.settings.areasItem), findsOneWidget);
```

In `app/test/features/settings/presentation/areas_page_test.dart`, add assertions to existing tests:

```dart
expect(find.byKey(K.areas.page), findsOneWidget);
expect(find.byKey(K.areas.createButton), findsOneWidget);
```

When opening the create dialog:

```dart
await tester.tap(find.byKey(K.areas.createButton));
await tester.pumpAndSettle();

expect(find.byKey(K.areas.nameField), findsOneWidget);
expect(find.byKey(K.areas.saveButton), findsOneWidget);
```

When opening the delete dialog:

```dart
expect(find.byKey(K.areas.deleteDialog), findsOneWidget);
expect(find.byKey(K.areas.deleteConfirmButton), findsOneWidget);
```

- [x] **Step 2: Run tests to verify they fail**

Run:

```bash
cd app
flutter test test/features/settings/presentation/settings_page_test.dart test/features/settings/presentation/areas_page_test.dart
```

Expected: compile failures because `K.settings.areasItem` and `K.areas` do not exist.

- [x] **Step 3: Add key definitions**

Modify `app/lib/ui/keys.dart`:

```dart
class Keys {
  const Keys();

  static const serversDiscovery = ServersDiscoveryKeys();
  static const manualAddress = ManualAddressKeys();
  static const appScaffold = AppScaffoldKeys();
  static const home = HomeKeys();
  static const common = CommonKeys();
  static const settings = SettingsKeys();
  static const areas = AreasKeys();
  static const hub = HubKeys();
  static const onboarding = OnboardingKeys();
}
```

Add:

```dart
class AreasKeys {
  const AreasKeys();

  final page = const Key('areasPage');
  final createButton = const Key('areasCreateButton');
  final nameField = const Key('areasNameField');
  final saveButton = const Key('areasSaveButton');
  final deleteDialog = const Key('areasDeleteDialog');
  final deleteConfirmButton = const Key('areasDeleteConfirmButton');
}
```

Add to `SettingsKeys`:

```dart
final areasItem = const Key('areasListItem');
```

- [x] **Step 4: Attach keys to UI**

Modify `app/lib/features/settings/presentation/screens/settings_page.dart`:

```dart
ListTile(
  key: K.settings.areasItem,
  leading: const Icon(Symbols.home_work_rounded),
  title: const Text('Areas'),
  trailing: const Icon(Symbols.chevron_right_rounded),
  onTap: () => const AreasRouteData().push(context),
),
```

Modify `app/lib/features/settings/presentation/screens/areas_page.dart`:

```dart
return Scaffold(
  key: K.areas.page,
```

Add the create button key:

```dart
IconButton(
  key: K.areas.createButton,
```

Add the delete dialog key:

```dart
return AlertDialog(
  key: K.areas.deleteDialog,
```

Add the delete confirm key:

```dart
TextButton(
  key: K.areas.deleteConfirmButton,
```

Add the name field key:

```dart
TextField(
  key: K.areas.nameField,
```

Add the save button key:

```dart
TextButton(
  key: K.areas.saveButton,
```

- [x] **Step 5: Run widget tests**

Run:

```bash
cd app
dart format lib/ui/keys.dart lib/features/settings/presentation/screens/settings_page.dart lib/features/settings/presentation/screens/areas_page.dart test/features/settings/presentation/settings_page_test.dart test/features/settings/presentation/areas_page_test.dart
flutter test test/features/settings/presentation/settings_page_test.dart test/features/settings/presentation/areas_page_test.dart
```

Expected: all listed tests pass.

- [ ] **Step 6: Commit**

```bash
git add app/lib/ui/keys.dart app/lib/features/settings/presentation/screens/settings_page.dart app/lib/features/settings/presentation/screens/areas_page.dart app/test/features/settings/presentation/settings_page_test.dart app/test/features/settings/presentation/areas_page_test.dart
git commit -m "test: add stable area ui keys"
```

## Task 2: Add Home Assistant Area Test Helper

**Files:**
- Create: `app/integration_test/utils/hass_area_manager.dart`
- Test: `app/test/hass_area_manager_test.dart`

- [x] **Step 1: Write failing helper tests**

Create `app/test/hass_area_manager_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/integration_test/utils/hass_area_manager.dart';

void main() {
  test('parses Home Assistant area registry list response', () {
    final areas = HassAreaManager.parseAreas('''
{
  "id": 1,
  "type": "result",
  "success": true,
  "result": [
    {"area_id": "kitchen", "name": "Kitchen"},
    {"area_id": "office", "name": "Office"}
  ]
}
''');

    expect(areas.map((area) => area.areaId), ['kitchen', 'office']);
    expect(areas.map((area) => area.name), ['Kitchen', 'Office']);
  });

  test('finds an area by name', () {
    const area = HassTestArea(areaId: 'e2e_area_initial', name: 'E2E_Area_Initial');

    expect(
      HassAreaManager.findByName([area], 'E2E_Area_Initial'),
      area,
    );
    expect(HassAreaManager.findByName([area], 'Missing'), isNull);
  });
}
```

- [x] **Step 2: Run tests to verify they fail**

Run:

```bash
cd app
flutter test test/hass_area_manager_test.dart
```

Expected: compile failure because `hass_area_manager.dart` does not exist.

- [x] **Step 3: Implement area helper**

Create `app/integration_test/utils/hass_area_manager.dart`:

```dart
import 'dart:convert';

import 'remote_hass_cli.dart';

class HassTestArea {
  const HassTestArea({required this.areaId, required this.name});

  final String areaId;
  final String name;
}

class HassAreaManager {
  HassAreaManager({RemoteHassCli? cli}) : _cli = cli ?? RemoteHassCli();

  static const initialName = 'E2E_Area_Initial';
  static const renamedName = 'E2E_Area_Renamed';

  final RemoteHassCli _cli;

  static List<HassTestArea> parseAreas(String stdout) {
    final decoded = jsonDecode(stdout) as Map<String, dynamic>;
    final result = decoded['result'] as List<dynamic>;
    return result
        .map(
          (item) {
            final json = item as Map<String, dynamic>;
            return HassTestArea(
              areaId: json['area_id'] as String,
              name: json['name'] as String,
            );
          },
        )
        .toList();
  }

  static HassTestArea? findByName(List<HassTestArea> areas, String name) {
    for (final area in areas) {
      if (area.name == name) {
        return area;
      }
    }
    return null;
  }

  Future<List<HassTestArea>> list() async {
    final result = await _cli.execute('raw ws config/area_registry/list');
    return result.fold(
      (error) => throw Exception('Failed to list areas: $error'),
      (success) {
        if (!success.isSuccess) {
          throw Exception('Failed to list areas: ${success.stderr}');
        }
        return parseAreas(success.stdout);
      },
    );
  }

  Future<HassTestArea?> findRemoteByName(String name) async {
    return findByName(await list(), name);
  }

  Future<void> deleteByNameIfPresent(String name) async {
    final area = await findRemoteByName(name);
    if (area == null) {
      return;
    }
    await deleteById(area.areaId);
  }

  Future<void> cleanupDeterministicAreas() async {
    await deleteByNameIfPresent(initialName);
    await deleteByNameIfPresent(renamedName);
  }

  Future<void> deleteById(String areaId) async {
    final result = await _cli.execute(
      'raw ws config/area_registry/delete --json={"area_id":"$areaId"}',
    );
    result.fold(
      (error) => throw Exception('Failed to delete area $areaId: $error'),
      (success) {
        if (!success.isSuccess) {
          throw Exception(
            'Failed to delete area $areaId: ${success.stderr}',
          );
        }
      },
    );
  }
}
```

- [x] **Step 4: Run helper tests**

Run:

```bash
cd app
dart format integration_test/utils/hass_area_manager.dart test/hass_area_manager_test.dart
flutter test test/hass_area_manager_test.dart
```

Expected: helper tests pass.

- [ ] **Step 5: Commit**

```bash
git add app/integration_test/utils/hass_area_manager.dart app/test/hass_area_manager_test.dart
git commit -m "test: add home assistant area e2e helper"
```

## Task 3: Add BDD Steps For Area Management

**Files:**
- Create: `app/integration_test/step/home_assistant_test_areas_are_clean.dart`
- Create: `app/integration_test/step/home_assistant_should_have_area.dart`
- Create: `app/integration_test/step/home_assistant_should_not_have_area.dart`
- Create: `app/integration_test/step/i_create_area.dart`
- Create: `app/integration_test/step/i_rename_area.dart`
- Create: `app/integration_test/step/i_delete_area.dart`

- [x] **Step 1: Add remote cleanup step**

Create `app/integration_test/step/home_assistant_test_areas_are_clean.dart`:

```dart
import 'package:patrol/patrol.dart';

import '../utils/hass_area_manager.dart';

Future<void> homeAssistantTestAreasAreClean(PatrolIntegrationTester $) async {
  await HassAreaManager().cleanupDeterministicAreas();
}
```

- [x] **Step 2: Add remote assertion steps**

Create `app/integration_test/step/home_assistant_should_have_area.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/hass_area_manager.dart';

Future<void> homeAssistantShouldHaveArea(
  PatrolIntegrationTester $,
  String areaName,
) async {
  final manager = HassAreaManager();
  HassTestArea? area;
  for (var attempt = 0; attempt < 10; attempt += 1) {
    area = await manager.findRemoteByName(areaName);
    if (area != null) {
      break;
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  expect(area, isNotNull, reason: 'Expected Home Assistant area "$areaName"');
}
```

Create `app/integration_test/step/home_assistant_should_not_have_area.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/hass_area_manager.dart';

Future<void> homeAssistantShouldNotHaveArea(
  PatrolIntegrationTester $,
  String areaName,
) async {
  final manager = HassAreaManager();
  HassTestArea? area;
  for (var attempt = 0; attempt < 10; attempt += 1) {
    area = await manager.findRemoteByName(areaName);
    if (area == null) {
      break;
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  expect(area, isNull, reason: 'Expected no Home Assistant area "$areaName"');
}
```

- [x] **Step 3: Add UI create step**

Create `app/integration_test/step/i_create_area.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:patrol/patrol.dart';

Future<void> iCreateArea(PatrolIntegrationTester $, String areaName) async {
  await $(K.areas.createButton).tap();
  await $(K.areas.nameField).enterText(areaName);
  await $(K.areas.saveButton).tap();
  await $(find.text(areaName)).waitUntilVisible();
}
```

- [x] **Step 4: Add UI rename step**

Create `app/integration_test/step/i_rename_area.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:patrol/patrol.dart';

Future<void> iRenameArea(
  PatrolIntegrationTester $,
  String currentName,
  String newName,
) async {
  await $(find.text(currentName)).waitUntilVisible();
  await $(find.byIcon(Symbols.more_vert_rounded)).tap();
  await $(find.text('Rename')).tap();
  await $(K.areas.nameField).enterText(newName);
  await $(K.areas.saveButton).tap();
  await $(find.text(newName)).waitUntilVisible();
}
```

- [x] **Step 5: Add UI delete step**

Create `app/integration_test/step/i_delete_area.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:patrol/patrol.dart';

Future<void> iDeleteArea(PatrolIntegrationTester $, String areaName) async {
  await $(find.text(areaName)).waitUntilVisible();
  await $(find.byIcon(Symbols.more_vert_rounded)).tap();
  await $(find.text('Delete')).tap();
  await $(K.areas.deleteDialog).waitUntilVisible();
  await $(K.areas.deleteConfirmButton).tap();
  await $(find.text(areaName)).waitUntilNotVisible();
}
```

- [x] **Step 6: Format step files**

Run:

```bash
cd app
dart format integration_test/step/home_assistant_test_areas_are_clean.dart integration_test/step/home_assistant_should_have_area.dart integration_test/step/home_assistant_should_not_have_area.dart integration_test/step/i_create_area.dart integration_test/step/i_rename_area.dart integration_test/step/i_delete_area.dart
```

Expected: formatter exits 0.

- [ ] **Step 7: Commit**

```bash
git add app/integration_test/step/home_assistant_test_areas_are_clean.dart app/integration_test/step/home_assistant_should_have_area.dart app/integration_test/step/home_assistant_should_not_have_area.dart app/integration_test/step/i_create_area.dart app/integration_test/step/i_rename_area.dart app/integration_test/step/i_delete_area.dart
git commit -m "test: add area e2e steps"
```

## Task 4: Add Area Management E2E Feature

**Files:**
- Create: `app/integration_test/areas.feature`
- Generated: `app/integration_test/areas_test.dart`
- Modify generated: `app/integration_test/test_bundle.dart`

- [x] **Step 1: Write the feature**

Create `app/integration_test/areas.feature`:

```gherkin
import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';
import 'utils/hass_area_manager.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Area Management
  As a user
  I want to create, rename, and delete Home Assistant areas
  So that Hommie stays synchronized with Home Assistant area registry state

  After:
    Then home assistant test areas are clean
    And perform cleanup

  Background:
    Given home assistant access is configured
    And home assistant test areas are clean
    And I have successfully logged in

  Scenario: Create rename and delete an area
    Given the application is running in the foreground
    And I see {K.home.page} page

    When I tap on {K.appScaffold.settingsButton} button
    Then I see {K.settings.page} page

    When I tap on {K.settings.areasItem} list item
    Then I see {K.areas.page} page

    When I create area {HassAreaManager.initialName}
    Then home assistant should have area {HassAreaManager.initialName}

    When I rename area {HassAreaManager.initialName} to {HassAreaManager.renamedName}
    Then home assistant should have area {HassAreaManager.renamedName}
    And home assistant should not have area {HassAreaManager.initialName}

    When I delete area {HassAreaManager.renamedName}
    Then home assistant should not have area {HassAreaManager.renamedName}
```

- [x] **Step 2: Generate BDD test code**

Run:

```bash
cd app
dart run build_runner build --delete-conflicting-outputs
```

Expected:
- `app/integration_test/areas_test.dart` is generated.
- `app/integration_test/test_bundle.dart` imports and groups `areas_test`.

- [x] **Step 3: Inspect generated test**

Check:

```bash
cd app
sed -n '1,240p' integration_test/areas_test.dart
sed -n '1,80p' integration_test/test_bundle.dart
```

Expected:
- Generated test imports all new step files.
- `After` cleanup runs in `finally`.
- `test_bundle.dart` includes `areas_test`.

- [ ] **Step 4: Commit**

```bash
git add app/integration_test/areas.feature app/integration_test/areas_test.dart app/integration_test/test_bundle.dart
git commit -m "test: cover area management e2e flow"
```

## Task 5: Run Focused Verification

**Files:**
- No planned source changes.

- [x] **Step 1: Run static verification**

Run:

```bash
cd app
flutter analyze lib/ui/keys.dart lib/features/settings/presentation/screens/settings_page.dart lib/features/settings/presentation/screens/areas_page.dart integration_test test/hass_area_manager_test.dart
```

Expected: no issues found.

- [x] **Step 2: Run focused widget/helper tests**

Run:

```bash
cd app
flutter test test/hass_area_manager_test.dart test/features/settings/presentation/settings_page_test.dart test/features/settings/presentation/areas_page_test.dart
```

Expected: all focused tests pass.

- [ ] **Step 3: Run the real e2e test when Docker Home Assistant is available**

Ensure the test environment is running:

```bash
./scripts/setup_test_env.sh
```

Run:

```bash
cd app
patrol test -t integration_test/areas_test.dart --dart-define=HASS_TOKEN=$HASS_TOKEN
```

Expected:
- The app starts with configured Home Assistant access.
- The test opens Settings -> Areas.
- The app creates `E2E_Area_Initial`.
- `hass-cli-web` verifies the area exists remotely.
- The app renames it to `E2E_Area_Renamed`.
- `hass-cli-web` verifies renamed remote state and absence of the initial name.
- The app deletes it.
- `hass-cli-web` verifies the renamed area no longer exists.
- Cleanup runs even on failure.

- [ ] **Step 4: Commit any verification-only fixes**

If verification requires small test-harness fixes, commit them separately:

```bash
git add app
git commit -m "test: stabilize area e2e verification"
```

If verification passes without further edits, do not create an empty commit.

## Self-Review

- Spec coverage: The plan covers deterministic setup, UI-driven create/rename/delete, remote Home Assistant assertions through `hass-cli-web`, and cleanup.
- Placeholder scan: No `TBD`, `TODO`, or unspecified implementation steps remain.
- Type consistency: `K.settings.areasItem`, `K.areas.*`, `HassAreaManager`, and `HassTestArea` are introduced before use in later tasks.
- Scope check: This is a single testability feature, not a separate product feature. It stays focused on e2e coverage for area management.
