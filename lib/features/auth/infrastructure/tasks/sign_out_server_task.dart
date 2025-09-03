import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Dependencies([ServerConnectionManager])
class SignOutServerTask extends HTask {
  final IAuthRepository _authRepository;
  final Ref _ref;

  SignOutServerTask(this._authRepository, this._ref);

  @override
  Future<HTaskResult> execute(TaskExecutionContext context) async {
    final serverId = context.get<int>('serverId')!;

    try {
      // Step 1: Disconnect the server connection if active
      final connectionManager = _ref.read(
        serverConnectionManagerProvider.notifier,
      );

      connectionManager.disconnect(serverId);
      logger.i('Disconnected server connection for server: $serverId');

      // Step 2: Clear credentials from repository
      await _authRepository.signOut(serverId);
      logger.i('Successfully signed out from server: $serverId');

      return HTaskResult.success(null);
    } catch (e) {
      logger.e('Failed to sign out from server: $serverId', error: e);
      return HTaskResult.failure(e);
    }
  }

  @override
  bool get supportsRollback => false;

  @override
  String get name => 'Sign Out Server Task';
}
