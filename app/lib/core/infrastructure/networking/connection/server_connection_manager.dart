import 'dart:async';

import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/connection_error_classification.dart';
import 'package:hommie/core/infrastructure/networking/connection/ha_connection_factory.dart';
import 'package:hommie/core/infrastructure/networking/connection/i_server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_config_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_connection_manager.g.dart';

@Riverpod(keepAlive: true, dependencies: [serverConfig])
IServerConnectionManager serverConnectionManager(Ref ref) {
  final stateNotifier = ref.read(serverConnectionStateProvider.notifier);
  final manager = ServerConnectionManagerImpl(
    factory: HAConnectionFactory(ref),
    setState: (state) {
      switch (state) {
        case HAServerConnectionState.unknown:
          stateNotifier.reset();
        case HAServerConnectionState.connected:
          stateNotifier.setConnected();
        case HAServerConnectionState.disconnected:
          stateNotifier.setDisconnected();
        case HAServerConnectionState.connecting:
          stateNotifier.setConnecting();
        case HAServerConnectionState.reconnecting:
          stateNotifier.setReconnecting();
        case HAServerConnectionState.authFailure:
          stateNotifier.setAuthFailure();
      }
    },
    resetState: stateNotifier.reset,
  );

  ref.onDispose(manager.dispose);

  return manager;
}

@Dependencies([serverConfig])
final class ServerConnectionManagerImpl implements IServerConnectionManager {
  ServerConnectionManagerImpl({
    required IHAConnectionFactory factory,
    required void Function(HAServerConnectionState state) setState,
    required void Function() resetState,
  }) : _factory = factory,
       _setState = setState,
       _resetState = resetState;

  final IHAConnectionFactory _factory;
  final void Function(HAServerConnectionState state) _setState;
  final void Function() _resetState;

  final Map<int, _ConnectionResource> _resources = {};
  final Map<int, _OpeningResource> _inFlight = {};
  final Map<int, int> _versions = {};

  int? _activeServerId;
  int _resetGeneration = 0;
  bool _isDisposed = false;

  @override
  void setActiveServer(int? serverId) {
    if (_activeServerId == serverId) {
      return;
    }

    _activeServerId = serverId;
    _resetGeneration += 1;

    if (serverId == null && !_isDisposed) {
      _scheduleResetState(expectedActiveServerId: null);
    }

    final staleServerIds = {..._resources.keys, ..._inFlight.keys};

    for (final existingServerId in staleServerIds) {
      if (existingServerId != serverId) {
        disconnect(existingServerId);
      }
    }
  }

  @override
  Future<IHAConnection> getConnection(int serverId) {
    if (_isDisposed) {
      return Future.error(StateError('ServerConnectionManager is disposed'));
    }

    final resource = _resources[serverId];
    if (resource != null) {
      try {
        return Future.value(resource.connection);
      } catch (error, stackTrace) {
        return Future.error(error, stackTrace);
      }
    }

    final inFlight = _inFlight[serverId];
    if (inFlight != null) {
      return inFlight.future;
    }

    final version = _versionOf(serverId);
    final opening = _factory.open(serverId);
    final future = _open(serverId, version, opening);
    _inFlight[serverId] = _OpeningResource(opening: opening, future: future);
    return future;
  }

  Future<IHAConnection> _open(
    int serverId,
    int version,
    HAConnectionOpening opening,
  ) async {
    try {
      final managed = await opening.future;

      if (_isDisposed || version != _versionOf(serverId)) {
        await managed.close();
        throw const ConnectionOpenCancelled();
      }

      late final StreamSubscription<HASocketState> subscription;
      subscription = managed.states.listen((state) {
        _handleConnectionState(serverId, state, subscription);
      });

      final resource = _ConnectionResource(
        managed: managed,
        subscription: subscription,
      );
      _resources[serverId] = resource;

      _handleConnectionState(serverId, managed.currentState, subscription);

      return managed.connection;
    } on ConnectionOpenCancelled {
      rethrow;
    } catch (error) {
      if (_activeServerId == serverId &&
          version == _versionOf(serverId) &&
          !_isDisposed) {
        if (isConnectionAuthenticationFailure(error)) {
          _setState(HAServerConnectionState.authFailure);
        } else {
          _setState(HAServerConnectionState.disconnected);
        }
      }

      rethrow;
    } finally {
      if (version == _versionOf(serverId)) {
        _inFlight.remove(serverId);
      }
    }
  }

