import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/areas/domain/repositories/i_areas_repository.dart';
import 'package:hommie/features/sync/domain/entities/registry/area_registry_entry.dart';

final class AreasMessage extends HARequestMessage {
  const AreasMessage();

  @override
  String get type => 'config/area_registry/list';

  @override
  JsonMap get body => const <String, dynamic>{};
}

class AreasRepository implements IAreasRepository {
  final HAConnection _haWebsocketsConnection;

  AreasRepository(this._haWebsocketsConnection);

  @override
  Future<Either<Exception, List<AreaRegistryEntry>>> getAreas() async {
    try {
      logger.i('Get list of areas');
      final result = await _haWebsocketsConnection
          .sendMessage(const AreasMessage())
          .mapList(AreaRegistryEntry.fromJson);

      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
