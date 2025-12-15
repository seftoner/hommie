import 'dart:async';

import 'package:home_assistant_websocket/src/connection/ha_connection.dart';
import 'package:home_assistant_websocket/src/protocol/messages/ha_messages.dart';
import 'package:home_assistant_websocket/src/protocol/types/ha_response.dart';
import 'package:home_assistant_websocket/src/protocol/types/ha_subscription.dart';
import 'package:home_assistant_websocket/src/protocol/types/hass_event.dart';
import 'package:home_assistant_websocket/src/protocol/types/hass_service.dart';
import 'package:home_assistant_websocket/src/protocol/types/hass_types.dart';

class HACommands {
  /// Returns a value indicating whether the operation was successful.
  ///
  /// TODO: Consider changing the return type to `bool` to explicitly indicate success/failure.
  static Future<void> pingServer(IHAConnection connection) {
    return connection.sendMessage(PingMessage());
  }

  static Future<List<HassEntity>> getStates(IHAConnection connection) {
    return connection
        .sendMessage(GetStatesMessage())
        .mapList(HassEntity.fromJson);
  }

  static Future<HassUser> getUser(IHAConnection connection) {
    return connection
        .sendMessage(CurrentUserMessage())
        .mapItem(HassUser.fromJson);
  }

  static Future<HassConfig> getConfig(IHAConnection connection) {
    return connection.sendMessage(ConfigMessage()).mapItem(HassConfig.fromJson);
  }

  static HASubscription subscribeEvents(
    IHAConnection connection, [
    String? eventType,
  ]) {
    return connection.subscribeMessage(SubscribeEventsMessage(eventType));
  }

  static HASubscription subscribeEntities(IHAConnection connection) {
    return connection.subscribeMessage(SubscribeEntitiesMessage());
  }

  static Future<HassServices> getServices(IHAConnection connection) {
    return connection
        .sendMessage(GetServicesMessage())
        .mapItem(HassServices.fromJson);
  }

  static Future<CallServiceResponse> callService(
    IHAConnection connection, {
    required String domain,
    required String service,
    String? target,
    Map<String, dynamic>? serviceData,
    bool? returnResponse,
  }) {
    return connection
        .sendMessage(
          ServiceCallMessage(
            domain: domain,
            service: service,
            target: target,
            serviceData: serviceData,
            returnResponse: returnResponse,
          ),
        )
        .mapItem(CallServiceResponse.fromJson);
  }
}
