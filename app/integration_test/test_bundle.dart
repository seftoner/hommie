// ignore_for_file: type=lint, invalid_use_of_internal_member

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

// START: GENERATED TEST IMPORTS
import 'areas_test.dart' as areas_test;
import 'authorization_test.dart' as authorization_test;
import 'offline_banner_test.dart' as offline_banner_test;
// END: GENERATED TEST IMPORTS

Future<void> main() async {
  final nativeAutomator = NativeAutomator(config: NativeAutomatorConfig());
  await nativeAutomator.initialize();
  PatrolBinding.ensureInitialized(NativeAutomatorConfig())
    ..workaroundDebugDefaultTargetPlatformOverride =
        debugDefaultTargetPlatformOverride;

  // START: GENERATED TEST GROUPS
  group('areas_test', areas_test.main);
  group('authorization_test', authorization_test.main);
  group('offline_banner_test', offline_banner_test.main);
  // END: GENERATED TEST GROUPS
}
