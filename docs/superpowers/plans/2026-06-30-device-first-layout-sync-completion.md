# Device-First Layout Sync Completion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Finish the accepted Home Assistant device-first layout sync design beyond the initial foundation slice.

**Architecture:** Keep HA registry data and Hommie layout overrides separate. Mirror HA devices and entities into Drift by stable registry ids, persist Hommie-owned tile overrides separately, then build the Home projection from mirrored devices, mirrored entities, and overrides. UI migration should be incremental: expose device-first sections first, then switch rendering without deleting the existing entity-first fallback until tests cover the new path.

**Tech Stack:** Flutter, Dart, Riverpod, Drift, `flutter_test`, `build_runner`.

---

## Current State

- Entity registry identity is mirrored in `Entities` by `registryId`.
- `HomeTile`, `HomeTileOverride`, and `projectDeviceTiles` exist in the home domain/application layer.
- `HomePageState.deviceSections` exists, but currently derives temporary `HaDevice` values from cached entities because device registry rows are not yet mirrored.
- No persistent local tile override table/repository exists yet.
- Missing tiles can be projected from in-memory overrides, but override persistence and rebind/remove commands are not wired yet.

## Task 1: Mirror HA Device Registry Rows

**Files:**
- Modify: `app/lib/core/database/tables.dart`
- Modify: `app/lib/core/database/database.g.dart`
- Modify: `app/lib/features/home/domain/entities/device.dart`
- Modify: `app/lib/features/home/domain/repositories/i_device_repository.dart`
- Modify: `app/lib/features/home/infrastructure/repositories/mappers/device_mapper.dart`
- Modify: `app/lib/features/home/infrastructure/repositories/drift_device_repository.dart`
- Modify: `app/lib/application/session/server_sync_coordinator.dart`
- Test: `app/test/core/database/entities_table_test.dart`
- Test: `app/test/features/home/infrastructure/drift_device_repository_test.dart`
- Test: `app/test/application/session/server_sync_coordinator_test.dart`

- [x] **Step 1: Write failing database/repository tests**

Add tests proving:

```dart
test('device registry rows persist HA metadata', () async {
  final db = AppDatabase(NativeDatabase.memory());
  addTearDown(db.close);
  final serverId = await db.into(db.serverEntities).insert(
    ServerEntitiesCompanion.insert(name: 'Home', url: 'http://h:8123'),
  );

  await db.into(db.deviceEntities).insert(
    DeviceEntitiesCompanion.insert(
      haId: 'device-1',
      name: 'Hue bulb',
      type: 'light',
      serverId: serverId,
      areaHaId: const Value('kitchen'),
      nameByUser: const Value('Counter lamp'),
      manufacturer: const Value('Signify'),
      model: const Value('LCA001'),
      disabled: const Value(true),
    ),
  );

  final row = await db.select(db.deviceEntities).getSingle();
  expect(row.haId, 'device-1');
  expect(row.areaHaId, 'kitchen');
  expect(row.nameByUser, 'Counter lamp');
  expect(row.manufacturer, 'Signify');
  expect(row.model, 'LCA001');
  expect(row.disabled, isTrue);
});
```

Create `app/test/features/home/infrastructure/drift_device_repository_test.dart` and verify:

```dart
test('syncRegistry upserts devices by stable HA id', () async {
  await repo.syncRegistry(serverId: serverId, devices: const [
    Device(
      id: 'device-1',
      name: 'Hue bulb',
      type: 'light',
      areaId: 'kitchen',
      nameByUser: 'Counter lamp',
      manufacturer: 'Signify',
      model: 'LCA001',
      disabled: false,
    ),
  ]);

  final before = await db.select(db.deviceEntities).getSingle();

  await repo.syncRegistry(serverId: serverId, devices: const [
    Device(
      id: 'device-1',
      name: 'Hue bulb renamed',
      type: 'light',
      areaId: 'office',
      nameByUser: 'Desk lamp',
      manufacturer: 'Signify',
      model: 'LCA001',
      disabled: true,
    ),
  ]);

  final after = await db.select(db.deviceEntities).getSingle();
  expect(after.id, before.id);
  expect(after.haId, 'device-1');
  expect(after.name, 'Hue bulb renamed');
  expect(after.areaHaId, 'office');
  expect(after.nameByUser, 'Desk lamp');
  expect(after.disabled, isTrue);
});
```

