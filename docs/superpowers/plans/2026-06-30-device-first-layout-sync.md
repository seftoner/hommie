# Device-First Layout Sync Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the foundations for a Google Home/HomeKit-style Home Assistant client where the home view is device-first, registry-backed, rename-safe, and offline-renderable.

**Architecture:** Home Assistant registry data is mirrored into Drift by stable ids, while Hommie stores local tile presentation as overrides. The first implementation slice expands registry identity, updates architecture guidance, introduces device-first projection models, and preserves the existing entity-first UI until the projection is wired into Home.

**Tech Stack:** Flutter, Dart, Riverpod code generation, Drift, Freezed/json_serializable, `home_assistant_client`, `flutter_test`, `dart test`.

---

## File Map

- `docs/home-assistant-feature-architecture.md`: keep as the general HA feature guardrail; add a short device-first registry projection section and update entity-first examples.
- `packages/home_assistant_client/lib/src/protocol/types/hass_types.dart`: inspect before changing state payload assumptions; keep command/state payloads entity-addressed.
- `app/lib/features/entities/infrastructure/repositories/ha_registry_repository.dart`: expand remote registry DTO projections to retain stable entity/device identity.
- `app/lib/features/entities/infrastructure/repositories/entity_resolver.dart`: stop treating hidden as filtered-out; preserve disabled entries as unavailable metadata.
- `app/lib/features/entities/domain/entities/ha_entity.dart`: add stable registry identity fields needed by entity tiles and device primary-entity selection.
- `app/lib/features/entities/infrastructure/repositories/mappers/entity_mapper.dart`: map new domain fields to Drift rows.
- `app/lib/core/database/tables.dart`: extend `Entities` into an entity mirror and replace the fragile `DeviceEntities` semantics with HA device identity.
- `app/lib/core/database/database.dart`: include new Drift tables if introduced.
- `app/lib/features/home/domain/entities/home_tile.dart`: create device-first projection models for device tiles, entity tiles, and resolution status.
- `app/lib/features/home/application/device_tile_projection.dart`: compute device-first tiles from mirrored devices/entities/areas and local overrides.
- `app/lib/features/home/application/home_page_controller.dart`: controller entry point for exposing device tile sections beside existing entity sections.
- `app/test/features/entities/infrastructure/registry_records_test.dart`: extend DTO parsing coverage.
- `app/test/features/entities/infrastructure/entity_resolver_test.dart`: update disabled/hidden behavior coverage.
- `app/test/features/home/application/device_tile_projection_test.dart`: add device-first projection tests.
- `docs/superpowers/specs/2026-06-30-ha-registry-layout-sync-design.md`: reference only if behavior is ambiguous during implementation.

## Task 1: Update Architecture Guardrail

**Files:**
- Modify: `docs/home-assistant-feature-architecture.md`

- [ ] **Step 1: Patch the HA architecture guide**

Add this section after `Sync To Cache`:

```markdown
## Registry-Backed Home Projections

Home rendering should use three layers:

1. **Registry mirror**: Drift rows synced from Home Assistant areas, devices, and
   entities by `ServerSyncCoordinator`.
2. **Local tile overrides**: Hommie-owned size, order, hidden/suppressed state,
   and primary-entity override.
3. **Live state overlay**: transient entity state from a scoped subscription.

The default home projection is device-first. A visible tile normally binds to HA
`device_id`, computes a primary entity from that device's entities, and resolves
the current `entity_id` only when sending a command. Entity tiles are reserved
for device-less things such as scenes, scripts, helpers, groups, and explicit
entity-specific controls.

Feature widgets must read this projection, not raw registry payloads.
```

Replace the entity-first example near the top with:

```markdown
If a feature seems to need two paths, split it. Example: a device tile reads
cached device/entity registry metadata from Drift, overlays live entity state
from `entityStatesProvider`, and sends commands through a controller that
resolves the current `entity_id` at call time.
```

- [ ] **Step 2: Verify markdown has no stale terminology**

Run:

```bash
rg -n "light card reads cached entity|UI widgets reading WebSocket payloads" docs/home-assistant-feature-architecture.md
```

Expected:

