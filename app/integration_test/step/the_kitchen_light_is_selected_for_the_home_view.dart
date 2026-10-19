import 'package:patrol/patrol.dart';
import '../utils/test_context.dart';

Future<void> theKitchenLightIsSelectedForTheHomeView(PatrolIntegrationTester $) async {
  await TestContext.instance().appState.selectHomeEntity('light.kitchen_light');
  await $.pump();
}
