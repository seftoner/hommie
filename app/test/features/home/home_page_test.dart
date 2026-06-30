import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/application/command_availability_provider.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
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

class _DeviceTileHomeController extends HomePageController {
  @override
  HomePageState build() => const HomePageState(
    serverName: 'Home',
    tabs: [
      HomeSummaryTab(),
      HomeAreaTab(areaId: 'kitchen', title: 'Kitchen'),
    ],
    sections: [],
    deviceSections: [
      HomeDeviceSection(
        areaId: 'kitchen',
        title: 'Kitchen',
        tiles: [
          HomeTile(
            kind: HomeTileKind.device,
            targetId: 'dev-lamp',
            name: 'Counter lamp',
            areaId: 'kitchen',
            size: HomeTileSize.small,
            order: 0,
            resolution: HomeTileResolution.active,
            primaryEntity: HaEntity(
              registryId: 'reg-light',
              entityId: 'light.kitchen_lamp',
              domain: 'light',
              name: 'Kitchen lamp',
              areaId: 'kitchen',
              deviceId: 'dev-lamp',
            ),
          ),
        ],
      ),
    ],
  );
}

class _MissingAndDisabledTileHomeController extends HomePageController {
  @override
  HomePageState build() => const HomePageState(
    serverName: 'Home',
    tabs: [HomeSummaryTab()],
    sections: [],
    deviceSections: [
      HomeDeviceSection(
        areaId: null,
        title: 'Unassigned',
        tiles: [
          HomeTile(
            kind: HomeTileKind.device,
            targetId: 'dev-disabled',
            name: 'Disabled lamp',
            areaId: null,
            size: HomeTileSize.small,
            order: 0,
            resolution: HomeTileResolution.disabled,
            secondaryEntities: [
              HaEntity(
                registryId: 'reg-disabled-light',
                entityId: 'light.disabled_lamp',
                domain: 'light',
                name: 'Disabled lamp',
                deviceId: 'dev-disabled',
              ),
            ],
          ),
          HomeTile(
            kind: HomeTileKind.device,
            targetId: 'dev-unavailable',
            name: 'Offline lamp',
            areaId: null,
            size: HomeTileSize.small,
            order: 1,
            resolution: HomeTileResolution.unavailable,
            secondaryEntities: [
              HaEntity(
                registryId: 'reg-offline-light',
                entityId: 'light.offline_lamp',
                domain: 'light',
                name: 'Offline lamp',
                deviceId: 'dev-unavailable',
              ),
            ],
          ),
          HomeTile(
            kind: HomeTileKind.device,
            targetId: 'dev-missing',
            name: 'Old lamp',
            areaId: null,
            size: HomeTileSize.large,
            order: 2,
            resolution: HomeTileResolution.missing,
          ),
        ],
      ),
    ],
  );
}

class _UnsupportedUnavailableTileHomeController extends HomePageController {
  @override
  HomePageState build() => const HomePageState(
    serverName: 'Home',
    tabs: [HomeSummaryTab()],
    sections: [],
    deviceSections: [
      HomeDeviceSection(
        areaId: null,
        title: 'Unassigned',
        tiles: [
          HomeTile(
            kind: HomeTileKind.device,
            targetId: 'dev-light',
            name: 'Lamp',
            areaId: null,
            size: HomeTileSize.small,
            order: 0,
            resolution: HomeTileResolution.active,
            primaryEntity: HaEntity(
              registryId: 'reg-light',
              entityId: 'light.lamp',
              domain: 'light',
              name: 'Lamp',
              deviceId: 'dev-light',
            ),
          ),
          HomeTile(
            kind: HomeTileKind.device,
            targetId: 'dev-update',
            name: 'Demo Update with Progress',
            areaId: null,
            size: HomeTileSize.small,
            order: 1,
            resolution: HomeTileResolution.unavailable,
            secondaryEntities: [
              HaEntity(
                registryId: 'reg-update',
                entityId: 'update.demo_update',
                domain: 'update',
                name: 'Demo Update with Progress',
                deviceId: 'dev-update',
              ),
            ],
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
  testWidgets('renders summary from device tile sections', (tester) async {
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
            _DeviceTileHomeController.new,
          ),
          entityStatesProvider.overrideWithValue(const {}),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    expect(find.text('Kitchen'), findsWidgets);
    expect(find.byType(LightCard), findsOneWidget);
    expect(find.text('No lights here yet'), findsNothing);
  });

  testWidgets('renders area tab from device tile sections', (tester) async {
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
            _DeviceTileHomeController.new,
          ),
          entityStatesProvider.overrideWithValue(const {}),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    await tester.tap(find.widgetWithText(Tab, 'Kitchen'));
    await tester.pumpAndSettle();

    expect(find.byType(LightCard), findsOneWidget);
    expect(find.text('No lights here yet'), findsNothing);
  });

  testWidgets('renders disabled and missing tiles as non-command cards', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homePageControllerProvider.overrideWith(
            _MissingAndDisabledTileHomeController.new,
          ),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    expect(find.text('Disabled lamp'), findsOneWidget);
    expect(find.text('Disabled'), findsOneWidget);
    expect(find.text('Offline lamp'), findsOneWidget);
    expect(find.text('Unavailable'), findsOneWidget);
    expect(find.text('Old lamp'), findsOneWidget);
    expect(find.text('Missing'), findsOneWidget);
    expect(find.text('Rebind'), findsOneWidget);
    expect(find.text('Remove'), findsOneWidget);
    expect(find.byType(Switch), findsNothing);
  });

  testWidgets('does not render unsupported unavailable device tiles', (
    tester,
  ) async {
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
            _UnsupportedUnavailableTileHomeController.new,
          ),
          entityStatesProvider.overrideWithValue(const {
            'light.lamp': EntityStateValue(state: 'on'),
          }),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();

    expect(find.byType(LightCard), findsOneWidget);
    expect(find.text('Demo Update with Progress'), findsNothing);
    expect(find.text('Unavailable'), findsNothing);
  });

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
