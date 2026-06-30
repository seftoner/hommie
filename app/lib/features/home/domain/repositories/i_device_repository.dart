import 'package:hommie/features/home/domain/entities/device.dart';

abstract interface class IDeviceRepository {
  Future<List<Device>> getAll();
  Stream<List<Device>> watchByServer(int serverId);
  Future<List<Device>> getByServer(int serverId);
  Future<Device?> getById(int id);
  Future<Device?> getByHaId({required int serverId, required String haId});
  Future<List<Device>> getByArea(int areaId);
  Future<void> syncRegistry({
    required int serverId,
    required List<Device> devices,
  });
  Future<void> save(Device device);
  Future<void> delete(int id);
}
