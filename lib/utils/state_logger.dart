import 'package:hommie/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A class that observes the state changes in a Provider.
class StateLogger extends ProviderObserver {
  const StateLogger();
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.t('''
            {
              provider: ${provider.name ?? provider.runtimeType},
              oldValue: $previousValue,
              newValue: $newValue
            }
''');
  }
}
