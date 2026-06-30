import 'dart:async';

import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_states_provider.g.dart';

/// Live entity states for the active server, keyed by entity_id.
///
/// Subscribes to `subscribe_entities` while connected and folds the compressed
/// diffs into a map. Volatile — not persisted. Empty while disconnected.
@Riverpod(dependencies: [serverScopeConnection])
class EntityStates extends _$EntityStates {
  HASubscription? _sub;
  StreamSubscription<dynamic>? _events;
  IHAConnection? _connection;
  Map<String, EntityState> _current = const {};

  @override
  Map<String, EntityStateValue> build() {
    final IHAConnection connection;
    try {
      connection = ref.watch(serverScopeConnectionProvider);
    } catch (error, stackTrace) {
      if (_isServerScopeConnectionUnavailable(error)) {
        _current = const {};
        unawaited(_stop());
        return const {};
      }
      _throwOriginalError(error, stackTrace);
    }

    ref.onDispose(() {
      unawaited(_stop());
    });

    if (identical(_connection, connection) && _sub != null) {
      return _toStateValues(_current);
    }

    unawaited(_stop());
    _connection = connection;
    _current = const {};
    try {
      _sub = HomeAssistantApi.fromConnection(connection).entities.subscribe();
    } on ConnectionClosedError {
      unawaited(_stop());
      return const {};
    }

    _events = _sub!.stream.listen((update) {
      if (update is StatesUpdates) {
        _current = applyStatesUpdate(_current, update);
        state = _toStateValues(_current);
      }
    });

    return _toStateValues(_current);
  }

  Future<void> _stop() async {
    final events = _events;
    final sub = _sub;
    _events = null;
    _sub = null;
    _connection = null;

    await events?.cancel();
    if (sub != null && !sub.isDisposed) {
      await sub.dispose();
    }
  }
}

Map<String, EntityStateValue> _toStateValues(Map<String, EntityState> states) {
  return states.map(
    (entityId, entityState) => MapEntry(
      entityId,
      EntityStateValue(
        state: entityState.state ?? 'unknown',
        attributes: entityState.attributes ?? const {},
      ),
    ),
  );
}

bool _isServerScopeConnectionUnavailable(Object error) {
  return switch (error) {
    ServerScopeConnectionUnavailableException() => true,
    ProviderException(:final exception) => _isServerScopeConnectionUnavailable(
      exception,
    ),
    _ => false,
  };
}

Never _throwOriginalError(Object error, StackTrace stackTrace) {
  if (error case ProviderException(:final exception, :final stackTrace)) {
    Error.throwWithStackTrace(exception, stackTrace);
  }
  Error.throwWithStackTrace(error, stackTrace);
}
