import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cached_entities_provider.g.dart';

/// Reactive list of cached entities for the active server.
@Riverpod(dependencies: [serverScopeId])
Stream<List<HaEntity>> cachedEntities(Ref ref) {
  final serverId = ref.watch(serverScopeIdProvider);
  return ref.watch(entityRepositoryProvider).watchByServer(serverId);
}

/// One renderable section: an area (or the synthetic unassigned group) + its
/// entities.
class AreaSection {
  final String? areaId; // null => unassigned (Summary only)
  final String title;
  final List<HaEntity> entities;

  const AreaSection({
    required this.areaId,
    required this.title,
    required this.entities,
  });
}

/// Groups [entities] under [areas] (sorted by name), appending a trailing
/// "Unassigned" section for entities whose areaId matches no known area.
List<AreaSection> groupEntitiesByArea(
  List<Area> areas,
  List<HaEntity> entities,
) {
  final sortedAreas = [...areas]..sort((a, b) => a.name.compareTo(b.name));
  final knownAreaIds = sortedAreas.map((a) => a.id).toSet();

  final sections = <AreaSection>[
    for (final area in sortedAreas)
      AreaSection(
        areaId: area.id,
        title: area.name,
        entities: entities.where((e) => e.areaId == area.id).toList(),
      ),
  ];

  final unassigned = entities
      .where((e) => e.areaId == null || !knownAreaIds.contains(e.areaId))
      .toList();
  if (unassigned.isNotEmpty) {
    sections.add(
      AreaSection(areaId: null, title: 'Unassigned', entities: unassigned),
    );
  }

  return sections;
}

/// Groups [entities] by Home Assistant entity domain/device type.
List<AreaSection> groupEntitiesByType(List<HaEntity> entities) {
  final sortedTypes = entities.map((e) => e.domain).toSet().toList()..sort();

  return [
    for (final type in sortedTypes)
      AreaSection(
        areaId: null,
        title: _entityTypeGroupTitle(type),
        entities: entities.where((e) => e.domain == type).toList(),
      ),
  ];
}

String _entityTypeGroupTitle(String type) {
  const labels = {
    'binary_sensor': 'Binary sensors',
    'button': 'Buttons',
    'climate': 'Climate',
    'cover': 'Covers',
    'fan': 'Fans',
    'humidifier': 'Humidifiers',
    'light': 'Lights',
    'lock': 'Locks',
    'media_player': 'Media players',
    'notify': 'Notifications',
    'number': 'Numbers',
    'select': 'Selects',
    'sensor': 'Sensors',
    'switch': 'Switches',
  };
  final label = labels[type];
  if (label != null) {
    return label;
  }

  return '${_formatTypeTitle(type)}s';
}

String _formatTypeTitle(String type) {
  final label = type.replaceAll('_', ' ');
  if (label.isEmpty) {
    return label;
  }
  return label[0].toUpperCase() + label.substring(1);
}
