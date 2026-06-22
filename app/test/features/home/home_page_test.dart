import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/home/presentation/screens/home_page.dart';

class _StubHomeController extends HomePageController {
  @override
  HomePageState build() => const HomePageState(
    serverName: 'Home',
    tabs: [
      HomeSummaryTab(),
      HomeAreaTab(areaId: 'kitchen', title: 'Kitchen'),
    ],
    sections: [
      AreaSection(
        areaId: 'kitchen',
        title: 'Kitchen',
        entities: [
          HaEntity(
            entityId: 'light.a',
            domain: 'light',
            name: 'A',
            areaId: 'kitchen',
          ),
        ],
      ),
    ],
  );
}

class _SyncFailureHomeController extends HomePageController {
  @override
  HomePageState build() =>
      const HomePageState(serverName: 'Home', syncFailure: Object());
}

void main() {
  testWidgets('renders area tabs and a light card', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homePageControllerProvider.overrideWith(_StubHomeController.new),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    // 'Kitchen' appears both as a tab and a room-group header.
    expect(find.text('Kitchen'), findsWidgets);
    expect(find.byType(LightCard), findsOneWidget);
  });

  testWidgets('renders empty sync failure state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homePageControllerProvider.overrideWith(
            _SyncFailureHomeController.new,
          ),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    expect(find.text('Unable to sync Home Assistant data'), findsOneWidget);
  });
}
