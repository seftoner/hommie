import 'package:hommie/features/home/domain/repositories/i_device_repository.dart';
import 'package:hommie/services/database/models/area.dart';
import 'package:hommie/services/database/models/device.dart';
import 'package:isar/isar.dart';
import 'package:hommie/features/home/domain/entities/device.dart' as domain;
import 'package:hommie/features/home/infrastructure/repositories/mappers/device_mapper.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/base_mapper.dart';

class IsarDeviceRepository implements IDeviceRepository {
  final Isar _isar;
  final _mapper = DeviceMapper.instance;

  IsarDeviceRepository(this._isar);

  @override
  Future<List<domain.Device>> getAll() async {
    return _isar.devices.where().findAll().mapWith(_mapper.fromDatabase);
  }

  @override
  Future<domain.Device?> getById(int id) async {
    return _isar.devices.get(id).mapWithNullable(_mapper.fromDatabase);
  }

  @override
  Future<domain.Device?> getByHaId(String haId) async {
    return _isar.devices
        .filter()
        .haIdEqualTo(haId)
        .findFirst()
        .mapWithNullable(_mapper.fromDatabase);
  }

  @override
  Future<List<domain.Device>> getByArea(int areaId) async {
    return _isar.devices
        .filter()
        .area((q) => q.idEqualTo(areaId))
        .findAll()
        .mapWith<domain.Device>(_mapper.fromDatabase);
  }

  @override
  Future<void> save(domain.Device device) =>
      _isar.writeTxn(() => _isar.devices.put(_mapper.toDatabase(device)));

  @override
  Future<void> delete(int id) => _isar.writeTxn(() => _isar.devices.delete(id));
}
