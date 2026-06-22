import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/settings/infrastructure/providers/device_info_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hub_status_provider.freezed.dart';
part 'hub_status_provider.g.dart';

@freezed
sealed class HubStatusState with _$HubStatusState {
  const factory HubStatusState({
    required ActiveServerSessionState sessionState,
    required AuthState authState,
    required String deviceName,
  }) = _HubStatusState;
}

extension HubStatusStateX on HubStatusState {
  Server? get server => sessionState.server;

  bool get isOnline => sessionState is OnlineServerSession;
  bool get isOffline => sessionState is OfflineServerSession;
}

@Riverpod(dependencies: [ActiveServerSession, authState, deviceInfoRepository])
Future<HubStatusState> hubStatus(Ref ref) async {
  final sessionState = ref.watch(activeServerSessionProvider);
  final authState = await ref.watch(authStateProvider.future);
  final deviceName = await ref
      .read(deviceInfoRepositoryProvider)
      .getDeviceName();

  return HubStatusState(
    sessionState: sessionState,
    authState: authState,
    deviceName: deviceName,
  );
}
