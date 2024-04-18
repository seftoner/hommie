import 'package:hommie/services/networking/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/areas/infrastructure/repositories/areas_repository.dart';

part 'areas_provider.g.dart';

@Riverpod(dependencies: [serverConnection])
Future<AreasRepository> areasRepository(AreasRepositoryRef ref) async {
  final connection = await ref.watch(serverConnectionProvider.future);
  return AreasRepository(connection);
}
