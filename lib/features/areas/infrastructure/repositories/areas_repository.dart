import 'package:fpdart/fpdart.dart';
import 'package:hommie/features/areas/domain/repositories/i_areas_repository.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_commands.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_websockets_connection.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types.dart';

class AreasRepository implements IAreasRepository {
  final HAWebsocketsConnection _haWebsocketsConnection;

  AreasRepository(this._haWebsocketsConnection);

  @override
  Future<Either<Exception, List<AreaEntity>>> getAreas() async {
    final result = await HACommands.getAreas(_haWebsocketsConnection);
    return Right(result);
  }
}
