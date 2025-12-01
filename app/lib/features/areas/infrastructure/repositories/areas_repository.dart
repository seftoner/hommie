import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/areas/domain/repositories/i_areas_repository.dart';

class AreasRepository implements IAreasRepository {
  final HAConnection _haWebsocketsConnection;

  AreasRepository(this._haWebsocketsConnection);

  @override
  Future<Either<Exception, List<AreaEntity>>> getAreas() async {
    try {
      logger.i('Get list of areas');
      final result = await HACommands.getAreas(_haWebsocketsConnection);

      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
