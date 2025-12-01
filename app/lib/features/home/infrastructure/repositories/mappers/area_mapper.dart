import 'package:drift/drift.dart';
import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/core/database/database.dart';

extension AreaMapper on AreaEntity {
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
  AreaEntitiesCompanion toCompanion(int serverId) {
    return AreaEntitiesCompanion(
      haId: Value(id),
      name: Value(name),
      image: Value(imageUrl),
      background: Value(backgroundUrl),
      serverId: Value(serverId),
    );
  }
}

extension AreaFutureListMapper on Future<List<AreaEntity>> {
  Future<List<Area>> mapToDomain() {
    return then((list) => list.map((value) => value.toDomain()).toList());
  }
}

extension AreaFutureMapper on Future<AreaEntity> {
  Future<Area> mapToDomain() {
    return then((value) => value.toDomain());
  }
}

extension AreFutureaNullableMapper on Future<AreaEntity?> {
  Future<Area?> mapToDomain() {
    return then((value) => value?.toDomain());
  }
}
