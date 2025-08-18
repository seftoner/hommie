import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:hommie/services/networking/home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/ha_messages.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/ha_socket.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'send_ha_command_messages_test.mocks.dart';
import 'utils/tests_helpers.dart';
import 'utils/tests_logger.dart';

@GenerateMocks([HASocket, HAConnectionOption])
void main() {
  late MockHASocket mockSocket;
  late StreamController<dynamic> socketStreamController;
  late StreamController<HASocketState> socketStateController;
  late HAConnection connection;

  logger = testLogger;

  // Helper method to simulate HA response
  void simulateHAResponse(response) {
    Future.delayed(Duration.zero, () {
      socketStreamController.add(jsonEncode(response));
    });
  }

  // Helper method to verify sent message
  void verifyHAMessage(Map<String, dynamic> expectedPayload) {
    final capturedMessage = verify(mockSocket.sendMessage(captureAny))
        .captured
        .single as HABaseMessage;
    expect(capturedMessage.payload, equals(expectedPayload));
  }

  setUpAll(() {
    provideDummy<HASocketState>(HASocketState.disconnected());
  });

  setUp(() async {
    // Initialize shared objects before each test
    mockSocket = MockHASocket();
    socketStreamController = StreamController<dynamic>();
    socketStateController = StreamController<HASocketState>();

    when(mockSocket.isClosed).thenAnswer((_) => false);
    when(mockSocket.state).thenAnswer((_) => HASocketState.authenticated());
    when(mockSocket.stream).thenAnswer((_) => socketStreamController.stream);
    when(mockSocket.stateStream)
        .thenAnswer((_) => socketStateController.stream);

    final mockConOption = MockHAConnectionOption();
    when(mockConOption.createSocket()).thenAnswer((_) async => mockSocket);

    connection = HAConnection(mockConOption);
    await connection.connect();
  });

  tearDown(() async {
    connection.close();

    await socketStreamController.close();
    await socketStateController.close();
  });

  group('Home Assistant API Commands', () {
    group('Service calls', () {
      test('successfully calls light service with parameters', () async {
        simulateHAResponse({
          'id': 2,
          'type': 'result',
          'success': true,
          'result': {
            'context': {
              'id': '326ef27d19415c60c492fe330945f954',
              'parent_id': null,
              'user_id': '31ddb597e03147118cf8d2f8fbea5553'
            },
            'response': null
          }
        });

        final result = await HACommands.callService(connection,
            domain: 'light',
            service: 'turn_on',
            serviceData: {'color_name': 'beige', 'brightness': '101'},
            target: '{"entity_id": "light.kitchen"}',
            returnResponse: true);

        verifyHAMessage({
          'id': 2,
          'type': 'call_service',
          'domain': 'light',
          'service': 'turn_on',
          'service_data': {'color_name': 'beige', 'brightness': '101'},
          'target': '{"entity_id": "light.kitchen"}',
          'return_response': true
        });

        expect(result, isNotNull);
      });
    });

    group('Data retrieval', () {
      final testCases = [
        (
          name: 'Areas',
          method: HACommands.getAreas,
          type: 'config/area_registry/list',
          file: 'get_areas_response.json'
        ),
        (
          name: 'User',
          method: HACommands.getUser,
          type: 'auth/current_user',
          file: 'get_user_response.json'
        ),
        (
          name: 'Config',
          method: HACommands.getConfig,
          type: 'get_config',
          file: 'get_config_response.json'
        ),
        (
          name: 'Services',
          method: HACommands.getServices,
          type: 'get_services',
          file: 'get_services_response.json'
        ),
        (
          name: 'States',
          method: HACommands.getStates,
          type: 'get_states',
          file: 'get_states_response.json'
        ),
      ];

      for (final testCase in testCases) {
        test('successfully retrieves ${testCase.name}', () async {
          final testJson = await readJsonTestDataFromFile(
              'test/data_samples/${testCase.file}');
          simulateHAResponse(testJson);

          final result = await testCase.method(connection);

          verifyHAMessage({
            'id': 2,
            'type': testCase.type,
          });

          expect(result, isNotNull);
        });
      }
    });
  });
}
