import 'package:hommie/features/areas/domain/entities/area.dart';
import 'package:hommie/features/areas/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_for_home_provider.g.dart';

@Riverpod(dependencies: [areasRepository])
Future<List<Area>> areasForHome(Ref ref) async {
  final repo = await ref.watch(areasRepositoryProvider.future);
  final result = await repo.getAreas();

  return result.fold((error) => throw error, (areas) {
    final sorted = [...areas]..sort((a, b) => a.name.compareTo(b.name));
    return sorted;
  });
}
