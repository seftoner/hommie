import 'package:home_assistant_client/src/api/home_assistant_api.dart';
import 'package:home_assistant_client/src/connection/ha_connection.dart';
import 'package:home_assistant_client/src/protocol/messages/ha_messages.dart';
import 'package:home_assistant_client/src/protocol/types/ha_response.dart';
import 'package:home_assistant_client/src/protocol/types/hass_types.dart';
import 'package:test/test.dart';

import 'fakes/fake_ha_socket.dart';
import 'helpers/websocket_harness.dart';
import 'utils/tests_helpers.dart';

void main() {
  late FakeHASocket fakeSocket;
  late HAConnection connection;

  setUp(() async {
    final harness = await createWebSocketHarness();
    fakeSocket = harness.socket;
    connection = harness.connection;
  });

  tearDown(() async {
    await connection.close();
  });

  group('HomeAssistantApi over WebSocket', () {
    group('Service calls', () {
      test('successfully calls light service with parameters', () async {
        const commandId = 2;
        final future = HomeAssistantApi.fromConnection(connection).services
            .call(
              domain: 'light',
              service: 'turn_on',
              serviceData: {'color_name': 'beige', 'brightness': '101'},
              target: const HATarget(entityIds: ['light.kitchen']),
              returnResponse: true,
            );

        final sent = await fakeSocket.nextSentWhere(
          (m) => m is ServiceCallMessage,
        );
        expect(
          sent.toPayload(id: commandId),
          equals({
            'id': commandId,
            'type': 'call_service',
            'domain': 'light',
            'service': 'turn_on',
            'service_data': {'color_name': 'beige', 'brightness': '101'},
            'target': {
              'entity_id': ['light.kitchen'],
            },
            'return_response': true,
          }),
        );

        fakeSocket.addIncoming({
          'id': commandId,
          'type': 'result',
          'success': true,
          'result': {
            'context': {
              'id': '326ef27d19415c60c492fe330945f954',
              'parent_id': null,
              'user_id': '31ddb597e03147118cf8d2f8fbea5553',
            },
            'response': null,
          },
        });

        final result = await future;

        expect(result, isNotNull);
      });
    });

    group('Data retrieval', () {
      final testCases = [
        (
          name: 'User',
          method: (HAConnection connection) {
            return HomeAssistantApi.fromConnection(connection).websocket
                .sendMessage(const CurrentUserMessage())
                .mapItem(HassUser.fromJson);
          },
          type: 'auth/current_user',
          file: 'get_user_response.json',
        ),
        (
          name: 'Config',
          method: (HAConnection connection) {
            return HomeAssistantApi.fromConnection(connection).config.get();
          },
          type: 'get_config',
          file: 'get_config_response.json',
        ),
        (
          name: 'Services',
          method: (HAConnection connection) {
            return HomeAssistantApi.fromConnection(connection).services.list();
          },
          type: 'get_services',
          file: 'get_services_response.json',
        ),
        (
          name: 'States',
          method: (HAConnection connection) {
            return HomeAssistantApi.fromConnection(connection).states.list();
          },
          type: 'get_states',
          file: 'get_states_response.json',
        ),
      ];

      for (final testCase in testCases) {
        test('successfully retrieves ${testCase.name}', () async {
          const commandId = 2;
          final testJson = await readJsonTestDataFromFile(
            'test/data_samples/${testCase.file}',
          );

          final future = testCase.method(connection);

          final sent = await fakeSocket.nextSentWhere(
            (m) => m is HARequestMessage && m.type == testCase.type,
          );
          expect(
            sent.toPayload(id: commandId),
            equals({'id': commandId, 'type': testCase.type}),
          );

          fakeSocket.addIncoming(testJson);

          final result = await future;

          expect(result, isNotNull);
        });
      }
    });
  });
}
