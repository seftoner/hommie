import 'package:hommie/features/home/domain/repositories/i_device_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/websocket_device_repository.dart';
import 'package:hommie/services/networking/server_connection_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'websocket_device_repository_provider.g.dart';

/// Provides WebSocket-based device repository for a specific server
///
/// This fetches device data directly from Home Assistant via WebSocket API
/// Use this when you need real-time device data from a specific server
@Riverpod(dependencies: [serverConnection])
Future<IDeviceRepository> websocketDeviceRepository(
  Ref ref,
  int serverId,
) async {
  final connection = await ref.watch(serverConnectionProvider(serverId).future);
  return WebSocketDeviceRepository(connection);
}
