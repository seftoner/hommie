import 'dart:async';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:patrol/patrol.dart';
import '../utils/test_context.dart';
Future<void> theClientIsConnectedToHomeAssistant(PatrolIntegrationTester $) async {
  final deadline = DateTime.now().add(const Duration(seconds: 30));
  while (TestContext.instance().appState.container.read(activeServerSessionProvider) is! OnlineServerSession) {
    if (DateTime.now().isAfter(deadline)) throw TimeoutException('Client did not establish an authenticated HA connection');
    await $.pump(const Duration(milliseconds: 100));
  }
}
