# Generic Entity Foundation (lights first) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Render each Home Assistant area as a tab on the Home screen, showing that area's lights as on/off cards, on top of a generic, domain-agnostic entity layer (sync → cache → live state → operations → per-domain widgets).

**Architecture:** A new `features/entities/` feature mirrors the existing `AreaRegistrySyncController` pattern. `EntityRegistrySyncController` caches all non-disabled/non-hidden entities (every domain) into a new generic Drift `entities` table, resolving each entity's area (`entity.area_id ?? device.area_id`). `entityStatesProvider` keeps live `state`/`attributes` via `subscribe_entities`. `EntityServiceController` is the single generic operation path (`call_service`). A presentation-layer domain-handler registry maps a `domain` string to a widget builder; v1 registers only `light`. The Home screen renders cached areas as tabs and cached entities grouped by area, rendering each entity through its handler (entities without a registered handler are skipped). Rendering is fully decoupled from the never-populated `homeView`.

**Tech Stack:** Flutter, Riverpod (codegen `@riverpod`), Drift, freezed/json (existing), `home_assistant_websocket` package, fpdart (`Either`), flutter_test.

**Conventions:**
- Run codegen after any `@riverpod`/`@freezed`/Drift change: from `app/`, `dart run build_runner build --delete-conflicting-outputs`.
- Run tests from `app/`: `flutter test <path>`.
- Commit per task (Conventional Commits, imperative, lowercase, no trailing period).
- The app is pre-production and uses **no Drift migrations**: `schemaVersion` stays `1`. During dev, if a stale `hommie_db` exists, delete it so the new table is created (Drift creates all tables on a fresh DB).

---

## File Structure

**Core DB (modify):**
- `app/lib/core/database/tables.dart` — add `Entities` table.
- `app/lib/core/database/database.dart` — register `Entities`.

**New feature `app/lib/features/entities/`:**
- `domain/entities/ha_entity.dart` — `HaEntity` (cached entity metadata).
- `domain/entities/entity_state_value.dart` — `EntityStateValue` (live state).
- `domain/repositories/i_entity_repository.dart` — `IEntityRepository`.
- `infrastructure/repositories/mappers/entity_mapper.dart` — `EntityRow`⇄`HaEntity`.
- `infrastructure/repositories/drift_entity_repository.dart` — `DriftEntityRepository`.
- `infrastructure/repositories/ha_registry_repository.dart` — registry messages + `HaRegistryRepository` + `EntityRegistryRecord`/`DeviceRegistryRecord`.
- `infrastructure/repositories/entity_resolver.dart` — `resolveEntities(...)` pure function.
- `infrastructure/providers/entity_repository_provider.dart` — `entityRepositoryProvider`.
- `infrastructure/providers/registry_repository_provider.dart` — `registryRepositoryProvider`.
- `application/entity_registry_sync_controller.dart` — `EntitySyncStatus` + `EntityRegistrySyncController`.
- `application/entity_states_provider.dart` — `applyStatesUpdate(...)` pure fn + `EntityStates` notifier.
- `application/entity_service_controller.dart` — `EntityServiceController`.
- `application/cached_entities_provider.dart` — `cachedEntities` stream + `groupEntitiesByArea(...)` pure fn.
- `presentation/handlers/entity_domain_handler.dart` — `EntityDomainHandler` interface + `entityDomainHandlersProvider`.
- `presentation/handlers/light_domain_handler.dart` — `LightDomainHandler`.
- `presentation/widgets/light_card.dart` — `LightCard`.
- `presentation/widgets/entity_card.dart` — `EntityCard` (resolves handler).

**Home feature (modify):**
- `app/lib/features/home/application/home_page_controller.dart` — rework to areas+entities.
- `app/lib/features/home/presentation/screens/home_page.dart` — render via entities, drop `homeView` gate.

---

## Task 1: Add the generic `entities` Drift table

**Files:**
- Modify: `app/lib/core/database/tables.dart` (append new table)
- Modify: `app/lib/core/database/database.dart:9-19` (register table)
- Test: `app/test/core/database/entities_table_test.dart`

- [ ] **Step 1: Append the table to `tables.dart`**

```dart
/// Generic Home Assistant entity cache (every domain).
///
/// `entityId` is the HA entity_id (e.g. "light.kitchen"); `domain` is its prefix
/// ("light"). `areaHaId` is the *resolved* HA area slug, stored denormalized (not
/// an FK) so an area re-sync can never cascade-delete entities and so entity/area
/// syncs stay order-independent — grouping is resolved at read time by matching
/// `areaHaId` against `AreaEntities.haId`.
@DataClassName('EntityRow')
class Entities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityId => text()();
  TextColumn get name => text()();
  TextColumn get domain => text()();
  TextColumn get deviceId => text().nullable()();
  TextColumn get areaHaId => text().nullable()();
  TextColumn get entityCategory => text().nullable()();
  IntColumn get serverId =>
      integer().references(ServerEntities, #id, onDelete: KeyAction.cascade)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {serverId, entityId},
  ];
}
```

- [ ] **Step 2: Register the table in `database.dart`**

In the `@DriftDatabase(tables: [...])` list (`database.dart:9-19`), add `Entities,` after `DeviceHomeConfigs,`. Leave `schemaVersion => 1` unchanged.

- [ ] **Step 3: Regenerate Drift code**

Run (from `app/`): `dart run build_runner build --delete-conflicting-outputs`
Expected: completes; `database.g.dart` now exposes `entities`, `EntityRow`, `EntitiesCompanion`.

- [ ] **Step 4: Write the failing test**

```dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/database/database.dart';

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('entities table inserts and reads back', async {
    final serverId = await db.into(db.serverEntities).insert(
      ServerEntitiesCompanion.insert(name: 'Home', url: 'http://h:8123'),
    );
    await db.into(db.entities).insert(
      EntitiesCompanion.insert(
        entityId: 'light.kitchen',
        name: 'Kitchen',
        domain: 'light',
        serverId: serverId,
        areaHaId: const Value('kitchen'),
      ),
    );

    final rows = await db.select(db.entities).get();
    expect(rows, hasLength(1));
    expect(rows.single.entityId, 'light.kitchen');
    expect(rows.single.areaHaId, 'kitchen');
  });
}
```

Note: replace `async {` with `() async {` (the test body is an async closure).

- [ ] **Step 5: Run the test**

Run: `flutter test test/core/database/entities_table_test.dart`
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/core/database/tables.dart app/lib/core/database/database.dart app/lib/core/database/database.g.dart app/test/core/database/entities_table_test.dart
git commit -m "feat: add generic entities drift table"
```

---

## Task 2: Domain models `HaEntity` and `EntityStateValue`

**Files:**
- Create: `app/lib/features/entities/domain/entities/ha_entity.dart`
- Create: `app/lib/features/entities/domain/entities/entity_state_value.dart`
- Test: `app/test/features/entities/domain/entity_state_value_test.dart`

- [ ] **Step 1: Write `ha_entity.dart`**

```dart
/// Cached, domain-agnostic Home Assistant entity metadata.
class HaEntity {
  final String entityId; // e.g. "light.kitchen"
  final String domain; // e.g. "light"
  final String name;
  final String? deviceId;
  final String? areaId; // HA area slug (matches AreaEntities.haId), or null

  const HaEntity({
    required this.entityId,
    required this.domain,
    required this.name,
    this.deviceId,
    this.areaId,
  });
}
```

- [ ] **Step 2: Write `entity_state_value.dart`**

```dart
/// Live state of an entity (volatile; not persisted).
class EntityStateValue {
  final String state; // "on", "off", "unavailable", ...
  final Map<String, dynamic> attributes;

  const EntityStateValue({required this.state, this.attributes = const {}});

