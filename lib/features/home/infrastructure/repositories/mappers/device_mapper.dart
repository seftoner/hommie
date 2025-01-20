import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/base_mapper.dart';
import 'package:hommie/services/database/models/device.dart' as db;

class DeviceMapper implements BaseMapper<Device, db.Device> {
  const DeviceMapper._();
  static final instance = const DeviceMapper._();

  @override
  Device fromDatabase(db.Device device) => Device(
        id: device.haId,
        name: device.name,
        type: device.type,
        isHidden: device.isHidden,
        position: device.position,
        areaId: device.area.value?.haId ?? '',
      );

  @override
  db.Device toDatabase(Device device) => db.Device(
        haId: device.id,
        name: device.name,
        type: device.type,
        isHidden: device.isHidden,
        position: device.position,
      );
}
