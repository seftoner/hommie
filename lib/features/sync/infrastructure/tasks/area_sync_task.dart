import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';
import 'package:hommie/services/networking/home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/types/types.dart';

class AreaSyncTask extends HAction<List<AreaEntity>, dynamic> {
  final IHAConnection _connection;

  AreaSyncTask({required IHAConnection connection}) : _connection = connection;

  @override
  String get name => 'areas';

  @override
  Future<HActionResult<List<AreaEntity>, dynamic>> execute(
    ActionExecutionContext context,
  ) async {
    final areas = await HACommands.getAreas(_connection);
    // final areas = await fetchAreas();
    // context.setValue('areas', areas);
    return HActionResult.success(areas);
  }

  @override
  Future<void> rollback(ActionExecutionContext context) async {
    // Implement rollback logic to revert the state changes made during execution
    // Perhaps this could involve resetting the area state or notifying the system
    throw UnimplementedError('Rollback not yet implemented');
  }
}
