import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/areas/domain/repositories/i_areas_repository.dart';
import 'package:hommie/features/areas/infrastructure/repositories/areas_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(dependencies: [serverScopeConnection])
Future<IAreasRepository> areasRepository(Ref ref) async {
  final connection = await ref.watch(serverScopeConnectionProvider.future);
  return AreasRepository(connection);
}
