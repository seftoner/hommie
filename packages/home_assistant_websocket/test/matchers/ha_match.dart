import 'package:home_assistant_websocket/src/ha_messages.dart';
import 'package:test/test.dart';

Matcher haMessage({required String type, int? subscription, int? id}) {
  return predicate((HABaseMessage arg) {
    if (arg.payload['type'] != type) return false;
    if (subscription != null && arg.payload['subscription'] != subscription) {
      return false;
    }
    if (id != null && arg.payload['id'] != id) return false;

    return true;
  }, 'HA message type=$type subscription=$subscription id=$id');
}
