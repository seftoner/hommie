import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/settings/application/active_server_areas_provider.dart';
import 'package:hommie/features/settings/application/areas_settings_controller.dart';
import 'package:hommie/features/settings/application/areas_settings_state.dart';
import 'package:hommie/features/settings/presentation/screens/areas_page.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class _FakeAreasSettingsController extends AreasSettingsController {
  _FakeAreasSettingsController({this.deleteCompleter, this.deleteFailure});

  final Completer<void>? deleteCompleter;
  final Object? deleteFailure;
  final deletedAreaIds = <String>[];

  @override
  FutureOr<void> build() {}

  @override
  Future<void> create(String name) async {}

  @override
  Future<void> rename({required String areaId, required String name}) async {}

  @override
  Future<void> delete({required String areaId}) async {
    deletedAreaIds.add(areaId);
    if (deleteCompleter != null) {
      await deleteCompleter!.future;
    }
    final failure = deleteFailure;
    if (failure != null) {
      throw failure;
    }
  }
}

void main() {
  testWidgets('lists cached areas and shows add icon when editable', (
    tester,
  ) async {
    await _pumpAreasPage(
      tester,
      state: const ActiveServerAreasState(
        areas: [
          Area(id: 'kitchen', name: 'Kitchen'),
          Area(id: 'office', name: 'Office'),
        ],
        canEdit: true,
        hasActiveServer: true,
      ),
    );

    expect(find.text('Kitchen'), findsOneWidget);
    expect(find.text('Office'), findsOneWidget);
    expect(find.byIcon(Symbols.add_rounded), findsOneWidget);

    final addButton = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Symbols.add_rounded),
    );
    expect(addButton.onPressed, isNotNull);
    expect(addButton.tooltip, 'Create area');
  });

  testWidgets('is read-only while offline', (tester) async {
    await _pumpAreasPage(
      tester,
      state: const ActiveServerAreasState(
        areas: [Area(id: 'kitchen', name: 'Kitchen')],
        canEdit: false,
        hasActiveServer: true,
      ),
    );

    expect(find.text('Kitchen'), findsOneWidget);
    expect(
      find.text('Connect to Home Assistant to edit areas'),
      findsOneWidget,
    );

    final addButton = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Symbols.add_rounded),
    );
    expect(addButton.onPressed, isNull);

    await tester.tap(find.byIcon(Symbols.more_vert_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Rename'), findsNothing);
    expect(find.text('Delete'), findsNothing);
  });

  testWidgets('shows delete confirmation copy', (tester) async {
    final controller = _FakeAreasSettingsController();
    await _pumpAreasPage(
      tester,
      state: const ActiveServerAreasState(
        areas: [Area(id: 'kitchen', name: 'Kitchen')],
        canEdit: true,
        hasActiveServer: true,
      ),
      controller: controller,
    );

    await tester.tap(find.byIcon(Symbols.more_vert_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Delete area "Kitchen"? Devices and entities will not be deleted.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(controller.deletedAreaIds, ['kitchen']);
    expect(find.text('Delete area'), findsNothing);
  });

  testWidgets('disables delete dialog actions while deleting', (tester) async {
    final deleteCompleter = Completer<void>();
    await _pumpAreasPage(
      tester,
      state: const ActiveServerAreasState(
        areas: [Area(id: 'kitchen', name: 'Kitchen')],
        canEdit: true,
        hasActiveServer: true,
      ),
      controller: _FakeAreasSettingsController(
        deleteCompleter: deleteCompleter,
      ),
    );

    await tester.tap(find.byIcon(Symbols.more_vert_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pump();

    final buttons = tester.widgetList<TextButton>(find.byType(TextButton));

    expect(buttons.every((button) => button.onPressed == null), isTrue);

    deleteCompleter.complete();
    await tester.pumpAndSettle();
  });

  testWidgets('keeps delete dialog open and shows failure', (tester) async {
    await _pumpAreasPage(
      tester,
      state: const ActiveServerAreasState(
        areas: [Area(id: 'kitchen', name: 'Kitchen')],
        canEdit: true,
        hasActiveServer: true,
      ),
      controller: _FakeAreasSettingsController(
        deleteFailure: Exception('delete failed'),
      ),
    );

    await tester.tap(find.byIcon(Symbols.more_vert_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Delete area'), findsOneWidget);
    expect(find.text('Exception: delete failed'), findsOneWidget);
  });
}

Future<void> _pumpAreasPage(
  WidgetTester tester, {
  required ActiveServerAreasState state,
  _FakeAreasSettingsController? controller,
}) async {
  final fakeController = controller ?? _FakeAreasSettingsController();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        activeServerAreasProvider.overrideWith((_) async => state),
        areasSettingsControllerProvider.overrideWith(() => fakeController),
      ],
      child: const MaterialApp(home: AreasPage()),
    ),
  );
  await tester.pump();
}
