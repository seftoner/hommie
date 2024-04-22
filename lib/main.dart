import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/bootstrap.dart';
import 'package:hommie/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
// import 'package:workmanager_workspace/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    int? totalExecutions;
    final sharedPreference =
        await SharedPreferences.getInstance(); //Initialize dependency

    print("Native called background task: $taskName, data: $inputData");
    try {
      //add code execution
      totalExecutions = sharedPreference.getInt("totalExecutions");
      sharedPreference.setInt(
          "totalExecutions", totalExecutions == null ? 1 : totalExecutions + 1);
    } catch (err) {
      logger.e(err.toString());
      throw Exception(err);
    }

    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await scheduleBackgroundTask();

  runApp(
    UncontrolledProviderScope(
      container: await bootstrap(),
      child: const HommieApp(),
    ),
  );
}

Future<void> scheduleBackgroundTask() async {
  if (Platform.isAndroid || Platform.isIOS) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);

    Workmanager().registerPeriodicTask(
      "com.hommie.workmanager.task-identifier",
      "simpleTask",
      initialDelay: const Duration(seconds: 10),
      frequency: const Duration(seconds: 4),
      constraints: Constraints(
        // connected or metered mark the task as requiring internet
        networkType: NetworkType.connected,
        // require external power
        requiresCharging: true,
      ),
      inputData: {"test": "me"},
    );
  }
}
