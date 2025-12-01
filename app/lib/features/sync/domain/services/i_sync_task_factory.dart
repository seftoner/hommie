import 'package:hommie/core/infrastructure/actions/haction.dart';

abstract class ISyncTaskFactory {
  Future<List<HAction>> createAllTasks();
  Future<HAction> createAreaSyncTask();
  Future<HAction> createDeviceSyncTask();
}
