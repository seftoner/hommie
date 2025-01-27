import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/core/bootstrap/bootstrap.dart';
import 'package:hommie/core/observers/app_state_logger.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/database/database_provider.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await bootstrap();

      logger.i('Start the application 🚀');

      final appOverrides = await _initializeProviderOverrides();

      runApp(
        ProviderScope(
          observers: const [AppStateLoggerObserver()],
          overrides: appOverrides,
          child: const HommieApp(),
        ),
      );
    },
    (error, stack) {
      // Log the unhandled error
      logger.e('Unhandled exception: $error', error: error, stackTrace: stack);
    },
  );
}

Future<List<Override>> _initializeProviderOverrides() async {
  final isar = await DatabaseInitializer.initialize();

  return [
    databaseConnectionProvider.overrideWith((ref) {
      ref.onDispose(() => isar.close());
      return isar;
    }),
  ];
}
