import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/presentation/screens/server_discovery_page.dart';
import 'package:hommie/features/common/domain/entities/ha_server.dart';
import 'package:hommie/features/common/domain/entities/ha_version.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/ui/keys.dart';

import '../../integration_test/utils/discovery_assertions.dart';

final fixtureUrl = Uri.parse('http://127.0.0.1:18124');

Widget discoveryScreen(Widget child) => MaterialApp(
  home: Scaffold(key: K.serversDiscovery.page, body: child),
);

void main() {
  testWidgets('matches and taps only the row with the exact name and URL', (
    tester,
  ) async {
    final selected = <ServerUrl>[];
    final foreignUrl = Uri.parse('http://other-home.local:8123');
    await tester.pumpWidget(
      discoveryScreen(
        DiscoveredHaServersList(
          servers: [
            for (final url in [foreignUrl, fixtureUrl])
              HaServer(
                uuid: url.host,
                name: 'Hommie E2E',
                uri: url,
                internalUrl: url,
                version: HaVersion.fromString('2024.12.5'),
              ),
          ],
          onTap: (url) async => selected.add(url),
        ),
      ),
    );
    final row = discoveredServerRow(name: 'Hommie E2E', url: fixtureUrl);
    expect(row, findsOneWidget);
    await tester.tap(row);
    expect(selected, [ServerUrl(fixtureUrl.toString())]);
    expect(
      discoveredServerRow(name: 'Another name', url: fixtureUrl),
      findsNothing,
    );
  });

  testWidgets('same name at a different URL cannot satisfy discovery', (
    tester,
  ) async {
    await tester.pumpWidget(
      discoveryScreen(
        const ListTile(
          title: Text('Hommie E2E'),
          subtitle: Text('http://other-home.local:8123'),
        ),
      ),
    );
    expect(
      discoveredServerRow(name: 'Hommie E2E', url: fixtureUrl),
      findsNothing,
    );
  });

  testWidgets('successful empty discovery satisfies absence', (tester) async {
    await tester.pumpWidget(discoveryScreen(const Text('No servers found.')));
    await waitForNoDiscoveredServers(tester);
  });

  for (final state in {
    'loading': const SizedBox.shrink(),
    'error': const Text('Error discovering servers.'),
    'populated': const ListTile(
      title: Text('Hommie E2E'),
      subtitle: Text('http://127.0.0.1:18124'),
    ),
    'stale empty label beside a populated row': const Column(
      children: [
        Text('No servers found.'),
        ListTile(title: Text('A server')),
      ],
    ),
    'offscreen empty state': const SingleChildScrollView(
      child: Column(
        children: [SizedBox(height: 1000), Text('No servers found.')],
      ),
    ),
  }.entries) {
    testWidgets('${state.key} cannot satisfy absence', (tester) async {
      await tester.pumpWidget(discoveryScreen(state.value));
      await expectLater(
        () => waitForNoDiscoveredServers(
          tester,
          timeout: const Duration(milliseconds: 200),
        ),
        throwsA(isA<TimeoutException>()),
      );
    });
  }

  testWidgets('waits for successful empty discovery after loading', (
    tester,
  ) async {
    final completed = ValueNotifier(false);
    addTearDown(completed.dispose);
    await tester.pumpWidget(
      discoveryScreen(
        ValueListenableBuilder<bool>(
          valueListenable: completed,
          builder: (_, ready, _) =>
              ready ? const Text('No servers found.') : const SizedBox.shrink(),
        ),
      ),
    );
    Timer(const Duration(milliseconds: 300), () => completed.value = true);
    await waitForNoDiscoveredServers(tester);
  });
}
