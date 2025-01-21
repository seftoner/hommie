import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/services/database/models/area.dart' as db;
import 'package:hommie/services/database/models/ha_server.dart';
import 'package:isar/isar.dart';
import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/area_mapper.dart';

class IsarAreaRepository implements IAreaRepository {
  final Isar _isar;
  // final _mapper = AreaMapper.instance;

  IsarAreaRepository(this._isar);

  @override
  Future<List<Area>> getAll() async {
    return _isar.areas.where().findAll().mapToDomain();
  }

  @override
  Future<Area?> getById(int id) async {
    return _isar.areas.get(id).mapToDomain();
  }

  @override
  Future<Area?> getByHaId(String haId) async {
    return _isar.areas.filter().haIdEqualTo(haId).findFirst().mapToDomain();
  }

  @override
  Future<void> save(Area area) =>
      _isar.writeTxn(() => _isar.areas.put(area.toDb()));

  @override
  Future<void> delete(int id) => _isar.writeTxn(() => _isar.areas.delete(id));

  @override
  Future<List<Area>> getByServer(int serverId) async {
    return _isar.areas
        .filter()
        .haServer((q) => q.idEqualTo(serverId))
        .findAll()
        .mapToDomain();
  }
}