  @override
  Future<void> reconnect(int serverId) async {
    disconnect(serverId);
    await getConnection(serverId);
  }

  @override
  void disconnect(int serverId) {
    _bumpVersion(serverId);
    _removeOpening(serverId);
    _removeResource(serverId);

    if (_activeServerId == serverId && !_isDisposed) {
      _scheduleResetState(expectedActiveServerId: serverId);
    }
  }

  void dispose() {
    if (_isDisposed) {
      return;
    }

    _isDisposed = true;

    for (final serverId in _resources.keys.toList()) {
      _bumpVersion(serverId);
      _removeResource(serverId);
    }

    for (final serverId in _inFlight.keys.toList()) {
      _bumpVersion(serverId);
      _removeOpening(serverId);
    }
  }

  void _removeResource(int serverId) {
    final resource = _resources.remove(serverId);
    if (resource != null) {
      unawaited(resource.dispose());
    }
  }

  void _removeOpening(int serverId) {
    final opening = _inFlight.remove(serverId);
    if (opening != null) {
      unawaited(opening.close());
    }
  }

  void _handleConnectionState(
    int serverId,
    HASocketState state,
    StreamSubscription<HASocketState> subscription,
  ) {
    if (_isDisposed) {
      return;
    }

    final resource = _resources[serverId];
    if (resource == null || !identical(resource.subscription, subscription)) {
      return;
    }

    final shouldUpdateGlobalState = _activeServerId == serverId;
    switch (state) {
      case Disconnected(type: DisconnectionType.authFailure):
        if (shouldUpdateGlobalState) {
          _setState(HAServerConnectionState.authFailure);
        }
        _removeResource(serverId);
        break;
      case Connecting():
        if (shouldUpdateGlobalState) {
          _setState(HAServerConnectionState.connecting);
        }
        break;
      case Authenticated():
        if (shouldUpdateGlobalState) {
          _setState(HAServerConnectionState.connected);
        }
        break;
      case Reconnecting():
        if (shouldUpdateGlobalState) {
          _setState(HAServerConnectionState.reconnecting);
        }
        break;
      case Disconnected():
        if (shouldUpdateGlobalState) {
          _setState(HAServerConnectionState.disconnected);
        }
        break;
    }
  }

  void _scheduleResetState({required int? expectedActiveServerId}) {
    final generation = ++_resetGeneration;
    scheduleMicrotask(() {
      if (_isDisposed ||
          _resetGeneration != generation ||
          _activeServerId != expectedActiveServerId) {
        return;
      }

      _resetState();
    });
  }

  int _versionOf(int serverId) => _versions[serverId] ?? 0;

  void _bumpVersion(int serverId) {
    _versions[serverId] = _versionOf(serverId) + 1;
  }
}

final class _OpeningResource {
  const _OpeningResource({required this.opening, required this.future});

  final HAConnectionOpening opening;
  final Future<IHAConnection> future;

  Future<void> close() => opening.close();
}

final class _ConnectionResource {
  const _ConnectionResource({
    required this.managed,
    required this.subscription,
  });

  final ManagedHAConnection managed;
  final StreamSubscription<HASocketState> subscription;

  IHAConnection get connection => managed.connection;

  Future<void> dispose() async {
    final closeFuture = managed.close();
    await subscription.cancel();
    await closeFuture;
  }
}
