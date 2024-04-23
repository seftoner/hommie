import 'dart:io';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/background_task/background_task.dart';
import 'package:hommie/utils/logger.dart';
import 'package:hommie/utils/state_logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerErrorHandlers();
  _registerBackgroundTasks();

  final container = ProviderContainer(
    overrides: [],
    observers: [const StateLogger()],
  );

  return container;
}

/// Background tasks currently supported only on iOS and Android.
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
