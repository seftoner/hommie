import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/domain/entity_display_name.dart';

void main() {
  test('resolves registry display name with HA-like entity id fallback', () {
    expect(
      resolveEntityRegistryDisplayName(
        name: null,
        originalName: null,
        entityId: 'light.kitchen_lights',
      ),
      'Kitchen Lights',
    );
    expect(
      resolveEntityRegistryDisplayName(
        name: '',
        originalName: '',
        entityId: 'light.office_rgbw_lights',
      ),
      'Office RGBW Lights',
    );
    expect(
      resolveEntityRegistryDisplayName(
        name: '  Ceiling Fan 1  ',
        originalName: 'fan.ceiling_fan',
        entityId: 'fan.ceiling_fan',
      ),
      'Ceiling Fan 1',
    );
  });

  test(
    'resolves cached entity display name when name still contains entity id',
    () {
      expect(
        resolveEntityDisplayName(
          const HaEntity(
            entityId: 'light.living_room_rgbww_lights',
            domain: 'light',
            name: 'light.living_room_rgbww_lights',
          ),
        ),
        'Living Room RGBWW Lights',
      );
      expect(
        resolveEntityDisplayName(
          const HaEntity(
            entityId: 'light.special_bed_light',
            domain: 'light',
            name: '!Special bed light!',
          ),
        ),
        '!Special bed light!',
      );
    },
  );
}
