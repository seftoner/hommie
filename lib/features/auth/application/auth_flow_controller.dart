import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/application/auth_state_machine.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/tasks/activate_server_if_exist_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/activate_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/create_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/delete_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/get_config_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/oauth_login_attempt_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/sign_out_server_task.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';
import 'package:hommie/features/shared/domain/models/task_chain.dart';
import 'package:hommie/features/shared/infrastructure/runner/task_executor.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_flow_controller.g.dart';

@Dependencies([
  websocketConfigRepository,
  ActiveServer,
  AuthStateMachine,
  ServerConnectionState,
  goRouter,
  ServerConnectionManager,
])
class AuthFlowController {
  AuthFlowController(this._ref);

  final Ref _ref;

  Future<void> login(String serverUrl) async {
    final serverManager = _ref.read(serverManagerProvider);
    final authRepository = _ref.read(authRepositoryProvider);

    final loginAction = TaskChain.builder()
        .withContext('serverUrl', serverUrl)
        .addTask(CreateServerTask(serverManager))
        .addTask(OAuthLoginAttemptTask(authRepository))
        .addTask(GetConfigTask(serverManager, _ref))
        .addTask(ActivateServerTask(_ref))
        .onTaskError<OAuthLoginAttemptTask, AuthFailure>((failure) {
          _setFailure(failure);
        })
        .onAnyError(_logAndSetFailure)
        .onSuccess((context) async {
          final server = context.get<Server>('server');
          final serverId = server.id;
          if (serverId != null) {
            await _ref
                .read(authStateMachineProvider(serverId).notifier)
                .hydrate();
            _ref.read(goRouterProvider).go(const HomeRouteData().location);
          }
        })
        .build();

    await TaskExecutor(loginAction).execute();
  }

  Future<void> signOut(int serverId) async {
    final serverManager = _ref.read(serverManagerProvider);
    final authRepository = _ref.read(authRepositoryProvider);

    final signOutAction = TaskChain.builder()
        .withContext('serverId', serverId)
        .addTask(SignOutServerTask(authRepository, _ref))
        .addTask(DeleteServerTask(serverManager, _ref))
        .addTask(ActivateServerIfExistTask(serverManager, _ref))
        .onAnyError(_logAndSetFailure)
        .onSuccess((context) async {
          await _ref
              .read(authStateMachineProvider(serverId).notifier)
              .clearSession();
          _ref.read(serverConnectionStateProvider.notifier).reset();

          final nextServer = await _ref.read(activeServerProvider.future);
          if (nextServer?.id != null) {
            await _ref
                .read(authStateMachineProvider(nextServer!.id!).notifier)
                .hydrate();
            _ref.read(goRouterProvider).go(const HomeRouteData().location);
          } else {
            _ref.read(goRouterProvider).go(const DiscoveryRoute().location);
          }
        })
        .build();

    await TaskExecutor(signOutAction).execute();
  }

  void _setFailure(AuthFailure failure) {
    final activeServer = _ref.read(activeServerProvider).value;
    final serverId = activeServer?.id;
    if (serverId != null) {
      _ref
          .read(authStateMachineProvider(serverId).notifier)
          .setFailure(failure);
    }
  }

  void _logAndSetFailure(Object error) {
    logger.e('Auth flow error: $error');
    if (error is AuthFailure) {
      _setFailure(error);
    }
  }
}

@Riverpod(
  keepAlive: true,
  dependencies: [
    websocketConfigRepository,
    ActiveServer,
    AuthStateMachine,
    ServerConnectionState,
    goRouter,
    ServerConnectionManager,
  ],
)
AuthFlowController authFlowController(Ref ref) {
  return AuthFlowController(ref);
}
