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
