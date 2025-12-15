import 'dart:convert';

typedef JsonMap = Map<String, dynamic>;

/// Outgoing HA websocket message (immutable).
///
/// Note: This is intentionally NOT `sealed` to allow external extensibility
/// (apps/tests can define their own message types).
abstract class HAMessage {
  const HAMessage();

  /// Builds the payload. For request/command messages, [id] is required.
  JsonMap toPayload({int? id});

  String encodeToJson({int? id}) => jsonEncode(toPayload(id: id));

  @override
  String toString() => '$runtimeType';
}

/// Base for messages that MUST contain an id (most commands/subscriptions).
abstract class HARequestMessage extends HAMessage {
  const HARequestMessage();

  String get type;
  JsonMap get body;

  @override
  JsonMap toPayload({int? id}) {
    if (id == null) {
      throw StateError(
        '$runtimeType requires an id. Call encodeToJson(id: ...)',
      );
    }
    return <String, dynamic>{'type': type, 'id': id, ...body};
  }
}

// ---------------------------------------------------------------------------
// Auth / handshake
// ---------------------------------------------------------------------------

final class AuthMessage extends HAMessage {
  const AuthMessage({required this.accessToken});

  final String accessToken;

  @override
  JsonMap toPayload({int? id}) => <String, dynamic>{
    'type': 'auth',
    'access_token': accessToken,
  };

  @override
  String toString() => 'AuthMessage(accessToken: **redacted**)';
}

/// HA expects `id: 1` here (special case).
final class SupportedFeaturesMessage extends HAMessage {
  const SupportedFeaturesMessage({
    this.features = const <String, dynamic>{'coalesce_messages': 1},
  });

  final JsonMap features;

  @override
  JsonMap toPayload({int? id}) => <String, dynamic>{
    'type': 'supported_features',
    'id': 1,
    'features': features,
  };
}

// ---------------------------------------------------------------------------
// Simple requests
// ---------------------------------------------------------------------------

final class CurrentUserMessage extends HARequestMessage {
  const CurrentUserMessage();

  @override
  String get type => 'auth/current_user';

  @override
  JsonMap get body => const <String, dynamic>{};
}

final class GetStatesMessage extends HARequestMessage {
  const GetStatesMessage();

  @override
  String get type => 'get_states';

  @override
  JsonMap get body => const <String, dynamic>{};
}

final class GetServicesMessage extends HARequestMessage {
  const GetServicesMessage();

  @override
  String get type => 'get_services';

  @override
  JsonMap get body => const <String, dynamic>{};
}

final class ConfigMessage extends HARequestMessage {
  const ConfigMessage();

  @override
  String get type => 'get_config';

  @override
  JsonMap get body => const <String, dynamic>{};
}

final class PingMessage extends HARequestMessage {
  const PingMessage();

  @override
  String get type => 'ping';

  @override
  JsonMap get body => const <String, dynamic>{};
}

// ---------------------------------------------------------------------------
// call_service
// ---------------------------------------------------------------------------

/// Optional typed target (recommended).
final class HATarget {
  const HATarget({this.entityIds, this.deviceIds, this.areaIds});

  final List<String>? entityIds;
  final List<String>? deviceIds;
  final List<String>? areaIds;

  JsonMap toJson() => <String, dynamic>{
    if (entityIds != null) 'entity_id': entityIds,
    if (deviceIds != null) 'device_id': deviceIds,
    if (areaIds != null) 'area_id': areaIds,
  };
}

final class ServiceCallMessage extends HARequestMessage {
  /// Backward-compatible: `target` as a single entity id string.
  /// Recommended: use [haTarget] for full correctness.
  const ServiceCallMessage({
    required this.domain,
    required this.service,
    this.target,
    this.haTarget,
    this.serviceData,
    this.returnResponse,
  }) : assert(
         target == null || haTarget == null,
         'Provide either target (legacy entity id) or haTarget, not both.',
       );

  final String domain;
  final String service;

  /// Legacy single entity id (kept for DX/backward compat with your current API).
  final String? target;

  /// Preferred typed target.
  final HATarget? haTarget;

  final JsonMap? serviceData;
  final bool? returnResponse;

  @override
  String get type => 'call_service';

  @override
  JsonMap get body => <String, dynamic>{
    'domain': domain,
    'service': service,
    if (haTarget != null) 'target': haTarget!.toJson(),
    if (haTarget == null && target != null)
      'target': <String, dynamic>{'entity_id': target},
    if (serviceData != null) 'service_data': serviceData,
    if (returnResponse != null) 'return_response': returnResponse,
  };
}

// ---------------------------------------------------------------------------
// Subscriptions
// ---------------------------------------------------------------------------

final class SubscribeEntitiesMessage extends HARequestMessage {
  const SubscribeEntitiesMessage({this.entityIds});

  final List<String>? entityIds;

  @override
  String get type => 'subscribe_entities';

  @override
  JsonMap get body => <String, dynamic>{
    if (entityIds != null) 'entity_ids': entityIds,
  };
}

final class SubscribeEventsMessage extends HARequestMessage {
  const SubscribeEventsMessage(this.eventType);

  final String? eventType;

  @override
  String get type => 'subscribe_events';

  @override
  JsonMap get body => <String, dynamic>{
    if (eventType != null) 'event_type': eventType,
  };
}

final class UnsubscribeEventsMessage extends HARequestMessage {
  const UnsubscribeEventsMessage({required this.subscriptionID});

  final int subscriptionID;

  @override
  String get type => 'unsubscribe_events';

  @override
  JsonMap get body => <String, dynamic>{'subscription': subscriptionID};
}
