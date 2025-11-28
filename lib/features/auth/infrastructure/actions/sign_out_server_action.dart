import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';
import 'package:hommie/services/networking/i_server_connection_manager.dart';

class SignOutServerAction extends HAction {
  final IAuthRepository _authRepository;
  final IServerConnectionManager _serverConnectionManager;

  SignOutServerAction(this._authRepository, this._serverConnectionManager);

  @override
  Future<HActionResult> execute(ActionExecutionContext context) async {
    final serverId = context.get<int>('serverId');

    try {
      // Step 1: Disconnect the server connection if active
      _serverConnectionManager.disconnect(serverId);
      logger.i('Disconnected server connection for server: $serverId');

      // Step 2: Clear credentials from repository
      await _authRepository.signOut(serverId);
      logger.i('Successfully signed out from server: $serverId');

      return HActionResult.success(null);
    } catch (e) {
      logger.e('Failed to sign out from server: $serverId', error: e);
      return HActionResult.failure(e);
    }
  }

  @override
  bool get supportsRollback => false;

  @override
  String get name => 'Sign Out Server Task';
}
