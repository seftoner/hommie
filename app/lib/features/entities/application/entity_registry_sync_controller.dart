import 'dart:async';

import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/providers/registry_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/repositories/entity_resolver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_registry_sync_controller.g.dart';

enum EntitySyncStatus { notStarted, syncing, success, failure }

/// Keeps the local entity cache in sync with Home Assistant.
/// Subscribes to entity_registry_updated and device_registry_updated; refreshes
/// the full entity set into Drift on connect and on either event.
@Riverpod(dependencies: [serverScopeId, serverScopeConnection, registryRepository, entityRepository])
class EntityRegistrySyncController extends _$EntityRegistrySyncController {
  HASubscription? _entitySub;
  HASubscription? _deviceSub;
  StreamSubscription<dynamic>? _entityEvents;
  StreamSubscription<dynamic>? _deviceEvents;
  bool _didInitialSync = false;

  @override
  EntitySyncStatus build() {
    final serverId = ref.watch(serverScopeIdProvider);
    final connectionState = ref.watch(serverConnectionStateProvider);

    ref.onDispose(() => unawaited(_stop()));

    if (connectionState != HAServerConnectionState.connected) {
      _didInitialSync = false;
      unawaited(_stop());
      return EntitySyncStatus.notStarted;
    }

    unawaited(_start(serverId));
    return EntitySyncStatus.syncing;
  }

  Future<void> _start(int serverId) async {
    if (_entitySub != null) {
      return;
    }

    // Subscription setup is best-effort: a transient subscribe failure must not
    // prevent the initial sync below.
    try {
      final connection = ref.read(serverScopeConnectionProvider);
      _entitySub = HACommands.subscribeEvents(connection, 'entity_registry_updated');
      _deviceSub = HACommands.subscribeEvents(connection, 'device_registry_updated');
      _entityEvents = _entitySub!.stream.listen((_) => unawaited(_sync(serverId)));
      _deviceEvents = _deviceSub!.stream.listen((_) => unawaited(_sync(serverId)));
    } catch (_) {
      // Ignore; we still attempt the initial sync and will retry on reconnect.
    }

    if (!_didInitialSync) {
      _didInitialSync = true;
      await _sync(serverId);
    }
  }

  Future<void> _sync(int serverId) async {
    state = EntitySyncStatus.syncing;
    final registry = ref.read(registryRepositoryProvider);
    final local = ref.read(entityRepositoryProvider);
    try {
      final entities = await registry.getEntities();
      final devices = await registry.getDevices();
      final resolved = resolveEntities(entities: entities, devices: devices);
      await local.syncAll(serverId: serverId, entities: resolved);
      state = EntitySyncStatus.success;
    } catch (_) {
      // Surface failure; retried on next event / reconnect.
      state = EntitySyncStatus.failure;
    }
  }

  Future<void> _stop() async {
    await _entityEvents?.cancel();
    await _deviceEvents?.cancel();
    _entityEvents = null;
    _deviceEvents = null;
    for (final sub in [_entitySub, _deviceSub]) {
      if (sub != null && !sub.isDisposed) {
        try {
          await sub.dispose();
        } catch (_) {}
      }
    }
    _entitySub = null;
    _deviceSub = null;
  }
}
