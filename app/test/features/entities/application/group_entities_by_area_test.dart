import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

void main() {
  HaEntity e(String id, String? area) =>
      HaEntity(entityId: id, domain: 'light', name: id, areaId: area);

  test('groups by area, sorts areas, appends unassigned', () {
    final areas = [
      const Area(id: 'kitchen', name: 'Kitchen'),
      const Area(id: 'bath', name: 'Bath'),
    ];
    final entities = [
      e('light.a', 'kitchen'),
      e('light.b', 'bath'),
      e('light.c', null),
      e('light.d', 'ghost'),
    ];

    final sections = groupEntitiesByArea(areas, entities);

    expect(sections.map((s) => s.title), ['Bath', 'Kitchen', 'Unassigned']);
    expect(sections[1].entities.map((x) => x.entityId), ['light.a']);
    expect(sections.last.entities.map((x) => x.entityId), ['light.c', 'light.d']);
  });

  test('no unassigned section when all entities are placed', () {
    final sections = groupEntitiesByArea(
      [const Area(id: 'kitchen', name: 'Kitchen')],
      [e('light.a', 'kitchen')],
    );
    expect(sections.map((s) => s.title), ['Kitchen']);
  });
}
