import 'package:hommie/features/common/domain/entities/ha_server.dart';
import 'package:hommie/features/common/domain/entities/ha_version.dart';
import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

/// Usage: a home assistant server is discoverable as {'Hommie E2E'}
Future<void> aHomeAssistantServerIsDiscoverableAs(
  PatrolIntegrationTester $,
  String name,
) async {
  final context = TestContext.instance();
  context.discoveryFixture.setServers([
    HaServer(
      uuid: 'e2e-discovery',
      name: name,
      uri: context.config.appServerUrl,
      internalUrl: context.config.appServerUrl,
      version: HaVersion.fromString('2024.12.5'),
    ),
  ]);
}
