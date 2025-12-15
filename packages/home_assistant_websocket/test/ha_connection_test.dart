import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:home_assistant_websocket/src/api/commands/ha_commands.dart';
import 'package:home_assistant_websocket/src/connection/ha_connection.dart';
import 'package:home_assistant_websocket/src/connection/ha_connection_option.dart';
import 'package:home_assistant_websocket/src/connection/ha_socket_state.dart';
import 'package:home_assistant_websocket/src/logging/logger_interface.dart';
import 'package:home_assistant_websocket/src/protocol/messages/ha_messages.dart';
import 'package:home_assistant_websocket/src/protocol/types/hass_event.dart';
import 'package:home_assistant_websocket/src/protocol/types/hass_subscription.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'fakes/fake_ha_socket.dart';
import 'ha_connection_test.mocks.dart';

@GenerateMocks([HAConnectionOption])
void main() {
  late MockHAConnectionOption mockOptions;
  late HAConnection connection;
  late FakeHASocket fakeSocket;

  setUp(() {
    mockOptions = MockHAConnectionOption();
    fakeSocket = FakeHASocket();

    when(mockOptions.createSocket()).thenAnswer((_) async {
      return fakeSocket;
    });
    when(mockOptions.logger).thenReturn(const NoOpLogger());

    connection = HAConnection(mockOptions);
  });

  tearDown(() async {
    await connection.close();
  });

  group('Connection lifecycle', () {
    test('connect should create new socket if none exists', () async {
      // Arrange
      fakeSocket.setState(const Authenticated());

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
      await connection.close();

      // Assert
      expect(fakeSocket.isClosed, isTrue);
      expect(connection.currentState, isA<Disconnected>());
    });
  });

  group('Command handling', () {
    test('sendCommand should successfully send and receive response', () async {
      // Arrange
      await connection.connect();

      // Act
      final resultFuture = HACommands.getStates(connection);

      await fakeSocket.nextSentWhere((m) => m is GetStatesMessage);
      const id = 2;

      fakeSocket.addIncoming({
        'id': id,
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

      final result = await resultFuture;

      // Assert
      expect(
        fakeSocket.sentMessages.where((m) => m is GetStatesMessage).length,
        1,
      );
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

        // Act
        final subscription = HACommands.subscribeEntities(connection);

        await fakeSocket.nextSentWhere((m) => m is SubscribeEntitiesMessage);
        const subscriptionId = 2;

        fakeSocket.addIncoming({
          'id': subscriptionId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        fakeSocket.addIncoming({
          'id': subscriptionId,
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

        final subscriptionMessage =
            await subscription.stream.first as StatesUpdates;

        // Assert
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

        await fakeSocket.nextSentWhere((m) => m is SubscribeEntitiesMessage);
        const subscriptionId = 2;

        // ACK subscription
        fakeSocket.addIncoming({
          'id': subscriptionId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        // Allow the connection to process the ACK.
        await Future<void>.delayed(Duration.zero);

        // Act
        final disposeFuture = subscription.dispose();

        await fakeSocket.nextSentWhere(
          (m) =>
              m is UnsubscribeEventsMessage &&
              (m).subscriptionID == subscriptionId,
        );
        const unsubscribeCommandId = 3;

        // ACK unsubscribe
        fakeSocket.addIncoming({
          'id': unsubscribeCommandId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await disposeFuture;

        expect(subscription.isDisposed, isTrue);
      },
    );

    test('manually closed subscription should not receive events', () async {
      // Arrange
      await connection.connect();

      final subscription = HACommands.subscribeEntities(connection);
      final events = <dynamic>[];
      final streamSubscription = subscription.stream.listen(events.add);

      await fakeSocket.nextSentWhere((m) => m is SubscribeEntitiesMessage);
      const subscriptionId = 2;

      // ACK subscription
      fakeSocket.addIncoming({
        'id': subscriptionId,
        'type': 'result',
        'success': true,
        'result': null,
      });

      await Future<void>.delayed(Duration.zero);

      // Act - dispose subscription
      final disposeFuture = subscription.dispose();

      await fakeSocket.nextSentWhere(
        (m) =>
            m is UnsubscribeEventsMessage &&
            (m).subscriptionID == subscriptionId,
      );
      const unsubscribeCommandId = 3;

      fakeSocket.addIncoming({
        'id': unsubscribeCommandId,
        'type': 'result',
        'success': true,
        'result': null,
      });

      await disposeFuture;
      await streamSubscription.cancel();

      // Try to emit event after disposal
      fakeSocket.addIncoming({
        'id': subscriptionId,
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

      await Future<void>.delayed(Duration.zero);

      // Assert
      expect(events, isEmpty);
      expect(subscription.isDisposed, isTrue);
    });

    test(
      'closing connection should dispose all active subscriptions',
      () async {
        // Arrange
        await connection.connect();

        final subscription1 = HACommands.subscribeEntities(connection);
        final subscription2 = HACommands.subscribeEntities(connection);

        await fakeSocket.nextSentWhere((m) => m is SubscribeEntitiesMessage);
        await fakeSocket.nextSentWhere((m) => m is SubscribeEntitiesMessage);

        const sub1Id = 2;
        const sub2Id = 3;

        // ACK both subscriptions
        fakeSocket.addIncoming({
          'id': sub1Id,
          'type': 'result',
          'success': true,
          'result': null,
        });
        fakeSocket.addIncoming({
          'id': sub2Id,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await Future<void>.delayed(Duration.zero);

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

        await fakeSocket.nextSentWhere((m) => m is SubscribeEntitiesMessage);
        const subscriptionId = 2;

        // Server rejects the subscription
        fakeSocket.addIncoming({
          'id': subscriptionId,
          'type': 'result',
          'success': false,
          'error': {'code': 'invalid_format', 'message': 'Subscribe failed'},
        });

        await Future<void>.delayed(Duration.zero);

        // Assert
        expect(subscription.isDisposed, isTrue);

        // No unsubscribe should be sent as part of cleanup for failed subscribe.
        expect(
          fakeSocket.sentMessages
              .where((m) => m is UnsubscribeEventsMessage)
              .toList(),
          isEmpty,
        );
      },
    );

    test(
      'event for unknown subscription should send unsubscribe (safety)',
      () async {
        // Arrange
        await connection.connect();

        // Emit event for unknown subscription id
        fakeSocket.addIncoming({
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

        // Assert: should attempt to unsubscribe from unknown subscription id
        final unsub = await fakeSocket.nextSentWhere(
          (m) => m is UnsubscribeEventsMessage && (m).subscriptionID == 999,
        );
        expect((unsub as UnsubscribeEventsMessage).subscriptionID, 999);
      },
    );

    test(
      'closing connection when socket already closed should not send unsubscribe',
      () async {
        // Arrange
        await connection.connect();

        final subscription = HACommands.subscribeEntities(connection);

        await fakeSocket.nextSentWhere((m) => m is SubscribeEntitiesMessage);
        const subscriptionId = 2;

        fakeSocket.addIncoming({
          'id': subscriptionId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await Future<void>.delayed(Duration.zero);

        // Simulate server closing the connection.
        await fakeSocket.closeFromServer(
          closeCode: 1002,
          reason: 'Invalid message',
          type: DisconnectionType.error,
        );

        await Future<void>.delayed(Duration.zero);

        final sentCountBeforeManualClose = fakeSocket.sentMessages.length;

        // Act - close connection (socket already closed)
        await connection.close();

        // Assert - should not attempt to send unsubscribe
        expect(fakeSocket.sentMessages.length, sentCountBeforeManualClose);
        expect(
          fakeSocket.sentMessages
              .where((m) => m is UnsubscribeEventsMessage)
              .toList(),
          isEmpty,
        );
        expect(subscription.isDisposed, isTrue);
      },
    );

    test(
      'subscribeEvents should send subscribe_events with event_type and unsubscribe on dispose',
      () async {
        // Arrange
        await connection.connect();

        // Act
        final subscription = HACommands.subscribeEvents(
          connection,
          'area_registry_updated',
        );

        await fakeSocket.nextSentWhere(
          (m) =>
              m is SubscribeEventsMessage &&
              m.eventType == 'area_registry_updated',
        );
        const subscriptionId = 2;

        // ACK subscription
        fakeSocket.addIncoming({
          'id': subscriptionId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await Future<void>.delayed(Duration.zero);

        final disposeFuture = subscription.dispose();

        await fakeSocket.nextSentWhere(
          (m) =>
              m is UnsubscribeEventsMessage &&
              m.subscriptionID == subscriptionId,
        );
        const unsubscribeCommandId = 3;

        // ACK unsubscribe
        fakeSocket.addIncoming({
          'id': unsubscribeCommandId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await disposeFuture;

        // Assert
        expect(subscription, isA<HassSubscription>());
        expect(subscription.isDisposed, isTrue);
      },
    );

    test('subscribeEvents should receive HassEvent payloads', () async {
      // Arrange
      await connection.connect();

      final subscription = HACommands.subscribeEvents(
        connection,
        'area_registry_updated',
      );

      await fakeSocket.nextSentWhere(
        (m) =>
            m is SubscribeEventsMessage &&
            m.eventType == 'area_registry_updated',
      );
      const subscriptionId = 2;

      // ACK subscription
      fakeSocket.addIncoming({
        'id': subscriptionId,
        'type': 'result',
        'success': true,
        'result': null,
      });

      // Emit event
      fakeSocket.addIncoming({
        'id': subscriptionId,
        'type': 'event',
        'event': {
          'event_type': 'area_registry_updated',
          'data': {
            'action': 'create',
            'area_id': 'living_room',
            'name': 'Living Room',
          },
          'origin': 'LOCAL',
          'time_fired': '2024-01-15T10:30:00.123456+00:00',
          'context': {
            'id': '01HKXXX123456789ABC',
            'parent_id': null,
            'user_id': 'user123',
          },
        },
      });

      final first = await subscription.stream.first;

      // Assert
      expect(first, isA<HassEvent>());
      final event = first as HassEvent;
      expect(event.event_type, equals('area_registry_updated'));
      expect(event.origin, equals('LOCAL'));
      expect(event.data['action'], equals('create'));
      expect(event.data['area_id'], equals('living_room'));
      expect(event.data['name'], equals('Living Room'));

      final disposeFuture = subscription.dispose();

      await fakeSocket.nextSentWhere(
        (m) =>
            m is UnsubscribeEventsMessage && m.subscriptionID == subscriptionId,
      );
      const unsubscribeCommandId = 3;

      // ACK unsubscribe
      fakeSocket.addIncoming({
        'id': unsubscribeCommandId,
        'type': 'result',
        'success': true,
        'result': null,
      });

      await disposeFuture;
    });
  });

  group('Timeout & shutdown', () {
    test('sendMessage should time out and fail the command', () {
      fakeAsync((async) {
        var connected = false;
        connection.connect().then((_) => connected = true);
        async.flushMicrotasks();
        expect(connected, isTrue);

        Object? error;
        connection
            .sendMessage(PingMessage(), timeout: const Duration(seconds: 2))
            .catchError((e) => error = e);

        async.elapse(const Duration(seconds: 2));
        async.flushMicrotasks();

        expect(error, isA<TimeoutException>());
      });
    });

    test('close should complete pending commands (no timeout leak)', () {
      fakeAsync((async) {
        var connected = false;
        connection.connect().then((_) => connected = true);
        async.flushMicrotasks();
        expect(connected, isTrue);

        Object? error;
        connection
            .sendMessage(PingMessage(), timeout: const Duration(hours: 1))
            .catchError((e) => error = e);

        var closed = false;
        connection.close().then((_) => closed = true);
        async.flushMicrotasks();

        expect(closed, isTrue);
        expect(error, equals('Connection lost 📡'));

        // Ensure timers don't fire later and change outcome.
        async.elapse(const Duration(hours: 2));
        async.flushMicrotasks();
        expect(error, equals('Connection lost 📡'));
      });
    });
  });

  group('Invalid client messages', () {
    test('server closes connection on invalid client message', () async {
      await connection.connect();

      // Send a normal request, then simulate the server closing due to "invalid message".
      final future = connection.sendMessage(
        PingMessage(),
        timeout: const Duration(seconds: 30),
      );
      final expectation = expectLater(
        future,
        throwsA(equals('Connection lost 📡')),
      );

      await fakeSocket.nextSentWhere((m) => m is PingMessage);

      await fakeSocket.closeFromServer(
        closeCode: 1002,
        reason: 'Invalid message',
        type: DisconnectionType.error,
      );

      // Allow HAConnection to process onDone.
      await Future<void>.delayed(Duration.zero);

      await expectation;
      expect(connection.currentState, isA<Disconnected>());
    });
  });
}
