import 'package:hommie/services/networking/home_assistant_websocket/src/types/hass_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_controller.g.dart';

@riverpod
class AreasController extends _$AreasController {
  @override
  Future<List<AreaEntity>> build() async {
    // final repository = await ref.watch(areasRepositoryProvider.future);
    // final resultOrError = await repository.getAreas();
    // return resultOrError.fold(
    //   (l) => throw l,
    //   (r) => r,
    // );
    return const [
      AreaEntity(area_id: 'living_room', name: 'Living Room'),
      AreaEntity(area_id: 'bedroom', name: 'Bedroom'),
      AreaEntity(area_id: 'kitchen', name: 'Kitchen'),
      AreaEntity(area_id: 'bathroom', name: 'Bathroom'),
    ];
  }
}
