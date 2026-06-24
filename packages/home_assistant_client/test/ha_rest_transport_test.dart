import 'dart:async';
import 'dart:io';

import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('HARestTransport', () {
    test(
      'getJson attaches bearer token and builds server-relative path',
      () async {
        final client = MockClient((request) async {
          expect(request.method, 'GET');
          expect(request.url, Uri.parse('http://ha.test/api/config'));
          expect(request.headers['authorization'], 'Bearer token-1');
          return http.Response('{"location_name":"Kitchen"}', 200);
        });
        final transport = HARestTransport(
          serverUri: Uri.parse('http://ha.test'),
          tokenProvider: () async => 'token-1',
          client: client,
        );

        final json = await transport.getJson('/api/config');

        expect(json, {'location_name': 'Kitchen'});
      },
    );

    test('requestJson sends JSON bodies for POST requests', () async {
      final client = MockClient((request) async {
        expect(request.method, 'POST');
        expect(
          request.url,
          Uri.parse('http://ha.test/api/services/light/toggle'),
        );
        expect(request.headers['authorization'], 'Bearer token-1');
        expect(request.headers['content-type'], contains('application/json'));
        expect(request.body, '{"entity_id":"light.kitchen"}');
        return http.Response('{"ok":true}', 200);
      });
      final transport = HARestTransport(
        serverUri: Uri.parse('http://ha.test'),
        tokenProvider: () async => 'token-1',
        client: client,
      );

      final json = await transport.requestJson(
        method: 'POST',
        path: '/api/services/light/toggle',
        body: {'entity_id': 'light.kitchen'},
      );

      expect(json, {'ok': true});
    });

    test(
      'maps authentication and HTTP failures to package exceptions',
      () async {
        final authTransport = HARestTransport(
          serverUri: Uri.parse('http://ha.test'),
          tokenProvider: () async => 'token-1',
          client: MockClient((_) async => http.Response('no', 401)),
        );

        await expectLater(
          authTransport.getJson('/api/config'),
          throwsA(isA<HAAuthenticationException>()),
        );

        final failingTransport = HARestTransport(
          serverUri: Uri.parse('http://ha.test'),
          tokenProvider: () async => 'token-1',
          client: MockClient(
            (_) async => http.Response('{"error":"bad"}', 500),
          ),
        );

        await expectLater(
          failingTransport.getJson('/api/config'),
          throwsA(
            isA<HAHttpException>()
                .having((error) => error.statusCode, 'statusCode', 500)
                .having((error) => error.body, 'body', {'error': 'bad'}),
          ),
        );
      },
    );

    test('maps timeout and socket failures to connection exceptions', () async {
      final timeoutTransport = HARestTransport(
        serverUri: Uri.parse('http://ha.test'),
        tokenProvider: () async => 'token-1',
        client: MockClient(
          (_) => Future<http.Response>.error(TimeoutException('slow')),
        ),
      );

      await expectLater(
        timeoutTransport.getJson('/api/config'),
        throwsA(isA<HAConnectionException>()),
      );

      final socketTransport = HARestTransport(
        serverUri: Uri.parse('http://ha.test'),
        tokenProvider: () async => 'token-1',
        client: MockClient(
          (_) => Future<http.Response>.error(const SocketException('offline')),
        ),
      );

      await expectLater(
        socketTransport.getJson('/api/config'),
        throwsA(isA<HAConnectionException>()),
      );
    });
  });
}
