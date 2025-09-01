import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/services/database/models/area_entity.dart' as db;
import 'package:hommie/services/database/models/server_entity.dart';
import 'package:isar_community/isar.dart';
import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/area_mapper.dart';

class IsarAreaRepository implements IAreaRepository {
  final Isar _isar;
  // final _mapper = AreaMapper.instance;

  IsarAreaRepository(this._isar);

  @override
  Future<List<Area>> getAll() async {
    return _isar.areaEntitys.where().findAll().mapToDomain();
  }

  @override
  Future<Area?> getById(int id) async {
    return _isar.areaEntitys.get(id).mapToDomain();
  }

  @override
  Future<Area?> getByHaId(String haId) async {
    return _isar.areaEntitys
        .filter()
        .haIdEqualTo(haId)
        .findFirst()
        .mapToDomain();
  }

  @override
  Future<void> save(Area area) =>
      _isar.writeTxn(() => _isar.areaEntitys.put(area.toDb()));

  @override
  Future<void> delete(int id) =>
      _isar.writeTxn(() => _isar.areaEntitys.delete(id));

  @override
  Future<List<Area>> getByServer(int serverId) async {
    return _isar.areaEntitys
        .filter()
        .server((q) => q.idEqualTo(serverId))
        .findAll()
        .mapToDomain();
  }
}
