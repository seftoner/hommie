import 'package:computer/computer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/core/bootstrap/bootstrap.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/observers/app_state_logger.dart';
import 'package:patrol/patrol.dart';

import '../utils/test_provider_overrides.dart';

// ignore: provider_dependencies
Future<void> theApplicationIsRunningInTheForeground(
  PatrolIntegrationTester $,
) async {
  await initLogger();
  logger.i('Start the test integration tests 🚀👷');

  final computer = Computer.shared();
  await computer.turnOn(verbose: true);

  await $.pumpWidget(
    ProviderScope(
      observers: const [AppStateLoggerObserver()],
      retry: (retryCount, error) => null,
      overrides: TestProviderOverrides.instance().overrides.cast(),
      child: const HommieApp(),
    ),
  );
}
