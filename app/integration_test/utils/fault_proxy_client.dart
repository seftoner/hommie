import 'dart:convert';

import 'package:http/http.dart' as http;

class FaultProxyClient {
  final Uri _url;
  final http.Client _client;
  final Duration _timeout;
  FaultProxyClient({
    required Uri faultControlUrl,
    http.Client? client,
    Duration timeout = const Duration(seconds: 5),
  }) : _url = faultControlUrl.resolve('/proxies/hommie_ha'),
       _client = client ?? http.Client(),
       _timeout = timeout;
  Future<void> disconnectFromHa() => _set(false);
  Future<void> restoreHaRoute() => _set(true);
  Future<void> _set(bool enabled) async {
    try {
      final response = await _client
          .post(
            _url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'enabled': enabled}),
          )
          .timeout(_timeout);
      if (response.statusCode != 200) {
        throw StateError('Proxy control HTTP ${response.statusCode}');
      }
      final data = jsonDecode(response.body);
      if (data is! Map ||
          data['name'] != 'hommie_ha' ||
          data['enabled'] != enabled) {
        throw StateError('Proxy state was not confirmed');
      }
    } catch (_) {
      throw StateError(
        'Cannot ${enabled ? 'restore' : 'disable'} hommie_ha route; check Toxiproxy control',
      );
    }
  }
}
