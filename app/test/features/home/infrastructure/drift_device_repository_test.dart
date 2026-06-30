import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/home/infrastructure/repositories/drift_device_repository.dart';

void main() {
  group('DriftDeviceRepository', () {
    late AppDatabase db;
    late DriftDeviceRepository repo;
    late int serverId;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      repo = DriftDeviceRepository(db);
      serverId = await db
          .into(db.serverEntities)
          .insert(
            ServerEntitiesCompanion.insert(name: 'Home', url: 'http://h:8123'),
          );
    });

    tearDown(() => db.close());

    test('syncRegistry upserts devices by stable HA id', () async {
      await repo.syncRegistry(
        serverId: serverId,
        devices: const [
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
        ],
      );

      final before = await db.select(db.deviceEntities).getSingle();

      await repo.syncRegistry(
        serverId: serverId,
        devices: const [
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
        ],
      );

      final after = await db.select(db.deviceEntities).getSingle();
      expect(after.id, before.id);
      expect(after.haId, 'device-1');
      expect(after.name, 'Hue bulb renamed');
      expect(after.areaHaId, 'office');
      expect(after.nameByUser, 'Desk lamp');
      expect(after.disabled, isTrue);

      final domain = await repo.getByServer(serverId);
      expect(domain.single.id, 'device-1');
      expect(domain.single.name, 'Hue bulb renamed');
      expect(domain.single.areaId, 'office');
      expect(domain.single.nameByUser, 'Desk lamp');
      expect(domain.single.disabled, isTrue);
    });

    test('syncRegistry is scoped per server', () async {
      final otherServerId = await db
          .into(db.serverEntities)
          .insert(
            ServerEntitiesCompanion.insert(name: 'Cabin', url: 'http://c:8123'),
          );

      await repo.syncRegistry(
        serverId: serverId,
        devices: const [Device(id: 'device-1', name: 'Lamp', type: 'light')],
      );
      await repo.syncRegistry(
        serverId: otherServerId,
        devices: const [Device(id: 'device-2', name: 'Switch', type: 'switch')],
      );

      await repo.syncRegistry(serverId: serverId, devices: const []);

      expect(await repo.getByServer(serverId), isEmpty);
      final other = await repo.getByServer(otherServerId);
      expect(other.single.id, 'device-2');
    });

    test('getByHaId is scoped per server', () async {
      final otherServerId = await db
          .into(db.serverEntities)
          .insert(
            ServerEntitiesCompanion.insert(name: 'Cabin', url: 'http://c:8123'),
          );

      await repo.syncRegistry(
        serverId: serverId,
        devices: const [
          Device(id: 'device-1', name: 'Home lamp', type: 'light'),
        ],
      );
      await repo.syncRegistry(
        serverId: otherServerId,
        devices: const [
          Device(id: 'device-1', name: 'Cabin lamp', type: 'light'),
        ],
      );

      final homeDevice = await repo.getByHaId(
        serverId: serverId,
        haId: 'device-1',
      );
      final cabinDevice = await repo.getByHaId(
        serverId: otherServerId,
        haId: 'device-1',
      );

      expect(homeDevice?.name, 'Home lamp');
      expect(cabinDevice?.name, 'Cabin lamp');
    });

    test('watchByServer emits synced devices', () async {
      final stream = repo.watchByServer(serverId);
      final future = stream.firstWhere((devices) => devices.isNotEmpty);

      await repo.syncRegistry(
        serverId: serverId,
        devices: const [Device(id: 'device-1', name: 'Lamp', type: 'light')],
      );

      expect(await future, hasLength(1));
    });
  });
}