```text
docs/home-assistant-feature-architecture.md:18:| Remote sync into cache | A coordinator that owns fetch/subscription and writes Drift cache | UI widgets reading WebSocket payloads directly |
```

The table wording can stay because it warns against raw payload use.

- [ ] **Step 3: Commit**

```bash
git add docs/home-assistant-feature-architecture.md
git commit -m "Document device-first HA feature architecture"
```

## Task 2: Preserve Stable Registry Identity

**Files:**
- Modify: `app/lib/features/entities/infrastructure/repositories/ha_registry_repository.dart`
- Modify: `app/lib/features/entities/domain/entities/ha_entity.dart`
- Modify: `app/lib/features/entities/infrastructure/repositories/entity_resolver.dart`
- Modify: `app/lib/features/entities/infrastructure/repositories/mappers/entity_mapper.dart`
- Test: `app/test/features/entities/infrastructure/registry_records_test.dart`
- Test: `app/test/features/entities/infrastructure/entity_resolver_test.dart`

- [ ] **Step 1: Write failing DTO parsing tests**

Add assertions to `registry_records_test.dart`:

```dart
test('EntityRegistryRecord keeps stable registry identity', () {
  final r = EntityRegistryRecord.fromJson({
    'id': 'entity-reg-1',
    'entity_id': 'light.kitchen_bulb',
    'unique_id': 'abc123',
    'platform': 'hue',
    'name': 'Kitchen bulb',
    'original_name': 'Hue bulb',
    'device_id': 'device-1',
    'area_id': 'kitchen',
    'disabled_by': 'user',
    'hidden_by': 'user',
    'entity_category': 'diagnostic',
  });

  expect(r.id, 'entity-reg-1');
  expect(r.entityId, 'light.kitchen_bulb');
  expect(r.uniqueId, 'abc123');
  expect(r.platform, 'hue');
  expect(r.deviceId, 'device-1');
  expect(r.areaId, 'kitchen');
  expect(r.disabled, isTrue);
  expect(r.hidden, isTrue);
  expect(r.entityCategory, 'diagnostic');
});

test('DeviceRegistryRecord keeps HA device identity and labels', () {
  final d = DeviceRegistryRecord.fromJson({
    'id': 'device-1',
    'area_id': 'kitchen',
    'name': 'Hue bulb',
    'name_by_user': 'Counter lamp',
    'manufacturer': 'Signify',
    'model': 'LCA001',
    'disabled_by': null,
  });

  expect(d.id, 'device-1');
  expect(d.areaId, 'kitchen');
  expect(d.name, 'Hue bulb');
  expect(d.nameByUser, 'Counter lamp');
  expect(d.manufacturer, 'Signify');
  expect(d.model, 'LCA001');
  expect(d.disabled, isFalse);
});
```

- [ ] **Step 2: Run tests to verify failure**

Run:

```bash
dart test app/test/features/entities/infrastructure/registry_records_test.dart
```

Expected: FAIL because `EntityRegistryRecord` does not expose `id`, `uniqueId`, or `platform`, and `DeviceRegistryRecord` does not expose labels/disabled metadata.

- [ ] **Step 3: Expand registry DTOs**

Update `EntityRegistryRecord`:

```dart
class EntityRegistryRecord {
  final String id;
  final String entityId;
  final String uniqueId;
  final String platform;
  final String? name;
  final String? originalName;
  final String? deviceId;
  final String? areaId;
  final bool disabled;
  final bool hidden;
  final String? entityCategory;

  const EntityRegistryRecord({
    required this.id,
    required this.entityId,
    required this.uniqueId,
    required this.platform,
    this.name,
    this.originalName,
    this.deviceId,
    this.areaId,
    this.disabled = false,
    this.hidden = false,
    this.entityCategory,
  });

  factory EntityRegistryRecord.fromJson(Map<String, dynamic> j) =>
      EntityRegistryRecord(
        id: j['id'] as String,
        entityId: j['entity_id'] as String,
        uniqueId: j['unique_id'] as String,
        platform: j['platform'] as String,
        name: j['name'] as String?,
        originalName: j['original_name'] as String?,
        deviceId: j['device_id'] as String?,
        areaId: j['area_id'] as String?,
        disabled: j['disabled_by'] != null,
        hidden: j['hidden_by'] != null,
        entityCategory: j['entity_category'] as String?,
      );
}
```

