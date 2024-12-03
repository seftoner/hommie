import 'package:hommie/core/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A class that observes the state changes in a Provider.
class AppStateLoggerObserver extends ProviderObserver {
  const AppStateLoggerObserver();

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.t(
      {
        'msg':
            "Provider '${provider.name ?? provider.runtimeType}' change state",
        "old": previousValue,
        "new": newValue
      },
    );

    @override
    // ignore: unused_element
    void providerDidFail(
      ProviderBase<Object?> provider,
      Object error,
      StackTrace stackTrace,
      ProviderContainer container,
    ) {
      logger.e(error, stackTrace: stackTrace);
    }
  }
}
