import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../../integration_test/utils/remote_hass_cli.dart';

RemoteHassCli cli(MockClient client) => RemoteHassCli(
  fixtureControlUrl: Uri.parse('http://127.0.0.1:3000'),
  managementToken: 'sentinel-secret',
  client: client,
  timeout: const Duration(milliseconds: 20),
);

void main() {
  test('a spaced JSON payload arrives as one argument', () async {
    final client = cli(
      MockClient((request) async {
        expect(jsonDecode(request.body)['args'], [
          'raw',
          'ws',
          'create',
          '--json={"name":"Kitchen room"}',
        ]);
        return http.Response(
          jsonEncode({
            'stdout': '{"success":true,"result":"area-id"}',
            'stderr': '',
            'exit_code': 0,
          }),
          200,
        );
      }),
    );
    expect(
      await client.executeWs('create', payload: {'name': 'Kitchen room'}),
      'area-id',
    );
  });
  test('HA failure is rejected even when the CLI exits successfully', () async {
    final client = cli(
      MockClient(
        (_) async => http.Response(
          jsonEncode({
            'stdout': '{"success":false,"error":{"code":"invalid_token","message":"sentinel-secret"}}',
            'stderr': '',
            'exit_code': 0,
          }),
          200,
        ),
      ),
    );
    await expectLater(
      client.executeWs('read'),
      throwsA(
        predicate(
          (e) =>
              e.toString().contains('invalid_token') &&
              !e.toString().contains('sentinel-secret'),
        ),
      ),
    );
  });
  test('HTTP failure and malformed body are contextual errors', () async {
    for (final response in [
      http.Response('<html>sentinel-secret</html>', 502),
      http.Response('bad json', 200),
    ]) {
      final result = await cli(MockClient((_) async => response))
          .execute(['raw']);
      expect(result.isLeft(), isTrue);
      result.fold(
        (error) => expect(error.toString(), isNot(contains('sentinel-secret'))),
        (_) => fail('Must fail'),
      );
    }
  });
  test('a timed-out mutation is sent once and reports uncertainty', () async {
    var calls = 0;
    final result = await cli(
      MockClient((_) async {
        calls++;
        await Future<void>.delayed(const Duration(seconds: 1));
        return http.Response('{}', 200);
      }),
    ).execute(['raw', 'ws', 'create']);
    expect(calls, 1);
    expect(result.isLeft(), isTrue);
    result.fold(
      (error) => expect(error.message, contains('unknown')),
      (_) => fail('Must timeout'),
    );
  });
}
