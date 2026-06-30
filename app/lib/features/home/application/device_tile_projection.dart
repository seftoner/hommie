import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';

const _domainPriority = <String>[
  'light',
  'switch',
  'climate',
  'cover',
  'fan',
  'media_player',
  'lock',
  'vacuum',
  'button',
  'sensor',
  'binary_sensor',
];

List<HomeTile> projectDeviceTiles({
  required List<HaDevice> devices,
  required List<HaEntity> entities,
  required List<HomeTileOverride> overrides,
}) {
  final deviceById = {for (final device in devices) device.id: device};
  final entitiesByDeviceId = <String, List<HaEntity>>{};
  final entityByRegistryId = {
    for (final entity in entities) entity.registryId: entity,
  };
  final overrideByTarget = {
    for (final override in overrides)
      if (!override.hidden) (override.kind, override.targetId): override,
  };

  for (final entity in entities) {
    final deviceId = entity.deviceId;
    if (deviceId == null) {
      continue;
    }
    entitiesByDeviceId.putIfAbsent(deviceId, () => []).add(entity);
  }

  final projected = <_ProjectedTile>[];

  for (final device in devices) {
    final override = overrideByTarget[(HomeTileKind.device, device.id)];
    final deviceEntities = entitiesByDeviceId[device.id] ?? const [];
    final primaryEntity = _selectPrimaryEntity(
      deviceEntities,
      override?.primaryEntityRegistryId,
    );
    final tileAreaId = device.areaId;
    final hasCurrentAreaOrder =
        override?.areaId == tileAreaId && override?.order != null;

    projected.add(
      _ProjectedTile(
        tile: HomeTile(
          kind: HomeTileKind.device,
          targetId: device.id,
          name: device.name,
          areaId: tileAreaId,
          size: override?.size ?? HomeTileSize.small,
          order: hasCurrentAreaOrder ? override!.order! : 0,
          resolution: _deviceResolution(device, primaryEntity),
          primaryEntity: primaryEntity,
          secondaryEntities: _secondaryEntities(deviceEntities, primaryEntity),
        ),
        hasCurrentAreaOrder: hasCurrentAreaOrder,
      ),
    );
  }

  for (final override in overrides) {
    if (override.hidden) {
      continue;
    }
    if (override.kind == HomeTileKind.device) {
      if (!deviceById.containsKey(override.targetId)) {
        projected.add(_missingTile(override));
      }
      continue;
    }

    final entity = entityByRegistryId[override.targetId];
    if (entity == null) {
      projected.add(_missingTile(override));
      continue;
    }

    final tileAreaId = entity.areaId;
    final hasCurrentAreaOrder =
        override.areaId == tileAreaId && override.order != null;
    projected.add(
      _ProjectedTile(
        tile: HomeTile(
          kind: HomeTileKind.entity,
          targetId: entity.registryId,
          name: entity.name,
          areaId: tileAreaId,
          size: override.size,
          order: hasCurrentAreaOrder ? override.order! : 0,
          resolution: entity.disabled
              ? HomeTileResolution.disabled
              : HomeTileResolution.active,
          primaryEntity: entity,
        ),
        hasCurrentAreaOrder: hasCurrentAreaOrder,
      ),
    );
  }

  return _assignOrders(projected);
}

HomeTileResolution _deviceResolution(HaDevice device, HaEntity? primaryEntity) {
  if (device.disabled) {
    return HomeTileResolution.disabled;
  }
  if (primaryEntity == null) {
    return HomeTileResolution.unavailable;
  }
  if (primaryEntity.disabled) {
    return HomeTileResolution.disabled;
  }
  return HomeTileResolution.active;
}

HaEntity? _selectPrimaryEntity(
  List<HaEntity> entities,
  String? primaryEntityRegistryId,
) {
  final visibleCandidates = entities
      .where((entity) => !entity.disabled)
      .where((entity) => entity.entityCategory != 'config')
      .where((entity) => entity.entityCategory != 'diagnostic')
      .toList();

  if (primaryEntityRegistryId != null) {
    for (final entity in visibleCandidates) {
      if (entity.registryId == primaryEntityRegistryId) {
        return entity;
      }
    }
  }

  visibleCandidates.sort((a, b) {
    final domainCompare = _domainRank(
      a.domain,
    ).compareTo(_domainRank(b.domain));
    if (domainCompare != 0) {
      return domainCompare;
    }
    return a.registryId.compareTo(b.registryId);
  });

  return visibleCandidates.firstOrNull;
}

int _domainRank(String domain) {
  final index = _domainPriority.indexOf(domain);
  if (index == -1) {
    return _domainPriority.length;
  }
  return index;
}

List<HaEntity> _secondaryEntities(
  List<HaEntity> entities,
  HaEntity? primaryEntity,
) {
  return [
    for (final entity in entities)
      if (entity.registryId != primaryEntity?.registryId) entity,
  ];
}

_ProjectedTile _missingTile(HomeTileOverride override) {
  return _ProjectedTile(
    tile: HomeTile(
      kind: override.kind,
      targetId: override.targetId,
      name: override.lastKnownName ?? override.targetId,
      areaId: override.lastKnownAreaId ?? override.areaId,
      size: override.size,
      order: override.order ?? 0,
      resolution: HomeTileResolution.missing,
    ),
    hasCurrentAreaOrder: true,
  );
}

List<HomeTile> _assignOrders(List<_ProjectedTile> projected) {
  final usedOrdersByArea = <String, Set<int>>{};
  final nextOrderByArea = <String, int>{};

  for (final item in projected) {
    if (!item.hasCurrentAreaOrder) {
      continue;
    }
    final areaKey = _areaKey(item.tile.areaId);
    usedOrdersByArea.putIfAbsent(areaKey, () => {}).add(item.tile.order);
  }

  final result = <HomeTile>[];
  for (final item in projected) {
    if (item.hasCurrentAreaOrder) {
      result.add(item.tile);
      continue;
    }

    final areaKey = _areaKey(item.tile.areaId);
    final usedOrders = usedOrdersByArea.putIfAbsent(areaKey, () => {});
    var nextOrder = nextOrderByArea[areaKey] ?? 0;
    while (usedOrders.contains(nextOrder)) {
      nextOrder++;
    }
    usedOrders.add(nextOrder);
    nextOrderByArea[areaKey] = nextOrder + 1;

    result.add(
      HomeTile(
        kind: item.tile.kind,
        targetId: item.tile.targetId,
        name: item.tile.name,
        areaId: item.tile.areaId,
        size: item.tile.size,
        order: nextOrder,
        resolution: item.tile.resolution,
        primaryEntity: item.tile.primaryEntity,
        secondaryEntities: item.tile.secondaryEntities,
      ),
    );
  }

  result.sort((a, b) {
    final areaCompare = _areaKey(a.areaId).compareTo(_areaKey(b.areaId));
    if (areaCompare != 0) {
      return areaCompare;
    }
    final orderCompare = a.order.compareTo(b.order);
    if (orderCompare != 0) {
      return orderCompare;
    }
    return a.targetId.compareTo(b.targetId);
  });
  return result;
}

String _areaKey(String? areaId) => areaId ?? '';

class _ProjectedTile {
  final HomeTile tile;
  final bool hasCurrentAreaOrder;

  const _ProjectedTile({required this.tile, required this.hasCurrentAreaOrder});
}
