import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';
import 'package:hommie/features/sync/domain/entities/registry/area_registry_entry.dart';

final class AreasMessage extends HARequestMessage {
  const AreasMessage();

  @override
  String get type => 'config/area_registry/list';

  @override
  JsonMap get body => const <String, dynamic>{};
}

class AreaSyncTask extends HAction<List<AreaRegistryEntry>, dynamic> {
  final IHAConnection _connection;

  AreaSyncTask({required IHAConnection connection}) : _connection = connection;

  @override
  String get name => 'areas';

  @override
  Future<HActionResult<List<AreaRegistryEntry>, dynamic>> execute(
    ActionExecutionContext context,
  ) async {
    final areas = await _connection
        .sendMessage(const AreasMessage())
        .mapList(AreaRegistryEntry.fromJson);

    return HActionResult.success(areas);
  }

  @override
  Future<void> rollback(ActionExecutionContext context) async {
    // Implement rollback logic to revert the state changes made during execution
    // Perhaps this could involve resetting the area state or notifying the system
    throw UnimplementedError('Rollback not yet implemented');
  }
}
