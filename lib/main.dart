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

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    print("$task started. inputData = $inputData");
    await prefs.setString(task, 'Last ran at: ${DateTime.now().toString()}');

    switch (task) {
      case simplePeriodicTask:
        logger.d("$simplePeriodicTask was executed(Android)");
        break;
      case iOSBackgroundAppRefresh:
        logger.d("$iOSBackgroundAppRefresh was executed(iOS)");
        // To test, follow the instructions on https://developer.apple.com/documentation/backgroundtasks/starting_and_terminating_tasks_during_development
        // and https://github.com/fluttercommunity/flutter_workmanager/blob/main/IOS_SETUP.md
        break;
      default:
        return Future.value(false);
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  runApp(
    UncontrolledProviderScope(
      container: await bootstrap(callbackDispatcher),
      child: const HommieApp(),
    ),
  );
}