Update `DeviceRegistryRecord`:

```dart
class DeviceRegistryRecord {
  final String id;
  final String? areaId;
  final String? name;
  final String? nameByUser;
  final String? manufacturer;
  final String? model;
  final bool disabled;

  const DeviceRegistryRecord({
    required this.id,
    this.areaId,
    this.name,
    this.nameByUser,
    this.manufacturer,
    this.model,
    this.disabled = false,
  });

  factory DeviceRegistryRecord.fromJson(Map<String, dynamic> j) =>
      DeviceRegistryRecord(
        id: j['id'] as String,
        areaId: j['area_id'] as String?,
        name: j['name'] as String?,
        nameByUser: j['name_by_user'] as String?,
        manufacturer: j['manufacturer'] as String?,
        model: j['model'] as String?,
        disabled: j['disabled_by'] != null,
      );
}
```

- [ ] **Step 4: Update resolver tests for disabled and hidden**

In `entity_resolver_test.dart`, update the main test so disabled and hidden records are preserved:

```dart
final entities = [
  const EntityRegistryRecord(
    id: 'reg-a',
    entityId: 'light.a',
    uniqueId: 'uid-a',
    platform: 'test',
    areaId: 'kitchen',
  ),
  const EntityRegistryRecord(
    id: 'reg-b',
    entityId: 'light.b',
    uniqueId: 'uid-b',
    platform: 'test',
    deviceId: 'dev1',
  ),
  const EntityRegistryRecord(
    id: 'reg-c',
    entityId: 'light.c',
    uniqueId: 'uid-c',
    platform: 'test',
  ),
  const EntityRegistryRecord(
    id: 'reg-d',
    entityId: 'light.d',
    uniqueId: 'uid-d',
    platform: 'test',
    disabled: true,
  ),
  const EntityRegistryRecord(
    id: 'reg-e',
    entityId: 'light.e',
    uniqueId: 'uid-e',
    platform: 'test',
    hidden: true,
  ),
];
```

Expected assertions:

```dart
expect(result.map((e) => e.entityId), [
  'light.a',
  'light.b',
  'light.c',
  'light.d',
  'light.e',
]);
expect(result.singleWhere((e) => e.entityId == 'light.d').disabled, isTrue);
expect(result.singleWhere((e) => e.entityId == 'light.e').hidden, isTrue);
```

- [ ] **Step 5: Expand `HaEntity` and resolver**

Update `HaEntity`:

```dart
class HaEntity {
  final String registryId;
  final String uniqueId;
  final String platform;
  final String entityId;
  final String domain;
  final String name;
  final String? deviceId;
  final String? areaId;
  final bool disabled;
  final bool hidden;
  final String? entityCategory;

  const HaEntity({
    required this.registryId,
    required this.uniqueId,
    required this.platform,
    required this.entityId,
    required this.domain,
    required this.name,
    this.deviceId,
    this.areaId,
    this.disabled = false,
    this.hidden = false,
    this.entityCategory,
  });
}
```

Update resolver mapping:

```dart
result.add(HaEntity(
  registryId: e.id,
  uniqueId: e.uniqueId,
  platform: e.platform,
  entityId: e.entityId,
  domain: domain,
  name: name,
  deviceId: e.deviceId,
  areaId: area,
  disabled: e.disabled,
  hidden: e.hidden,
  entityCategory: e.entityCategory,
));
```

- [ ] **Step 6: Run focused tests**

Run:

```bash
dart test app/test/features/entities/infrastructure/registry_records_test.dart app/test/features/entities/infrastructure/entity_resolver_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/features/entities/infrastructure/repositories/ha_registry_repository.dart app/lib/features/entities/domain/entities/ha_entity.dart app/lib/features/entities/infrastructure/repositories/entity_resolver.dart app/lib/features/entities/infrastructure/repositories/mappers/entity_mapper.dart app/test/features/entities/infrastructure/registry_records_test.dart app/test/features/entities/infrastructure/entity_resolver_test.dart
git commit -m "Preserve stable HA registry identity"
```

## Task 3: Add Device-First Projection Models

