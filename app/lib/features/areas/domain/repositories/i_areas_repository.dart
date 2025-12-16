import 'package:fpdart/fpdart.dart';
import 'package:hommie/features/areas/domain/entities/area.dart';

abstract class IAreasRepository {
  Future<Either<Exception, List<Area>>> getAreas();
}
