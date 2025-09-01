import 'package:computer/computer.dart';
import 'package:hommie/core/bootstrap/background_tasks.dart';
import 'package:hommie/core/bootstrap/error_handlers.dart';
import 'package:hommie/core/utils/log_file.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/database/database_provider.dart';

Future<void> bootstrap() async {
  await initLogger();

  final computer = Computer.shared();
  await computer.turnOn(verbose: true);

  // Initialize database early
  await DatabaseInitializer.initialize();

  registerErrorHandlers();
  registerBackgroundTasks();
}

Future<void> initLogger() async {
  final logFile = await getLogsPath();
  logger = createLogger(logFile.path);
}
