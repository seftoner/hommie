import 'package:home_assistant_websocket/src/api/commands/ha_commands.dart';
import 'package:home_assistant_websocket/src/connection/ha_connection.dart';
import 'package:home_assistant_websocket/src/connection/ha_connection_option.dart';
import 'package:home_assistant_websocket/src/connection/ha_socket_state.dart';
import 'package:home_assistant_websocket/src/logging/logger_interface.dart';
import 'package:home_assistant_websocket/src/protocol/messages/ha_messages.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'fakes/fake_ha_socket.dart';
import 'send_ha_command_messages_test.mocks.dart';
import 'utils/tests_helpers.dart';

@GenerateMocks([HAConnectionOption])
void main() {
  late MockHAConnectionOption mockOptions;
  late FakeHASocket fakeSocket;
  late HAConnection connection;

  setUpAll(() {
    provideDummy<HASocketState>(const Disconnected());
  });

  setUp(() async {
    mockOptions = MockHAConnectionOption();
    fakeSocket = FakeHASocket();

    when(mockOptions.createSocket()).thenAnswer((_) async => fakeSocket);
    when(mockOptions.logger).thenReturn(const NoOpLogger());

    // Keep the socket in an authenticated state for tests.
    fakeSocket.setState(const Authenticated());

    connection = HAConnection(mockOptions);
    await connection.connect();
  });

  tearDown(() async {
    await connection.close();
  });

  group('Home Assistant API Commands', () {
    group('Service calls', () {
      test('successfully calls light service with parameters', () async {
        const commandId = 2;
        final future = HACommands.callService(
          connection,
          domain: 'light',
          service: 'turn_on',
          serviceData: {'color_name': 'beige', 'brightness': '101'},
          target: 'light.kitchen',
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
            'target': {'entity_id': 'light.kitchen'},
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
        /* (
          name: 'Areas',
          method: HACommands.getAreas,
          type: 'config/area_registry/list',
          file: 'get_areas_response.json',
        ), */
        (
          name: 'User',
          method: HACommands.getUser,
          type: 'auth/current_user',
          file: 'get_user_response.json',
        ),
        (
          name: 'Config',
          method: HACommands.getConfig,
          type: 'get_config',
          file: 'get_config_response.json',
        ),
        (
          name: 'Services',
          method: HACommands.getServices,
          type: 'get_services',
          file: 'get_services_response.json',
        ),
        (
          name: 'States',
          method: HACommands.getStates,
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