- [x] **Step 2: Run RED tests**

```bash
flutter test app/test/core/database/entities_table_test.dart app/test/features/home/infrastructure/drift_device_repository_test.dart
```

Expected: FAIL because `DeviceEntities` lacks HA metadata columns and repository sync API.

- [x] **Step 3: Extend schema and domain**

Add nullable `areaHaId`, `nameByUser`, `manufacturer`, `model`, and boolean `disabled` to `DeviceEntities`.
Extend `Device` with optional metadata fields while preserving existing constructor call sites.

- [x] **Step 4: Add repository sync/read APIs**

Extend `IDeviceRepository` and `DriftDeviceRepository` with:

```dart
Stream<List<Device>> watchByServer(int serverId);
Future<List<Device>> getByServer(int serverId);
Future<void> syncRegistry({
  required int serverId,
  required List<Device> devices,
});
```

`syncRegistry` must delete only registry rows missing from the latest HA device registry for that server. It must upsert by `{serverId, haId}`.

- [x] **Step 5: Wire sync coordinator**

After `remote.getDevices()`, map `DeviceRegistryRecord` to `Device` and call `deviceRepository.syncRegistry(...)` before entity resolution. Keep entity resolution using the remote `DeviceRegistryRecord` list.

- [x] **Step 6: Generate code and run tests**

```bash
dart run build_runner build
dart format app/lib app/test
flutter test app/test/core/database/entities_table_test.dart app/test/features/home/infrastructure/drift_device_repository_test.dart app/test/application/session/server_sync_coordinator_test.dart
```

- [x] **Step 7: Commit**

```bash
git add app/lib/core/database/tables.dart app/lib/core/database/database.g.dart app/lib/features/home/domain/entities/device.dart app/lib/features/home/domain/repositories/i_device_repository.dart app/lib/features/home/infrastructure/repositories/mappers/device_mapper.dart app/lib/features/home/infrastructure/repositories/drift_device_repository.dart app/lib/application/session/server_sync_coordinator.dart app/test/core/database/entities_table_test.dart app/test/features/home/infrastructure/drift_device_repository_test.dart app/test/application/session/server_sync_coordinator_test.dart
git commit -m "Mirror HA device registry metadata"
```

## Task 2: Persist Local Home Tile Overrides

**Files:**
- Modify: `app/lib/core/database/tables.dart`
- Modify: `app/lib/core/database/database.dart`
- Modify: `app/lib/core/database/database.g.dart`
- Create: `app/lib/features/home/domain/repositories/i_home_tile_override_repository.dart`
- Create: `app/lib/features/home/infrastructure/repositories/drift_home_tile_override_repository.dart`
- Create: `app/lib/features/home/infrastructure/providers/home_tile_override_repository_provider.dart`
- Test: `app/test/features/home/infrastructure/drift_home_tile_override_repository_test.dart`

- [x] **Step 1: Write RED tests**

Test that overrides persist `kind`, `targetId`, `areaId`, `size`, `order`, `hidden`, `primaryEntityRegistryId`, and last-known snapshots. Test that upserting an override for a moved area keeps size but changes `areaId/order` only when explicitly saved by Hommie.

- [x] **Step 2: Add `HomeTileOverrides` Drift table**

Use `{serverId, kind, targetId}` as identity. Store order as nullable int and `areaHaId` as nullable text. Store `lastKnownAreaHaId`, `lastKnownName`, `lastKnownDomain`.

- [x] **Step 3: Implement repository**

Repository API:

```dart
Stream<List<HomeTileOverride>> watchByServer(int serverId);
Future<List<HomeTileOverride>> getByServer(int serverId);
Future<void> upsert({
  required int serverId,
  required HomeTileOverride override,
});
Future<void> remove({
  required int serverId,
  required HomeTileKind kind,
  required String targetId,
});
```

- [x] **Step 4: Generate code, run focused tests, commit**

