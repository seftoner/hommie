import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/home/infrastructure/providers/device_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cached_devices_provider.g.dart';

/// Reactive list of cached Home Assistant device registry rows for the active
/// server.
@Riverpod(dependencies: [serverScopeId])
Stream<List<Device>> cachedDevices(Ref ref) {
  final serverId = ref.watch(serverScopeIdProvider);
  return ref.watch(deviceRepositoryProvider).watchByServer(serverId);
}
