import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
import 'package:hommie/features/home/infrastructure/repositories/drift_home_tile_override_repository.dart';

void main() {
  late AppDatabase db;
  late DriftHomeTileOverrideRepository repo;
  late int serverId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = DriftHomeTileOverrideRepository(db);
    serverId = await db
        .into(db.serverEntities)
        .insert(
          ServerEntitiesCompanion.insert(name: 'Home', url: 'http://h:8123'),
        );
  });

  tearDown(() => db.close());

  test('upsert persists all override fields', () async {
    await repo.upsert(
      serverId: serverId,
      override: const HomeTileOverride(
        kind: HomeTileKind.device,
        targetId: 'device-1',
        areaId: 'kitchen',
        size: HomeTileSize.large,
        order: 7,
        hidden: true,
        primaryEntityRegistryId: 'entity-reg-1',
        lastKnownName: 'Kitchen lamp',
        lastKnownAreaId: 'kitchen',
        lastKnownDomain: 'light',
      ),
    );

    final overrides = await repo.getByServer(serverId);
    expect(overrides, hasLength(1));
    expect(overrides.single.kind, HomeTileKind.device);
    expect(overrides.single.targetId, 'device-1');
    expect(overrides.single.areaId, 'kitchen');
    expect(overrides.single.size, HomeTileSize.large);
    expect(overrides.single.order, 7);
    expect(overrides.single.hidden, isTrue);
    expect(overrides.single.primaryEntityRegistryId, 'entity-reg-1');
    expect(overrides.single.lastKnownName, 'Kitchen lamp');
    expect(overrides.single.lastKnownAreaId, 'kitchen');
    expect(overrides.single.lastKnownDomain, 'light');
  });

  test('upsert replaces an override by kind and target', () async {
    await repo.upsert(
      serverId: serverId,
      override: const HomeTileOverride(
        kind: HomeTileKind.device,
        targetId: 'device-1',
        areaId: 'kitchen',
        size: HomeTileSize.small,
        order: 1,
      ),
    );
    await repo.upsert(
      serverId: serverId,
      override: const HomeTileOverride(
        kind: HomeTileKind.device,
        targetId: 'device-1',
        areaId: 'office',
        size: HomeTileSize.large,
        order: 9,
      ),
    );

    final overrides = await repo.getByServer(serverId);
    expect(overrides, hasLength(1));
    expect(overrides.single.areaId, 'office');
    expect(overrides.single.size, HomeTileSize.large);
    expect(overrides.single.order, 9);
  });

  test('remove deletes only the requested override', () async {
    await repo.upsert(
      serverId: serverId,
      override: const HomeTileOverride(
        kind: HomeTileKind.device,
        targetId: 'device-1',
      ),
    );
    await repo.upsert(
      serverId: serverId,
      override: const HomeTileOverride(
        kind: HomeTileKind.entity,
        targetId: 'entity-1',
      ),
    );

    await repo.remove(
      serverId: serverId,
      kind: HomeTileKind.device,
      targetId: 'device-1',
    );

    final overrides = await repo.getByServer(serverId);
    expect(overrides.single.kind, HomeTileKind.entity);
    expect(overrides.single.targetId, 'entity-1');
  });

  test('watchByServer emits changes and stays scoped per server', () async {
    final otherServerId = await db
        .into(db.serverEntities)
        .insert(
          ServerEntitiesCompanion.insert(name: 'Cabin', url: 'http://c:8123'),
        );
    final future = repo
        .watchByServer(serverId)
        .firstWhere((overrides) => overrides.isNotEmpty);

    await repo.upsert(
      serverId: otherServerId,
      override: const HomeTileOverride(
        kind: HomeTileKind.device,
        targetId: 'other-device',
      ),
    );
    await repo.upsert(
      serverId: serverId,
      override: const HomeTileOverride(
        kind: HomeTileKind.device,
        targetId: 'device-1',
      ),
    );

    final overrides = await future;
    expect(overrides.single.targetId, 'device-1');
    expect(await repo.getByServer(otherServerId), hasLength(1));
  });
}
