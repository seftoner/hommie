import 'package:hommie/features/sync/domain/models/sync_task.dart';

abstract class ISyncTaskFactory {
  Future<List<SyncTask>> createAllTasks();
  Future<SyncTask> createAreaSyncTask();
  Future<SyncTask> createDeviceSyncTask();
}
