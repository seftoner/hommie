import 'dart:async';

import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/server_sync_state.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/areas/infrastructure/repositories/areas_repository.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/repositories/entity_resolver.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_sync_coordinator.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [ActiveServerSession, areaRepository, entityRepository],
)
class ServerSyncCoordinator extends _$ServerSyncCoordinator {
  HASubscription? _areaSub;
  HASubscription? _entitySub;
  HASubscription? _deviceSub;
  StreamSubscription<dynamic>? _areaEvents;
  StreamSubscription<dynamic>? _entityEvents;
  StreamSubscription<dynamic>? _deviceEvents;
  IHAConnection? _connection;
  Future<void>? _startFuture;
  ServerSyncState? _lastState;
  int? _serverId;
  int _revision = 0;

  @override
  ServerSyncState build() {
    ref.onDispose(() {
      _revision += 1;
      _startFuture = null;
      unawaited(_stopSubscriptions());
    });

    final session = ref.watch(activeServerSessionProvider);

    return switch (session) {
      OnlineServerSession(:final activeServer, :final connection)
          when activeServer.id != null =>
        _ensureStarted(activeServer.id!, connection),
      OfflineServerSession() => _stopAndRemember(const SyncOfflineWithCache()),
      _ => _stopAndRemember(const SyncIdle()),
    };
  }

  ServerSyncState _ensureStarted(int serverId, IHAConnection connection) {
    final isSameSession =
        _serverId == serverId && identical(_connection, connection);
    if (isSameSession) {
      final current = _lastState ?? const InitialSyncRunning();
      return _remember(current);
    }

    _revision += 1;
    _serverId = serverId;
    _connection = connection;
    _startFuture = null;
    unawaited(_stopSubscriptions());

    final revision = _revision;
    _startFuture = _start(serverId, connection, revision);
    unawaited(_startFuture);

    return _remember(const InitialSyncRunning());
  }

  ServerSyncState _stopAndRemember(ServerSyncState next) {
    if (_serverId != null ||
        _connection != null ||
        _startFuture != null ||
        _areaSub != null ||
        _entitySub != null ||
        _deviceSub != null) {
      _revision += 1;
      _serverId = null;
      _connection = null;
      _startFuture = null;
      unawaited(_stopSubscriptions());
    }

    return _remember(next);
  }

  ServerSyncState _remember(ServerSyncState next) {
    _lastState = next;
    return next;
  }

  void _publish(ServerSyncState next) {
    _lastState = next;
    state = next;
  }

  Future<void> _start(
    int serverId,
    IHAConnection connection,
    int revision,
  ) async {
    if (!_isCurrent(serverId, connection, revision)) {
      return;
    }

    _publish(const InitialSyncRunning());

    try {
      await _subscribe(serverId, connection, revision);
      await _syncAreas(serverId, connection, revision);
      await _syncEntities(serverId, connection, revision);
      if (_isCurrent(serverId, connection, revision)) {
        _publish(const SyncReady());
      }
    } catch (error) {
      if (_isCurrent(serverId, connection, revision)) {
        _publish(SyncFailed(error));
      }
    } finally {
      if (_isCurrent(serverId, connection, revision)) {
        _startFuture = null;
      }
    }
  }

  Future<void> _subscribe(
    int serverId,
    IHAConnection connection,
    int revision,
  ) async {
    try {
      _areaSub = HACommands.subscribeEvents(
        connection,
        'area_registry_updated',
      );
      _entitySub = HACommands.subscribeEvents(
        connection,
        'entity_registry_updated',
      );
      _deviceSub = HACommands.subscribeEvents(
        connection,
        'device_registry_updated',
      );

      _areaEvents = _areaSub!.stream.listen((_) {
        unawaited(_refreshAreas(serverId, connection, revision));
      });
      _entityEvents = _entitySub!.stream.listen((_) {
        unawaited(_refreshEntities(serverId, connection, revision));
      });
      _deviceEvents = _deviceSub!.stream.listen((_) {
        unawaited(_refreshEntities(serverId, connection, revision));
      });
    } catch (_) {
      await _stopSubscriptions();
      rethrow;
    }
  }

  Future<void> _refreshAreas(
    int serverId,
    IHAConnection connection,
    int revision,
  ) async {
    try {
      await _syncAreas(serverId, connection, revision);
      if (_isCurrent(serverId, connection, revision) &&
          _lastState is SyncFailed) {
        _publish(const SyncReady());
      }
    } catch (error) {
      if (_isCurrent(serverId, connection, revision)) {
        _publish(SyncFailed(error));
      }
    }
  }

  Future<void> _refreshEntities(
    int serverId,
    IHAConnection connection,
    int revision,
  ) async {
    try {
      await _syncEntities(serverId, connection, revision);
      if (_isCurrent(serverId, connection, revision) &&
          _lastState is SyncFailed) {
        _publish(const SyncReady());
      }
    } catch (error) {
      if (_isCurrent(serverId, connection, revision)) {
        _publish(SyncFailed(error));
      }
    }
  }

  Future<void> _syncAreas(
    int serverId,
    IHAConnection connection,
    int revision,
  ) async {
    final remote = AreasRepository(connection);
    final result = await remote.getAreas();
    final areas = result.match<List<Area>>(
      (error) => throw error,
      (areas) => areas,
    );

    if (!_isCurrent(serverId, connection, revision)) {
      return;
    }

    await ref
        .read(areaRepositoryProvider)
        .syncAll(serverId: serverId, areas: areas);
  }

  Future<void> _syncEntities(
    int serverId,
    IHAConnection connection,
    int revision,
  ) async {
    final remote = HaRegistryRepository(connection);
    final entities = await remote.getEntities();
    final devices = await remote.getDevices();

    if (!_isCurrent(serverId, connection, revision)) {
      return;
    }

    final resolved = resolveEntities(entities: entities, devices: devices);
    await ref
        .read(entityRepositoryProvider)
        .syncAll(serverId: serverId, entities: resolved);
  }

  bool _isCurrent(int serverId, IHAConnection connection, int revision) {
    return _revision == revision &&
        _serverId == serverId &&
        identical(_connection, connection);
  }

  Future<void> _stopSubscriptions() async {
    final areaEvents = _areaEvents;
    final entityEvents = _entityEvents;
    final deviceEvents = _deviceEvents;
    final areaSub = _areaSub;
    final entitySub = _entitySub;
    final deviceSub = _deviceSub;

    _areaEvents = null;
    _entityEvents = null;
    _deviceEvents = null;
    _areaSub = null;
    _entitySub = null;
    _deviceSub = null;

    await areaEvents?.cancel();
    await entityEvents?.cancel();
    await deviceEvents?.cancel();

    for (final sub in [areaSub, entitySub, deviceSub]) {
      if (sub != null && !sub.isDisposed) {
        try {
          await sub.dispose();
        } catch (_) {
          // Best-effort unsubscribe.
        }
      }
    }
  }
}
