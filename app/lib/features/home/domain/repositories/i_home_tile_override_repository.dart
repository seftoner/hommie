import 'package:hommie/features/home/domain/entities/home_tile.dart';

abstract interface class IHomeTileOverrideRepository {
  Stream<List<HomeTileOverride>> watchByServer(int serverId);
  Future<List<HomeTileOverride>> getByServer(int serverId);
  Future<void> upsert({
    required int serverId,
    required HomeTileOverride override,
  });
  Future<void> remove({
    required int serverId,
    required HomeTileKind kind,
    required String targetId,
  });
}
