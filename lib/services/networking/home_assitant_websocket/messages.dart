class HassServiceTarget {
  List<String>? entityId;
  List<String>? deviceId;
  List<String>? areaId;

  HassServiceTarget({
    this.entityId,
    this.deviceId,
    this.areaId,
  });
}

class ServiceCallMessage {
  final String type = "call_service";
  String domain;
  String service;
  Map<String, dynamic>? serviceData;
  HassServiceTarget? target;

  ServiceCallMessage({
    required this.domain,
    required this.service,
    this.serviceData,
    this.target,
  });
}

enum Error {
  one(1),
  two(2),
  three(3),
  four(4);

  const Error(this.code);
  final int code;

  @override
  String toString() => code.toString();
}

class Messages {
  static Map<String, dynamic> auth(String accessToken) {
    return {
      'type': 'auth',
      'access_token': accessToken,
    };
  }

  final supportedFeatures = {
    'type': 'supported_features',
    'id': 1, // Always the first message after auth
    'features': {'coalesce_messages': 1},
  };

  static final areas = <String, dynamic>{
    'type': 'config/area_registry/list',
  };

  static final states = <String, dynamic>{
    'type': 'get_states',
  };

  static final config = <String, dynamic>{
    'type': "get_config",
  };

  static final services = <String, dynamic>{
    'type': "get_services",
  };

  static final user = <String, dynamic>{
    'type': "auth/current_user",
  };

  static final ping = <String, dynamic>{
    'type': "ping",
  };

  static final subscribeEntities = <String, dynamic>{
    'type': "subscribe_entities",
  };

  static Map<String, dynamic> subscribeEvents(String? eventType) {
    return {
      'type': "subscribe_events",
      if (eventType != null) 'event_type': eventType,
    };
  }

  static Map<String, dynamic> unsubscribeEvents(int subscriptionId) {
    return <String, dynamic>{
      'type': "subscribe_events",
      'subscription': subscriptionId
    };
  }

  static Map<String, dynamic> error(Error code, String message) {
    return {
      'type': "result",
      'success': false,
      'error': {
        'code': code,
        'message': message,
      },
    };
  }
}
