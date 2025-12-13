import 'dart:async';

import 'package:home_assistant_websocket/src/ha_commands.dart';
import 'package:home_assistant_websocket/src/ha_connection.dart';
import 'package:home_assistant_websocket/src/ha_connection_option.dart';
import 'package:home_assistant_websocket/src/ha_socket.dart';
import 'package:home_assistant_websocket/src/ha_socket_state.dart';
import 'package:home_assistant_websocket/src/hass_subscription.dart';
import 'package:home_assistant_websocket/src/logger_interface.dart';
import 'package:home_assistant_websocket/src/types/hass_event.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'ha_connection_test.mocks.dart';
import 'helpers/test_helpers.dart';
import 'matchers/ha_match.dart';

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
    // Setup mock socket close behavior
    when(mockSocket.close()).thenAnswer((_) async {
      when(mockSocket.isClosed).thenReturn(true);
      await socketStreamController.close();
    });
    when(mockOptions.createSocket()).thenAnswer((_) async {
      when(mockSocket.isClosed).thenReturn(false);
      return mockSocket;
    });
    when(mockOptions.logger).thenReturn(const NoOpLogger());

    // Make sure subscription can be cancelled
    when(
      mockStreamSubscription.cancel(),
    ).thenAnswer((_) => Future<void>.value());

    connection = HAConnection(mockOptions);
  });

  tearDown(() async {
    await connection.close();
    await stateController.close();
    await socketStreamController.close();
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

      emitSocketMessage(socketStreamController, {
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
        await connection.connect();

        emitSocketMessage(socketStreamController, {
          'id': 2,
          'type': 'result',
          'success': true,
          'result': null,
        });

        emitSocketMessage(socketStreamController, {
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

    test(
      'manually closing subscription should send unsubscribe message',
      () async {
        // Arrange
        await connection.connect();

        final subscription = HACommands.subscribeEntities(connection);

        // Let HAConnection send the subscribe command first.
        await Future.delayed(const Duration(milliseconds: 1));

        // Respond to subscription request
        emitSocketMessage(socketStreamController, {
          'id': 2,
          'type': 'result',
          'success': true,
          'result': null,
        });

        // Ensure the connection processes the ACK and marks subscription active.
        await Future.delayed(const Duration(milliseconds: 10));

        // Act: start dispose, then deliver unsubscribe ACK (id: 3), then await dispose.
        final disposeFuture = subscription.dispose();

        // Give dispose() a moment to send the unsubscribe request.
        await Future.delayed(const Duration(milliseconds: 1));

        // Respond to unsubscribe request
        emitSocketMessage(socketStreamController, {
          'id': 3,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await disposeFuture;

        verifyInOrder([
          mockSocket.sendMessage(
            argThat(haMessage(type: 'subscribe_entities', id: 2)),
          ),
          mockSocket.sendMessage(
            argThat(
              haMessage(type: 'unsubscribe_events', subscription: 2, id: 3),
            ),
          ),
        ]);

        expect(subscription.isDisposed, isTrue);
      },
    );

    test('manually closed subscription should not receive events', () async {
      // Arrange
      await connection.connect();

      final subscription = HACommands.subscribeEntities(connection);
      final events = <dynamic>[];
      final streamSubscription = subscription.stream.listen(events.add);

      // Let HAConnection send the subscribe command first (and set up pending completer)
      await Future<void>.delayed(const Duration(milliseconds: 1));

      // Respond to subscription request (id: 2)
      emitSocketMessage(socketStreamController, {
        'id': 2,
        'type': 'result',
        'success': true,
        'result': null,
      });

      // Give the connection time to process the subscribe result and register the subscription id
      await Future.delayed(const Duration(milliseconds: 10));

      // Respond to unsubscribe request (id: 3)
      emitSocketMessage(socketStreamController, {
        'id': 3,
        'type': 'result',
        'success': true,
        'result': null,
      }, delay: const Duration(milliseconds: 10));

      // Act - dispose subscription
      await subscription.dispose();
      await streamSubscription.cancel();

      // Try to emit event after disposal
      emitSocketMessage(socketStreamController, {
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
      });

      // Wait to ensure no events are received
      await Future.delayed(const Duration(milliseconds: 1));

      // Assert
      expect(events, isEmpty);
      expect(subscription.isDisposed, isTrue);
    });

    test(
      'closing connection should dispose all active subscriptions',
      () async {
        // Arrange
        // when(mockSocket.isClosed).thenReturn(false);
        await connection.connect();

        // Respond to subscription requests
        emitSocketMessage(socketStreamController, {
          'id': 2,
          'type': 'result',
          'success': true,
          'result': null,
        });

        emitSocketMessage(socketStreamController, {
          'id': 3,
          'type': 'result',
          'success': true,
          'result': null,
        });

        final subscription1 = HACommands.subscribeEntities(connection);
        final subscription2 = HACommands.subscribeEntities(connection);

        // Wait for subscriptions to be established
        await Future.delayed(const Duration(milliseconds: 50));

        // Act - close connection
        await connection.close();

        // Assert
        expect(subscription1.isDisposed, isTrue);
        expect(subscription2.isDisposed, isTrue);
      },
    );

    test(
      'subscription should be disposed if server returns error on subscribe (no unsubscribe sent)',
      () async {
        // Arrange
        await connection.connect();

        final subscription = HACommands.subscribeEntities(connection);

        // Let HAConnection send the subscribe command first.
        await Future.delayed(const Duration(milliseconds: 1));

        // Server rejects the subscription (id: 2)
        emitSocketMessage(socketStreamController, {
          'id': 2,
          'type': 'result',
          'success': false,
          'error': {'code': 'invalid_format', 'message': 'Subscribe failed'},
        });

        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(subscription.isDisposed, isTrue);

        // Only subscribe should have been sent.
        verify(
          mockSocket.sendMessage(
            argThat(haMessage(type: 'subscribe_entities', id: 2)),
          ),
        ).called(1);

        // No unsubscribe should be sent as part of cleanup for failed subscribe.
        verifyNever(
          mockSocket.sendMessage(
            argThat(haMessage(type: 'unsubscribe_events')),
          ),
        );
      },
    );

    test(
      'event for unknown subscription should send unsubscribe (safety)',
      () async {
        // Arrange
        await connection.connect();

        // Emit event for unknown subscription id
        emitSocketMessage(socketStreamController, {
          'id': 999,
          'type': 'event',
          'event': {
            'a': {
              'light.test': {
                's': 'on',
                'a': {'friendly_name': 'Test Light', 'supported_features': 0},
              },
            },
          },
        });

        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert: should attempt to unsubscribe from unknown subscription id
        verify(
          mockSocket.sendMessage(
            argThat(haMessage(type: 'unsubscribe_events', subscription: 999)),
          ),
        ).called(1);
      },
    );

    test(
      'closing connection when socket already closed should not send unsubscribe',
      () async {
        // Arrange
        when(mockSocket.isClosed).thenReturn(false);
        await connection.connect();

        // Respond to subscription request
        emitSocketMessage(socketStreamController, {
          'id': 2,
          'type': 'result',
          'success': true,
          'result': null,
        });

        final subscription = HACommands.subscribeEntities(connection);

        // Wait for subscription to be established
        await Future.delayed(const Duration(milliseconds: 50));

        // Simulate server closing the connection
        when(mockSocket.isClosed).thenReturn(true);
        socketStreamController.close();

        // Wait for connection to detect closure
        await Future.delayed(const Duration(milliseconds: 50));

        // Clear previous interactions
        clearInteractions(mockSocket);

        // Act - close connection (socket already closed)
        await connection.close();

        // Assert - should not attempt to send unsubscribe
        verifyNever(mockSocket.sendMessage(any));
        expect(subscription.isDisposed, isTrue);
      },
    );
  });
}
