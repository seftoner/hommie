import 'package:hommie/core/domain/repositories/i_areas_repository.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/areas/infrastructure/repositories/areas_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_repository_providers.g.dart';

@Riverpod(dependencies: [serverScopeConnection])
IAreasRepository areasRepository(Ref ref) {
  final connection = ref.watch(serverScopeConnectionProvider);
  return AreasRepository(connection);
}