**Files:**
- Create: `app/lib/features/home/domain/entities/home_tile.dart`
- Create: `app/lib/features/home/application/device_tile_projection.dart`
- Test: `app/test/features/home/application/device_tile_projection_test.dart`

- [ ] **Step 1: Write projection tests**

Create `device_tile_projection_test.dart` with cases:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/home/application/device_tile_projection.dart';

void main() {
  test('groups device entities into one device tile with controllable primary', () {
    final tiles = projectDeviceTiles(
      devices: const [
        HaDevice(
          id: 'dev1',
          name: 'Kitchen bulb',
          areaId: 'kitchen',
        ),
      ],
      entities: const [
        HaEntity(
          registryId: 'reg-sensor',
          uniqueId: 'uid-sensor',
          platform: 'test',
          entityId: 'sensor.kitchen_bulb_power',
          domain: 'sensor',
          name: 'Power',
          deviceId: 'dev1',
          areaId: 'kitchen',
        ),
        HaEntity(
          registryId: 'reg-light',
          uniqueId: 'uid-light',
          platform: 'test',
          entityId: 'light.kitchen_bulb',
          domain: 'light',
          name: 'Kitchen bulb',
          deviceId: 'dev1',
          areaId: 'kitchen',
        ),
      ],
      overrides: const [],
    );

    expect(tiles, hasLength(1));
    expect(tiles.single.targetId, 'dev1');
    expect(tiles.single.areaId, 'kitchen');
    expect(tiles.single.primaryEntity?.entityId, 'light.kitchen_bulb');
    expect(tiles.single.secondaryEntities.map((e) => e.entityId), [
      'sensor.kitchen_bulb_power',
    ]);
  });

  test('does not auto-promote device-less entity to main device tile', () {
    final tiles = projectDeviceTiles(
      devices: const [],
      entities: const [
        HaEntity(
          registryId: 'scene-reg',
          uniqueId: 'scene-uid',
          platform: 'scene',
          entityId: 'scene.movie_time',
          domain: 'scene',
          name: 'Movie time',
        ),
      ],
      overrides: const [],
    );

    expect(tiles, isEmpty);
  });
}
```

- [ ] **Step 2: Run projection tests to verify failure**

Run:

```bash
dart test app/test/features/home/application/device_tile_projection_test.dart
```

Expected: FAIL because `HaDevice`, `HomeTile`, and `projectDeviceTiles` do not exist.

- [ ] **Step 3: Create projection entities**

Create `home_tile.dart`:

```dart
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

enum HomeTileKind { device, entity }

enum HomeTileResolution { active, unavailable, disabled, missing }

enum HomeTileSize { small, large }

class HaDevice {
  final String id;
  final String name;
  final String? areaId;
  final bool disabled;

  const HaDevice({
    required this.id,
    required this.name,
    this.areaId,
    this.disabled = false,
  });
}

class HomeTileOverride {
  final HomeTileKind kind;
  final String targetId;
  final HomeTileSize? size;
  final int? order;
  final bool hidden;
  final String? primaryEntityRegistryId;

  const HomeTileOverride({
    required this.kind,
    required this.targetId,
    this.size,
    this.order,
    this.hidden = false,
    this.primaryEntityRegistryId,
  });
}

class HomeTile {
  final HomeTileKind kind;
  final String targetId;
  final String name;
  final String? areaId;
  final HomeTileSize size;
  final int order;
  final HomeTileResolution resolution;
  final HaEntity? primaryEntity;
  final List<HaEntity> secondaryEntities;

  const HomeTile({
    required this.kind,
    required this.targetId,
    required this.name,
    required this.areaId,
    required this.size,
    required this.order,
    required this.resolution,
    this.primaryEntity,
    this.secondaryEntities = const [],
  });
}
```

- [ ] **Step 4: Create projection logic**

Create `device_tile_projection.dart`:

```dart
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';

export 'package:hommie/features/home/domain/entities/home_tile.dart';

const _domainPriority = <String>[
  'light',
  'switch',
  'climate',
  'cover',
  'fan',
  'media_player',
  'lock',
  'vacuum',
  'button',
  'sensor',
  'binary_sensor',
];

