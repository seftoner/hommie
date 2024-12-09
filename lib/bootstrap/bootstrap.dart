import 'package:computer/computer.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/bootstrap/background_tasks.dart';
import 'package:hommie/bootstrap/error_handlers.dart';
import 'package:hommie/core/utils/log_file.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/core/observers/app_state_logger.dart';

Future<ProviderContainer> bootstrap() async {
  final computer = Computer.shared();
  await computer.turnOn(
    workersCount: 2,
    verbose: true,
  );

  // await _initLogger();

  registerErrorHandlers();
  registerBackgroundTasks();

  final container = ProviderContainer(
    overrides: [],
    observers: [const AppStateLoggerObserver()],
  );

  return container;
}

Future<void> initLogger() async {
  final logFile = await getLogsPath();
  logger = createLogger(logFile.path);
}
