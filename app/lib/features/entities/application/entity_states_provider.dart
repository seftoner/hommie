import 'dart:async';

import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_states_provider.g.dart';

/// Applies a compressed [StatesUpdates] (subscribe_entities payload) onto the
/// current entity-state map and returns the new map.
Map<String, EntityStateValue> applyStatesUpdate(
  Map<String, EntityStateValue> current,
  StatesUpdates update,
) {
  final next = Map<String, EntityStateValue>.from(current);

  update.add?.forEach((entityId, es) {
    next[entityId] = EntityStateValue(
      state: es.state ?? 'unknown',
      attributes: es.attributes ?? const {},
    );
  });

  update.change?.forEach((entityId, diff) {
    final plus = diff.add;
    if (plus == null) {
      return;
    }
    final cur = next[entityId];
    next[entityId] = EntityStateValue(
      state: plus.state ?? cur?.state ?? 'unknown',
      attributes: {...?cur?.attributes, ...?plus.attributes},
    );
  });

  update.remove?.forEach(next.remove);

  return next;
}

/// Live entity states for the active server, keyed by entity_id.
///
/// Subscribes to `subscribe_entities` while connected and folds the compressed
/// diffs into a map. Volatile — not persisted. Empty while disconnected.
@Riverpod(dependencies: [serverScopeConnection])
class EntityStates extends _$EntityStates {
  HASubscription? _sub;
  StreamSubscription<dynamic>? _events;

  @override
  Map<String, EntityStateValue> build() {
    final connectionState = ref.watch(serverConnectionStateProvider);

    ref.onDispose(() {
      unawaited(_events?.cancel());
      final sub = _sub;
      if (sub != null && !sub.isDisposed) {
        unawaited(sub.dispose());
      }
    });

    if (connectionState != HAServerConnectionState.connected) {
      return const {};
    }

    // Read the scoped connection only once connected — avoids touching the
    // (overridden-per-server) provider while disconnected.
    final connection = ref.watch(serverScopeConnectionProvider);

    try {
      _sub = HACommands.subscribeEntities(connection);
      _events = _sub!.stream.listen((update) {
        if (update is StatesUpdates) {
          state = applyStatesUpdate(state, update);
        }
      });
    } catch (_) {
      // Offline / unavailable connection: leave state empty.
    }

    return const {};
  }
}
