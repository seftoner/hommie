import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    ServerEntities,
    AreaEntities,
    DeviceEntities,
    DeviceAreaConfigs,
    HomeViewConfigs,
    AreaHomeConfigs,
    DeviceHomeConfigs,
    Entities,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await _migrateToV2();
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _migrateToV2() async {
    await customStatement('PRAGMA foreign_keys = OFF');

    await customStatement('''
      CREATE TABLE area_entities_v2 (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        ha_id TEXT NOT NULL,
        name TEXT NOT NULL,
        background TEXT NULL,
        image TEXT NULL,
        server_id INTEGER NOT NULL REFERENCES server_entities (id)
          ON DELETE CASCADE,
        UNIQUE(server_id, ha_id)
      );
    ''');

    await customStatement('''
      INSERT INTO area_entities_v2 (id, ha_id, name, background, image, server_id)
      SELECT id, ha_id, name, background, image, server_id
      FROM area_entities;
    ''');

    await customStatement('''
      CREATE TABLE device_entities_v2 (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        ha_id TEXT NOT NULL UNIQUE,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        server_id INTEGER NOT NULL REFERENCES server_entities (id)
          ON DELETE CASCADE
      );
    ''');

    await customStatement('''
      INSERT INTO device_entities_v2 (id, ha_id, name, type, server_id)
      SELECT device_entities.id,
             device_entities.ha_id,
             device_entities.name,
             device_entities.type,
             area_entities.server_id
      FROM device_entities
      INNER JOIN area_entities ON area_entities.id = device_entities.area_id;
    ''');

    await customStatement('''
      CREATE TABLE device_area_configs (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        device_id INTEGER NOT NULL REFERENCES device_entities (id)
          ON DELETE CASCADE,
        area_id INTEGER NOT NULL REFERENCES area_entities (id)
          ON DELETE CASCADE,
        UNIQUE(device_id, area_id)
      );
    ''');

    await customStatement('''
      INSERT INTO device_area_configs (device_id, area_id)
      SELECT id, area_id
      FROM device_entities;
    ''');

    await customStatement('DROP TABLE device_entities;');
    await customStatement('DROP TABLE area_entities;');
    await customStatement(
      'ALTER TABLE area_entities_v2 RENAME TO area_entities;',
    );
    await customStatement(
      'ALTER TABLE device_entities_v2 RENAME TO device_entities;',
    );

    await customStatement('''
      CREATE TABLE entities (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        entity_id TEXT NOT NULL,
        name TEXT NOT NULL,
        domain TEXT NOT NULL,
        device_id TEXT NULL,
        area_ha_id TEXT NULL,
        entity_category TEXT NULL,
        server_id INTEGER NOT NULL REFERENCES server_entities (id)
          ON DELETE CASCADE,
        UNIQUE(server_id, entity_id)
      );
    ''');
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'hommie_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
