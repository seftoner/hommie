import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/infrastructure/repositories/drift_entity_repository.dart';

void main() {
  late AppDatabase db;
  late DriftEntityRepository repo;
  late int serverId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = DriftEntityRepository(db);
    serverId = await db
        .into(db.serverEntities)
        .insert(
          ServerEntitiesCompanion.insert(name: 'Home', url: 'http://h:8123'),
        );
  });
  tearDown(() => db.close());

  HaEntity light(
    String id, {
    String? registryId,
    String? uniqueId,
    String platform = 'test',
    String? area,
    bool disabled = false,
    bool hidden = false,
    String? entityCategory,
  }) => HaEntity(
    registryId: registryId ?? 'reg-$id',
    uniqueId: uniqueId ?? 'uid-$id',
    platform: platform,
    entityId: id,
    domain: 'light',
    name: id,
    areaId: area,
    disabled: disabled,
    hidden: hidden,
    entityCategory: entityCategory,
  );

  test('syncAll inserts entities', () async {
    await repo.syncAll(
      serverId: serverId,
      entities: [light('light.a', area: 'kitchen')],
    );
    final rows = await repo.getByServer(serverId);
    expect(rows, hasLength(1));
    expect(rows.single.entityId, 'light.a');
    expect(rows.single.registryId, 'reg-light.a');
    expect(rows.single.uniqueId, 'uid-light.a');
    expect(rows.single.platform, 'test');
    expect(rows.single.areaId, 'kitchen');
  });

  test(
    'syncAll removes entities no longer present and upserts changes',
    () async {
      await repo.syncAll(
        serverId: serverId,
        entities: [light('light.a'), light('light.b')],
      );
      await repo.syncAll(
        serverId: serverId,
        entities: [
          const HaEntity(
            entityId: 'light.a',
            domain: 'light',
            name: 'Renamed',
            areaId: 'den',
          ),
        ],
      );
      final rows = await repo.getByServer(serverId);
      expect(rows, hasLength(1));
      expect(rows.single.entityId, 'light.a');
      expect(rows.single.name, 'Renamed');
      expect(rows.single.areaId, 'den');
    },
  );

  test('watchByServer emits on change', () async {
    final stream = repo.watchByServer(serverId);
    final future = stream.firstWhere((rows) => rows.isNotEmpty);
    await repo.syncAll(serverId: serverId, entities: [light('light.a')]);
    expect(await future, hasLength(1));
  });

  test(
    'syncAll treats registry id as identity when entity id changes',
    () async {
      await repo.syncAll(
        serverId: serverId,
        entities: [
          light(
            'light.old_name',
            registryId: 'reg-light',
            uniqueId: 'uid-light',
          ),
        ],
      );
      final before = await db.select(db.entities).getSingle();

      await repo.syncAll(
        serverId: serverId,
        entities: [
          light(
            'light.new_name',
            registryId: 'reg-light',
            uniqueId: 'uid-light',
          ),
        ],
      );

      final after = await db.select(db.entities).getSingle();
      expect(after.id, before.id);
      expect(after.registryId, 'reg-light');
      expect(after.entityId, 'light.new_name');
    },
  );

  test(
    'syncAll persists disabled hidden and entity category metadata',
    () async {
      await repo.syncAll(
        serverId: serverId,
        entities: [
          light(
            'sensor.signal',
            registryId: 'reg-signal',
            uniqueId: 'uid-signal',
            platform: 'hue',
            disabled: true,
            hidden: true,
            entityCategory: 'diagnostic',
          ),
        ],
      );

      final rows = await repo.getByServer(serverId);
      expect(rows.single.registryId, 'reg-signal');
      expect(rows.single.uniqueId, 'uid-signal');
      expect(rows.single.platform, 'hue');
      expect(rows.single.disabled, isTrue);
      expect(rows.single.hidden, isTrue);
      expect(rows.single.entityCategory, 'diagnostic');
    },
  );

  test(
    'syncAll is scoped per server and does not touch other servers',
    () async {
      final otherServerId = await db
          .into(db.serverEntities)
          .insert(
            ServerEntitiesCompanion.insert(name: 'Other', url: 'http://o:8123'),
          );
      await repo.syncAll(serverId: serverId, entities: [light('light.a')]);
      await repo.syncAll(serverId: otherServerId, entities: [light('light.b')]);

      // Re-sync server 1 to an empty set: server 2's entity must survive.
      await repo.syncAll(serverId: serverId, entities: []);

      expect(await repo.getByServer(serverId), isEmpty);
      final other = await repo.getByServer(otherServerId);
      expect(other.single.entityId, 'light.b');
    },
  );
}
