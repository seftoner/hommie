import 'package:hommie/services/networking/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/areas/infrastructure/repositories/areas_repository.dart';

part 'areas_provider.g.dart';

@riverpod
AreasRepository areasRepository(AreasRepositoryRef ref) {
  final connection = ref.watch(hAConnectionProvider);
  return AreasRepository(connection.value!);
}
