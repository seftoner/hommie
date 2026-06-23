import 'dart:async';

import 'package:home_assistant_websocket/src/api/transports/ha_rest_transport.dart';
import 'package:home_assistant_websocket/src/api/transports/ha_websocket_transport.dart';
import 'package:home_assistant_websocket/src/connection/ha_connection.dart';
import 'package:home_assistant_websocket/src/protocol/messages/ha_messages.dart';
import 'package:home_assistant_websocket/src/protocol/types/ha_subscription.dart';
import 'package:home_assistant_websocket/src/protocol/types/hass_event.dart';
import 'package:home_assistant_websocket/src/protocol/types/hass_service.dart';
import 'package:home_assistant_websocket/src/protocol/types/hass_types.dart';
import 'package:http/http.dart' as http;

enum HATransport { rest, websocket }

final class HATransportDefaults {
  const HATransportDefaults({
    this.oneShotReads = HATransport.rest,
    this.serviceCalls = HATransport.rest,
  });

  final HATransport oneShotReads;
  final HATransport serviceCalls;
}

final class HomeAssistantApi {
  HomeAssistantApi({
    required Uri serverUri,
    required HATokenProvider tokenProvider,
    http.Client? httpClient,
    this.defaults = const HATransportDefaults(),
  }) : rest = HARestTransport(
         serverUri: serverUri,
         tokenProvider: tokenProvider,
         client: httpClient,
       ),
       websocket = const HAWebSocketTransport.unavailable() {
    _initResources();
  }

  HomeAssistantApi.fromConnection(
    IHAConnection connection, {
    this.defaults = const HATransportDefaults(
      oneShotReads: HATransport.websocket,
      serviceCalls: HATransport.websocket,
    ),
  }) : rest = HARestTransport.unavailable(),
       websocket = HAWebSocketTransport(connection) {
    _initResources();
  }

  final HATransportDefaults defaults;
  final HARestTransport rest;
  final HAWebSocketTransport websocket;

  late final HAConfigApi config;
  late final HAStatesApi states;
  late final HAServicesApi services;
  late final HAEntitiesApi entities;
  late final HAEventsApi events;

  void _initResources() {
    config = HAConfigApi._(this);
    states = HAStatesApi._(this);
    services = HAServicesApi._(this);
    entities = HAEntitiesApi._(this);
    events = HAEventsApi._(this);
  }

  HARestTransport _requireRest() {
    return rest;
  }

  HAWebSocketTransport _requireWebSocket() {
    return websocket;
  }
}

final class HAConfigApi {
  const HAConfigApi._(this._api);

  final HomeAssistantApi _api;

  Future<HassConfig> get({HATransport? via}) async {
    final transport = via ?? _api.defaults.oneShotReads;
    return switch (transport) {
      HATransport.rest => HassConfig.fromJson(
        await _api._requireRest().getJson('/api/config')
            as Map<String, dynamic>,
      ),
      HATransport.websocket => HassConfig.fromJson(
        await _api._requireWebSocket().sendMessage(const ConfigMessage())
            as Map<String, dynamic>,
      ),
    };
  }
}

final class HAStatesApi {
  const HAStatesApi._(this._api);

  final HomeAssistantApi _api;

  Future<List<HassEntity>> list({HATransport? via}) async {
    final transport = via ?? _api.defaults.oneShotReads;
    final payload = switch (transport) {
      HATransport.rest => await _api._requireRest().getJson('/api/states'),
      HATransport.websocket => await _api._requireWebSocket().sendMessage(
        const GetStatesMessage(),
      ),
    };

    return (payload as List<dynamic>)
        .map((item) => HassEntity.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<HassEntity> get(String entityId) async {
    final payload = await _api._requireRest().getJson(
      '/api/states/${Uri.encodeComponent(entityId)}',
    );
    return HassEntity.fromJson(payload as Map<String, dynamic>);
  }
}

final class HAServicesApi {
  const HAServicesApi._(this._api);

  final HomeAssistantApi _api;

  Future<HassServices> list({HATransport? via}) async {
    final transport = via ?? _api.defaults.oneShotReads;
    final payload = switch (transport) {
      HATransport.rest => await _api._requireRest().getJson('/api/services'),
      HATransport.websocket => await _api._requireWebSocket().sendMessage(
        const GetServicesMessage(),
      ),
    };
    return HassServices.fromJson(payload as Map<String, dynamic>);
  }

  Future<CallServiceResponse> call({
    required String domain,
    required String service,
    HATarget? target,
    Map<String, dynamic>? serviceData,
    bool? returnResponse,
    HATransport? via,
  }) async {
    final transport = via ?? _api.defaults.serviceCalls;
    return switch (transport) {
      HATransport.rest => _callRest(
        domain: domain,
        service: service,
        target: target,
        serviceData: serviceData,
        returnResponse: returnResponse,
      ),
      HATransport.websocket => _callWebSocket(
        domain: domain,
        service: service,
        target: target,
        serviceData: serviceData,
        returnResponse: returnResponse,
      ),
    };
  }

  Future<CallServiceResponse> _callRest({
    required String domain,
    required String service,
    HATarget? target,
    Map<String, dynamic>? serviceData,
    bool? returnResponse,
  }) async {
    final body = <String, dynamic>{
      ...?serviceData,
      ...?target?.toJson(),
      if (returnResponse != null) 'return_response': returnResponse,
    };
    final payload = await _api._requireRest().requestJson(
      method: 'POST',
      path: '/api/services/$domain/$service',
      body: body,
    );
    if (payload is Map<String, dynamic>) {
      return CallServiceResponse.fromJson(payload);
    }
    return CallServiceResponse(
      context: const Context(id: ''),
      response: payload,
    );
  }

  Future<CallServiceResponse> _callWebSocket({
    required String domain,
    required String service,
    HATarget? target,
    Map<String, dynamic>? serviceData,
    bool? returnResponse,
  }) async {
    final payload = await _api._requireWebSocket().sendMessage(
      ServiceCallMessage(
        domain: domain,
        service: service,
        haTarget: target,
        serviceData: serviceData,
        returnResponse: returnResponse,
      ),
    );
    return CallServiceResponse.fromJson(payload as Map<String, dynamic>);
  }
}

final class HAEntitiesApi {
  const HAEntitiesApi._(this._api);

  final HomeAssistantApi _api;

  HASubscription subscribe({List<String>? entityIds}) {
    return _api._requireWebSocket().subscribeMessage(
      SubscribeEntitiesMessage(entityIds: entityIds),
    );
  }
}

final class HAEventsApi {
  const HAEventsApi._(this._api);

  final HomeAssistantApi _api;

  HASubscription subscribe([String? eventType]) {
    return _api._requireWebSocket().subscribeMessage(
      SubscribeEventsMessage(eventType),
    );
  }
}
