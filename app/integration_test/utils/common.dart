import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:patrol/patrol.dart';
import 'package:hommie/core/bootstrap/bootstrap.dart';

import 'test_context.dart';
import 'fault_proxy_client.dart';
import 'hass_token_manager.dart';
import 'hass_area_manager.dart';
import 'cold_phase.dart';
import 'failure_evidence.dart';

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
    skip: coldPhaseSkip(
      const String.fromEnvironment('E2E_COLD_PHASE', defaultValue: 'none'),
      tags is String ? [tags] : (tags as Iterable?)?.cast<String>() ?? [],
      skip,
    ),
    tags: tags,
    ($) async {
      final context = TestContext.instance();
      context.begin('scenario${++_scenario}');
      var primaryFailed = false;
      context.cleanup.register('provider resources', context.appState.close);
      context.cleanup.register('app persisted state', () async {
        if (!context.preserveSeed) await context.appState.reset();
      });
      final proxy = FaultProxyClient(
        faultControlUrl: context.config.faultControlUrl,
      );
      context.cleanup.register('proxy HTTP client', () async {
        proxy.close();
      });
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
          final flutterError = FlutterError.onError;
          final platformError = PlatformDispatcher.instance.onError;
          final errorWidget = ErrorWidget.builder;
          try {
            await bootstrap();
          } finally {
            FlutterError.onError = flutterError;
            PlatformDispatcher.instance.onError = platformError;
            ErrorWidget.builder = errorWidget;
          }
          _bootstrapped = true;
        }
        if (context.config.coldPhase != 'verify')
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
        context.preserveSeed = context.config.coldPhase == 'seed';
      } catch (_) {
        primaryFailed = true;
        try {
          await captureFailureImage(context.config.runId);
        } catch (_) {
          debugPrint(
            'Failure screenshot capture failed; primary error retained',
          );
        }
        rethrow;
      }
    },
  );
}
