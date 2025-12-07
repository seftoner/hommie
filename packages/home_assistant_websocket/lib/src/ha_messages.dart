import 'dart:convert';

abstract class HABaseMessage {
  late Map<String, dynamic> _payload;
  Map<String, dynamic> get _basePayload;

  HABaseMessage() {
    _payload = _basePayload;
  }

  set id(int id) {
    _payload['id'] = id;
  }

  Map<String, dynamic> get payload {
    return _payload;
  }

  String toJson() => jsonEncode(_payload);

  @override
  String toString() => _payload.toString();
}

class AuthMessage extends HABaseMessage {
  AuthMessage({required String accessToken}) {
    _payload['access_token'] = accessToken;
  }

  @override
  Map<String, dynamic> get _basePayload => {'type': 'auth'};
}

class SupportedFeaturesMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'supported_features',
    'id': 1, // Always the first message after auth
    'features': {'coalesce_messages': 1},
  };
}

class AreasMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'config/area_registry/list',
  };
}

class CurrentUserMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'auth/current_user',
  };
}

class GetStatesMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'get_states',
  };
}

class GetServicesMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'get_services',
  };
}

class ServiceCallMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'call_service',
  };

  ServiceCallMessage({
    required String domain,
    required String service,
    String? target,
    Map<String, dynamic>? serviceData,
    bool? returnResponse,
  }) {
    _payload.addAll({
      'domain': domain,
      'service': service,
      if (target != null) 'target': target,
      if (serviceData != null) 'service_data': serviceData,
      if (returnResponse != null) 'return_response': returnResponse,
    });
  }
}

class SubscribeEntitiesMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'subscribe_entities',
  };

  ///Filter entites by id
  set entityIds(List<String> ids) {
    _payload['entity_ids'] = ids;
  }
}

class SubscribeEventsMessage extends HABaseMessage {
  SubscribeEventsMessage(String? eventType) {
    if (eventType != null) {
      _payload['event_type'] = eventType;
    }
  }
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'subscribe_events',
  };
}

class UnsubscribeEventsMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'unsubscribe_events',
  };

  UnsubscribeEventsMessage({required int subscriptionID}) {
    _payload['subscription'] = subscriptionID;
  }
}

class ConfigMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{
    'type': 'get_config',
  };
}

class PingMessage extends HABaseMessage {
  @override
  Map<String, dynamic> get _basePayload => <String, dynamic>{'type': 'ping'};
}
