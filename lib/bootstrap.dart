import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/utils/state_logger.dart';

Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerErrorHandlers();

  final container = ProviderContainer(
    overrides: [],
    observers: [const StateLogger()],
  );

  return container;
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
