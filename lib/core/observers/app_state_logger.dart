import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:hommie/core/utils/logger.dart';

/// A class that observes the state changes in a Provider.
final class AppStateLoggerObserver extends ProviderObserver {
  const AppStateLoggerObserver();

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    logger.t({
      'msg':
          "Provider '${context.provider.name ?? context.provider.runtimeType}' change state",
      'old': previousValue,
      'new': newValue,
    });
  }

  @override
  // ignore: unused_element
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    if (error is ProviderException) {
      // The provider didn't fail directly, but instead depends on a failed provider.
      // The error was therefore already logged.
      return;
    }
    logger.e(error, stackTrace: stackTrace);
  }
}
