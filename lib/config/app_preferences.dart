import 'dart:async';

import 'package:hommie/config/app_config.dart';
import 'package:hommie/core/preferences/storage_service.dart';

/* final appPreferencesProvider = Provider((ref) {
  final StorageService sharedPrefsService = SharedPrefsStorageService();
  sharedPrefsService.init();
  return AppPreferences(sharedPrefsService);
}); */

// Us figured out this class is redundant. I will keep it for now, but I will remove it later.
class AppPreferences implements AppConfig {
  final StorageService sharedPreferences;
  static const String serverUriKey = 'serverUri'; // Add const variable

  AppPreferences(this.sharedPreferences);

  @override
  void clearData() {
    sharedPreferences.clear();
  }

  @override
  void setRemoteHomeAssistantServerUri(String uri) async {
    sharedPreferences.set(serverUriKey, uri);
  }

  @override
  Future<String?> getRemoteHomeAssistantServerUri() async {
    Completer<String> completer = Completer<String>();

    await sharedPreferences.get(serverUriKey).then((value) {
      if (value is String) {
        completer.complete(value);
      } else {
        // ignore: null_argument_to_non_null_type
        completer.complete(null);
      }
    });
    return completer.future;
  }
}
