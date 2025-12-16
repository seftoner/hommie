import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/domain/repositories/i_areas_repository.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/areas/infrastructure/entry/area_registry_entry.dart';

final class AreasMessage extends HARequestMessage {
  const AreasMessage();

  @override
  String get type => 'config/area_registry/list';

  @override
  JsonMap get body => const <String, dynamic>{};
}

class AreasRepository implements IAreasRepository {
  final IHAConnection _haWebsocketsConnection;

  AreasRepository(this._haWebsocketsConnection);

  @override
  Future<Either<Exception, List<Area>>> getAreas() async {
    try {
      logger.i('Get list of areas');
      final result = await _haWebsocketsConnection
          .sendMessage(const AreasMessage())
          .mapList(AreaRegistryEntry.fromJson);

      return Right(result.toDomain());
    } catch (e) {
      return Left(Exception(e));
    }
  }
}

/// Maps infrastructure [AreaRegistryEntry] to domain [Area]
extension AreaRegistryEntryMapper on AreaRegistryEntry {
  Area toDomain() {
    return Area(
      id: areaId,
      name: name,
      icon: icon,
      picture: picture,
      aliases: aliases,
      labels: labels,
    );
  }
}

/// Maps a list of [AreaRegistryEntry] to a list of domain [Area]
extension AreaRegistryEntryListMapper on List<AreaRegistryEntry> {
  List<Area> toDomain() {
    return map((entry) => entry.toDomain()).toList();
  }
}
