import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
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
    final session = _ref.read(activeServerSessionProvider);
    if (session is! OnlineServerSession) {
      throw ConnectionClosedError('Home Assistant connection is offline.');
    }

    final domain = domainOverride ?? entityId.split('.').first;
    await HACommands.callService(
      session.connection,
      domain: domain,
      service: service,
      target: entityId,
      serviceData: data,
    );
  }
}

@Riverpod(dependencies: [ActiveServerSession])
EntityServiceController entityServiceController(Ref ref) {
  return EntityServiceController(ref);
}
