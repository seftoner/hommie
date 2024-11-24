import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_commands.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oauth2/oauth2.dart';

import 'send_ha_command_messages_test.mocks.dart';
import 'tests_helpers.dart';

@GenerateMocks([HASocket])
void main() {
  late MockHASocket mockSocket;
  late StreamController<dynamic> streamController;
  late HAConnection connection;

  setUp(() {
    // Initialize shared objects before each test
    mockSocket = MockHASocket();
    streamController = StreamController<dynamic>();

    when(mockSocket.isClosed()).thenAnswer((_) => false);
    when(mockSocket.stream).thenAnswer((_) => streamController.stream);

    final credentials = Credentials("test-token");
    final haConnectionOption = HAConnectionOption(credentials);

    connection = HAConnection(mockSocket, haConnectionOption);
  });

  tearDown(() async {
    // Clean up shared objects after each test
    await streamController.close();
    connection.close();
  });

  test("Call 'call_service' message ", () async {
    // Mock response to simulate WebSocket stream
    Future.delayed(Duration.zero, () {
      streamController.add(jsonEncode({
        "id": 2,
        "type": "result",
        "success": true,
        "result": {
          "context": {
            "id": "326ef27d19415c60c492fe330945f954",
            "parent_id": null,
            "user_id": "31ddb597e03147118cf8d2f8fbea5553"
          },
          "response": null
        }
      }));
    });

    // Act
    final result = await HACommands.callService(connection,
        domain: "light",
        service: "turn_on",
        serviceData: {"color_name": "beige", "brightness": "101"},
        target: "{\"entity_id\": \"light.kitchen\"}",
        returnResponse: true);

    // Assert on the sent message
    final capturedMessage =
        verify(mockSocket.sendMessage(captureAny)).captured.single;

    expect(capturedMessage, isA<HABaseMessgae>());
    final sentMessage = capturedMessage as HABaseMessgae;

    // Perform more specific assertions about the message content
    expect(
        sentMessage.payload,
        equals({
          "id": 2,
          "type": "call_service",
          "domain": "light",
          "service": "turn_on",
          "service_data": {"color_name": "beige", "brightness": "101"},
          "target": "{\"entity_id\": \"light.kitchen\"}",
          "return_response": true
        }));

    // Assert on the result returned from the command
    expect(result, isNotNull);
  });

  test("Call 'getAreas' message", () async {
    // Mock response to simulate WebSocket stream
    final testJson = await readJsonTestDataFromFile(
        'test/data_samples/get_areas_reponse.json');
    Future.delayed(Duration.zero, () {
      streamController.add(jsonEncode(testJson));
    });

    // Act
    final result = await HACommands.getAreas(connection);

    // Assert on the sent message
    final capturedMessage =
        verify(mockSocket.sendMessage(captureAny)).captured.single;

    expect(capturedMessage, isA<HABaseMessgae>());
    final sentMessage = capturedMessage as HABaseMessgae;

    // Perform more specific assertions about the message content
    expect(
        sentMessage.payload,
        equals({
          "id": 2,
          "type": "config/area_registry/list",
        }));

    // Assert on the result returned from the command
    expect(result, isNotNull);
  });
}
