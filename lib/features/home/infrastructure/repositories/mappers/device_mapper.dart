import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/services/database/models/device.dart' as db;

extension DeviceMapper on db.Device {
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
  db.Device toDb() {
    return db.Device(
      haId: id,
      name: name,
      type: type,
    );
  }
}

extension DeviceFutureListMapper on Future<List<db.Device>> {
  Future<List<Device>> mapToDomain() {
    return then((list) => list.map((value) => value.toDomain()).toList());
  }
}

extension DeviceFutureMapper on Future<db.Device> {
  Future<Device> mapToDomain() {
    return then((value) => value.toDomain());
  }
}

extension DeviceFutureNullableMapper on Future<db.Device?> {
  Future<Device?> mapToDomain() {
    return then((value) => value?.toDomain());
  }
}
