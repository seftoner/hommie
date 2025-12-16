import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/areas/domain/entities/area.dart';
import 'package:hommie/features/areas/domain/repositories/i_areas_repository.dart';

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
  Future<Either<Exception, List<Area>>> getAreas() async {
    try {
      logger.i('Get list of areas');
      final result = await _haWebsocketsConnection
          .sendMessage(const AreasMessage())
          .mapList(_mapJsonToArea);

      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  Area _mapJsonToArea(JsonMap json) {
    final id = json['area_id'];
    final name = json['name'];

    if (id is! String || name is! String) {
      throw const FormatException('Invalid area payload');
    }

    final aliases = json['aliases'];
    final labels = json['labels'];

    return Area(
      id: id,
      name: name,
      icon: json['icon'] as String?,
      picture: json['picture'] as String?,
      aliases: aliases is List
          ? aliases.whereType<String>().toList(growable: false)
          : const [],
      labels: labels is List
          ? labels.whereType<String>().toList(growable: false)
          : const [],
    );
  }
}
