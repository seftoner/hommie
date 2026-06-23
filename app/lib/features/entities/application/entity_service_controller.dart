import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_service_controller.g.dart';

/// Single generic path for entity operations: calls an HA service on an entity.
class EntityServiceController {
  EntityServiceController(this._ref);

  final Ref _ref;

  /// Calls `<domain>.<service>` targeting [entityId]. Domain is derived from the
  /// entity_id prefix unless [domainOverride] is given.
  Future<void> call(
    String entityId,
    String service, {
    String? domainOverride,
    Map<String, dynamic>? data,
  }) async {
    final IHAConnection connection;
    try {
      connection = _ref.read(serverScopeConnectionProvider);
    } catch (error, stackTrace) {
      if (_isServerScopeConnectionUnavailable(error)) {
        throw const RemoteCommandUnavailableException();
      }
      _throwOriginalError(error, stackTrace);
    }

    final domain = domainOverride ?? entityId.split('.').first;
    await HomeAssistantApi.fromConnection(connection).services.call(
      domain: domain,
      service: service,
      target: HATarget(entityIds: [entityId]),
      serviceData: data,
    );
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

class RemoteCommandUnavailableException implements Exception {
  const RemoteCommandUnavailableException();

  @override
  String toString() => 'Remote entity commands are unavailable offline.';
}

@Riverpod(dependencies: [serverScopeConnection])
EntityServiceController entityServiceController(Ref ref) {
  return EntityServiceController(ref);
}
