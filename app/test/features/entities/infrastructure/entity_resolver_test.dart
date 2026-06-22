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
