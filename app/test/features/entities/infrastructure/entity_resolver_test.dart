import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/infrastructure/repositories/entity_resolver.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';

void main() {
  test('resolves area and preserves disabled/hidden metadata', () {
    final entities = [
      const EntityRegistryRecord(
        id: 'reg-a',
        entityId: 'light.a',
        uniqueId: 'uid-a',
        platform: 'test',
        areaId: 'kitchen',
      ), // direct
      const EntityRegistryRecord(
        id: 'reg-b',
        entityId: 'light.b',
        uniqueId: 'uid-b',
        platform: 'test',
        deviceId: 'dev1',
      ), // via device
      const EntityRegistryRecord(
        id: 'reg-c',
        entityId: 'light.c',
        uniqueId: 'uid-c',
        platform: 'test',
      ), // no area
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
    final devices = [const DeviceRegistryRecord(id: 'dev1', areaId: 'den')];

    final result = resolveEntities(entities: entities, devices: devices);

    expect(result.map((e) => e.entityId), [
      'light.a',
      'light.b',
      'light.c',
      'light.d',
      'light.e',
    ]);
    expect(result[0].registryId, 'reg-a');
    expect(result[0].uniqueId, 'uid-a');
    expect(result[0].platform, 'test');
    expect(result[0].areaId, 'kitchen');
    expect(result[0].domain, 'light');
    expect(result[1].areaId, 'den'); // device fallback
    expect(result[2].areaId, isNull);
    expect(result.singleWhere((e) => e.entityId == 'light.d').disabled, isTrue);
    expect(result.singleWhere((e) => e.entityId == 'light.e').hidden, isTrue);
  });

  test('name falls back original_name then entity id display label', () {
    final result = resolveEntities(
      entities: [
        const EntityRegistryRecord(
          id: 'reg-x',
          entityId: 'light.x',
          uniqueId: 'uid-x',
          platform: 'test',
          originalName: 'X',
        ),
        const EntityRegistryRecord(
          id: 'reg-rgbw',
          entityId: 'light.office_rgbw_lights',
          uniqueId: 'uid-rgbw',
          platform: 'test',
          name: '',
          originalName: '',
        ),
        const EntityRegistryRecord(
          id: 'reg-y',
          entityId: 'light.y',
          uniqueId: 'uid-y',
          platform: 'test',
        ),
      ],
      devices: const [],
    );
    expect(result[0].name, 'X');
    expect(result[1].name, 'Office RGBW Lights');
    expect(result[2].name, 'Y');
  });
}
