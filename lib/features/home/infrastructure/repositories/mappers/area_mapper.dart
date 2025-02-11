import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/services/database/models/area_entity.dart' as db;

extension AreaMapper on db.AreaEntity {
  Area toDomain() {
    return Area(
      id: haId,
      name: name,
      imageUrl: image,
      backgroundUrl: background,
    );
  }
}

extension AreaDomainMapper on Area {
  db.AreaEntity toDb() {
    return db.AreaEntity(
      haId: id,
      name: name,
      image: imageUrl,
      background: backgroundUrl,
    );
  }
}

extension AreFutureaListMapper on Future<List<db.AreaEntity>> {
  Future<List<Area>> mapToDomain() {
    return then((list) => list.map((value) => value.toDomain()).toList());
  }
}

extension AreFutureaMapper on Future<db.AreaEntity> {
  Future<Area> mapToDomain() {
    return then((value) => value.toDomain());
  }
}

extension AreFutureaNullableMapper on Future<db.AreaEntity?> {
  Future<Area?> mapToDomain() {
    return then((value) => value?.toDomain());
  }
}
