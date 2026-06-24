import 'package:hommie/core/infrastructure/database/database_provider.dart';
import 'package:hommie/features/entities/domain/repositories/i_entity_repository.dart';
import 'package:hommie/features/entities/infrastructure/repositories/drift_entity_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_repository_provider.g.dart';

@Riverpod(keepAlive: true)
IEntityRepository entityRepository(Ref ref) {
  final database = ref.watch(databaseConnectionProvider);
  return DriftEntityRepository(database);
}
