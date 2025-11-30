import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/src/ha_connection_option.dart';
import 'package:home_assistant_websocket/src/ha_socket.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../app/test/utils/tests_logger.dart';
import 'ha_connection_test.mocks.dart';

class MockEventCallback extends Mock {
  void call(Map<String, dynamic> event);
}

@GenerateMocks([
  HASocket,
  HAConnectionOption,
  StreamController,
  StreamSubscription<String>,
])
void main() {
  late MockHASocket mockSocket;
  late MockHAConnectionOption mockOptions;
  late HAConnection connection;
  late StreamController<HASocketState> stateController;
  late MockStreamSubscription<String> mockStreamSubscription;
  late StreamController<String> socketStreamController;

  logger = testLogger;

  void emitSocketMessage(
    Map<String, dynamic> message, {
    Duration delay = const Duration(milliseconds: 100),
  }) {
    Future.delayed(
      delay,
      () => socketStreamController.add(jsonEncode(message)),
    );
  }

  setUpAll(() {
    provideDummy<HASocketState>(const Disconnected());
  });

  setUp(() {
    mockSocket = MockHASocket();
    mockOptions = MockHAConnectionOption();
    stateController = StreamController<HASocketState>.broadcast();
    mockStreamSubscription = MockStreamSubscription();
    socketStreamController = StreamController<String>.broadcast();

    // Setup default mock behavior
    when(mockSocket.state).thenReturn(const Disconnected());
    when(mockSocket.stateStream).thenAnswer((_) => stateController.stream);
    when(mockSocket.stream).thenAnswer((_) => socketStreamController.stream);
    when(mockOptions.createSocket()).thenAnswer((_) async => mockSocket);

    // Make sure subscription can be cancelled
    when(
      mockStreamSubscription.cancel(),
    ).thenAnswer((_) => Future<void>.value());

    connection = HAConnection(mockOptions);
  });

  tearDown(() {
    stateController.close();
    socketStreamController.close();
  });

  group('Connection lifecycle', () {
    test('connect should create new socket if none exists', () async {
      // Arrange
      when(mockSocket.state).thenReturn(const Authenticated());

      // Act
      await connection.connect();

      // Assert
      verify(mockOptions.createSocket()).called(1);
      expect(connection.currentState, isA<Authenticated>());
    });

    test(
      'connect should not create new socket if one already exists',
      () async {
        // Arrange
        await connection.connect();
        clearInteractions(mockOptions);

        // Act
        await connection.connect();

        // Assert
        verifyNever(mockOptions.createSocket());
      },
    );

    test('close should properly cleanup resources', () async {
      // Arrange
      await connection.connect();

      // Act
      connection.close();

      // Assert
      verify(mockSocket.close()).called(1);
      expect(connection.currentState, isA<Disconnected>());
    });
  });

  group('Command handling', () {
    test('sendCommand should successfully send and receive response', () async {
      // Arrange
      await connection.connect();
      when(mockSocket.isClosed).thenReturn(false);

      emitSocketMessage({
        'id': 2,
        'type': 'result',
        'success': true,
        'result': [
          {
            'entity_id': 'light.test',
            'state': 'on',
            'last_changed': '2023-10-10T10:00:00.000Z',
            'last_updated': '2023-10-10T10:00:00.000Z',
            'attributes': {
              'friendly_name': 'Test Light',
              'supported_features': 0,
            },
            'context': {
              'id': '123456',
              'parent_id': null,
              'user_id': 'user_123',
            },
          },
        ],
      });

      // Act
      final result = await HACommands.getStates(connection);

      // Assert
      verify(mockSocket.sendMessage(any)).called(1);
      expect(result, isA<List<HassEntity>>());
      expect(result.first.entity_id, 'light.test');
      expect(result.first.state, 'on');
      expect(result.first.attributes.friendly_name, 'Test Light');
    });
  });

  group('Subscription handling', () {
    test(
      'subscribeMessage should register subscription and handle events',
      () async {
        // Arrange
        when(mockSocket.isClosed).thenReturn(false);
        await connection.connect();

        emitSocketMessage({
          'id': 2,
          'type': 'result',
          'success': true,
          'result': null,
        });

        emitSocketMessage({
          'id': 2,
          'type': 'event',
          'event': {
            'a': {
              'light.test': {
                's': 'on',
                'a': {'friendly_name': 'Test Light', 'supported_features': 0},
                'c': '01HV3B31R2CXV8P961E8W3JCZC',
                'lc': 1712730507.010314,
                'lu': 1712730507.010314,
              },
            },
          },
        }, delay: const Duration(milliseconds: 200));

        // Act
        final subscription = HACommands.subscribeEntities(connection);
        final subscriptionMessage =
            await subscription.stream.first as StatesUpdates;

        // Assert
        verify(mockSocket.sendMessage(any)).called(1);
        expect(subscription, isA<HassSubscription>());
        expect(subscriptionMessage.add?['light.test']!.state, equals('on'));
      },
    );
  });
}
