import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_controller.g.dart';

@Riverpod(dependencies: [serverScopeConnection])
class AreasController extends _$AreasController {
  @override
  Future<List<AreaEntity>> build() async {
    try {
      // Get the current server connection - this ensures we're using the active server
      final connection = await ref.watch(serverScopeConnectionProvider.future);
      final areas = await HACommands.getAreas(connection);
      return areas;
    } catch (e) {
      // No active server or connection failed - return empty list
      return const [];
    }
  }
}
