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
            registryId: 'reg-light-kitchen',
            uniqueId: 'uid-light-kitchen',
            platform: 'hue',
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
    expect(rows.single.registryId, 'reg-light-kitchen');
    expect(rows.single.uniqueId, 'uid-light-kitchen');
    expect(rows.single.platform, 'hue');
    expect(rows.single.name, 'Kitchen');
    expect(rows.single.domain, 'light');
    expect(rows.single.areaHaId, 'kitchen');
  });

  test('device ha ids are scoped per server', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    final firstServerId = await db
        .into(db.serverEntities)
        .insert(
          ServerEntitiesCompanion.insert(name: 'Home', url: 'http://h:8123'),
        );
    final secondServerId = await db
        .into(db.serverEntities)
        .insert(
          ServerEntitiesCompanion.insert(name: 'Cabin', url: 'http://c:8123'),
        );

    await db
        .into(db.deviceEntities)
        .insert(
          DeviceEntitiesCompanion.insert(
            haId: 'device-1',
            name: 'Lamp',
            type: 'light',
            serverId: firstServerId,
          ),
        );
    await db
        .into(db.deviceEntities)
        .insert(
          DeviceEntitiesCompanion.insert(
            haId: 'device-1',
            name: 'Lamp',
            type: 'light',
            serverId: secondServerId,
          ),
        );

    final devices = await db.select(db.deviceEntities).get();
    expect(devices, hasLength(2));
  });
}