  bool get isOn => state == 'on';
  bool get isUnavailable => state == 'unavailable' || state == 'unknown';
}
```

- [ ] **Step 3: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';

void main() {
  test('isOn / isUnavailable derive from state', () {
    expect(const EntityStateValue(state: 'on').isOn, isTrue);
    expect(const EntityStateValue(state: 'off').isOn, isFalse);
    expect(const EntityStateValue(state: 'unavailable').isUnavailable, isTrue);
  });
}
```

- [ ] **Step 4: Run the test**

Run: `flutter test test/features/entities/domain/entity_state_value_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/entities/domain app/test/features/entities/domain
git commit -m "feat: add HaEntity and EntityStateValue domain models"
```

---

## Task 3: Entity repository (interface, mapper, Drift impl)

**Files:**
- Create: `app/lib/features/entities/domain/repositories/i_entity_repository.dart`
- Create: `app/lib/features/entities/infrastructure/repositories/mappers/entity_mapper.dart`
- Create: `app/lib/features/entities/infrastructure/repositories/drift_entity_repository.dart`
- Test: `app/test/features/entities/infrastructure/drift_entity_repository_test.dart`

- [ ] **Step 1: Write the interface**

```dart
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

abstract interface class IEntityRepository {
  /// Transactional full sync: delete entities no longer present, upsert the rest.
  Future<void> syncAll({required int serverId, required List<HaEntity> entities});

  /// Reactive list of cached entities for a server.
  Stream<List<HaEntity>> watchByServer(int serverId);

  /// One-shot read of cached entities for a server.
  Future<List<HaEntity>> getByServer(int serverId);
}
```

- [ ] **Step 2: Write the mapper**

```dart
import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

extension EntityRowMapper on EntityRow {
  HaEntity toDomain() => HaEntity(
    entityId: entityId,
    domain: domain,
    name: name,
    deviceId: deviceId,
    areaId: areaHaId,
  );
}

extension HaEntityCompanionMapper on HaEntity {
  EntitiesCompanion toCompanion(int serverId) => EntitiesCompanion(
    entityId: Value(entityId),
    name: Value(name),
    domain: Value(domain),
    deviceId: Value(deviceId),
    areaHaId: Value(areaId),
    serverId: Value(serverId),
  );
}
```

- [ ] **Step 3: Write the Drift implementation**

```dart
import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/domain/repositories/i_entity_repository.dart';
import 'package:hommie/features/entities/infrastructure/repositories/mappers/entity_mapper.dart';

class DriftEntityRepository implements IEntityRepository {
  final AppDatabase _db;

  DriftEntityRepository(this._db);

  @override
  Stream<List<HaEntity>> watchByServer(int serverId) {
    return (_db.select(_db.entities)..where((e) => e.serverId.equals(serverId)))
        .watch()
        .map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  @override
  Future<List<HaEntity>> getByServer(int serverId) async {
    final rows = await (_db.select(
      _db.entities,
    )..where((e) => e.serverId.equals(serverId))).get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<void> syncAll({
    required int serverId,
    required List<HaEntity> entities,
  }) async {
    await _db.transaction(() async {
      final existing = await (_db.select(
        _db.entities,
      )..where((e) => e.serverId.equals(serverId))).get();

      final nextIds = entities.map((e) => e.entityId).toSet();

      for (final row in existing) {
        if (!nextIds.contains(row.entityId)) {
          await (_db.delete(
            _db.entities,
          )..where((e) => e.id.equals(row.id))).go();
        }
      }

      for (final entity in entities) {
        await _db
            .into(_db.entities)
            .insert(
              entity.toCompanion(serverId),
              onConflict: DoUpdate(
                (old) => entity.toCompanion(serverId),
                target: [_db.entities.serverId, _db.entities.entityId],
              ),
            );
      }
    });
  }
}
```

- [ ] **Step 4: Write the failing test**

```dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/infrastructure/repositories/drift_entity_repository.dart';
import 'package:drift/drift.dart' show Value;

void main() {
  late AppDatabase db;
  late DriftEntityRepository repo;
  late int serverId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = DriftEntityRepository(db);
    serverId = await db.into(db.serverEntities).insert(
      ServerEntitiesCompanion.insert(name: 'Home', url: 'http://h:8123'),
    );
  });
  tearDown(() => db.close());

  HaEntity light(String id, {String? area}) =>
      HaEntity(entityId: id, domain: 'light', name: id, areaId: area);

  test('syncAll inserts entities', () async {
    await repo.syncAll(serverId: serverId, entities: [light('light.a', area: 'kitchen')]);
    final rows = await repo.getByServer(serverId);
    expect(rows, hasLength(1));
    expect(rows.single.entityId, 'light.a');
    expect(rows.single.areaId, 'kitchen');
  });

  test('syncAll removes entities no longer present and upserts changes', () async {
    await repo.syncAll(serverId: serverId, entities: [light('light.a'), light('light.b')]);
    await repo.syncAll(serverId: serverId, entities: [
      HaEntity(entityId: 'light.a', domain: 'light', name: 'Renamed', areaId: 'den'),
    ]);
    final rows = await repo.getByServer(serverId);
    expect(rows, hasLength(1));
    expect(rows.single.entityId, 'light.a');
    expect(rows.single.name, 'Renamed');
    expect(rows.single.areaId, 'den');
  });

  test('watchByServer emits on change', () async {
    final stream = repo.watchByServer(serverId);
    final future = stream.firstWhere((rows) => rows.isNotEmpty);
    await repo.syncAll(serverId: serverId, entities: [light('light.a')]);
    expect(await future, hasLength(1));
  });
}
```

- [ ] **Step 5: Run the tests**

Run: `flutter test test/features/entities/infrastructure/drift_entity_repository_test.dart`
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/features/entities/domain/repositories app/lib/features/entities/infrastructure/repositories app/test/features/entities/infrastructure
git commit -m "feat: add entity repository with drift cache and diff sync"
```

---

## Task 4: `entityRepositoryProvider`

**Files:**
- Create: `app/lib/features/entities/infrastructure/providers/entity_repository_provider.dart`

- [ ] **Step 1: Write the provider**

```dart
import 'package:hommie/core/infrastructure/database/database_provider.dart';
import 'package:hommie/features/entities/domain/repositories/i_entity_repository.dart';
import 'package:hommie/features/entities/infrastructure/repositories/drift_entity_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_repository_provider.g.dart';

@Riverpod(keepAlive: true)
IEntityRepository entityRepository(Ref ref) {
  final database = ref.watch(databaseConnectionProvider);
  return DriftEntityRepository(database);
}
```

Note: confirm the import path of `databaseConnectionProvider` matches the one used in `app/lib/features/home/infrastructure/providers/area_repository_provider.dart` (`core/infrastructure/database/database_provider.dart`).

- [ ] **Step 2: Regenerate**

Run (from `app/`): `dart run build_runner build --delete-conflicting-outputs`
Expected: `entity_repository_provider.g.dart` generated, no errors.

- [ ] **Step 3: Commit**

```bash
git add app/lib/features/entities/infrastructure/providers/entity_repository_provider.dart app/lib/features/entities/infrastructure/providers/entity_repository_provider.g.dart
git commit -m "feat: add entityRepository provider"
```

---

## Task 5: Registry records + parsing

**Files:**
- Create: `app/lib/features/entities/infrastructure/repositories/ha_registry_repository.dart` (records portion)
- Test: `app/test/features/entities/infrastructure/registry_records_test.dart`

These are lightweight, defensive parsers (only the fields we need) — avoids coupling to the large freezed registry models and tolerates missing optional fields.

- [ ] **Step 1: Write the records (top of `ha_registry_repository.dart`)**

```dart
import 'package:home_assistant_websocket/home_assistant_websocket.dart';

