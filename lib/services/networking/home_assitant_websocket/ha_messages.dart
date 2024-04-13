import 'dart:convert';

abstract class HABaseMessgae {
  late Map<String, dynamic> _payload;
  Map<String, dynamic> get _basePayload;

  HABaseMessgae() {
    _payload = _basePayload;
  }

  set id(int id) {
    _payload["id"] = id;
  }

  Map<String, dynamic> get payload {
    return _payload;
  }

  String toJson() => jsonEncode(_payload);

  @override
  String toString() => _payload.toString();
}

class AuthMessage extends HABaseMessgae {
  AuthMessage({required String accessToken}) {
    _payload["access_token"] = accessToken;
  }

  @override
  get _basePayload => {"type": "auth"};
}

class SupportedFeaturesMessage extends HABaseMessgae {
  @override
  get _basePayload => <String, dynamic>{
        'type': 'supported_features',
        'id': 1, // Always the first message after auth
        'features': {'coalesce_messages': 1},
      };
}

class AreasMessage extends HABaseMessgae {
  @override
  get _basePayload => <String, dynamic>{
        'type': 'config/area_registry/list',
      };
}

class CurrentUserMessage extends HABaseMessgae {
  @override
  get _basePayload => <String, dynamic>{
        'type': 'auth/current_user',
      };
}

class GetStatesMessage extends HABaseMessgae {
  @override
  get _basePayload => <String, dynamic>{
        'type': 'get_states',
      };
}

class SubscribeEntitiesMessage extends HABaseMessgae {
  @override
  get _basePayload => <String, dynamic>{
        'type': 'subscribe_entities',
      };

  ///Filter entites by id
  set entityIds(List<String> ids) {
    _payload["entity_ids"] = ids;
  }
}

class UnsubscribeEventsMessage extends HABaseMessgae {
  @override
  get _basePayload => <String, dynamic>{
        'type': 'unsubscribe_events',
      };

  UnsubscribeEventsMessage({required int subsctibtionID}) {
    _payload["subscription"] = subsctibtionID;
  }
}

class ConfigMessage extends HABaseMessgae {
  @override
  get _basePayload => <String, dynamic>{
        'type': 'get_config',
      };
}

class PingMessage extends HABaseMessgae {
  @override
  get _basePayload => <String, dynamic>{
        'type': 'ping',
      };
}
