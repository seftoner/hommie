import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/services/database/models/device_entity.dart' as db;

extension DeviceMapper on db.DeviceEntity {
  Device toDomain() {
    return Device(
      id: haId,
      name: name,
      type: type,
      areaId: area.value?.haId ?? '',
    );
  }
}

extension DeviceDomainMapper on Device {
  db.DeviceEntity toDb() {
    return db.DeviceEntity(
      haId: id,
      name: name,
      type: type,
    );
  }
}

extension DeviceFutureListMapper on Future<List<db.DeviceEntity>> {
  Future<List<Device>> mapToDomain() {
    return then((list) => list.map((value) => value.toDomain()).toList());
  }
}

extension DeviceFutureMapper on Future<db.DeviceEntity> {
  Future<Device> mapToDomain() {
    return then((value) => value.toDomain());
  }
}

extension DeviceFutureNullableMapper on Future<db.DeviceEntity?> {
  Future<Device?> mapToDomain() {
    return then((value) => value?.toDomain());
  }
}
