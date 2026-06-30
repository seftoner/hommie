import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/home/application/device_tile_projection.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
import 'package:hommie/features/home/infrastructure/providers/device_repository_provider.dart';
import 'package:hommie/features/home/infrastructure/providers/home_tile_override_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tile_rebind_controller.g.dart';

@Riverpod(dependencies: [serverScopeId])
class HomeTileRebindController extends _$HomeTileRebindController {
  @override
  void build() {}

  Future<void> rebindDevice({
    required String missingTargetId,
    required String replacementDeviceId,
  }) async {
    final serverId = ref.read(serverScopeIdProvider);
    final overrideRepository = ref.read(homeTileOverrideRepositoryProvider);
    final deviceRepository = ref.read(deviceRepositoryProvider);

    final overrides = await overrideRepository.getByServer(serverId);
    final missingOverride = _findDeviceOverride(overrides, missingTargetId);
    if (missingOverride == null) {
      throw StateError('Missing tile override not found: $missingTargetId');
    }

    final replacementDevice = await deviceRepository.getByHaId(
      serverId: serverId,
      haId: replacementDeviceId,
    );
    if (replacementDevice == null) {
      throw StateError('Replacement device not found: $replacementDeviceId');
    }

    final devices = await deviceRepository.getByServer(serverId);
    final targetAreaId = replacementDevice.areaId;
    final order = _nextOrderInArea(
      areaId: targetAreaId,
      devices: devices,
      overrides: overrides,
      excludingTargetIds: {missingTargetId, replacementDeviceId},
    );

    await overrideRepository.upsert(
      serverId: serverId,
      override: HomeTileOverride(
        kind: HomeTileKind.device,
        targetId: replacementDevice.id,
        areaId: targetAreaId,
        size: missingOverride.size,
        order: order,
        lastKnownName: _displayName(replacementDevice),
        lastKnownAreaId: targetAreaId,
      ),
    );

    if (missingTargetId != replacementDeviceId) {
      await overrideRepository.remove(
        serverId: serverId,
        kind: HomeTileKind.device,
        targetId: missingTargetId,
      );
    }
  }

  Future<void> removeTile({
    required HomeTileKind kind,
    required String targetId,
  }) async {
    await ref
        .read(homeTileOverrideRepositoryProvider)
        .remove(
          serverId: ref.read(serverScopeIdProvider),
          kind: kind,
          targetId: targetId,
        );
  }
}

HomeTileOverride? _findDeviceOverride(
  List<HomeTileOverride> overrides,
  String targetId,
) {
  for (final override in overrides) {
    if (override.kind == HomeTileKind.device && override.targetId == targetId) {
      return override;
    }
  }
  return null;
}

int _nextOrderInArea({
  required String? areaId,
  required List<Device> devices,
  required List<HomeTileOverride> overrides,
  required Set<String> excludingTargetIds,
}) {
  final orderingDevices = [
    for (final device in devices)
      if (!excludingTargetIds.contains(device.id))
        _haDeviceFromRegistry(device),
  ];
  final orderingOverrides = [
    for (final override in overrides)
      if (override.kind != HomeTileKind.device ||
          !excludingTargetIds.contains(override.targetId))
        override,
  ];
  final tiles = projectDeviceTiles(
    devices: orderingDevices,
    entities: const [],
    overrides: orderingOverrides,
  );

  var maxOrder = -1;
  for (final tile in tiles) {
    if (tile.areaId == areaId && tile.order > maxOrder) {
      maxOrder = tile.order;
    }
  }
  return maxOrder + 1;
}

HaDevice _haDeviceFromRegistry(Device device) {
  return HaDevice(
    id: device.id,
    name: _displayName(device),
    areaId: device.areaId,
    disabled: device.disabled,
  );
}

String _displayName(Device device) => device.nameByUser ?? device.name;
