import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/home/application/device_tile_projection.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';

void main() {
  group('projectDeviceTiles', () {
    test('creates device tiles bound to HA device ids', () {
      final tiles = projectDeviceTiles(
        devices: const [
          HaDevice(id: 'dev-lamp', name: 'Kitchen lamp', areaId: 'kitchen'),
        ],
        entities: const [
          HaEntity(
            registryId: 'ent-signal',
            uniqueId: 'uid-signal',
            platform: 'hue',
            entityId: 'sensor.kitchen_lamp_signal',
            domain: 'sensor',
            name: 'Signal strength',
            deviceId: 'dev-lamp',
            areaId: 'kitchen',
            entityCategory: 'diagnostic',
          ),
          HaEntity(
            registryId: 'ent-light',
            uniqueId: 'uid-light',
            platform: 'hue',
            entityId: 'light.kitchen_lamp',
            domain: 'light',
            name: 'Kitchen lamp',
            deviceId: 'dev-lamp',
            areaId: 'kitchen',
          ),
        ],
        overrides: const [
          HomeTileOverride(
            kind: HomeTileKind.device,
            targetId: 'dev-lamp',
            areaId: 'kitchen',
            size: HomeTileSize.large,
            order: 3,
          ),
        ],
      );

      expect(tiles, hasLength(1));
      expect(tiles.single.kind, HomeTileKind.device);
      expect(tiles.single.targetId, 'dev-lamp');
      expect(tiles.single.areaId, 'kitchen');
      expect(tiles.single.size, HomeTileSize.large);
      expect(tiles.single.order, 3);
      expect(tiles.single.resolution, HomeTileResolution.active);
      expect(tiles.single.primaryEntity?.registryId, 'ent-light');
      expect(tiles.single.secondaryEntities, hasLength(1));
      expect(tiles.single.secondaryEntities.single.registryId, 'ent-signal');
    });

    test('keeps size but appends when HA moves a device to another area', () {
      final tiles = projectDeviceTiles(
        devices: const [
          HaDevice(id: 'dev-existing', name: 'Existing', areaId: 'kitchen'),
          HaDevice(id: 'dev-moved', name: 'Moved', areaId: 'kitchen'),
        ],
        entities: const [
          HaEntity(
            registryId: 'ent-existing',
            uniqueId: 'uid-existing',
            platform: 'test',
            entityId: 'switch.existing',
            domain: 'switch',
            name: 'Existing',
            deviceId: 'dev-existing',
            areaId: 'kitchen',
          ),
          HaEntity(
            registryId: 'ent-moved',
            uniqueId: 'uid-moved',
            platform: 'test',
            entityId: 'light.moved',
            domain: 'light',
            name: 'Moved',
            deviceId: 'dev-moved',
            areaId: 'kitchen',
          ),
        ],
        overrides: const [
          HomeTileOverride(
            kind: HomeTileKind.device,
            targetId: 'dev-existing',
            areaId: 'kitchen',
            size: HomeTileSize.small,
            order: 0,
          ),
          HomeTileOverride(
            kind: HomeTileKind.device,
            targetId: 'dev-moved',
            areaId: 'office',
            size: HomeTileSize.large,
            order: 0,
          ),
        ],
      );

      final moved = tiles.singleWhere((tile) => tile.targetId == 'dev-moved');

      expect(moved.areaId, 'kitchen');
      expect(moved.size, HomeTileSize.large);
      expect(moved.order, 1);
      expect(tiles.map((tile) => tile.targetId), ['dev-existing', 'dev-moved']);
    });

    test('keeps missing override tiles for rebind or removal', () {
      final tiles = projectDeviceTiles(
        devices: const [],
        entities: const [],
        overrides: const [
          HomeTileOverride(
            kind: HomeTileKind.device,
            targetId: 'dev-missing',
            areaId: 'kitchen',
            size: HomeTileSize.large,
            order: 2,
            lastKnownName: 'Old lamp',
            lastKnownAreaId: 'kitchen',
          ),
        ],
      );

      expect(tiles, hasLength(1));
      expect(tiles.single.targetId, 'dev-missing');
      expect(tiles.single.name, 'Old lamp');
      expect(tiles.single.areaId, 'kitchen');
      expect(tiles.single.size, HomeTileSize.large);
      expect(tiles.single.order, 2);
      expect(tiles.single.resolution, HomeTileResolution.missing);
      expect(tiles.single.primaryEntity, isNull);
    });
  });
}
