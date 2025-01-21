import 'package:hommie/features/home/domain/repositories/i_device_repository.dart';
import 'package:hommie/services/database/models/area.dart';
import 'package:hommie/services/database/models/device.dart';
import 'package:isar/isar.dart';
import 'package:hommie/features/home/domain/entities/device.dart' as domain;
import 'package:hommie/features/home/infrastructure/repositories/mappers/device_mapper.dart';

class IsarDeviceRepository implements IDeviceRepository {
  final Isar _isar;

  IsarDeviceRepository(this._isar);

  @override
  Future<List<domain.Device>> getAll() async {
    return _isar.devices.where().findAll().mapToDomain();
  }

  @override
  Future<domain.Device?> getById(int id) async {
    return _isar.devices.get(id).mapToDomain();
  }

  @override
  Future<domain.Device?> getByHaId(String haId) async {
    return _isar.devices.filter().haIdEqualTo(haId).findFirst().mapToDomain();
  }

  @override
  Future<List<domain.Device>> getByArea(int areaId) async {
    return _isar.devices
        .filter()
        .area((q) => q.idEqualTo(areaId))
        .findAll()
        .mapToDomain();
  }

  @override
  Future<void> save(domain.Device device) =>
      _isar.writeTxn(() => _isar.devices.put(device.toDb()));

  @override
  Future<void> delete(int id) => _isar.writeTxn(() => _isar.devices.delete(id));
}
