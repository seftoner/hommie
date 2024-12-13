import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hommie/core/utils/logger.dart';

void registerErrorHandlers() {
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
    return Center(
      child: Text(
        "Something went wrong.\n${details.exception}",
      ),
    );
  };

  logger.d("Application error handlers initialized");
}
