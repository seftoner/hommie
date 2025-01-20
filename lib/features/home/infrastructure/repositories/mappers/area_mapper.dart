import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/services/database/models/area.dart' as db;
import 'package:hommie/services/networking/home_assitant_websocket/src/types/hass_types.dart';
import 'base_mapper.dart';

import 'device_mapper.dart';

class AreaMapper implements BaseMapper<Area, db.Area> {
  const AreaMapper._();
  static final instance = const AreaMapper._();

  @override
  Area fromDatabase(db.Area area) => Area(
        id: area.haId,
        name: area.name,
        imageUrl: area.image,
        backgroundUrl: area.background,
        position: area.position,
        devices: area.devices.map(DeviceMapper.instance.fromDatabase).toList(),
      );

  @override
  db.Area toDatabase(Area area) => db.Area(
        haId: area.id,
        name: area.name,
        image: area.imageUrl,
        background: area.backgroundUrl,
        position: area.position,
      );

  Area fromHass(AreaEntity area, {int position = 0}) => Area(
        id: area.area_id,
        name: area.name,
        imageUrl: area.picture,
        position: position,
      );
}