/// Minimal projection of a `config/entity_registry/list` row.
class EntityRegistryRecord {
  final String entityId;
  final String? name;
  final String? originalName;
  final String? deviceId;
  final String? areaId;
  final bool disabled;
  final bool hidden;
  final String? entityCategory;

  const EntityRegistryRecord({
    required this.entityId,
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
        entityId: j['entity_id'] as String,
        name: j['name'] as String?,
        originalName: j['original_name'] as String?,
        deviceId: j['device_id'] as String?,
        areaId: j['area_id'] as String?,
        disabled: j['disabled_by'] != null,
        hidden: j['hidden_by'] != null,
        entityCategory: j['entity_category'] as String?,
      );
}

/// Minimal projection of a `config/device_registry/list` row.
class DeviceRegistryRecord {
  final String id;
  final String? areaId;

  const DeviceRegistryRecord({required this.id, this.areaId});

  factory DeviceRegistryRecord.fromJson(Map<String, dynamic> j) =>
      DeviceRegistryRecord(id: j['id'] as String, areaId: j['area_id'] as String?);
}
```

- [ ] **Step 2: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';

void main() {
  test('EntityRegistryRecord parses and derives disabled/hidden', () {
    final r = EntityRegistryRecord.fromJson({
      'entity_id': 'light.kitchen',
      'name': null,
      'original_name': 'Kitchen',
      'device_id': 'dev1',
      'area_id': null,
      'disabled_by': 'user',
      'hidden_by': null,
      'entity_category': null,
    });
    expect(r.entityId, 'light.kitchen');
    expect(r.originalName, 'Kitchen');
    expect(r.deviceId, 'dev1');
    expect(r.disabled, isTrue);
    expect(r.hidden, isFalse);
  });

  test('DeviceRegistryRecord parses area', () {
    final d = DeviceRegistryRecord.fromJson({'id': 'dev1', 'area_id': 'kitchen'});
    expect(d.id, 'dev1');
    expect(d.areaId, 'kitchen');
  });
}
```

- [ ] **Step 3: Run the test**

Run: `flutter test test/features/entities/infrastructure/registry_records_test.dart`
Expected: PASS.

- [ ] **Step 4: Commit**

```bash
git add app/lib/features/entities/infrastructure/repositories/ha_registry_repository.dart app/test/features/entities/infrastructure/registry_records_test.dart
git commit -m "feat: add lightweight HA registry record parsers"
```

---

## Task 6: Registry messages + `HaRegistryRepository` + provider

**Files:**
- Modify: `app/lib/features/entities/infrastructure/repositories/ha_registry_repository.dart` (append messages + repo)
- Create: `app/lib/features/entities/infrastructure/providers/registry_repository_provider.dart`

- [ ] **Step 1: Append messages + repository to `ha_registry_repository.dart`**

```dart
final class EntityRegistryListMessage extends HARequestMessage {
  const EntityRegistryListMessage();
  @override
  String get type => 'config/entity_registry/list';
  @override
  JsonMap get body => const <String, dynamic>{};
}

final class DeviceRegistryListMessage extends HARequestMessage {
  const DeviceRegistryListMessage();
  @override
  String get type => 'config/device_registry/list';
  @override
  JsonMap get body => const <String, dynamic>{};
}

class HaRegistryRepository {
  final IHAConnection _connection;

  HaRegistryRepository(this._connection);

  Future<List<EntityRegistryRecord>> getEntities() => _connection
      .sendMessage(const EntityRegistryListMessage())
      .mapList(EntityRegistryRecord.fromJson);

  Future<List<DeviceRegistryRecord>> getDevices() => _connection
      .sendMessage(const DeviceRegistryListMessage())
      .mapList(DeviceRegistryRecord.fromJson);
}
```

Note: `JsonMap`, `HARequestMessage`, `IHAConnection`, and the `.mapList` extension are all exported by `home_assistant_websocket` (already imported at the top of the file). Mirror `AreasMessage` in `features/areas/infrastructure/repositories/areas_repository.dart` if the `JsonMap` symbol name differs.

- [ ] **Step 2: Write the provider**

```dart
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registry_repository_provider.g.dart';

@Riverpod(dependencies: [serverScopeConnection])
HaRegistryRepository registryRepository(Ref ref) {
  final connection = ref.watch(serverScopeConnectionProvider);
  return HaRegistryRepository(connection);
}
```

- [ ] **Step 3: Regenerate**

Run (from `app/`): `dart run build_runner build --delete-conflicting-outputs`
Expected: `registry_repository_provider.g.dart` generated; no analyzer errors in the repository file.

- [ ] **Step 4: Sanity-run analyzer**

Run (from `app/`): `flutter analyze lib/features/entities/infrastructure`
Expected: No errors (warnings about unused are acceptable until later tasks wire it).

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/entities/infrastructure/repositories/ha_registry_repository.dart app/lib/features/entities/infrastructure/providers/registry_repository_provider.dart app/lib/features/entities/infrastructure/providers/registry_repository_provider.g.dart
git commit -m "feat: add HA registry repository for entity and device lists"
```

---

## Task 7: `resolveEntities` pure function

**Files:**
- Create: `app/lib/features/entities/infrastructure/repositories/entity_resolver.dart`
- Test: `app/test/features/entities/infrastructure/entity_resolver_test.dart`

- [ ] **Step 1: Write the resolver**

```dart
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';

/// Turns registry rows into cached [HaEntity]s:
/// - drops disabled/hidden entities,
/// - resolves area as entity.area_id ?? device.area_id,
/// - derives domain from the entity_id prefix,
/// - name fallback: name -> original_name -> entity_id.
List<HaEntity> resolveEntities({
  required List<EntityRegistryRecord> entities,
  required List<DeviceRegistryRecord> devices,
}) {
  final deviceAreaById = <String, String?>{
    for (final d in devices) d.id: d.areaId,
  };

  final result = <HaEntity>[];
  for (final e in entities) {
    if (e.disabled || e.hidden) continue;
    final domain = e.entityId.split('.').first;
    final area = e.areaId ?? (e.deviceId != null ? deviceAreaById[e.deviceId] : null);
    final name = e.name ?? e.originalName ?? e.entityId;
    result.add(HaEntity(
      entityId: e.entityId,
      domain: domain,
      name: name,
      deviceId: e.deviceId,
      areaId: area,
    ));
  }
  return result;
}
```

- [ ] **Step 2: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/infrastructure/repositories/entity_resolver.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';

void main() {
  test('resolves entity area then device area; drops disabled/hidden', () {
    final entities = [
      const EntityRegistryRecord(entityId: 'light.a', areaId: 'kitchen'), // direct
      const EntityRegistryRecord(entityId: 'light.b', deviceId: 'dev1'), // via device
      const EntityRegistryRecord(entityId: 'light.c'), // no area
      const EntityRegistryRecord(entityId: 'light.d', disabled: true),
      const EntityRegistryRecord(entityId: 'light.e', hidden: true),
    ];
    final devices = [const DeviceRegistryRecord(id: 'dev1', areaId: 'den')];

    final result = resolveEntities(entities: entities, devices: devices);

    expect(result.map((e) => e.entityId), ['light.a', 'light.b', 'light.c']);
    expect(result[0].areaId, 'kitchen');
    expect(result[0].domain, 'light');
    expect(result[1].areaId, 'den'); // device fallback
    expect(result[2].areaId, isNull);
  });

  test('name falls back original_name then entity_id', () {
    final result = resolveEntities(entities: [
      const EntityRegistryRecord(entityId: 'light.x', originalName: 'X'),
      const EntityRegistryRecord(entityId: 'light.y'),
    ], devices: const []);
    expect(result[0].name, 'X');
    expect(result[1].name, 'light.y');
  });
}
```

- [ ] **Step 3: Run the test**

Run: `flutter test test/features/entities/infrastructure/entity_resolver_test.dart`
Expected: PASS.

- [ ] **Step 4: Commit**

```bash
git add app/lib/features/entities/infrastructure/repositories/entity_resolver.dart app/test/features/entities/infrastructure/entity_resolver_test.dart
git commit -m "feat: add entity area-resolution function"
```

---

## Task 8: `EntityRegistrySyncController`

**Files:**
- Create: `app/lib/features/entities/application/entity_registry_sync_controller.dart`
- Test: `app/test/features/entities/application/entity_registry_sync_controller_test.dart`

Mirrors `app/lib/features/areas/application/area_registry_sync_controller.dart`.

- [ ] **Step 1: Write the controller**

```dart
import 'dart:async';

import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/providers/registry_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/repositories/entity_resolver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_registry_sync_controller.g.dart';

enum EntitySyncStatus { notStarted, syncing, success, failure }

/// Keeps the local entity cache in sync with Home Assistant.
/// Subscribes to entity_registry_updated and device_registry_updated; refreshes
/// the full entity set into Drift on connect and on either event.
@Riverpod(dependencies: [serverScopeId, serverScopeConnection, registryRepository, entityRepository])
class EntityRegistrySyncController extends _$EntityRegistrySyncController {
  HASubscription? _entitySub;
  HASubscription? _deviceSub;
  StreamSubscription<dynamic>? _entityEvents;
  StreamSubscription<dynamic>? _deviceEvents;
  bool _didInitialSync = false;

  @override
  EntitySyncStatus build() {
    final serverId = ref.watch(serverScopeIdProvider);
    final connectionState = ref.watch(serverConnectionStateProvider);

    ref.onDispose(() => unawaited(_stop()));

    if (connectionState != HAServerConnectionState.connected) {
      _didInitialSync = false;
      unawaited(_stop());
      return EntitySyncStatus.notStarted;
    }

    unawaited(_start(serverId));
    return EntitySyncStatus.syncing;
  }

  Future<void> _start(int serverId) async {
    if (_entitySub != null) return;

    final connection = ref.read(serverScopeConnectionProvider);
    _entitySub = HACommands.subscribeEvents(connection, 'entity_registry_updated');
    _deviceSub = HACommands.subscribeEvents(connection, 'device_registry_updated');
    _entityEvents = _entitySub!.stream.listen((_) => unawaited(_sync(serverId)));
    _deviceEvents = _deviceSub!.stream.listen((_) => unawaited(_sync(serverId)));

    if (!_didInitialSync) {
      _didInitialSync = true;
      await _sync(serverId);
    }
  }

  Future<void> _sync(int serverId) async {
    state = EntitySyncStatus.syncing;
    final registry = ref.read(registryRepositoryProvider);
    final local = ref.read(entityRepositoryProvider);
    try {
      final entities = await registry.getEntities();
      final devices = await registry.getDevices();
      final resolved = resolveEntities(entities: entities, devices: devices);
      await local.syncAll(serverId: serverId, entities: resolved);
      state = EntitySyncStatus.success;
    } catch (_) {
      // Surface failure; retried on next event / reconnect.
      state = EntitySyncStatus.failure;
    }
  }

  Future<void> _stop() async {
    await _entityEvents?.cancel();
    await _deviceEvents?.cancel();
    _entityEvents = null;
    _deviceEvents = null;
    for (final sub in [_entitySub, _deviceSub]) {
      if (sub != null && !sub.isDisposed) {
        try {
          await sub.dispose();
        } catch (_) {}
      }
    }
    _entitySub = null;
    _deviceSub = null;
  }
}
```

- [ ] **Step 2: Regenerate**

Run (from `app/`): `dart run build_runner build --delete-conflicting-outputs`
Expected: `entity_registry_sync_controller.g.dart` generated.

- [ ] **Step 3: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/entities/application/entity_registry_sync_controller.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/domain/repositories/i_entity_repository.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/providers/registry_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';

class _FakeRegistry implements HaRegistryRepository {
  @override
  Future<List<EntityRegistryRecord>> getEntities() async =>
      [const EntityRegistryRecord(entityId: 'light.a', areaId: 'kitchen')];
  @override
  Future<List<DeviceRegistryRecord>> getDevices() async => const [];
  // ignore: unused_element
  IHAConnection get connection => throw UnimplementedError();
}

class _FakeEntityRepo implements IEntityRepository {
  final captured = <HaEntity>[];
  @override
  Future<void> syncAll({required int serverId, required List<HaEntity> entities}) async {
    captured
      ..clear()
      ..addAll(entities);
  }
  @override
  Future<List<HaEntity>> getByServer(int serverId) async => captured;
  @override
  Stream<List<HaEntity>> watchByServer(int serverId) => Stream.value(captured);
}

void main() {
  test('does not sync when disconnected', () async {
    final repo = _FakeEntityRepo();
    final container = ProviderContainer(overrides: [
      serverScopeIdProvider.overrideWithValue(1),
      registryRepositoryProvider.overrideWithValue(_FakeRegistry()),
      entityRepositoryProvider.overrideWithValue(repo),
      serverConnectionStateProvider.overrideWith(() => _ConnState(HAServerConnectionState.disconnected)),
    ]);
    addTearDown(container.dispose);

    final status = container.read(entityRegistrySyncControllerProvider);
    expect(status, EntitySyncStatus.notStarted);
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(repo.captured, isEmpty);
  });

  test('initial sync writes resolved entities when connected', () async {
    final repo = _FakeEntityRepo();
    final container = ProviderContainer(overrides: [
      serverScopeIdProvider.overrideWithValue(1),
      serverScopeConnectionProvider.overrideWithValue(_UnusedConnection()),
      registryRepositoryProvider.overrideWithValue(_FakeRegistry()),
      entityRepositoryProvider.overrideWithValue(repo),
      serverConnectionStateProvider.overrideWith(() => _ConnState(HAServerConnectionState.connected)),
    ]);
    addTearDown(container.dispose);

    container.read(entityRegistrySyncControllerProvider);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(repo.captured.map((e) => e.entityId), ['light.a']);
    expect(repo.captured.single.areaId, 'kitchen');
  });
}

class _ConnState extends ServerConnectionState {
  _ConnState(this._initial);
  final HAServerConnectionState _initial;
  @override
  HAServerConnectionState build() => _initial;
}

class _UnusedConnection implements IHAConnection {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
```

Notes for the implementer:
- In the connected test, `_start` calls `HACommands.subscribeEvents(connection, ...)` on `_UnusedConnection`, which throws via `noSuchMethod`. To keep the test focused on the sync path, guard `_start` so a failed `subscribeEvents` still runs the initial `_sync` — OR (preferred) wrap the two `subscribeEvents` calls in a try/catch that logs and proceeds to `_sync`. Add that try/catch in `_start` (around the subscription setup only) before running this test; it also hardens against transient subscribe failures.
- `serverScopeConnectionProvider`/`serverScopeIdProvider` are scoped providers; `overrideWithValue`/`overrideWithValue` at container root is valid for tests.

- [ ] **Step 4: Harden `_start` (make subscription failure non-fatal), then run**

Wrap the four subscription lines in `_start` in `try { ... } catch (_) {}` (keep the `_didInitialSync`/`_sync` block outside the catch).

Run: `flutter test test/features/entities/application/entity_registry_sync_controller_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/entities/application/entity_registry_sync_controller.dart app/lib/features/entities/application/entity_registry_sync_controller.g.dart app/test/features/entities/application/entity_registry_sync_controller_test.dart
git commit -m "feat: add entity registry sync controller"
```

---

## Task 9: `entityStatesProvider` (live state)

**Files:**
- Create: `app/lib/features/entities/application/entity_states_provider.dart`
- Test: `app/test/features/entities/application/apply_states_update_test.dart`

The compressed-diff merge is extracted as a pure function for testing; the notifier is a thin subscription wrapper.

- [ ] **Step 1: Write the pure merge + notifier**

```dart
import 'dart:async';

import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_states_provider.g.dart';

/// Applies a compressed [StatesUpdates] (subscribe_entities payload) onto the
/// current entity-state map and returns the new map.
Map<String, EntityStateValue> applyStatesUpdate(
  Map<String, EntityStateValue> current,
  StatesUpdates update,
) {
  final next = Map<String, EntityStateValue>.from(current);

  update.add?.forEach((entityId, es) {
    next[entityId] = EntityStateValue(
      state: es.state ?? 'unknown',
      attributes: es.attributes ?? const {},
    );
  });

  update.change?.forEach((entityId, diff) {
    final plus = diff.add;
    if (plus == null) return;
    final cur = next[entityId];
    next[entityId] = EntityStateValue(
      state: plus.state ?? cur?.state ?? 'unknown',
      attributes: {...?cur?.attributes, ...?plus.attributes},
    );
  });

  update.remove?.forEach(next.remove);

  return next;
}

@Riverpod(dependencies: [serverScopeConnection])
class EntityStates extends _$EntityStates {
  HASubscription? _sub;
  StreamSubscription<dynamic>? _events;

