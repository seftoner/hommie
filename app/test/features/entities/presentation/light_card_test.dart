import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

class _CapturingConnection implements IHAConnection {
  String? lastService;

  @override
  HAResponse sendMessage(HAMessage message) async {
    lastService = (message as HARequestMessage).body['service'] as String?;
    return {
      'context': {'id': 'x'},
    };
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  testWidgets('tapping the switch calls toggle and flips optimistically', (
    tester,
  ) async {
    final conn = _CapturingConnection();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            OnlineServerSession(
              activeServer: const Server(id: 1, name: 'Home'),
              connection: conn,
            ),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: LightCard(
              entity: HaEntity(
                entityId: 'light.kitchen',
                domain: 'light',
                name: 'Kitchen',
              ),
              state: EntityStateValue(state: 'off'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Off'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(conn.lastService, 'toggle');
    expect(find.text('On'), findsOneWidget); // optimistic flip
  });

  testWidgets('unavailable state disables the switch', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: LightCard(
              entity: HaEntity(
                entityId: 'light.kitchen',
                domain: 'light',
                name: 'Kitchen',
              ),
              state: null,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Unavailable'), findsOneWidget);
    final switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.onChanged, isNull);
  });
}