List<HomeTile> projectDeviceTiles({
  required List<HaDevice> devices,
  required List<HaEntity> entities,
  required List<HomeTileOverride> overrides,
}) {
  final entitiesByDevice = <String, List<HaEntity>>{};
  for (final entity in entities) {
    final deviceId = entity.deviceId;
    if (deviceId == null) {
      continue;
    }
    entitiesByDevice.putIfAbsent(deviceId, () => []).add(entity);
  }

  final overrideByDeviceId = {
    for (final override in overrides)
      if (override.kind == HomeTileKind.device) override.targetId: override,
  };

  final tiles = <HomeTile>[];
  for (final device in devices) {
    final override = overrideByDeviceId[device.id];
    if (override?.hidden ?? false) {
      continue;
    }

    final candidates = entitiesByDevice[device.id] ?? const <HaEntity>[];
    final primary = _selectPrimaryEntity(candidates, override);
    final secondary = [
      for (final entity in candidates)
        if (entity.registryId != primary?.registryId) entity,
    ];

    tiles.add(HomeTile(
      kind: HomeTileKind.device,
      targetId: device.id,
      name: device.name,
      areaId: device.areaId,
      size: override?.size ?? HomeTileSize.small,
      order: override?.order ?? tiles.length,
      resolution: device.disabled || (primary?.disabled ?? false)
          ? HomeTileResolution.disabled
          : primary == null
              ? HomeTileResolution.unavailable
              : HomeTileResolution.active,
      primaryEntity: primary,
      secondaryEntities: secondary,
    ));
  }

  tiles.sort((a, b) {
    final areaCompare = (a.areaId ?? '').compareTo(b.areaId ?? '');
    if (areaCompare != 0) {
      return areaCompare;
    }
    return a.order.compareTo(b.order);
  });
  return tiles;
}

