import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:test/test.dart';

void main() {
  group('HassArea', () {
    test('parses area registry JSON with defaults and value semantics', () {
      final area = HassArea.fromJson({
        'area_id': 'kitchen',
        'name': 'Kitchen',
        'icon': 'mdi:stove',
      });

      expect(
        area,
        equals(
          const HassArea(areaId: 'kitchen', name: 'Kitchen', icon: 'mdi:stove'),
        ),
      );
      expect(area.createdAt, 0);
      expect(area.modifiedAt, 0);
      expect(area.aliases, isEmpty);
      expect(area.labels, isEmpty);
      expect(area.toJson(), {
        'created_at': 0.0,
        'modified_at': 0.0,
        'area_id': 'kitchen',
        'name': 'Kitchen',
        'floor_id': null,
        'humidity_entity_id': null,
        'icon': 'mdi:stove',
        'picture': null,
        'temperature_entity_id': null,
        'aliases': <String>[],
        'labels': <String>[],
      });
    });
  });
}
