import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/application/command_availability_provider.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';

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
        overrides: [serverScopeConnectionProvider.overrideWithValue(conn)],
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
      ProviderScope(
        overrides: [
          commandAvailabilityProvider.overrideWithValue(
            const CommandAvailability(
              canSend: true,
              reason: CommandAvailabilityReason.available,
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

  testWidgets(
    'command unavailable disables the switch while state is present',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            commandAvailabilityProvider.overrideWithValue(
              const CommandAvailability(
                canSend: false,
                reason: CommandAvailabilityReason.serverConnectionUnavailable,
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
      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.onChanged, isNull);
    },
  );
}