  @override
  Map<String, EntityStateValue> build() {
    final connectionState = ref.watch(serverConnectionStateProvider);
    final connection = ref.watch(serverScopeConnectionProvider);

    ref.onDispose(() {
      unawaited(_events?.cancel());
      final sub = _sub;
      if (sub != null && !sub.isDisposed) unawaited(sub.dispose());
    });

    if (connectionState != HAServerConnectionState.connected) {
      return const {};
    }

    try {
      _sub = HACommands.subscribeEntities(connection);
      _events = _sub!.stream.listen((update) {
        if (update is StatesUpdates) {
          state = applyStatesUpdate(state, update);
        }
      });
    } catch (_) {
      // Offline / unavailable connection: leave state empty.
    }

    return const {};
  }
}
```

- [ ] **Step 2: Regenerate**

Run (from `app/`): `dart run build_runner build --delete-conflicting-outputs`
Expected: `entity_states_provider.g.dart` generated.

- [ ] **Step 3: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';

void main() {
  test('add then change updates state map', () {
    var map = <String, EntityStateValue>{};

    map = applyStatesUpdate(
      map,
      StatesUpdates(add: {'light.a': EntityState(state: 'off')}),
    );
    expect(map['light.a']!.isOn, isFalse);

    map = applyStatesUpdate(
      map,
      StatesUpdates(change: {'light.a': EntityDiff(add: EntityState(state: 'on'))}),
    );
    expect(map['light.a']!.isOn, isTrue);
  });

  test('remove drops the entity', () {
    var map = applyStatesUpdate(
      {},
      StatesUpdates(add: {'light.a': EntityState(state: 'on')}),
    );
    map = applyStatesUpdate(map, const StatesUpdates(remove: ['light.a']));
    expect(map.containsKey('light.a'), isFalse);
  });
}
```

- [ ] **Step 4: Run the test**

Run: `flutter test test/features/entities/application/apply_states_update_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/entities/application/entity_states_provider.dart app/lib/features/entities/application/entity_states_provider.g.dart app/test/features/entities/application/apply_states_update_test.dart
git commit -m "feat: add live entity-states provider"
```

---

## Task 10: `EntityServiceController` (generic operations)

**Files:**
- Create: `app/lib/features/entities/application/entity_service_controller.dart`
- Test: `app/test/features/entities/application/entity_service_controller_test.dart`

- [ ] **Step 1: Write the controller**

```dart
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_service_controller.g.dart';

/// Single generic path for entity operations: calls an HA service on an entity.
class EntityServiceController {
  final IHAConnection _connection;

  EntityServiceController(this._connection);

  /// Calls `<domain>.<service>` targeting [entityId]. Domain is derived from the
  /// entity_id prefix unless [domainOverride] is given.
  Future<void> call(
    String entityId,
    String service, {
    String? domainOverride,
    Map<String, dynamic>? data,
  }) async {
    final domain = domainOverride ?? entityId.split('.').first;
    await HACommands.callService(
      _connection,
      domain: domain,
      service: service,
      target: entityId,
      serviceData: data,
    );
  }
}

@Riverpod(dependencies: [serverScopeConnection])
EntityServiceController entityServiceController(Ref ref) {
  final connection = ref.watch(serverScopeConnectionProvider);
  return EntityServiceController(connection);
}
```

- [ ] **Step 2: Regenerate**

Run (from `app/`): `dart run build_runner build --delete-conflicting-outputs`
Expected: `entity_service_controller.g.dart` generated.

- [ ] **Step 3: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/entities/application/entity_service_controller.dart';

class _CapturingConnection implements IHAConnection {
  HARequestMessage? sent;
  @override
  Future<dynamic> sendMessage(HAMessage message) async {
    sent = message as HARequestMessage;
    return {'context': {'id': 'x'}};
  }
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  test('call derives domain and targets the entity', () async {
    final conn = _CapturingConnection();
    final controller = EntityServiceController(conn);

    await controller.call('light.kitchen', 'toggle');

    expect(conn.sent!.type, 'call_service');
    final body = conn.sent!.body;
    expect(body['domain'], 'light');
    expect(body['service'], 'toggle');
    expect(body['target'], {'entity_id': 'light.kitchen'});
  });
}
```

Note: `HACommands.callService` wraps the result in `.mapItem(CallServiceResponse.fromJson)`, so the fake returns a map with a `context`. Confirm the `HAMessage`/`HARequestMessage`/`body`/`type` members are exported from the package (they are — `ha_messages.dart` is exported).

- [ ] **Step 4: Run the test**

Run: `flutter test test/features/entities/application/entity_service_controller_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/entities/application/entity_service_controller.dart app/lib/features/entities/application/entity_service_controller.g.dart app/test/features/entities/application/entity_service_controller_test.dart
git commit -m "feat: add generic entity service controller"
```

---

## Task 11: Domain-handler interface + registry provider

**Files:**
- Create: `app/lib/features/entities/presentation/handlers/entity_domain_handler.dart`

- [ ] **Step 1: Write the interface + registry provider**

```dart
import 'package:flutter/widgets.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/handlers/light_domain_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_domain_handler.g.dart';

/// Per-domain presentation + operations plug-in. Add a device type later by
/// registering a new handler in [entityDomainHandlers] — nothing else changes.
abstract class EntityDomainHandler {
  String get domain;
  Widget buildCard(HaEntity entity, EntityStateValue? state);
}

@riverpod
Map<String, EntityDomainHandler> entityDomainHandlers(Ref ref) {
  final handlers = <EntityDomainHandler>[const LightDomainHandler()];
  return {for (final h in handlers) h.domain: h};
}
```

- [ ] **Step 2: Defer build_runner to Task 12** (this file imports `LightDomainHandler`, created next). Do not run codegen yet.

- [ ] **Step 3: Commit**

```bash
git add app/lib/features/entities/presentation/handlers/entity_domain_handler.dart
git commit -m "feat: add entity domain-handler interface and registry"
```

---

## Task 12: `LightDomainHandler` + `LightCard`

**Files:**
- Create: `app/lib/features/entities/presentation/widgets/light_card.dart`
- Create: `app/lib/features/entities/presentation/handlers/light_domain_handler.dart`
- Test: `app/test/features/entities/presentation/light_card_test.dart`

- [ ] **Step 1: Write `LightCard`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/entities/application/entity_service_controller.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class LightCard extends ConsumerStatefulWidget {
  const LightCard({super.key, required this.entity, required this.state});

  final HaEntity entity;
  final EntityStateValue? state;

  @override
  ConsumerState<LightCard> createState() => _LightCardState();
}

class _LightCardState extends ConsumerState<LightCard> {
  bool? _optimistic;

  bool get _isOn => _optimistic ?? widget.state?.isOn ?? false;
  bool get _unavailable => widget.state == null || widget.state!.isUnavailable;

  Future<void> _toggle() async {
    final previous = _isOn;
    setState(() => _optimistic = !previous);
    try {
      await ref.read(entityServiceControllerProvider).call(widget.entity.entityId, 'toggle');
    } catch (_) {
      if (mounted) setState(() => _optimistic = previous);
    }
  }

  @override
  void didUpdateWidget(covariant LightCard old) {
    super.didUpdateWidget(old);
    // Once real state matches optimistic guess, drop the override.
    if (_optimistic != null && widget.state?.isOn == _optimistic) {
      _optimistic = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('light_card.${widget.entity.entityId}'),
      child: ListTile(
        leading: Icon(_isOn ? Symbols.lightbulb_rounded : Symbols.lightbulb_outline_rounded),
        title: Text(widget.entity.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(_unavailable ? 'Unavailable' : (_isOn ? 'On' : 'Off')),
        trailing: Switch(
          value: _isOn,
          onChanged: _unavailable ? null : (_) => _toggle(),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Write `LightDomainHandler`**

```dart
import 'package:flutter/widgets.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/handlers/entity_domain_handler.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';

class LightDomainHandler extends EntityDomainHandler {
  const LightDomainHandler();

