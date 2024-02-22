import 'package:hommie/services/networking/home_assitant_websocket/ha_websockets_connection.dart';
import 'package:hommie/services/networking/home_assitant_websocket/messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types.dart';

class HACommands {
  static Future<List<HassEntity>> getStates(HAWebsocketsConnection connection) {
    return connection.sendMessage<List<HassEntity>>(Messages.states());
  }

  static Future<List<AreaEntity>> getAreas(HAWebsocketsConnection connection) {
    return connection.sendMessage<List<AreaEntity>>(Messages.areas());
  }

  static Future<HassUser> getUser(HAWebsocketsConnection connection) {
    return connection.sendMessage<HassUser>(Messages.user());
  }

  static Future<HassConfig> getConfig(HAWebsocketsConnection connection) {
    return connection.sendMessage<HassConfig>(Messages.config());
  }

  static Future<HassServices> getServices(HAWebsocketsConnection connection) {
    return connection.sendMessage<HassServices>(Messages.config());
  }
}
