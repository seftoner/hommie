import 'package:hommie/features/home/domain/entities/device.dart';

abstract interface class IDeviceRepository {
  Future<List<Device>> getAll();
  Future<Device?> getById(int id);
  Future<Device?> getByHaId(String haId);
  Future<List<Device>> getByArea(int areaId);
  Future<void> save(Device device);
  Future<void> delete(int id);
}
