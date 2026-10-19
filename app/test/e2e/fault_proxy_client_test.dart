import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../../integration_test/utils/fault_proxy_client.dart';

void main() {
  test('loss and recovery control only the named app route', () async {
    final states = <bool>[];
    final client = FaultProxyClient(
      faultControlUrl: Uri.parse('http://localhost:18474'),
      client: MockClient((request) async {
        expect(request.url.path, '/proxies/hommie_ha');
        final enabled = jsonDecode(request.body)['enabled'] as bool;
        states.add(enabled);
        return http.Response(
          jsonEncode({'name': 'hommie_ha', 'enabled': enabled}),
          200,
        );
      }),
    );
    await client.disconnectFromHa();
    await client.restoreHaRoute();
    await client.restoreHaRoute();
    expect(states, [false, true, true]);
  });
  test(
    'a wrong returned state fails instead of pretending outage occurred',
    () async {
      final client = FaultProxyClient(
        faultControlUrl: Uri.parse('http://localhost'),
        client: MockClient(
          (_) async =>
              http.Response('{"name":"hommie_ha","enabled":true}', 200),
        ),
      );
      await expectLater(client.disconnectFromHa(), throwsStateError);
    },
  );
  test('missing route and malformed body fail contextually', () async {
    for (final response in [
      http.Response('missing', 404),
      http.Response('bad', 200),
    ]) {
      final client = FaultProxyClient(
        faultControlUrl: Uri.parse('http://localhost'),
        client: MockClient((_) async => response),
      );
      await expectLater(client.restoreHaRoute(), throwsStateError);
    }
  });
  test('unresponsive control requests have a deadline', () async {
    final client = FaultProxyClient(
      faultControlUrl: Uri.parse('http://localhost'),
      timeout: const Duration(milliseconds: 10),
      client: MockClient((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 100));
        return http.Response('{}', 200);
      }),
    );
    await expectLater(client.disconnectFromHa(), throwsStateError);
  });
}
