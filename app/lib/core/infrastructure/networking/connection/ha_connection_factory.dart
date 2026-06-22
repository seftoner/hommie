import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/logging/ha_logger_adapter.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_config_provider.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/server_auth_token_provider.dart';
import 'package:hommie/features/auth/infrastructure/providers/server_credentials_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

abstract interface class IHAConnectionFactory {
  Future<ManagedHAConnection> open(int serverId);
}

final class HAConnectionFactory implements IHAConnectionFactory {
  const HAConnectionFactory(this._ref);

  final Ref _ref;

  @override
  Future<ManagedHAConnection> open(int serverId) async {
    final server = await _ref.read(serverConfigProvider(serverId).future);
    final serverUrl = Uri.parse(server.url);

    // ignore: provider_dependencies
    Future<HAAuthToken> fetchToken() async {
      try {
        return await _ref.read(serverAuthTokenProvider(serverId).future);
      } on AuthFailure catch (failure) {
        throw ConnectionError('Failed to resolve token: $failure');
      } on AuthFailureException catch (exception) {
        throw ConnectionError('Failed to resolve token: ${exception.failure}');
      }
    }

    final connectionOption = HAConnectionOption.withLogger(
      serverUrl: serverUrl,
      fetchAuthToken: fetchToken,
      customLogger: HaLoggerAdapter(logger),
    );

    final orchestrator = ConnectionOrchestrator(connectionOption);
    await orchestrator.connect();

    final connection = orchestrator.connection;
    if (connection == null) {
      await orchestrator.close();
      throw ConnectionError('Connection failed to establish');
    }

    return ManagedHAConnection(
      connection: connection,
      states: orchestrator.state,
      close: orchestrator.close,
    );
  }
}
