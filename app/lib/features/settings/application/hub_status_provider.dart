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

enum HubConnectionStatusKind {
  online,
  connecting,
  authRevoked,
  offline,
  noActive,
}

@freezed
sealed class HubConnectionStatus with _$HubConnectionStatus {
  const factory HubConnectionStatus({
    required HubConnectionStatusKind kind,
    required String label,
    required String description,
    required Server? server,
  }) = _HubConnectionStatus;
}

@freezed
sealed class HubStatusState with _$HubStatusState {
  const factory HubStatusState({
    required HubConnectionStatus connectionStatus,
    required AuthState authState,
    required String deviceName,
  }) = _HubStatusState;
}

extension HubStatusStateX on HubStatusState {
  Server? get server => connectionStatus.server;

  bool get isOnline => connectionStatus.kind == HubConnectionStatusKind.online;
  bool get isOffline =>
      connectionStatus.kind == HubConnectionStatusKind.offline;
}

@Riverpod(dependencies: [ActiveServerSession, authState, deviceInfoRepository])
Future<HubStatusState> hubStatus(Ref ref) async {
  final sessionState = ref.watch(activeServerSessionProvider);
  final authState = await ref.watch(authStateProvider.future);
  final deviceName = await ref
      .read(deviceInfoRepositoryProvider)
      .getDeviceName();

  return HubStatusState(
    connectionStatus: _mapConnectionStatus(sessionState),
    authState: authState,
    deviceName: deviceName,
  );
}

HubConnectionStatus _mapConnectionStatus(ActiveServerSessionState state) {
  switch (state) {
    case OnlineServerSession(:final activeServer):
      return HubConnectionStatus(
        kind: HubConnectionStatusKind.online,
        label: 'Connected',
        description: 'Connected to Home Assistant',
        server: activeServer,
      );
    case ConnectingServerSession(:final activeServer):
      return HubConnectionStatus(
        kind: HubConnectionStatusKind.connecting,
        label: 'Connecting',
        description: 'Connecting to server...',
        server: activeServer,
      );
    case ResolvingServerSession():
      return const HubConnectionStatus(
        kind: HubConnectionStatusKind.connecting,
        label: 'Connecting',
        description: 'Connecting to server...',
        server: null,
      );
    case AuthRevokedServerSession(:final activeServer):
      return HubConnectionStatus(
        kind: HubConnectionStatusKind.authRevoked,
        label: 'Auth failure',
        description: 'Authentication required',
        server: activeServer,
      );
    case OfflineServerSession(:final activeServer):
      return HubConnectionStatus(
        kind: HubConnectionStatusKind.offline,
        label: 'Disconnected',
        description: 'Not connected to server',
        server: activeServer,
      );
    case NoActiveServerSession():
      return const HubConnectionStatus(
        kind: HubConnectionStatusKind.noActive,
        label: 'Unknown',
        description: 'Connection status unknown',
        server: null,
      );
  }
}
