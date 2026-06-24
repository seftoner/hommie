import 'dart:async';

import 'package:home_assistant_client/src/api/ha_api_exceptions.dart';
import 'package:home_assistant_client/src/connection/ha_connection.dart';
import 'package:home_assistant_client/src/protocol/messages/ha_messages.dart';
import 'package:home_assistant_client/src/protocol/types/ha_response.dart';
import 'package:home_assistant_client/src/protocol/types/ha_subscription.dart';

final class HAWebSocketTransport {
  const HAWebSocketTransport(this._connection);

  const HAWebSocketTransport.unavailable() : _connection = null;

  final IHAConnection? _connection;

  HAResponse sendMessage(HAMessage message) {
    return _requireConnection().sendMessage(message);
  }

  HASubscription subscribeMessage(HAMessage message) {
    return _requireConnection().subscribeMessage(message);
  }

  Future<dynamic> sendJson(Map<String, dynamic> payload) {
    return sendMessage(HARawWebSocketMessage(payload));
  }

  HASubscription subscribeJson(Map<String, dynamic> payload) {
    return subscribeMessage(HARawWebSocketMessage(payload));
  }

  IHAConnection _requireConnection() {
    final connection = _connection;
    if (connection == null) {
      throw const UnsupportedTransportException(
        'WebSocket transport is unavailable.',
      );
    }
    return connection;
  }
}

final class HARawWebSocketMessage extends HARequestMessage {
  const HARawWebSocketMessage(this.payload);

  final Map<String, dynamic> payload;

  @override
  String get type {
    final value = payload['type'];
    if (value is String && value.isNotEmpty) {
      return value;
    }
    throw StateError('Raw WebSocket payload requires a non-empty type.');
  }

  @override
  JsonMap get body {
    return <String, dynamic>{
      for (final entry in payload.entries)
        if (entry.key != 'type' && entry.key != 'id') entry.key: entry.value,
    };
  }
}
