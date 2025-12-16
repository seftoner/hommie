import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/home/infrastructure/providers/home_view_repository_provider.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';

class DeleteServerAction extends HAction {
  final IServerManager _serverManager;
  final Ref _ref;

  DeleteServerAction(this._serverManager, this._ref);

  @override
  Future<HActionResult> execute(ActionExecutionContext context) async {
    final serverId = context.get<int>('serverId');

    try {
      // 1. Delete all home view configurations for this server
      final homeViewRepository = _ref.read(
        homeViewRepositoryForServerProvider(serverId),
      );
      await homeViewRepository.delete();
      logger.i('Deleted home views for server: $serverId');

      // 2. Remove server from manager (allows removing the last server during sign out)
      // This should handle the cascade deletion through the repository layer
      await _serverManager.removeServer(serverId, allowRemovingLast: true);

      return HActionResult.success(null);
    } catch (e) {
      logger.e('Error deleting server $serverId: $e');
      return HActionResult.failure(e);
    }
  }

  @override
  bool get supportsRollback => false;

  @override
  String get name => 'Delete Server Task';
}
