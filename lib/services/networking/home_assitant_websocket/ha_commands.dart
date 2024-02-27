import 'dart:async';

import 'package:hommie/services/networking/home_assitant_websocket/future_mapping_extension.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';
import 'package:hommie/services/networking/home_assitant_websocket/messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types.dart';

class HACommands {
  static Future<List<HassEntity>> getStates(HAConnection connection) {
    return connection
        .sendMessage(Messages.states())
        .mapList(HassEntity.fromJson);
  }

  static Future<List<AreaEntity>> getAreas(HAConnection connection) {
    return connection
        .sendMessage(Messages.areas())
        .mapList(AreaEntity.fromJson);
  }

  static Future<HassUser> getUser(HAConnection connection) {
    return connection.sendMessage(Messages.user()).mapItem(HassUser.fromJson);
  }

  static Future<HassConfig> getConfig(HAConnection connection) {
    return connection
        .sendMessage(Messages.config())
        .mapItem(HassConfig.fromJson);
  }

  // static Future<HassServices> getServices(HAConnection connection) {
  //   return connection.sendMessage(Messages.config()).mapItem(HassServices.????);
  // }
}
