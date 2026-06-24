import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/core/domain/entities/area.dart';

extension AreaMapper on AreaEntity {
  Area toDomain() {
    return Area(id: haId, name: name, picture: image);
  }
}

extension AreaDomainMapper on Area {
  AreaEntitiesCompanion toCompanion(int serverId) {
    return AreaEntitiesCompanion(
      haId: Value(id),
      name: Value(name),
      image: Value(picture),
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

extension AreaFutureNullableMapper on Future<AreaEntity?> {
  Future<Area?> mapToDomain() {
    return then((value) => value?.toDomain());
  }
}
