import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'command_availability_provider.g.dart';

enum CommandAvailabilityReason { available, serverConnectionUnavailable }

class CommandAvailability {
  const CommandAvailability({required this.canSend, required this.reason});

  final bool canSend;
  final CommandAvailabilityReason reason;
}

@Riverpod(dependencies: [serverScopeConnection])
CommandAvailability commandAvailability(Ref ref) {
  try {
    ref.watch(serverScopeConnectionProvider);
    return const CommandAvailability(
      canSend: true,
      reason: CommandAvailabilityReason.available,
    );
  } catch (error, stackTrace) {
    if (_isServerScopeConnectionUnavailable(error)) {
      return const CommandAvailability(
        canSend: false,
        reason: CommandAvailabilityReason.serverConnectionUnavailable,
      );
    }
    _throwOriginalError(error, stackTrace);
  }
}

bool _isServerScopeConnectionUnavailable(Object error) {
  return switch (error) {
    ServerScopeConnectionUnavailableException() => true,
    ProviderException(:final exception) => _isServerScopeConnectionUnavailable(
      exception,
    ),
    _ => false,
  };
}

Never _throwOriginalError(Object error, StackTrace stackTrace) {
  if (error case ProviderException(:final exception, :final stackTrace)) {
    Error.throwWithStackTrace(exception, stackTrace);
  }
  Error.throwWithStackTrace(error, stackTrace);
}
