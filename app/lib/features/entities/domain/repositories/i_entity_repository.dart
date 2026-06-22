import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

abstract interface class IEntityRepository {
  /// Transactional full sync: delete entities no longer present, upsert the rest.
  Future<void> syncAll({required int serverId, required List<HaEntity> entities});

  /// Reactive list of cached entities for a server.
  Stream<List<HaEntity>> watchByServer(int serverId);

  /// One-shot read of cached entities for a server.
  Future<List<HaEntity>> getByServer(int serverId);
}