HaEntity? _selectPrimaryEntity(
  List<HaEntity> entities,
  HomeTileOverride? override,
) {
  final usable = [
    for (final entity in entities)
      if (!entity.disabled &&
          entity.entityCategory != 'config' &&
          entity.entityCategory != 'diagnostic')
        entity,
  ];

  final overrideId = override?.primaryEntityRegistryId;
  if (overrideId != null) {
    for (final entity in usable) {
      if (entity.registryId == overrideId) {
        return entity;
      }
    }
  }

  if (usable.isEmpty) {
    return null;
  }

  usable.sort((a, b) {
    final aPriority = _domainPriority.indexOf(a.domain);
    final bPriority = _domainPriority.indexOf(b.domain);
    final normalizedA = aPriority == -1 ? _domainPriority.length : aPriority;
    final normalizedB = bPriority == -1 ? _domainPriority.length : bPriority;
    final priorityCompare = normalizedA.compareTo(normalizedB);
    if (priorityCompare != 0) {
      return priorityCompare;
    }
    return a.entityId.compareTo(b.entityId);
  });
  return usable.first;
}
```

- [ ] **Step 5: Run projection tests**

Run:

```bash
dart test app/test/features/home/application/device_tile_projection_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/features/home/domain/entities/home_tile.dart app/lib/features/home/application/device_tile_projection.dart app/test/features/home/application/device_tile_projection_test.dart
git commit -m "Add device-first tile projection foundation"
```

## Task 4: Refresh Drift Mirror Schema

**Files:**
- Modify: `app/lib/core/database/tables.dart`
- Modify: `app/lib/core/database/database.dart`
- Modify: `app/lib/features/entities/infrastructure/repositories/mappers/entity_mapper.dart`
- Modify: `app/lib/features/entities/infrastructure/repositories/drift_entity_repository.dart`
- Test: `app/test/core/database/entities_table_test.dart`
- Test: `app/test/features/entities/infrastructure/drift_entity_repository_test.dart`

- [ ] **Step 1: Add failing persistence tests for stable identity**

In `drift_entity_repository_test.dart`, add:

```dart
test('syncAll upserts by stable registry id when entity_id changes', () async {
  await repo.syncAll(
    serverId: server.id!,
    entities: const [
      HaEntity(
        registryId: 'reg-light',
        uniqueId: 'uid-light',
        platform: 'test',
        entityId: 'light.old_name',
        domain: 'light',
        name: 'Kitchen light',
      ),
    ],
  );

  await repo.syncAll(
    serverId: server.id!,
    entities: const [
      HaEntity(
        registryId: 'reg-light',
        uniqueId: 'uid-light',
        platform: 'test',
        entityId: 'light.new_name',
        domain: 'light',
        name: 'Kitchen light',
      ),
    ],
  );

  final rows = await repo.getByServer(server.id!);
  expect(rows, hasLength(1));
  expect(rows.single.registryId, 'reg-light');
  expect(rows.single.entityId, 'light.new_name');
});
```

- [ ] **Step 2: Run test to verify failure**

Run:

```bash
dart test app/test/features/entities/infrastructure/drift_entity_repository_test.dart
```

Expected: FAIL because the current Drift unique key is `{serverId, entityId}`.

- [ ] **Step 3: Update schema**

Change `Entities` to include:

```dart
TextColumn get registryId => text()();
TextColumn get uniqueId => text()();
TextColumn get platform => text()();
BoolColumn get disabled => boolean().withDefault(const Constant(false))();
BoolColumn get hidden => boolean().withDefault(const Constant(false))();
```

Change unique key:

```dart
@override
List<Set<Column>> get uniqueKeys => [
  {serverId, registryId},
];
```

Update `DeviceEntities` semantics so device identity is `serverId + haId`, where `haId` means HA `device_id`, not mutable `entity_id`. Change unique keys to `{serverId, haId}` and keep `type` as a coarse display hint until the device tile projection replaces it.

- [ ] **Step 4: Regenerate Drift code**

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: generated files update successfully.

- [ ] **Step 5: Update mappers and repository upsert target**

Use `registryId`, `uniqueId`, `platform`, `disabled`, `hidden`, and `entityCategory` in `entity_mapper.dart`. In `DriftEntityRepository.syncAll`, compute `nextIds` from `registryId` and upsert with target `[serverId, registryId]`.

- [ ] **Step 6: Run persistence tests**

Run:

```bash
dart test app/test/core/database/entities_table_test.dart app/test/features/entities/infrastructure/drift_entity_repository_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/core/database/tables.dart app/lib/core/database/database.dart app/lib/core/database/database.g.dart app/lib/features/entities/infrastructure/repositories/mappers/entity_mapper.dart app/lib/features/entities/infrastructure/repositories/drift_entity_repository.dart app/test/core/database/entities_table_test.dart app/test/features/entities/infrastructure/drift_entity_repository_test.dart
git commit -m "Persist HA entity mirror by registry identity"
```

## Task 5: Wire Projection Behind Existing Home UI Boundary

**Files:**
- Modify: `app/lib/features/home/application/home_page_controller.dart`
- Modify: `app/lib/features/home/presentation/screens/home_page.dart`
- Test: `app/test/features/home/home_page_controller_test.dart`
- Test: `app/test/features/home/home_page_test.dart`

- [ ] **Step 1: Add controller tests for generated device tiles**

Add a test that stubs cached devices/entities and verifies the controller exposes a device tile section grouped by HA area. Keep existing entity rendering tests until UI replacement is complete.

- [ ] **Step 2: Introduce a parallel device tile field**

Extend `HomePageState` with a `deviceSections` field while keeping current `sections`. This avoids a big-bang UI rewrite.

- [ ] **Step 3: Compute `deviceSections` from projection**

Use the projection introduced in Task 3. Leave existing entity sections in place for current UI compatibility.

- [ ] **Step 4: Run home tests**

Run:

```bash
dart test app/test/features/home/home_page_controller_test.dart app/test/features/home/home_page_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/home/application/home_page_controller.dart app/lib/features/home/presentation/screens/home_page.dart app/test/features/home/home_page_controller_test.dart app/test/features/home/home_page_test.dart
git commit -m "Expose device-first home projection"
```

## Final Verification

- [ ] Run entity tests:

```bash
dart test app/test/features/entities
```

- [ ] Run home tests:

```bash
dart test app/test/features/home
```

- [ ] Run analyzer:

```bash
dart analyze app
```

- [ ] Inspect git status:

```bash
git status --short
```

Expected: no unstaged changes except generated files intentionally committed during their task.
