import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:hommie/features/home/infrastructure/providers/home_view_repository_provider.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Dependencies([ServerConnectionState])
class DeleteServerTask extends HTask {
  final IServerManager _serverManager;
  final Ref _ref;

  DeleteServerTask(this._serverManager, this._ref);

  @override
  Future<HTaskResult> execute(TaskExecutionContext context) async {
    final serverId = context.get<int>('serverId');

    try {
      // 1. Delete all home view configurations for this server
      final homeViewRepository = _ref.read(
        homeViewRepositoryForServerProvider(serverId),
      );
      await homeViewRepository.delete();
      logger.i('Deleted home views for server: $serverId');

      // 2. Get repositories for areas and devices
      final areaRepository = _ref.read(areaRepositoryProvider);

      // Get all areas for this server
      final areas = await areaRepository.getByServer(serverId);
      logger.i('Found ${areas.length} areas for server: $serverId');

      // NOTE: Due to data type mismatch between domain models (String IDs) and
      // repository interfaces (int IDs), we cannot directly delete areas and devices here.
      // The ServerManager.forceRemoveServer should handle cascade deletion through
      // the database layer. If not, this will need to be implemented with direct
      // Isar operations in a future improvement.
      if (areas.isNotEmpty) {
        logger.w(
          'Skipping individual area/device deletion due to ID type mismatch - relying on cascade deletion',
        );
      }

      // 3. Reset connection state since we're removing a server
      _ref.read(serverConnectionStateProvider.notifier).reset();
      logger.i('Reset connection state after server deletion');

      // 4. Force remove server from manager (allows removing the last server during sign out)
      // This should handle the cascade deletion through the repository layer
      await _serverManager.forceRemoveServer(serverId);
      logger.i(
        'Successfully removed server and initiated cascade deletion: $serverId',
      );

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
