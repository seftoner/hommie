import 'package:hommie/features/home/domain/entities/area.dart';

abstract interface class IAreaRepository {
  Future<List<Area>> getAll();
  Future<Area?> getById(int id);
  Future<Area?> getByHaId(String haId);
  Future<void> save(Area area);
  Future<void> delete(int id);
  Future<void> updatePosition(int id, int position);
  Future<List<Area>> getByServer(int serverId);
}
