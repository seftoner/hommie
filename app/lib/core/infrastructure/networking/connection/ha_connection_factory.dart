import 'dart:async';

import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/infrastructure/logging/ha_logger_adapter.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_config_provider.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/providers/server_auth_token_provider.dart';
import 'package:hommie/features/auth/infrastructure/providers/server_credentials_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

abstract interface class IHAConnectionFactory {
  HAConnectionOpening open(int serverId);
}

final class HAConnectionFactory implements IHAConnectionFactory {
  HAConnectionFactory(
    this._ref, {
    ConnectionOrchestrator Function(HAConnectionOption option)?
    createOrchestrator,
  }) : _createOrchestrator =
           createOrchestrator ?? ((option) => ConnectionOrchestrator(option));

  final Ref _ref;
  final ConnectionOrchestrator Function(HAConnectionOption option)
  _createOrchestrator;

  @override
  HAConnectionOpening open(int serverId) {
    final completer = Completer<ManagedHAConnection>();
    var isClosed = false;
    ConnectionOrchestrator? orchestrator;
    StreamSubscription<HASocketState>? stateSubscription;
    Future<void>? closeFuture;

    Future<void> closeOpening() {
      isClosed = true;
      if (!completer.isCompleted) {
        completer.completeError(const ConnectionOpenCancelled());
      }

      closeFuture ??= () async {
        await stateSubscription?.cancel();
        stateSubscription = null;
        await orchestrator?.close();
      }();
      return closeFuture!;
    }

    unawaited(
      _openManaged(
            serverId,
            () => isClosed,
            (createdOrchestrator) {
              orchestrator = createdOrchestrator;
            },
            (subscription) {
              stateSubscription = subscription;
            },
          )
          .then((managed) {
            if (!completer.isCompleted) {
              completer.complete(managed);
            }
          })
          .catchError((Object error, StackTrace stackTrace) async {
            await stateSubscription?.cancel();
            stateSubscription = null;
            await orchestrator?.close();
            if (!completer.isCompleted) {
              completer.completeError(error, stackTrace);
            }
          }),
    );

    return HAConnectionOpening(
      future: completer.future,
      close: closeOpening,
      retryNow: () => orchestrator?.retryNow(),
      setNetworkAvailable: ({required isAvailable}) =>
          orchestrator?.setNetworkAvailable(isAvailable: isAvailable),
    );
  }

  Future<ManagedHAConnection> _openManaged(
    int serverId,
    bool Function() isClosed,
    void Function(ConnectionOrchestrator orchestrator) setOrchestrator,
    void Function(StreamSubscription<HASocketState> subscription)
    setStateSubscription,
  ) async {
    final server = await _ref.read(serverConfigProvider(serverId).future);
    if (isClosed()) {
      throw const ConnectionOpenCancelled();
    }

    final serverUrl = Uri.parse(server.url);

    // ignore: provider_dependencies
    Future<HAAuthToken> fetchToken() async {
      try {
        final result = await _ref
            .read(authRepositoryProvider)
            .getCredentials(serverId);
        return result.match(_throwTokenFailure, authTokenFromCredentials);
      } on AuthFailure catch (failure) {
        _throwTokenFailure(failure);
      } on AuthFailureException catch (exception) {
        _throwTokenFailure(exception.failure);
      }
    }

    final connectionOption = HAConnectionOption.withLogger(
      serverUrl: serverUrl,
      fetchAuthToken: fetchToken,
      customLogger: HaLoggerAdapter(logger),
    );

    final orchestrator = _createOrchestrator(connectionOption);
    setOrchestrator(orchestrator);

    HASocketState? currentState;
    final stateSubscription = orchestrator.state.listen((state) {
      currentState = state;
    });
    setStateSubscription(stateSubscription);

    await orchestrator.connect();

    if (isClosed()) {
      await orchestrator.close();
      throw const ConnectionOpenCancelled();
    }

    final state = currentState ?? orchestrator.currentState;
    final connection = orchestrator.connection;
    if (connection == null || state is Disconnected) {
      final failure = _connectionOpenError(state);
      await orchestrator.close();
      throw failure;
    }

    final authenticatedState = state is Authenticated
        ? state
        : const Authenticated();

    await stateSubscription.cancel();

    return ManagedHAConnection(
      currentConnection: () {
        final current = orchestrator.connection;
        if (current == null) {
          throw ConnectionClosedError(
            'Connection for server $serverId is not currently authenticated.',
          );
        }
        return current;
      },
      currentState: authenticatedState,
      states: orchestrator.state,
      close: orchestrator.close,
      retryNow: orchestrator.retryNow,
      setNetworkAvailable: orchestrator.setNetworkAvailable,
    );
  }

  Never _throwTokenFailure(AuthFailure failure) {
    switch (failure) {
      case InvalidToken():
        throw AuthenticationError('Failed to resolve token: $failure');
      case MissingCredentials() ||
          Connection() ||
          ServerFailure() ||
          Storage() ||
          UserBrake():
        throw ConnectionError('Failed to resolve token: $failure');
    }
  }

  Exception _connectionOpenError(HASocketState? state) {
    switch (state) {
      case Authenticated():
        return ConnectionError('Connection failed to establish');
      case Disconnected(type: DisconnectionType.authFailure, :final reason):
        return AuthenticationError(reason ?? 'Authentication failed');
      case Disconnected(:final reason, :final error):
        return ConnectionError(
          reason ?? error?.toString() ?? 'Connection failed to establish',
        );
      case Connecting() || Reconnecting():
        return ConnectionError('Connection did not authenticate');
      case null:
        return ConnectionError('Connection did not report a state');
    }
  }
}
