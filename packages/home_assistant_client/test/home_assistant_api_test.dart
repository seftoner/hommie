import 'dart:convert';
import 'dart:io';

import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'helpers/websocket_harness.dart';

void main() {
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
        final harness = await createWebSocketHarness();
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
      final harness = await createWebSocketHarness();
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
      final harness = await createWebSocketHarness();
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

    test('areas.list sends area registry list over WebSocket', () async {
      final harness = await createWebSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.areas.list();

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
        'result': [_areaJson()],
      });

      final areas = await future;
      expect(areas, hasLength(1));
      expect(areas.single.areaId, 'kitchen');
      expect(areas.single.name, 'Kitchen');
      expect(areas.single.icon, 'mdi:silverware-fork-knife');
    });

    test('areas.create sends area registry create over WebSocket', () async {
      final harness = await createWebSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.areas.create(name: 'Office');

      final sent = await harness.socket.nextSentWhere(
        (message) => message is HARawWebSocketMessage,
      );
      expect(sent.toPayload(id: 2), {
        'id': 2,
        'type': 'config/area_registry/create',
        'name': 'Office',
      });

      harness.socket.addIncoming({
        'id': 2,
        'type': 'result',
        'success': true,
        'result': _areaJson(areaId: 'office', name: 'Office'),
      });

      expect((await future).areaId, 'office');
    });

    test('areas.rename sends area registry update over WebSocket', () async {
      final harness = await createWebSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.areas.rename(areaId: 'office', name: 'Work room');

      final sent = await harness.socket.nextSentWhere(
        (message) => message is HARawWebSocketMessage,
      );
      expect(sent.toPayload(id: 2), {
        'id': 2,
        'type': 'config/area_registry/update',
        'area_id': 'office',
        'name': 'Work room',
      });

      harness.socket.addIncoming({
        'id': 2,
        'type': 'result',
        'success': true,
        'result': _areaJson(areaId: 'office', name: 'Work room'),
      });

      expect((await future).name, 'Work room');
    });

    test('areas.delete sends area registry delete over WebSocket', () async {
      final harness = await createWebSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.areas.delete(areaId: 'office');

      final sent = await harness.socket.nextSentWhere(
        (message) => message is HARawWebSocketMessage,
      );
      expect(sent.toPayload(id: 2), {
        'id': 2,
        'type': 'config/area_registry/delete',
        'area_id': 'office',
      });

      harness.socket.addIncoming({
        'id': 2,
        'type': 'result',
        'success': true,
        'result': null,
      });

      await expectLater(future, completes);
    });
  });
}

Map<String, dynamic> _areaJson({
  String areaId = 'kitchen',
  String name = 'Kitchen',
}) {
  return {
    'created_at': 1710000000.0,
    'modified_at': 1710000001.0,
    'area_id': areaId,
    'name': name,
    'floor_id': null,
    'humidity_entity_id': null,
    'icon': 'mdi:silverware-fork-knife',
    'picture': null,
    'temperature_entity_id': null,
    'aliases': <String>[],
    'labels': <String>[],
  };
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
