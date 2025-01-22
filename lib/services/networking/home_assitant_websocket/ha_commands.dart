import 'dart:async';

import 'package:hommie/services/networking/home_assitant_websocket/src/future_mapping_extension.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/ha_messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/hass_subscription.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/types/types.dart';

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

  static Future<List<AreaEntity>> getAreas(IHAConnection connection) {
    return connection.sendMessage(AreasMessage()).mapList(AreaEntity.fromJson);
  }

  static Future<HassUser> getUser(IHAConnection connection) {
    return connection
        .sendMessage(CurrentUserMessage())
        .mapItem(HassUser.fromJson);
  }

  static Future<HassConfig> getConfig(IHAConnection connection) {
    return connection.sendMessage(ConfigMessage()).mapItem(HassConfig.fromJson);
  }

  static HassSubscription subscribeEntities(IHAConnection connection,
      [String? eventType]) {
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
        .sendMessage(ServiceCallMessage(
            domain: domain,
            service: service,
            target: target,
            serviceData: serviceData,
            returnResponse: returnResponse))
        .mapItem(CallServiceResponse.fromJson);
  }
}
