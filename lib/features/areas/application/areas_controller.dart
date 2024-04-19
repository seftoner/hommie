import 'package:hommie/features/areas/areas_provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types/hass_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_controller.g.dart';

@riverpod
class AreasController extends _$AreasController {
  @override
  Future<List<AreaEntity>> build() async {
    final repository = await ref.watch(areasRepositoryProvider.future);
    final resultOrError = await repository.getAreas();
    return resultOrError.fold(
      (l) => throw l,
      (r) => r,
    );
  }
}
