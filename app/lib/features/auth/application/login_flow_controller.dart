import 'dart:async';

import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/common/domain/entities/ha_version.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_flow_controller.g.dart';

class LoginFlowException implements Exception {
  const LoginFlowException(this.failure);

  final AuthFailure failure;

  @override
  String toString() => 'LoginFlowException($failure)';
}

class LoginFlowController {
  LoginFlowController(this._ref);

  static final redirectUrl = Uri.parse('hommie://');

  final Ref _ref;

  Future<void> login(
    ServerUrl serverUrl, {
    required AuthResponseHandler handler,
  }) async {
    final serverManager = _ref.read(serverManagerProvider);
    final authRepository = _ref.read(authRepositoryProvider);
    Server? createdServer;
    var credentialsStored = false;
    var activated = false;

    try {
      createdServer = await serverManager.addServer(
        Server.temporary(baseUrl: serverUrl),
      );

      final loginResult = await authRepository.login(
        serverId: createdServer.id!,
        serverUrl: createdServer.baseUrl!.value.getOrElse((_) => ''),
        redirectUrl: redirectUrl,
        handler: handler,
      );

      final cancelled = await loginResult.match<Future<bool>>(
        (failure) async {
          if (failure is UserBrake) {
            await _rollback(
              serverId: createdServer!.id!,
              authRepository: authRepository,
              credentialsStored: credentialsStored,
            );
            createdServer = null;
            return true;
          }

          throw LoginFlowException(failure);
        },
        (_) async {
          credentialsStored = true;
          return false;
        },
      );

      if (cancelled) {
        return;
      }

      final server = createdServer!;
      final configRepository = await _ref.read(
        websocketConfigRepositoryProvider(server.id!).future,
      );
      final config = await configRepository.getConfig();

      final updatedServer = await serverManager.addServer(
        server.copyWith(
          name: config.location_name,
          version: HaVersion.fromString(config.version),
          internalUrl: config.internal_url,
          externalUrl: config.external_url,
        ),
      );

      await serverManager.activateServer(updatedServer.id!);
      activated = true;
    } catch (error, stackTrace) {
      if (!activated && createdServer?.id != null) {
        await _rollback(
          serverId: createdServer!.id!,
          authRepository: authRepository,
          credentialsStored: credentialsStored,
        );
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> _rollback({
    required int serverId,
    required IAuthRepository authRepository,
    required bool credentialsStored,
  }) async {
    final serverManager = _ref.read(serverManagerProvider);
    _ref.read(serverConnectionManagerProvider).disconnect(serverId);

    if (credentialsStored) {
      try {
        await authRepository.signOut(serverId);
      } catch (error, stackTrace) {
        logger.w(
          'Failed to clear credentials during login rollback',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    try {
      await serverManager.removeServer(serverId, allowRemovingLast: true);
    } catch (error, stackTrace) {
      logger.w(
        'Failed to remove temporary server during login rollback',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

@Riverpod(
  keepAlive: true,
  dependencies: [
    authRepository,
    serverConnectionManager,
    websocketConfigRepository,
  ],
)
LoginFlowController loginFlowController(Ref ref) {
  return LoginFlowController(ref);
}
