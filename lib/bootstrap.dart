import 'dart:io';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/background_task/background_task.dart';
import 'package:hommie/utils/logger.dart';
import 'package:hommie/utils/app_state_logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initLogger();

  _registerErrorHandlers();
  _registerBackgroundTasks();

  final container = ProviderContainer(
    overrides: [],
    observers: [const AppStateLoggerObserver()],
  );

  return container;
}

Future<void> _initLogger() async {
  final logFile = await getLogsPath();
  logger = createLogger(logFile.path);
}

Future<File> getLogsPath() async {
  final String dir = switch (Platform.operatingSystem) {
    'android' => (await getExternalStorageDirectory())?.path ?? "",
    'macos' => join((await getLibraryDirectory()).path, "Logs"),
    'linux' => join(_getXdgStateHome(), "hommie"),
    _ => (await getApplicationDocumentsDirectory()).path,
  };

  final file = File(join(dir, "hommie_logs.log"));
  if (!await file.exists()) {
    await file.create(recursive: true);
  }
  return file;
}

String _getXdgStateHome() {
  // path_provider seems does not support XDG_STATE_HOME,
  // which is the specification to store application logs on Linux.
  // See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
  if (const bool.hasEnvironment("XDG_STATE_HOME")) {
    String xdgStateHomeRaw = Platform.environment["XDG_STATE_HOME"] ?? "";
    if (xdgStateHomeRaw.isNotEmpty) {
      return xdgStateHomeRaw;
    }
  }
  return join(Platform.environment["HOME"] ?? "", ".local", "state");
}

/// Background tasks currently supported only on iOS and Android.
/// TODO: Here will bi implemented sensing sensors to HomeAssistant
Future<void> _registerBackgroundTasks() async {
  if (Platform.isLinux ||
      Platform.isMacOS ||
      Platform.isWindows ||
      Platform.isFuchsia) {
    return;
  }

  if (Platform.isIOS) {
    final status = await Permission.backgroundRefresh.status;
    if (status != PermissionStatus.granted) {
      logger.e("No 'Background App Refresh' permission granded");
      return;
    }
  }

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  if (Platform.isAndroid) {
    await Workmanager().registerPeriodicTask(
      simplePeriodicTask,
      simplePeriodicTask,
      initialDelay: const Duration(minutes: 15),
    );
  }

  if (Platform.isIOS) {
    await Workmanager().registerPeriodicTask(
      iOSBackgroundAppRefresh,
      iOSBackgroundAppRefresh,
      initialDelay: const Duration(seconds: 60),
      inputData: <String, dynamic>{}, //ignored on iOS
    );
  }
}

void _registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Center(child: Text(details.toString()));
  };
}
