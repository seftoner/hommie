import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/application/command_availability_provider.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/home/presentation/screens/home_page.dart';
import 'package:hommie/ui/keys.dart';

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

class _MixedDomainHomeController extends HomePageController {
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
          HaEntity(
            entityId: 'sensor.a',
            domain: 'sensor',
            name: 'A',
            areaId: 'kitchen',
          ),
          HaEntity(
            entityId: 'switch.a',
            domain: 'switch',
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

class _SyncFailureWithEmptyAreaHomeController extends HomePageController {
  @override
  HomePageState build() => const HomePageState(
    serverName: 'Home',
    syncFailure: Object(),
    tabs: [
      HomeSummaryTab(),
      HomeAreaTab(areaId: 'kitchen', title: 'Kitchen'),
    ],
    sections: [AreaSection(areaId: 'kitchen', title: 'Kitchen', entities: [])],
  );
}

class _InitialSyncHomeController extends HomePageController {
  @override
  HomePageState build() =>
      const HomePageState(serverName: 'Home', isInitialSyncing: true);
}

void main() {
  testWidgets('renders summary grouped by device type', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          commandAvailabilityProvider.overrideWithValue(
            const CommandAvailability(
              canSend: true,
              reason: CommandAvailabilityReason.available,
            ),
          ),
          homePageControllerProvider.overrideWith(_StubHomeController.new),
          entityStatesProvider.overrideWithValue(const {}),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    expect(find.text('Kitchen'), findsOneWidget);
    expect(find.text('Lights'), findsOneWidget);
    expect(find.byType(LightCard), findsOneWidget);
  });

  testWidgets('renders area tab grouped by device type', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          commandAvailabilityProvider.overrideWithValue(
            const CommandAvailability(
              canSend: true,
              reason: CommandAvailabilityReason.available,
            ),
          ),
          homePageControllerProvider.overrideWith(_StubHomeController.new),
          entityStatesProvider.overrideWithValue(const {}),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Kitchen'));
    await tester.pumpAndSettle();

    expect(find.text('Lights'), findsOneWidget);
    expect(find.byType(LightCard), findsOneWidget);
  });

  testWidgets('hides unsupported type groups', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          commandAvailabilityProvider.overrideWithValue(
            const CommandAvailability(
              canSend: true,
              reason: CommandAvailabilityReason.available,
            ),
          ),
          homePageControllerProvider.overrideWith(
            _MixedDomainHomeController.new,
          ),
          entityStatesProvider.overrideWithValue(const {}),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    expect(find.text('Lights'), findsOneWidget);
    expect(find.text('Sensors'), findsNothing);
    expect(find.text('Switches'), findsNothing);
    expect(find.text('No lights here yet'), findsNothing);
  });

  testWidgets('hides unsupported type groups in area tabs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          commandAvailabilityProvider.overrideWithValue(
            const CommandAvailability(
              canSend: true,
              reason: CommandAvailabilityReason.available,
            ),
          ),
          homePageControllerProvider.overrideWith(
            _MixedDomainHomeController.new,
          ),
          entityStatesProvider.overrideWithValue(const {}),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Kitchen'));
    await tester.pumpAndSettle();

    expect(find.text('Lights'), findsOneWidget);
    expect(find.text('Sensors'), findsNothing);
    expect(find.text('Switches'), findsNothing);
    expect(find.text('No lights here yet'), findsNothing);
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

  testWidgets(
    'renders sync failure when cached areas have no renderable entities',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homePageControllerProvider.overrideWith(
              _SyncFailureWithEmptyAreaHomeController.new,
            ),
          ],
          child: const MaterialApp(home: HomePage()),
        ),
      );
      await tester.pump();

      expect(find.text('Unable to sync Home Assistant data'), findsOneWidget);
      expect(find.text('No lights here yet'), findsNothing);
    },
  );

  testWidgets('keys initial home sync spinner', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homePageControllerProvider.overrideWith(
            _InitialSyncHomeController.new,
          ),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    expect(find.byKey(K.home.loadingSpinner), findsOneWidget);
  });
}
