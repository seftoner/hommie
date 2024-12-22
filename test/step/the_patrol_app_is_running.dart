import 'package:computer/computer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:patrol/patrol.dart';
import 'package:hommie/core/bootstrap/bootstrap.dart';
import 'package:hommie/core/observers/app_state_logger.dart';
import 'package:hommie/core/utils/logger.dart';

//TODO: Unify app initialization in tests and main build
Future<void> thePatrolAppIsRunning(PatrolIntegrationTester $) async {
  await initLogger();
  logger.i('Start the test integration tests 🚀👷');

  final computer = Computer.shared();
  await computer.turnOn(
    workersCount: 2,
    verbose: true,
  );

  await $.pumpWidget(
    const ProviderScope(
      observers: [AppStateLoggerObserver()],
      child: HommieApp(),
    ),
  );
}
