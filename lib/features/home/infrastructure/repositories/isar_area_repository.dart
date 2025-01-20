import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/base_mapper.dart';
import 'package:hommie/services/database/models/area.dart';
import 'package:hommie/services/database/models/ha_server.dart';
import 'package:isar/isar.dart';
import 'package:hommie/features/home/domain/entities/area.dart' as domain;
import 'package:hommie/features/home/infrastructure/repositories/mappers/area_mapper.dart';

class IsarAreaRepository implements IAreaRepository {
  final Isar _isar;
  final _mapper = AreaMapper.instance;

  IsarAreaRepository(this._isar);

  @override
  Future<List<domain.Area>> getAll() async {
    return _isar.areas.where().findAll().mapWith(_mapper.fromDatabase);
  }

  @override
  Future<domain.Area?> getById(int id) async {
    return _isar.areas.get(id).mapWithNullable(_mapper.fromDatabase);
  }

  @override
  Future<domain.Area?> getByHaId(String haId) async {
    return _isar.areas
        .filter()
        .haIdEqualTo(haId)
        .findFirst()
        .mapWithNullable(_mapper.fromDatabase);
  }

  @override
  Future<void> save(domain.Area area) =>
      _isar.writeTxn(() => _isar.areas.put(_mapper.toDatabase(area)));

  @override
  Future<void> delete(int id) => _isar.writeTxn(() => _isar.areas.delete(id));

  @override
  Future<void> updatePosition(int id, int position) async {
    await _isar.writeTxn(() async {
      final area = await _isar.areas.get(id);
      if (area != null) {
        area.position = position;
        await _isar.areas.put(area);
      }
    });
  }

  @override
  Future<List<domain.Area>> getByServer(int serverId) async {
    return _isar.areas
        .filter()
        .haServer((q) => q.idEqualTo(serverId))
        .findAll()
        .mapWith(_mapper.fromDatabase);
  }
}
