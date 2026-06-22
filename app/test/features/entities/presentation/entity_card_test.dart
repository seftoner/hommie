import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/widgets/entity_card.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';

void main() {
  testWidgets('light renders LightCard; unknown domain renders nothing', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [entityStatesProvider.overrideWithValue(const {})],
        child: const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                EntityCard(
                  entity: HaEntity(
                    entityId: 'light.a',
                    domain: 'light',
                    name: 'A',
                  ),
                ),
                EntityCard(
                  entity: HaEntity(
                    entityId: 'sensor.b',
                    domain: 'sensor',
                    name: 'B',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(LightCard), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsNothing);
  });
}
