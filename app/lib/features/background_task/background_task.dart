import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const simpleTaskKey = 'com.hommie.workmanager.forTestingTask';
const simplePeriodicTask = 'com.hommie.workmanager.simplePeriodicTask';
const simplePeriodic1HourTask =
    'com.hommie.workmanager.simplePeriodic1HourTask';
const iOSBackgroundAppRefresh = 'com.hommie.workmanager.sendSensorData';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    logger.d('$task started. inputData = $inputData');
    await prefs.setString(task, 'Last ran at: ${DateTime.now().toString()}');

    switch (task) {
      case simplePeriodicTask:
        logger.d('$simplePeriodicTask was executed(Android)');
        break;
      case iOSBackgroundAppRefresh:
        logger.d('$iOSBackgroundAppRefresh was executed(iOS)');
        // To test, follow the instructions on https://developer.apple.com/documentation/backgroundtasks/starting_and_terminating_tasks_during_development
        // and https://github.com/fluttercommunity/flutter_workmanager/blob/main/IOS_SETUP.md
        break;
      default:
        return Future.value(false);
    }
    return Future.value(true);
  });
}
