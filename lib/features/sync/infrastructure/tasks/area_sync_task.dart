import 'package:hommie/features/sync/domain/models/sync_task.dart';
import 'package:hommie/services/networking/home_assitant_websocket/home_assistant_websocket.dart';

class AreaSyncTask implements SyncTask {
  final IHAConnection _connection;

  AreaSyncTask({required IHAConnection connection}) : _connection = connection;

  @override
  String get name => 'areas';

  @override
  Set<String> get dependencies => {};

  @override
  Future<SyncResult> execute(SyncContext context) async {
    final areas = await HACommands.getAreas(_connection);
    // final areas = await fetchAreas();
    // context.setValue('areas', areas);
    return const SyncResult(status: SyncStatus.success);
  }
}
