import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';

void main() {
  test('EntityRegistryRecord parses and derives disabled/hidden', () {
    final r = EntityRegistryRecord.fromJson({
      'id': 'reg-light-kitchen',
      'entity_id': 'light.kitchen',
      'unique_id': 'uid-light-kitchen',
      'platform': 'hue',
      'name': null,
      'original_name': 'Kitchen',
      'device_id': 'dev1',
      'area_id': null,
      'disabled_by': 'user',
      'hidden_by': null,
      'entity_category': null,
    });
    expect(r.id, 'reg-light-kitchen');
    expect(r.entityId, 'light.kitchen');
    expect(r.uniqueId, 'uid-light-kitchen');
    expect(r.platform, 'hue');
    expect(r.originalName, 'Kitchen');
    expect(r.deviceId, 'dev1');
    expect(r.disabled, isTrue);
    expect(r.hidden, isFalse);
  });

  test('DeviceRegistryRecord parses identity, labels, and disabled state', () {
    final d = DeviceRegistryRecord.fromJson({
      'id': 'dev1',
      'area_id': 'kitchen',
      'name': 'Hue bulb',
      'name_by_user': 'Counter lamp',
      'manufacturer': 'Signify',
      'model': 'LCA001',
      'disabled_by': null,
    });
    expect(d.id, 'dev1');
    expect(d.areaId, 'kitchen');
    expect(d.name, 'Hue bulb');
    expect(d.nameByUser, 'Counter lamp');
    expect(d.manufacturer, 'Signify');
    expect(d.model, 'LCA001');
    expect(d.disabled, isFalse);
  });
}
