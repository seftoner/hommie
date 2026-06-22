import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_service_controller.g.dart';

/// Single generic path for entity operations: calls an HA service on an entity.
class EntityServiceController {
  final IHAConnection _connection;

  EntityServiceController(this._connection);

  /// Calls `<domain>.<service>` targeting [entityId]. Domain is derived from the
  /// entity_id prefix unless [domainOverride] is given.
  Future<void> call(
    String entityId,
    String service, {
    String? domainOverride,
    Map<String, dynamic>? data,
  }) async {
    final domain = domainOverride ?? entityId.split('.').first;
    await HACommands.callService(
      _connection,
      domain: domain,
      service: service,
      target: entityId,
      serviceData: data,
    );
  }
}

@Riverpod(dependencies: [serverScopeConnection])
EntityServiceController entityServiceController(Ref ref) {
  final connection = ref.watch(serverScopeConnectionProvider);
  return EntityServiceController(connection);
}
