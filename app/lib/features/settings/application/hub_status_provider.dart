import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/settings/infrastructure/providers/device_info_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hub_status_provider.freezed.dart';
part 'hub_status_provider.g.dart';

@freezed
sealed class HubStatusState with _$HubStatusState {
  const factory HubStatusState({
    required Server? server,
    required HAServerConnectionState connectionState,
    required AuthState authState,
    required String deviceName,
  }) = _HubStatusState;
}

@riverpod
Future<HubStatusState> hubStatus(Ref ref) async {
  final server = await ref.watch(activeServerProvider.future);
  final connectionState = ref.watch(serverConnectionStateProvider);
  final authState = await ref.watch(authStateProvider.future);
  final deviceName = await ref
      .read(deviceInfoRepositoryProvider)
      .getDeviceName();

  return HubStatusState(
    server: server,
    connectionState: connectionState,
    authState: authState,
    deviceName: deviceName,
  );
}
