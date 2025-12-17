import 'dart:async';

import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/areas/infrastructure/areas_repository_providers.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'area_registry_sync_controller.g.dart';

/// Keeps the local Drift area cache in sync with Home Assistant.
///
/// - When connected: subscribes to `area_registry_updated` and refreshes the full
///   registry into Drift.
/// - When disconnected: disposes the subscription.
@Riverpod(dependencies: [serverScopeId, serverScopeConnection, areasRepository])
class AreaRegistrySyncController extends _$AreaRegistrySyncController {
  HASubscription? _subscription;
  StreamSubscription<dynamic>? _eventsSubscription;
  bool _didInitialSync = false;

  @override
  void build() {
    final serverId = ref.watch(serverScopeIdProvider);
    final connectionState = ref.watch(serverConnectionStateProvider);

    ref.onDispose(() {
      unawaited(_stop());
    });

    if (connectionState != HAServerConnectionState.connected) {
      _didInitialSync = false;
      unawaited(_stop());
      return;
    }

    unawaited(_start(serverId));
  }

  Future<void> _start(int serverId) async {
    if (_subscription != null) {
      return;
    }

    final connection = ref.read(serverScopeConnectionProvider);

    // Subscribe to registry updates.
    final subscription = HACommands.subscribeEvents(
      connection,
      'area_registry_updated',
    );
    _subscription = subscription;

    _eventsSubscription = subscription.stream.listen((_) {
      unawaited(_sync(serverId));
    });

    // Initial sync on first connect.
    if (!_didInitialSync) {
      _didInitialSync = true;
      await _sync(serverId);
    }
  }

  Future<void> _sync(int serverId) async {
    final remote = ref.read(areasRepositoryProvider);
    final local = ref.read(areaRepositoryProvider);

    final result = await remote.getAreas();
    await result.match(
      (error) async {
        // Ignore transient errors; we'll retry on next event / reconnect.
      },
      (areas) async {
        await local.syncAll(serverId: serverId, areas: areas);
      },
    );
  }

  Future<void> _stop() async {
    final eventsSub = _eventsSubscription;
    _eventsSubscription = null;
    await eventsSub?.cancel();

    final sub = _subscription;
    _subscription = null;
    if (sub != null && !sub.isDisposed) {
      try {
        await sub.dispose();
      } catch (_) {
        // Best-effort unsubscribe.
      }
    }
  }
}
