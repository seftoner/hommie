import 'dart:io';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/utils/logger.dart';
import 'package:hommie/utils/state_logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

Future<ProviderContainer> bootstrap(Function callbackDispatcher) async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerErrorHandlers();
  _registerBackgroundTasks(callbackDispatcher);

  final container = ProviderContainer(
    overrides: [],
    observers: [const StateLogger()],
  );

  return container;
}

const simpleTaskKey = "com.hommie.workmanager.forTestingTask";
const simplePeriodicTask = "com.hommie.workmanager.simplePeriodicTask";
const simplePeriodic1HourTask =
    "com.hommie.workmanager.simplePeriodic1HourTask";
const iOSBackgroundAppRefresh = "com.hommie.workmanager.sendSensorData";

/// Background tasks currently supported only on iOS and Android.
Future<void> _registerBackgroundTasks(Function callbackDispatcher) async {
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
      initialDelay: Duration(seconds: 10),
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
