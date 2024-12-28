import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:patrol/patrol.dart';

Future<void> iSeeOfflinebanner(PatrolIntegrationTester $) async {
  await $(K.common.offlineBanner).waitUntilVisible();
}
