import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';

abstract class IAreasRepository {
  Future<Either<Exception, List<AreaEntity>>> getAreas();
}
