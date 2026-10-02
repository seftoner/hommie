import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../../integration_test/utils/hass_token_manager.dart';
import '../../integration_test/utils/remote_hass_cli.dart';

void main() {
  test('creates a namespaced token and resolves its exact new ID', () async {
    var created = false;
    final deletions = <String>[];
    final manager = HassTokenManager(
      cli: RemoteHassCli(
        fixtureControlUrl: Uri.parse('http://fixture'),
        managementToken: 'management',
        client: MockClient((request) async {
          final body = jsonDecode(request.body);
          expect(body['token'], 'management');
          final args = body['args'] as List;
          Object? result;
          if (args[2] == 'auth/refresh_tokens') {
            result = [
              {
                'id': 'baseline',
                'client_name': 'owned-name',
                'user_id': 'user',
              },
              if (created)
                {
                  'id': 'new-id',
                  'client_name': 'owned-name',
                  'user_id': 'user',
                },
            ];
          } else if (args[2] == 'auth/long_lived_access_token') {
            created = true;
            result = 'app-token';
          } else {
            deletions.add(
              jsonDecode((args[3] as String).substring(7))['refresh_token_id'],
            );
          }
          return http.Response(
            jsonEncode({
              'exit_code': 0,
              'stderr': '',
              'stdout': jsonEncode({'success': true, 'result': result}),
            }),
            200,
          );
        }),
      ),
    );
    final token = await manager.createLongLivedToken(clientName: 'owned-name');
    expect(token.id, 'new-id');
    expect(token.accessToken, 'app-token');
    await manager.deleteById(token.id);
    expect(deletions, ['new-id']);
  });
  test(
    'only already-deleted errors are idempotent; other HA errors fail',
    () async {
      var code = 'invalid_token_id';
      final manager = HassTokenManager(
        cli: RemoteHassCli(
          fixtureControlUrl: Uri.parse('http://fixture'),
          managementToken: 'management',
          client: MockClient(
            (_) async => http.Response(
              jsonEncode({
                'exit_code': 0,
                'stderr': '',
                'stdout': jsonEncode({
                  'success': false,
                  'error': {'code': code},
                }),
              }),
              200,
            ),
          ),
        ),
      );
      expect(await manager.deleteById('owned'), isFalse);
      code = 'unauthorized';
      await expectLater(manager.deleteById('owned'), throwsStateError);
    },
  );
}
