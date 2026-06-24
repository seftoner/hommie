import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/domain/repositories/i_areas_repository.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';

class AreasRepository implements IAreasRepository {
  final IHAConnection _haWebsocketsConnection;

  AreasRepository(this._haWebsocketsConnection);

  @override
  Future<Either<Exception, List<Area>>> getAreas() async {
    try {
      logger.i('Get list of areas');
      final result = await HomeAssistantApi.fromConnection(
        _haWebsocketsConnection,
      ).areas.list();

      return Right(result.map((entry) => entry.toDomain()).toList());
    } catch (e) {
      return Left(Exception(e));
    }
  }
}

extension HassAreaMapper on HassArea {
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
