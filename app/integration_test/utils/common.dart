import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:patrol/patrol.dart';
import 'package:hommie/core/bootstrap/bootstrap.dart';

import 'test_context.dart';
import 'fault_proxy_client.dart';
import 'hass_token_manager.dart';
import 'hass_area_manager.dart';

bool _bootstrapped = false;
int _scenario = 0;

final _patrolTesterConfig = const PatrolTesterConfig(printLogs: true);
final _platformAutomatorConfig = PlatformAutomatorConfig.fromOptions(
  findTimeout: const Duration(
    seconds: 20,
  ), // 10 seconds is too short for some CIs
);

void patrol(
  String description,
  Future<void> Function(PatrolIntegrationTester) callback, {
  bool? skip,
  dynamic tags,
  PlatformAutomatorConfig? platformAutomatorConfig,
  LiveTestWidgetsFlutterBindingFramePolicy framePolicy =
      LiveTestWidgetsFlutterBindingFramePolicy.fadePointers,
}) {
  patrolTest(
    description,
    config: _patrolTesterConfig,
    platformAutomatorConfig:
        platformAutomatorConfig ?? _platformAutomatorConfig,
    framePolicy: framePolicy,
    skip: skip,
    tags: tags,
    ($) async {
      final context = TestContext.instance();
      context.begin('scenario${++_scenario}');
      var primaryFailed = false;
      context.cleanup.register('provider resources', context.appState.close);
      context.cleanup.register('app persisted state', context.appState.reset);
      final proxy = FaultProxyClient(
        faultControlUrl: context.config.faultControlUrl,
      );
      context.cleanup.register('HA route restoration', proxy.restoreHaRoute);
      addTearDown(() async {
        try {
          await context.cleanup.finish(
            primaryFailed: primaryFailed,
            diagnostic: debugPrint,
          );
        } finally {
          context.clear();
        }
      });
      try {
        if (!_bootstrapped) {
          await bootstrap();
          _bootstrapped = true;
        }
        await context.appState.reset();
        context.cleanup.register(
          'owned HA areas',
          () => HassAreaManager().cleanupOwnedAreas(
            ids: context.ownedAreaIds,
            reservedNames: {context.initialAreaName, context.renamedAreaName},
          ),
        );
        final tokens = HassTokenManager();
        final baseline = (await tokens.list()).map((t) => t.id).toSet();
        context.cleanup.register('owned UI OAuth session', () async {
          final candidates = (await tokens.list())
              .where(
                (t) =>
                    !baseline.contains(t.id) &&
                    t.clientId == 'https://seftoner.github.io',
              )
              .toList();
          if (candidates.length > 1) {
            throw StateError(
              'Ambiguous OAuth session; manual ownership repair required',
            );
          }
          if (candidates.isNotEmpty) {
            await tokens.deleteById(candidates.single.id);
          }
        });
        await callback($);
      } catch (_) {
        primaryFailed = true;
        rethrow;
      }
    },
  );
}