  @override
  String get domain => 'light';

  @override
  Widget buildCard(HaEntity entity, EntityStateValue? state) =>
      LightCard(entity: entity, state: state);
}
```

Note: `EntityDomainHandler` has no `const` constructor by default; either add `const EntityDomainHandler();` to the abstract class so `const LightDomainHandler()` compiles, or drop `const` in both the handler constructor and the `entityDomainHandlers` list. Choose adding `const EntityDomainHandler();` to the interface.

- [ ] **Step 3: Regenerate (now that LightDomainHandler exists)**

Run (from `app/`): `dart run build_runner build --delete-conflicting-outputs`
Expected: `entity_domain_handler.g.dart` generated; no errors.

- [ ] **Step 4: Write the failing widget test**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';

class _CapturingConnection implements IHAConnection {
  String? lastService;
  @override
  Future<dynamic> sendMessage(HAMessage message) async {
    lastService = (message as HARequestMessage).body['service'] as String?;
    return {'context': {'id': 'x'}};
  }
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  testWidgets('tapping the switch calls toggle and flips optimistically', (tester) async {
    final conn = _CapturingConnection();
    await tester.pumpWidget(ProviderScope(
      overrides: [serverScopeConnectionProvider.overrideWithValue(conn)],
      child: const MaterialApp(
        home: Scaffold(
          body: LightCard(
            entity: HaEntity(entityId: 'light.kitchen', domain: 'light', name: 'Kitchen'),
            state: EntityStateValue(state: 'off'),
          ),
        ),
      ),
    ));

    expect(find.text('Off'), findsOneWidget);
    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(conn.lastService, 'toggle');
    expect(find.text('On'), findsOneWidget); // optimistic flip
  });
}
```

- [ ] **Step 5: Run the test**

Run: `flutter test test/features/entities/presentation/light_card_test.dart`
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/features/entities/presentation app/test/features/entities/presentation/light_card_test.dart
git commit -m "feat: add light domain handler and light card"
```

---

## Task 13: `EntityCard` (resolve handler, skip unknown)

**Files:**
- Create: `app/lib/features/entities/presentation/widgets/entity_card.dart`
- Test: `app/test/features/entities/presentation/entity_card_test.dart`

- [ ] **Step 1: Write `EntityCard`**

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/handlers/entity_domain_handler.dart';

/// Renders an entity via its domain handler. Returns an empty widget when the
/// entity's domain has no registered handler (skipped in v1 for non-lights).
class EntityCard extends ConsumerWidget {
  const EntityCard({super.key, required this.entity});

  final HaEntity entity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handler = ref.watch(entityDomainHandlersProvider)[entity.domain];
    if (handler == null) return const SizedBox.shrink();
    final state = ref.watch(entityStatesProvider.select((m) => m[entity.entityId]));
    return handler.buildCard(entity, state);
  }
}

/// True when an entity has a registered handler (used to filter the grid).
bool hasHandler(WidgetRef ref, HaEntity entity) =>
    ref.read(entityDomainHandlersProvider).containsKey(entity.domain);
```

- [ ] **Step 2: Write the failing test**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/widgets/entity_card.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';

void main() {
  testWidgets('light renders LightCard; unknown domain renders nothing', (tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Column(children: [
            EntityCard(entity: HaEntity(entityId: 'light.a', domain: 'light', name: 'A')),
            EntityCard(entity: HaEntity(entityId: 'sensor.b', domain: 'sensor', name: 'B')),
          ]),
        ),
      ),
    ));
    await tester.pump();

