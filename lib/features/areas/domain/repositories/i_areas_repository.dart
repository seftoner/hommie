import 'package:fpdart/fpdart.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types/hass_types.dart';

abstract class IAreasRepository {
  Future<Either<Exception, List<AreaEntity>>> getAreas();
}
