import 'dart:convert';
import 'dart:io';

import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'fakes/fake_ha_socket.dart';
import 'send_ha_command_messages_test.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy<HASocketState>(const Disconnected());
  });

  group('HomeAssistantApi', () {
    test('config.get via REST calls GET /api/config', () async {
      final api = HomeAssistantApi(
        serverUri: Uri.parse('http://ha.test'),
        tokenProvider: () async => 'token-1',
        httpClient: MockClient((request) async {
          expect(request.method, 'GET');
          expect(request.url, Uri.parse('http://ha.test/api/config'));
          return http.Response(
            jsonEncode(await _sampleResult('get_config')),
            200,
          );
        }),
      );

      final config = await api.config.get(via: HATransport.rest);

      expect(config.location_name, 'Home');
    });

    test(
      'config.get via WebSocket sends get_config over wrapped connection',
      () async {
        final harness = await _webSocketHarness();
        addTearDown(harness.close);

        final api = HomeAssistantApi.fromConnection(harness.connection);
        final future = api.config.get(via: HATransport.websocket);

        final sent = await harness.socket.nextSentWhere(
          (message) =>
              message is HARequestMessage && message.type == 'get_config',
        );
        expect(sent.toPayload(id: 2), {'id': 2, 'type': 'get_config'});

        harness.socket.addIncoming(await _sampleResponse('get_config'));

        expect((await future).location_name, 'Home');
      },
    );

    test('services.call via WebSocket preserves target payload', () async {
      final harness = await _webSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.services.call(
        domain: 'light',
        service: 'turn_on',
        target: const HATarget(entityIds: ['light.kitchen']),
        serviceData: {'brightness': 101},
      );

      final sent = await harness.socket.nextSentWhere(
        (message) => message is ServiceCallMessage,
      );
      expect(sent.toPayload(id: 2), {
        'id': 2,
        'type': 'call_service',
        'domain': 'light',
        'service': 'turn_on',
        'target': {
          'entity_id': ['light.kitchen'],
        },
        'service_data': {'brightness': 101},
      });

      harness.socket.addIncoming(await _sampleResponse('call_service'));

      expect(await future, isA<CallServiceResponse>());
    });

    test('raw WebSocket send accepts arbitrary message maps', () async {
      final harness = await _webSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.websocket.sendJson({
        'type': 'config/area_registry/list',
      });

      final sent = await harness.socket.nextSentWhere(
        (message) => message is HARawWebSocketMessage,
      );
      expect(sent.toPayload(id: 2), {
        'id': 2,
        'type': 'config/area_registry/list',
      });

      harness.socket.addIncoming({
        'id': 2,
        'type': 'result',
        'success': true,
        'result': [
          {'area_id': 'kitchen'},
        ],
      });

      expect(await future, [
        {'area_id': 'kitchen'},
      ]);
    });
  });
}

Future<_Harness> _webSocketHarness() async {
  final options = MockHAConnectionOption();
  final socket = FakeHASocket();

  when(options.createSocket()).thenAnswer((_) async => socket);
  when(options.logger).thenReturn(const NoOpLogger());

  socket.setState(const Authenticated());

  final connection = HAConnection(options);
  await connection.connect();
  return _Harness(connection: connection, socket: socket);
}

Future<Map<String, dynamic>> _sampleResponse(String name) async {
  final fileName = switch (name) {
    'get_config' => 'get_config_response.json',
    'call_service' => 'call_service_response.json',
    _ => throw ArgumentError.value(name, 'name'),
  };
  final raw = await File('test/data_samples/$fileName').readAsString();
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  decoded['id'] = 2;
  return decoded;
}

Future<dynamic> _sampleResult(String name) async {
  final response = await _sampleResponse(name);
  return response['result'];
}

final class _Harness {
  const _Harness({required this.connection, required this.socket});

  final HAConnection connection;
  final FakeHASocket socket;

  Future<void> close() => connection.close();
}