    expect(find.byType(LightCard), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsNothing);
  });
}
```

- [ ] **Step 3: Run the test**

Run: `flutter test test/features/entities/presentation/entity_card_test.dart`
Expected: PASS.

- [ ] **Step 4: Commit**

```bash
git add app/lib/features/entities/presentation/widgets/entity_card.dart app/test/features/entities/presentation/entity_card_test.dart
git commit -m "feat: add entity card that resolves domain handlers"
```

---

## Task 14: `cachedEntities` provider + `groupEntitiesByArea`

**Files:**
- Create: `app/lib/features/entities/application/cached_entities_provider.dart`
- Test: `app/test/features/entities/application/group_entities_by_area_test.dart`

- [ ] **Step 1: Write the provider + grouping helper**

```dart
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cached_entities_provider.g.dart';

@Riverpod(dependencies: [serverScopeId])
Stream<List<HaEntity>> cachedEntities(Ref ref) {
  final serverId = ref.watch(serverScopeIdProvider);
  return ref.watch(entityRepositoryProvider).watchByServer(serverId);
}

/// One renderable section: an area (or the synthetic unassigned group) + its entities.
class AreaSection {
  final String? areaId; // null => unassigned (Summary only)
  final String title;
  final List<HaEntity> entities;
  const AreaSection({required this.areaId, required this.title, required this.entities});
}

