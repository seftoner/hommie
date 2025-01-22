import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/services/database/models/area.dart' as db;

extension AreaMapper on db.Area {
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
  db.Area toDb() {
    return db.Area(
      haId: id,
      name: name,
      image: imageUrl,
      background: backgroundUrl,
    );
  }
}

extension AreFutureaListMapper on Future<List<db.Area>> {
  Future<List<Area>> mapToDomain() {
    return then((list) => list.map((value) => value.toDomain()).toList());
  }
}

extension AreFutureaMapper on Future<db.Area> {
  Future<Area> mapToDomain() {
    return then((value) => value.toDomain());
  }
}

extension AreFutureaNullableMapper on Future<db.Area?> {
  Future<Area?> mapToDomain() {
    return then((value) => value?.toDomain());
  }
}
