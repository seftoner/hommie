import 'package:home_assistant_websocket/src/ha_commands.dart';
import 'package:home_assistant_websocket/src/ha_connection.dart';
import 'package:home_assistant_websocket/src/ha_socket_state.dart';
import 'package:home_assistant_websocket/src/hass_subscription.dart';
import 'package:home_assistant_websocket/src/logger_interface.dart';
import 'package:home_assistant_websocket/src/types/hass_event.dart';
import 'package:home_assistant_websocket/src/types/hass_types.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'fakes/fake_ha_socket.dart';
import 'ha_connection_test.mocks.dart';

void main() {
  late MockHAConnectionOption mockOptions;
  late HAConnection connection;
  late FakeHASocket fakeSocket;

  setUp(() {
    mockOptions = MockHAConnectionOption();
    fakeSocket = FakeHASocket();

    when(mockOptions.createSocket()).thenAnswer((_) async => fakeSocket);
    when(mockOptions.logger).thenReturn(const NoOpLogger());

    connection = HAConnection(mockOptions);
  });

  tearDown(() async {
    await connection.close();
  });

  group('Areas registry', () {
    test(
      'getAreas should send config/area_registry/list and parse result',
      () async {
        // Arrange
        fakeSocket.setState(const Authenticated());
        await connection.connect();

        // Act
        final areasFuture = HACommands.getAreas(connection);

        final sent = await fakeSocket.nextSentWhere(
          (m) => m.payload['type'] == 'config/area_registry/list',
        );
        final id = sent.payload['id'] as int;

        fakeSocket.addIncoming({
          'id': id,
          'type': 'result',
          'success': true,
          'result': [
            {
              'area_id': 'living_room',
              'name': 'Living Room',
              'picture': null,
              'aliases': ['LR'],
            },
          ],
        });

        final areas = await areasFuture;

        // Assert
        expect(areas, isA<List<AreaEntity>>());
        expect(areas, hasLength(1));
        expect(areas.first.area_id, equals('living_room'));
        expect(areas.first.name, equals('Living Room'));
        expect(areas.first.aliases, equals(['LR']));
      },
    );
  });

  group('Area registry events (subscribe_events)', () {
    test(
      'subscribeEvents should send subscribe_events with event_type',
      () async {
        // Arrange
        fakeSocket.setState(const Authenticated());
        await connection.connect();

        // Act
        final subscription = HACommands.subscribeEvents(
          connection,
          'area_registry_updated',
        );

        final sentSubscribe = await fakeSocket.nextSentWhere(
          (m) =>
              m.payload['type'] == 'subscribe_events' &&
              m.payload['event_type'] == 'area_registry_updated',
        );
        final subscriptionId = sentSubscribe.payload['id'] as int;

        // ACK subscription
        fakeSocket.addIncoming({
          'id': subscriptionId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await Future<void>.delayed(Duration.zero);

        // Assert
        expect(subscription, isA<HassSubscription>());
        expect(subscription.isDisposed, isFalse);

        final disposeFuture = subscription.dispose();

        final sentUnsubscribe = await fakeSocket.nextSentWhere(
          (m) =>
              m.payload['type'] == 'unsubscribe_events' &&
              m.payload['subscription'] == subscriptionId,
        );
        final unsubscribeCommandId = sentUnsubscribe.payload['id'] as int;

        // ACK unsubscribe
        fakeSocket.addIncoming({
          'id': unsubscribeCommandId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await disposeFuture;
      },
    );

    test(
      'subscription should receive HassEvent for area_registry_updated',
      () async {
        // Arrange
        fakeSocket.setState(const Authenticated());
        await connection.connect();

        final subscription = HACommands.subscribeEvents(
          connection,
          'area_registry_updated',
        );

        final sentSubscribe = await fakeSocket.nextSentWhere(
          (m) =>
              m.payload['type'] == 'subscribe_events' &&
              m.payload['event_type'] == 'area_registry_updated',
        );
        final subscriptionId = sentSubscribe.payload['id'] as int;

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

        final sentUnsubscribe = await fakeSocket.nextSentWhere(
          (m) =>
              m.payload['type'] == 'unsubscribe_events' &&
              m.payload['subscription'] == subscriptionId,
        );
        final unsubscribeCommandId = sentUnsubscribe.payload['id'] as int;

        // ACK unsubscribe
        fakeSocket.addIncoming({
          'id': unsubscribeCommandId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await disposeFuture;
      },
    );

    test(
      'disposing subscription should send unsubscribe_events after ACK',
      () async {
        // Arrange
        fakeSocket.setState(const Authenticated());
        await connection.connect();

        final subscription = HACommands.subscribeEvents(
          connection,
          'area_registry_updated',
        );

        final sentSubscribe = await fakeSocket.nextSentWhere(
          (m) =>
              m.payload['type'] == 'subscribe_events' &&
              m.payload['event_type'] == 'area_registry_updated',
        );
        final subscriptionId = sentSubscribe.payload['id'] as int;

        // ACK subscription
        fakeSocket.addIncoming({
          'id': subscriptionId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await Future<void>.delayed(Duration.zero);

        // Act
        final disposeFuture = subscription.dispose();

        final sentUnsubscribe = await fakeSocket.nextSentWhere(
          (m) =>
              m.payload['type'] == 'unsubscribe_events' &&
              m.payload['subscription'] == subscriptionId,
        );
        final unsubscribeCommandId = sentUnsubscribe.payload['id'] as int;

        // ACK unsubscribe
        fakeSocket.addIncoming({
          'id': unsubscribeCommandId,
          'type': 'result',
          'success': true,
          'result': null,
        });

        await disposeFuture;

        // Assert
        expect(subscription.isDisposed, isTrue);
      },
    );
  });
}