/// Groups entities under the given areas (sorted by name), appending a trailing
/// "Unassigned" section for entities whose areaId matches no known area.
List<AreaSection> groupEntitiesByArea(List<Area> areas, List<HaEntity> entities) {
  final sortedAreas = [...areas]..sort((a, b) => a.name.compareTo(b.name));
  final knownAreaIds = sortedAreas.map((a) => a.id).toSet();

  final sections = <AreaSection>[
    for (final area in sortedAreas)
      AreaSection(
        areaId: area.id,
        title: area.name,
        entities: entities.where((e) => e.areaId == area.id).toList(),
      ),
  ];

  final unassigned = entities
      .where((e) => e.areaId == null || !knownAreaIds.contains(e.areaId))
      .toList();
  if (unassigned.isNotEmpty) {
    sections.add(AreaSection(areaId: null, title: 'Unassigned', entities: unassigned));
  }
  return sections;
}
```

- [ ] **Step 2: Regenerate**

Run (from `app/`): `dart run build_runner build --delete-conflicting-outputs`
Expected: `cached_entities_provider.g.dart` generated.

- [ ] **Step 3: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

void main() {
  HaEntity e(String id, String? area) =>
      HaEntity(entityId: id, domain: 'light', name: id, areaId: area);

  test('groups by area, sorts areas, appends unassigned', () {
    final areas = [
      const Area(id: 'kitchen', name: 'Kitchen'),
      const Area(id: 'bath', name: 'Bath'),
    ];
    final entities = [e('light.a', 'kitchen'), e('light.b', 'bath'), e('light.c', null), e('light.d', 'ghost')];

    final sections = groupEntitiesByArea(areas, entities);

    expect(sections.map((s) => s.title), ['Bath', 'Kitchen', 'Unassigned']);
    expect(sections[1].entities.map((x) => x.entityId), ['light.a']);
    expect(sections.last.entities.map((x) => x.entityId), ['light.c', 'light.d']);
  });

  test('no unassigned section when all entities are placed', () {
    final sections = groupEntitiesByArea(
      [const Area(id: 'kitchen', name: 'Kitchen')],
      [e('light.a', 'kitchen')],
    );
    expect(sections.map((s) => s.title), ['Kitchen']);
  });
}
```

- [ ] **Step 4: Run the test**

Run: `flutter test test/features/entities/application/group_entities_by_area_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/entities/application/cached_entities_provider.dart app/lib/features/entities/application/cached_entities_provider.g.dart app/test/features/entities/application/group_entities_by_area_test.dart
git commit -m "feat: add cached entities stream and area grouping"
```

---

## Task 15: Rework `HomePageController`

**Files:**
- Modify: `app/lib/features/home/application/home_page_controller.dart` (replace contents)
- Test: `app/test/features/home/home_page_controller_test.dart`

Replaces the `homeView`-based state with areas (for tabs) + grouped sections (for content), derived from cached areas + cached entities. Keeps `isEditing`/`toggleEditMode` (still referenced by the app bar menu).

- [ ] **Step 1: Replace `home_page_controller.dart` with:**

```dart
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/areas/application/area_registry_sync_controller.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/application/entity_registry_sync_controller.dart';
import 'package:hommie/features/home/application/cached_areas_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

sealed class HomeTab {
  const HomeTab();
}

final class HomeSummaryTab extends HomeTab {
  const HomeSummaryTab();
}

final class HomeAreaTab extends HomeTab {
  final String areaId;
  final String title;
  const HomeAreaTab({required this.areaId, required this.title});
}

class HomePageState {
  final bool isEditing;
  final String serverName;
  final List<HomeTab> tabs;
  final List<AreaSection> sections; // all areas + trailing unassigned
  final bool isSyncing; // first entity sync not finished

  const HomePageState({
    this.isEditing = false,
    this.serverName = '',
    this.tabs = const [HomeSummaryTab()],
    this.sections = const [],
    this.isSyncing = false,
  });

  HomePageState copyWith({
    bool? isEditing,
    String? serverName,
    List<HomeTab>? tabs,
    List<AreaSection>? sections,
    bool? isSyncing,
  }) => HomePageState(
    isEditing: isEditing ?? this.isEditing,
    serverName: serverName ?? this.serverName,
    tabs: tabs ?? this.tabs,
    sections: sections ?? this.sections,
    isSyncing: isSyncing ?? this.isSyncing,
  );

  /// Sections for a specific area tab (area sections only, never unassigned).
  List<AreaSection> sectionsForArea(String areaId) =>
      sections.where((s) => s.areaId == areaId).toList();
}

@Riverpod(
  dependencies: [
    serverScopeServer,
    cachedAreas,
    cachedEntities,
    AreaRegistrySyncController,
    EntityRegistrySyncController,
  ],
)
class HomePageController extends _$HomePageController {
  bool _isEditing = false;

  @override
  HomePageState build() {
    // Keep caches in sync while connected.
    ref.watch(areaRegistrySyncControllerProvider);
    final syncStatus = ref.watch(entityRegistrySyncControllerProvider);

    final server = ref.watch(serverScopeServerProvider);
    final areas = ref.watch(cachedAreasProvider).valueOrNull ?? const <Area>[];
    final entities = ref.watch(cachedEntitiesProvider).valueOrNull ?? const [];

    final sections = groupEntitiesByArea(areas, entities);
    final isSyncing = entities.isEmpty &&
        (syncStatus == EntitySyncStatus.syncing ||
            syncStatus == EntitySyncStatus.notStarted);

    return HomePageState(
      isEditing: _isEditing,
      serverName: server.name,
      tabs: _tabsFromAreas(areas),
      sections: sections,
      isSyncing: isSyncing,
    );
  }

  static List<HomeTab> _tabsFromAreas(List<Area> areas) {
    if (areas.isEmpty) return const [HomeSummaryTab()];
    final sorted = [...areas]..sort((a, b) => a.name.compareTo(b.name));
    return [
      const HomeSummaryTab(),
      for (final area in sorted) HomeAreaTab(areaId: area.id, title: area.name),
    ];
  }

  void toggleEditMode() {
    _isEditing = !_isEditing;
    state = state.copyWith(isEditing: _isEditing);
  }
}
```

- [ ] **Step 2: Regenerate**

Run (from `app/`): `dart run build_runner build --delete-conflicting-outputs`
Expected: `home_page_controller.g.dart` updated. (Other references like `homeView`, `isReordering`, `toggleReorderMode`, `DeviceWidgetConf`, `AreaHomeConf` are removed; the home_page rewrite in Task 16 drops their usages.)

- [ ] **Step 3: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/application/entity_registry_sync_controller.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/home/application/cached_areas_provider.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

void main() {
  test('builds summary + per-area tabs and sections', () {
    final container = ProviderContainer(overrides: [
      serverScopeServerProvider.overrideWithValue(
        const Server(id: 1, name: 'Home', url: 'http://h:8123'),
      ),
      cachedAreasProvider.overrideWith((ref) => Stream.value([
        const Area(id: 'kitchen', name: 'Kitchen'),
      ])),
      cachedEntitiesProvider.overrideWith((ref) => Stream.value([
        const HaEntity(entityId: 'light.a', domain: 'light', name: 'A', areaId: 'kitchen'),
      ])),
      entityRegistrySyncControllerProvider.overrideWith(() => _SyncOk()),
    ]);
    addTearDown(container.dispose);

    // Allow stream providers to emit.
    return Future<void>.delayed(const Duration(milliseconds: 20), () {
      final state = container.read(homePageControllerProvider);
      expect(state.tabs.whereType<HomeAreaTab>().map((t) => t.title), ['Kitchen']);
      expect(state.sections.first.entities.single.entityId, 'light.a');
      expect(state.isSyncing, isFalse);
    });
  });
}

