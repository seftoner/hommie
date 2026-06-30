import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

enum HomeTileKind { device, entity }

enum HomeTileResolution { active, unavailable, disabled, missing }

enum HomeTileSize { small, large }

class HaDevice {
  final String id;
  final String name;
  final String? areaId;
  final bool disabled;

  const HaDevice({
    required this.id,
    required this.name,
    this.areaId,
    this.disabled = false,
  });
}

class HomeTileOverride {
  final HomeTileKind kind;
  final String targetId;
  final String? areaId;
  final HomeTileSize size;
  final int? order;
  final bool hidden;
  final String? primaryEntityRegistryId;
  final String? lastKnownName;
  final String? lastKnownAreaId;
  final String? lastKnownDomain;

  const HomeTileOverride({
    required this.kind,
    required this.targetId,
    this.areaId,
    this.size = HomeTileSize.small,
    this.order,
    this.hidden = false,
    this.primaryEntityRegistryId,
    this.lastKnownName,
    this.lastKnownAreaId,
    this.lastKnownDomain,
  });
}

class HomeTile {
  final HomeTileKind kind;
  final String targetId;
  final String name;
  final String? areaId;
  final HomeTileSize size;
  final int order;
  final HomeTileResolution resolution;
  final HaEntity? primaryEntity;
  final List<HaEntity> secondaryEntities;

  const HomeTile({
    required this.kind,
    required this.targetId,
    required this.name,
    required this.areaId,
    required this.size,
    required this.order,
    required this.resolution,
    this.primaryEntity,
    this.secondaryEntities = const [],
  });
}
