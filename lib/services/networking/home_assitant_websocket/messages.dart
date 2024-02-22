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

  static Map<String, dynamic> supportedFeatures() {
    return {
      'type': 'supported_features',
      'id': 1, // Always the first message after auth
      'features': {'coalesce_messages': 1},
    };
  }

  static Map<String, dynamic> areas() {
    return {
      'type': 'config/area_registry/list',
    };
  }

  static Map<String, dynamic> states() {
    return {
      'type': 'get_states',
    };
  }

  static Map<String, dynamic> config() {
    return {
      'type': "get_config",
    };
  }

  static Map<String, dynamic> services() {
    return {
      'type': "get_services",
    };
  }

  static Map<String, dynamic> user() {
    return {
      'type': "auth/current_user",
    };
  }

  static Map<String, dynamic> ping() {
    return {
      'type': "ping",
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



/* 
  class HassServiceTarget {
  // Add the properties of HassServiceTarget according to your TypeScript definition
}

class ServiceCallMessage {
  String type;
  String domain;
  String service;
  Map<String, dynamic>? serviceData;
  HassServiceTarget? target;

  ServiceCallMessage({
    required this.type,
    required this.domain,
    required this.service,
    this.serviceData,
    this.target,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'type': type,
      'domain': domain,
      'service': service,
    };
    if (serviceData != null) {
      data['service_data'] = serviceData;
    }
    if (target != null) {
      // Assuming HassServiceTarget has a toJson method
      data['target'] = target!.toJson();
    }
    return data;
  }
}

ServiceCallMessage callService(
  String domain,
  String service, {
  Map<String, dynamic>? serviceData,
  HassServiceTarget? target,
}) {
  return ServiceCallMessage(
    type: "call_service",
    domain: domain,
    service: service,
    serviceData: serviceData,
    target: target,
  );
}

class SubscribeEventMessage {
  String type = "subscribe_events";
  String? eventType;

  SubscribeEventMessage({this.eventType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'type': type};
    if (eventType != null) {
      data['event_type'] = eventType;
    }
    return data;
  }
}


*/