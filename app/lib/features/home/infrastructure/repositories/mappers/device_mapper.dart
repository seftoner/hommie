import 'package:drift/drift.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/core/database/database.dart';

extension DeviceMapper on DeviceEntity {
  Device toDomain(String areaHaId) {
    return Device(id: haId, name: name, type: type, areaId: areaHaId);
  }
}

extension DeviceDomainMapper on Device {
  DeviceEntitiesCompanion toCompanion(int serverId) {
    return DeviceEntitiesCompanion(
      haId: Value(id),
      name: Value(name),
      type: Value(type),
      serverId: Value(serverId),
    );
  }
}

extension DeviceFutureListMapper on Future<List<DeviceEntity>> {
  Future<List<Device>> mapToDomain(String areaHaId) {
    return then(
      (list) => list.map((value) => value.toDomain(areaHaId)).toList(),
    );
  }
}

extension DeviceFutureMapper on Future<DeviceEntity> {
  Future<Device> mapToDomain(String areaHaId) {
    return then((value) => value.toDomain(areaHaId));
  }
}

extension DeviceFutureNullableMapper on Future<DeviceEntity?> {
  Future<Device?> mapToDomain(String areaHaId) {
    return then((value) => value?.toDomain(areaHaId));
  }
}