```bash
dart run build_runner build
flutter test app/test/features/home/infrastructure/drift_home_tile_override_repository_test.dart
git add app/lib/core/database/tables.dart app/lib/core/database/database.dart app/lib/core/database/database.g.dart app/lib/features/home/domain/repositories/i_home_tile_override_repository.dart app/lib/features/home/infrastructure/repositories/drift_home_tile_override_repository.dart app/lib/features/home/infrastructure/providers/home_tile_override_repository_provider.dart app/test/features/home/infrastructure/drift_home_tile_override_repository_test.dart
git commit -m "Persist home tile layout overrides"
```

## Task 3: Project Home From Mirrored Devices And Overrides

**Files:**
- Create: `app/lib/features/home/application/cached_devices_provider.dart`
- Create: `app/lib/features/home/application/home_tile_overrides_provider.dart`
- Modify: `app/lib/features/home/application/home_page_controller.dart`
- Test: `app/test/features/home/home_page_controller_test.dart`

- [x] **Step 1: Write RED controller tests**

Verify `HomePageState.deviceSections` uses cached device names/areas/disabled state from `DeviceRepository.watchByServer`, applies persisted overrides, and creates missing tiles for override targets absent from registry.

- [x] **Step 2: Implement providers and controller wiring**

Watch cached devices and overrides in `HomePageController`. Replace temporary `_devicesFromEntities` fallback with actual mirrored devices. Keep the fallback only for tests or empty device mirror if necessary, but prefer real device rows.

- [x] **Step 3: Run home tests and commit**

```bash
flutter test app/test/features/home/home_page_controller_test.dart app/test/features/home/application/device_tile_projection_test.dart
git add app/lib/features/home/application/cached_devices_provider.dart app/lib/features/home/application/home_tile_overrides_provider.dart app/lib/features/home/application/home_page_controller.dart app/test/features/home/home_page_controller_test.dart
git commit -m "Project home tiles from mirrored devices"
```

## Task 4: Add Missing Tile And Rebind Boundary

**Files:**
- Modify: `app/lib/features/home/domain/entities/home_tile.dart`
- Create: `app/lib/features/home/application/home_tile_rebind_controller.dart`
- Test: `app/test/features/home/application/home_tile_rebind_controller_test.dart`

- [x] **Step 1: Write RED tests**

Verify that a missing device override can be rebound to a current device id, preserving size and placing it at the end of the target's current area. Verify remove deletes only the local override.

- [x] **Step 2: Implement controller**

Controller methods:

```dart
Future<void> rebindDevice({
  required String missingTargetId,
  required String replacementDeviceId,
});

Future<void> removeTile({
  required HomeTileKind kind,
  required String targetId,
});
```

- [x] **Step 3: Run tests and commit**

```bash
flutter test app/test/features/home/application/home_tile_rebind_controller_test.dart
git add app/lib/features/home/application/home_tile_rebind_controller.dart app/test/features/home/application/home_tile_rebind_controller_test.dart
git commit -m "Add home tile rebind actions"
```

## Task 5: Switch Home UI To Device-First Rendering

**Files:**
- Modify: `app/lib/features/home/presentation/screens/home_page.dart`
- Create: `app/lib/features/home/presentation/widgets/home_tile_card.dart`
- Test: `app/test/features/home/home_page_test.dart`

- [ ] **Step 1: Write RED widget tests**

Verify summary and area tabs render device tiles grouped by device sections. Verify disabled tiles render as non-command cards, and missing tiles render `Rebind` and `Remove` actions. Keep entity card rendering only as a fallback for device-less explicit entity tiles.

- [ ] **Step 2: Implement device tile card**

Render active tiles through the primary entity where possible. Render disabled/unavailable/missing as non-command cards. Missing tiles expose Rebind and Remove buttons but can use placeholder callbacks until a full picker UI exists.

- [ ] **Step 3: Run home tests and commit**

```bash
flutter test app/test/features/home
git add app/lib/features/home/presentation/screens/home_page.dart app/lib/features/home/presentation/widgets/home_tile_card.dart app/test/features/home/home_page_test.dart
git commit -m "Render home from device-first tiles"
```

## Final Verification

```bash
flutter test app/test/features/entities
flutter test app/test/features/home
flutter test app/test/application/session/server_sync_coordinator_test.dart
flutter analyze
git status --short
```
