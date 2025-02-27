import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/home/infrastructure/providers/home_view_repository_provider.dart';
import 'package:hommie/features/server_manager/domain/i_server_manager.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

class DeleteServerTask extends HTask {
  final IServerManager _serverManager;
  final Ref _ref;

  DeleteServerTask(this._serverManager, this._ref);

  @override
  Future<HTaskResult> execute(TaskExecutionContext context) async {
    final serverId = context.get<int>('serverId')!;

    try {
      // Get HomeViewRepository specifically for this server
      final homeViewRepository =
          _ref.read(homeViewRepositoryForServerProvider(serverId));

      // Delete all home views for this server
      await homeViewRepository.delete();
      logger.i('Deleted home views for server: $serverId');

      // Remove server from manager
      await _serverManager.removeServer(serverId);
      logger.i('Successfully removed server: $serverId');

      return HTaskResult.success(null);
    } catch (e) {
      logger.e('Error deleting server $serverId: $e');
      return HTaskResult.failure(e);
    }
  }

  @override
  bool get supportsRollback => false;

  @override
  String get name => 'Delete Server Task';
}
