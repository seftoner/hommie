import 'package:fpdart/fpdart.dart';
import 'package:hommie/features/sync/domain/entities/registry/area_registry_entry.dart';

abstract class IAreasRepository {
  Future<Either<Exception, List<AreaRegistryEntry>>> getAreas();
}
