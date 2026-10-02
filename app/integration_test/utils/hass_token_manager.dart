import 'dart:convert';

import 'remote_hass_cli.dart';

class HassTokenRef {
  final String id, accessToken;
  HassTokenRef(this.id, this.accessToken);
}

class HassRefreshToken {
  final String id;
  final String? userId, clientName, clientId;
  HassRefreshToken(this.id, this.userId, this.clientName, this.clientId);
  factory HassRefreshToken.fromJson(Map<String, dynamic> json) =>
      HassRefreshToken(
        json['id'] as String,
        json['user_id'] as String?,
        json['client_name'] as String?,
        json['client_id'] as String?,
      );
}

class HassTokenManager {
  final RemoteHassCli _cli;
  HassTokenManager({RemoteHassCli? cli})
    : _cli = cli ?? RemoteHassCli.fromEnvironment();
  Future<List<HassRefreshToken>> list() async {
    final result = await _cli.executeWs('auth/refresh_tokens');
    if (result is! List) throw StateError('Invalid refresh token registry');
    return result
        .map(
          (entry) => HassRefreshToken.fromJson(
            Map<String, dynamic>.from(entry as Map),
          ),
        )
        .toList();
  }

  Future<HassTokenRef> createLongLivedToken({
    required String clientName,
  }) async {
    if (clientName.isEmpty) throw ArgumentError('Token client name required');
    final baseline = (await list()).map((t) => t.id).toSet();
    final value = await _cli.executeWs(
      'auth/long_lived_access_token',
      payload: {'lifespan': 3650, 'client_name': clientName},
    );
    if (value is! String) {
      throw StateError('Invalid access token creation result');
    }
    final matches = (await list())
        .where((t) => !baseline.contains(t.id) && t.clientName == clientName)
        .toList();
    if (matches.length != 1) {
      throw StateError(
        'Ambiguous owned token creation; reconcile namespaced registry before retrying',
      );
    }
    return HassTokenRef(matches.single.id, value);
  }

  Future<bool> deleteById(String id) async {
    final response = await _cli.execute([
      'raw',
      'ws',
      'auth/delete_refresh_token',
      '--json=${jsonEncode({'refresh_token_id': id})}',
    ]);
    return response.fold((error) => throw StateError(error.message), (success) {
      final data = jsonDecode(success.stdout);
      if (data is Map && data['success'] == true) return true;
      if (data is Map &&
          data['error'] is Map &&
          data['error']['code'] == 'invalid_token_id') {
        return false;
      }
      throw StateError('Home Assistant rejected owned token deletion');
    });
  }
}
