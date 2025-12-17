import 'package:hommie/core/domain/entities/area.dart';

abstract interface class IAreaRepository {
  Stream<List<Area>> watchByServer(int serverId);
  Future<List<Area>> getByServer(int serverId);

  Future<Area?> getByHaId({required int serverId, required String haId});

  /// Upserts a single area without changing its local DB id.
  Future<void> upsert({required int serverId, required Area area});

  /// Syncs the server's area registry.
  ///
  /// This should:
  /// - upsert existing areas (preserving their local ids)
  /// - insert new areas
  /// - delete areas that no longer exist in Home Assistant
  Future<void> syncAll({required int serverId, required List<Area> areas});
}
