import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/bootstrap/bootstrap.dart';
import 'package:hommie/core/utils/logger.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initLogger();

      logger.i("start the application");

      runApp(
        UncontrolledProviderScope(
          container: await bootstrap(),
          child: const HommieApp(),
        ),
      );
    },
    (error, stack) {
      // Log the unhandled error
      logger.e("Unhandled exception: $error", error: error, stackTrace: stack);
    },
  );
}
