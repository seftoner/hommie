import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/database/database.dart';

void main() {
  test('entities table inserts and reads back', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    final serverId = await db
        .into(db.serverEntities)
        .insert(
          ServerEntitiesCompanion.insert(name: 'Home', url: 'http://h:8123'),
        );
    await db
        .into(db.entities)
        .insert(
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
    expect(rows.single.name, 'Kitchen');
    expect(rows.single.domain, 'light');
    expect(rows.single.areaHaId, 'kitchen');
  });

  test('migrates v1 registry tables to v2 entity schema', () async {
    final migrated = AppDatabase(NativeDatabase.memory(setup: _seedV1Schema));
    addTearDown(migrated.close);

    final entityRows = await migrated.select(migrated.entities).get();
    expect(entityRows, isEmpty);

    final devices = await migrated.select(migrated.deviceEntities).get();
    expect(devices, hasLength(1));
    expect(devices.single.haId, 'light.kitchen');
    expect(devices.single.serverId, 1);

    final deviceAreas = await migrated.select(migrated.deviceAreaConfigs).get();
    expect(deviceAreas, hasLength(1));
    expect(deviceAreas.single.deviceId, devices.single.id);
    expect(deviceAreas.single.areaId, 1);

    await migrated
        .into(migrated.entities)
        .insert(
          EntitiesCompanion.insert(
            entityId: 'light.kitchen',
            name: 'Kitchen',
            domain: 'light',
            serverId: 1,
            areaHaId: const Value('kitchen'),
          ),
        );
    final insertedEntities = await migrated.select(migrated.entities).get();
    expect(insertedEntities.single.entityId, 'light.kitchen');
  });
}

void _seedV1Schema(dynamic rawDb) {
  rawDb
    ..execute('''
      CREATE TABLE server_entities (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 0,
        url TEXT NOT NULL,
        version TEXT NULL
      );
    ''')
    ..execute('''
      CREATE TABLE area_entities (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        ha_id TEXT NOT NULL UNIQUE,
        name TEXT NOT NULL,
        background TEXT NULL,
        image TEXT NULL,
        server_id INTEGER NOT NULL REFERENCES server_entities (id)
          ON DELETE CASCADE
      );
    ''')
    ..execute('''
      CREATE TABLE device_entities (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        ha_id TEXT NOT NULL UNIQUE,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        area_id INTEGER NOT NULL REFERENCES area_entities (id)
          ON DELETE CASCADE
      );
    ''')
    ..execute('''
      CREATE TABLE home_view_configs (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        server_id INTEGER NOT NULL UNIQUE REFERENCES server_entities (id)
          ON DELETE CASCADE
      );
    ''')
    ..execute('''
      CREATE TABLE area_home_configs (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "order" INTEGER NOT NULL,
        area_id INTEGER NOT NULL REFERENCES area_entities (id)
          ON DELETE CASCADE,
        home_config_id INTEGER NOT NULL REFERENCES home_view_configs (id)
          ON DELETE CASCADE,
        UNIQUE(home_config_id, area_id)
      );
    ''')
    ..execute('''
      CREATE TABLE device_home_configs (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "order" INTEGER NOT NULL,
        size INTEGER NOT NULL,
        device_id INTEGER NOT NULL REFERENCES device_entities (id)
          ON DELETE CASCADE,
        area_config_id INTEGER NOT NULL REFERENCES area_home_configs (id)
          ON DELETE CASCADE,
        UNIQUE(area_config_id, device_id)
      );
    ''')
    ..execute('''
      INSERT INTO server_entities (id, name, is_active, url, version)
      VALUES (1, 'Home', 1, 'http://home.test', '2026.6.1');
    ''')
    ..execute('''
      INSERT INTO area_entities (id, ha_id, name, server_id)
      VALUES (1, 'kitchen', 'Kitchen', 1);
    ''')
    ..execute('''
      INSERT INTO device_entities (id, ha_id, name, type, area_id)
      VALUES (1, 'light.kitchen', 'Kitchen', 'light', 1);
    ''')
    ..execute('PRAGMA user_version = 1;');
}
