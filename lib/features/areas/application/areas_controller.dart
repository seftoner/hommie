import 'package:hommie/services/networking/server_scope_provider.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/types/hass_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_controller.g.dart';

@Riverpod(dependencies: [serverScopeConnection])
class AreasController extends _$AreasController {
  @override
  Future<List<AreaEntity>> build() async {
    try {
      // Get the current server connection - this ensures we're using the active server
      await ref.watch(serverScopeConnectionProvider.future);

      // TODO: Use the connection to fetch real areas data from the current server
      // For now, return mock data but the dependency ensures server-specific refresh
      return const [
        AreaEntity(area_id: 'living_room', name: 'Living Room'),
        AreaEntity(area_id: 'bedroom', name: 'Bedroom'),
        AreaEntity(area_id: 'kitchen', name: 'Kitchen'),
        AreaEntity(area_id: 'bathroom', name: 'Bathroom'),
      ];
    } catch (e) {
      // No active server or connection failed - return empty list
      return const [];
    }
  }
}
