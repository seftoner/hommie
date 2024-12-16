import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hommie/features/background_task/background_task.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const simplePeriodicTask = 'com.hommie.workmanager.simplePeriodicTask';
const simplePeriodic1HourTask =
    'com.hommie.workmanager.simplePeriodic1HourTask';
const iOSBackgroundAppRefresh = 'com.hommie.workmanager.sendSensorData';
const simpleTaskKey = 'be.tramckrijte.workmanagerExample.simpleTask';
const rescheduledTaskKey = 'be.tramckrijte.workmanagerExample.rescheduledTask';
const failedTaskKey = 'be.tramckrijte.workmanagerExample.failedTask';
const simpleDelayedTask = 'be.tramckrijte.workmanagerExample.simpleDelayedTask';
const iOSBackgroundProcessingTask =
    'be.tramckrijte.workmanagerExample.iOSBackgroundProcessingTask';

final List<String> allTasks = [
  simpleTaskKey,
  rescheduledTaskKey,
  failedTaskKey,
  simpleDelayedTask,
  simplePeriodicTask,
  simplePeriodic1HourTask,
  iOSBackgroundAppRefresh,
  iOSBackgroundProcessingTask,
];

///FOR DEBUGGIN PURPOSE ONLY
class BGTaskDebugginPage extends StatefulWidget {
  const BGTaskDebugginPage({super.key});

  @override
  _BGTaskDebugginPageState createState() => _BGTaskDebugginPageState();
}

class _BGTaskDebugginPageState extends State<BGTaskDebugginPage> {
  bool workmanagerInitialized = false;
  String _prefsString = 'empty';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter WorkManager Example'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Plugin initialization',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ElevatedButton(
                  child: const Text('Start the Flutter background service'),
                  onPressed: () async {
                    if (Platform.isIOS) {
                      final status = await Permission.backgroundRefresh.status;
                      if (status != PermissionStatus.granted) {
                        _showNoPermission(context, status);
                        return;
                      }
                    }
                    if (!workmanagerInitialized) {
                      Workmanager().initialize(
                        callbackDispatcher,
                        isInDebugMode: true,
                      );
                      setState(() => workmanagerInitialized = true);
                    }
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Register task',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                //This task runs once.
                //Most likely this will trigger immediately
                ElevatedButton(
                  child: const Text('Register OneOff Task'),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      simpleTaskKey,
                      simpleTaskKey,
                      inputData: <String, dynamic>{
                        'int': 1,
                        'bool': true,
                        'double': 1.0,
                        'string': 'string',
                        'array': [1, 2, 3],
                      },
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Register rescheduled Task'),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      rescheduledTaskKey,
                      rescheduledTaskKey,
                      inputData: <String, dynamic>{
                        'key': Random().nextInt(64000),
                      },
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Register failed Task'),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      failedTaskKey,
                      failedTaskKey,
                    );
                  },
                ),
                //This task runs once
                //This wait at least 10 seconds before running
                ElevatedButton(
                    child: const Text('Register Delayed OneOff Task'),
                    onPressed: () {
                      Workmanager().registerOneOffTask(
                        simpleDelayedTask,
                        simpleDelayedTask,
                        initialDelay: const Duration(seconds: 10),
                      );
                    }),
                const SizedBox(height: 8),
                Text(
                  'Register periodic task (android only)',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                //This task runs periodically
                //It will wait at least 10 seconds before its first launch
                //Since we have not provided a frequency it will be the default 15 minutes
                ElevatedButton(
                  onPressed: Platform.isAndroid
                      ? () {
                          Workmanager().registerPeriodicTask(
                            simplePeriodicTask,
                            simplePeriodicTask,
                            initialDelay: const Duration(seconds: 10),
                          );
                        }
                      : null,
                  child: const Text('Register Periodic Task (Android)'),
                ),
                //This task runs periodically
                //It will run about every hour
                ElevatedButton(
                  onPressed: Platform.isAndroid
                      ? () {
                          Workmanager().registerPeriodicTask(
                            simplePeriodic1HourTask,
                            simplePeriodic1HourTask,
                            flexInterval: const Duration(minutes: 15),
                            frequency: const Duration(hours: 1),
                          );
                        }
                      : null,
                  child: const Text('Register 1 hour Periodic Task (Android)'),
                ),

                // Currently we cannot provide frequency for iOS, hence it will be
                // minimum 15 minutes after which iOS will reschedule
                ElevatedButton(
                  onPressed: Platform.isIOS
                      ? () async {
                          if (!workmanagerInitialized) {
                            _showNotInitialized();
                            return;
                          }
                          await Workmanager().registerPeriodicTask(
                            iOSBackgroundAppRefresh,
                            iOSBackgroundAppRefresh,
                            initialDelay: const Duration(seconds: 10),
                            inputData: <String, dynamic>{}, //ignored on iOS
                          );
                        }
                      : null,
                  child: const Text(
                      'Register Periodic Background App Refresh (iOS)'),
                ),

                // This task runs only once, to perform a time consuming task at
                // a later time decided by iOS.
                // Processing tasks run only when the device is idle. iOS might
                // terminate any running background processing tasks when the
                // user starts using the device.
                /// MARK: Register BackgroundProcessingTask (iOS)
                ElevatedButton(
                  onPressed: Platform.isIOS
                      ? () async {
                          if (!workmanagerInitialized) {
                            _showNotInitialized();
                            return;
                          }
                          await Workmanager().registerProcessingTask(
                            iOSBackgroundProcessingTask,
                            iOSBackgroundProcessingTask,
                            initialDelay: const Duration(seconds: 20),
                          );
                        }
                      : null,
                  child: const Text('Register BackgroundProcessingTask (iOS)'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: Platform.isAndroid
                      ? () async {
                          final workInfo =
                              await Workmanager().isScheduledByUniqueName(
                            simplePeriodicTask,
                          );
                          print('isscheduled = $workInfo');
                        }
                      : null,
                  child: const Text('isscheduled (Android)'),
                ),
                const SizedBox(height: 8),
                Text(
                  'Task cancellation',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ElevatedButton(
                  child: const Text('Cancel All'),
                  onPressed: () async {
                    await Workmanager().cancelAll();
                    print('Cancel all tasks completed');
                  },
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _refreshStats,
                  child: const Text('Refresh stats'),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: Text(
                    'Task run stats:\n'
                    '${workmanagerInitialized ? '' : 'Workmanager not initialized'}'
                    '\n$_prefsString',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Refresh/get saved prefs
  void _refreshStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    _prefsString = '';
    for (final task in allTasks) {
      _prefsString = '$_prefsString \n$task:\n${prefs.getString(task)}\n';
    }

    if (Platform.isIOS) {
      Workmanager().printScheduledTasks();
    }

    setState(() {});
  }

  void _showNotInitialized() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Workmanager not initialized'),
          content:
              const Text('Workmanager is not initialized, please initialize'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showNoPermission(BuildContext context, PermissionStatus hasPermission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No permission'),
          content: Text('Background app refresh is disabled, please enable in '
              'App settings. Status ${hasPermission.name}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
