import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

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
    callback,
  );
}
