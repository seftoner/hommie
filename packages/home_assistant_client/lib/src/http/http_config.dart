import 'dart:io';

class HttpConfig {
  static Map<String, String> get defaultHeaders => {
    'User-Agent': 'Hommie: ${Platform.operatingSystem}',
  };
}