class _SyncOk extends EntityRegistrySyncController {
  @override
  EntitySyncStatus build() => EntitySyncStatus.success;
}
```

Note: confirm the `Server` constructor signature (`app/lib/features/servers/domain/entities/server.dart`) and adjust the literal if fields differ. Also verify the exact `AreaRegistrySyncController` override is unnecessary here because `cachedAreas`/`cachedEntities` are overridden directly; if `homePageControllerProvider` still constructs the sync controllers, add `areaRegistrySyncControllerProvider.overrideWith(() => _AreaSyncNoop())` similarly.

- [ ] **Step 4: Run the test**

Run: `flutter test test/features/home/home_page_controller_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/home/application/home_page_controller.dart app/lib/features/home/application/home_page_controller.g.dart app/test/features/home/home_page_controller_test.dart
git commit -m "refactor: rebuild home page controller around areas and entities"
```

---

## Task 16: Rework `home_page.dart` to render entities by area

**Files:**
- Modify: `app/lib/features/home/presentation/screens/home_page.dart` (replace contents)
- Test: `app/test/features/home/home_page_test.dart`

Removes the `homeView`/`DeviceWidget`/`DragGridView` machinery; renders `AreaSection`s through `EntityCard`. Keeps `RoomGroup` and the app bar.

- [ ] **Step 1: Replace `home_page.dart` with:**

```dart
import 'package:flutter/material.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/presentation/widgets/entity_card.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([HomePageController])
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homePageControllerProvider);
    final showTabs = state.tabs.length > 1;

    if (state.isSyncing && state.sections.isEmpty) {
      return Scaffold(
        key: K.home.page,
        appBar: AppBar(title: Text(state.serverName)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (!showTabs) {
      return Scaffold(
        key: K.home.page,
        body: CustomScrollView(slivers: [
          _appBar(context, state),
          ..._sectionSlivers(state.sections, summary: true),
        ]),
      );
    }

    return DefaultTabController(
      length: state.tabs.length,
      child: Scaffold(
        key: K.home.page,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            _appBar(
              context,
              state,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  for (final tab in state.tabs)
                    switch (tab) {
                      HomeSummaryTab() => const Tab(text: 'Summary'),
                      HomeAreaTab(:final title) => Tab(text: title),
                    },
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              for (final tab in state.tabs)
                switch (tab) {
                  HomeSummaryTab() => CustomScrollView(
                      key: const PageStorageKey('home.summary'),
                      slivers: _sectionSlivers(state.sections, summary: true),
                    ),
                  HomeAreaTab(:final areaId) => CustomScrollView(
                      key: PageStorageKey('home.area.$areaId'),
                      slivers: _sectionSlivers(state.sectionsForArea(areaId), summary: false),
                    ),
                },
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _appBar(BuildContext context, HomePageState state, {PreferredSizeWidget? bottom}) {
    return SliverAppBar(
      title: Text(state.serverName),
      centerTitle: false,
      floating: true,
      pinned: true,
      bottom: bottom,
      actions: [
        IconButton(
          key: K.appScaffold.settingsButton,
          icon: const Icon(Symbols.settings_rounded),
          onPressed: () => const SettingsRouteData().push(context),
        ),
      ],
    );
  }

  List<Widget> _sectionSlivers(List<AreaSection> sections, {required bool summary}) {
    if (sections.isEmpty) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: Text('No lights here yet')),
        ),
      ];
    }
    return [
      for (final section in sections)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          sliver: SliverList.list(children: [
            if (summary) RoomGroup(roomName: section.title),
            if (section.entities.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('No lights here yet'),
              )
            else
              for (final entity in section.entities) EntityCard(entity: entity),
          ]),
        ),
    ];
  }
}

class RoomGroup extends StatelessWidget {
  const RoomGroup({super.key, required this.roomName});
  final String roomName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        roomName,
        style: context.fonts.titleMedium?.copyWith(color: context.colors.onSurfaceVariant),
      ),
    );
  }
}
```

Notes:
- This drops the `DeviceWidget`, `HomeDevicesGridView`, `OnOffToggleButton`, and drag-reorder code. If anything else imports those symbols, update those imports (grep `HomeDevicesGridView|DeviceWidget|OnOffToggleButton`); none are expected outside this file.
- Confirm `context.fonts`/`context.colors` come from `ui/utils.dart` (they did in the original file).
- Keep `K.home.page` and `K.appScaffold.settingsButton` keys so existing integration/widget tests keep matching.

- [ ] **Step 2: Write the failing widget test**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/home/presentation/screens/home_page.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';

class _StubHomeController extends HomePageController {
  @override
  HomePageState build() => HomePageState(
        serverName: 'Home',
        tabs: const [HomeSummaryTab(), HomeAreaTab(areaId: 'kitchen', title: 'Kitchen')],
        sections: const [
          AreaSection(
            areaId: 'kitchen',
            title: 'Kitchen',
            entities: [HaEntity(entityId: 'light.a', domain: 'light', name: 'A', areaId: 'kitchen')],
          ),
        ],
      );
}

void main() {
  testWidgets('renders area tabs and a light card', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [homePageControllerProvider.overrideWith(() => _StubHomeController())],
      child: const MaterialApp(home: HomePage()),
    ));
    await tester.pump();

    expect(find.text('Kitchen'), findsWidgets); // tab + room group
    expect(find.byType(LightCard), findsOneWidget);
  });
}
```

Note: this test imports `HaEntity` transitively; add `import 'package:hommie/features/entities/domain/entities/ha_entity.dart';`. If `homePageControllerProvider.overrideWith` requires the codegen'd notifier base, confirm the generated provider supports `.overrideWith(() => Notifier)` (it does for `@riverpod class`).

- [ ] **Step 3: Run the test**

Run: `flutter test test/features/home/home_page_test.dart`
Expected: PASS.

- [ ] **Step 4: Full analyze + test sweep**

Run (from `app/`): `flutter analyze`
Expected: no errors. Fix any dangling references to removed `home_view`/`DeviceWidget` symbols.

Run (from `app/`): `flutter test`
Expected: all pass.

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/home/presentation/screens/home_page.dart app/test/features/home/home_page_test.dart
git commit -m "feat: render areas as tabs with lights, drop home-view dependency"
```

---

## Task 17: Verify on a real instance + cleanup

**Files:**
- (No new files; verification + targeted fixes.)

- [ ] **Step 1: Run the app against a real/test HA**

Run (from `app/`): `flutter run -d macos`
Expected: Home shows a Summary tab + one tab per area; lights appear under their areas with correct on/off; toggling a light updates HA and the card; areas with no lights show the empty state; area-less lights appear under "Unassigned" on Summary.

- [ ] **Step 2: Confirm offline behavior**

Disconnect the network after one successful sync; relaunch. Expected: tabs + cached light list still render; cards show "Unavailable" with disabled switches.

- [ ] **Step 3: Remove the now-dead `home_view` render path (optional cleanup)**

If `HomeViewConf`, `AreaHomeConf`, `DeviceWidgetConf`, and `home_view`-only providers are unreferenced after Task 16 (grep to confirm), leave the Drift `homeView*`/`DeviceEntities` tables in place (future customization), but you may delete the unused `home_view.dart` domain types and `home_data_controller`/`cached_areas` duplication if they are dead. Do not remove anything still imported.

- [ ] **Step 4: Commit any cleanup**

```bash
git add -A
git commit -m "chore: remove dead home-view render types"
```

---

## Self-Review (completed during authoring)

- **Spec coverage:** entity registry cache (Tasks 1–4, 8), generic state store (Task 9), generic operations (Task 10), domain-handler registry (Tasks 11–13), area-grouped rendering decoupled from `homeView` (Tasks 14–16), lights as the only v1 handler (Task 12), all-non-disabled/hidden sync scope (Task 7), denormalized `areaHaId` (Task 1), edge cases — unassigned/empty/offline/loading (Tasks 14, 16, 17). Reliability fixes: single-source tabs (Task 15 derives from streams), sync status surfaced (`EntitySyncStatus`, Tasks 8/15), no `server.id!` crash (Task 15 uses `serverScopeServer.name` only). Covered.
- **Type consistency:** `HaEntity`, `EntityStateValue`, `EntitySyncStatus`, `AreaSection`, `HomePageState`, `EntityDomainHandler.buildCard`, `EntityServiceController.call`, repository `syncAll`/`watchByServer`/`getByServer` are used consistently across tasks.
- **Known verification points flagged inline:** `Server` constructor shape (Task 15), `databaseConnectionProvider` import path (Task 4), `JsonMap` symbol (Task 6), `const EntityDomainHandler()` (Task 12), generated-provider `.overrideWith` (Tasks 15/16). These are confirm-and-adjust, not placeholders.
```
