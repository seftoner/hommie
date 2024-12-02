import 'dart:io';

import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/background_task/background_task.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

/// Background tasks currently supported only on iOS and Android.
/// TODO: Here will bi implemented sensing sensors to HomeAssistant
Future<void> registerBackgroundTasks() async {
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
