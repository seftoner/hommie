import 'package:hommie/features/shared/domain/models/htask.dart';

abstract class ISyncTaskFactory {
  Future<List<HTask>> createAllTasks();
  Future<HTask> createAreaSyncTask();
  Future<HTask> createDeviceSyncTask();
}
