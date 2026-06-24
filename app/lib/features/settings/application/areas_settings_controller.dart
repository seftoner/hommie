import 'dart:async';

import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/home/application/area_registry_sync_service.dart';
import 'package:hommie/features/settings/application/areas_settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_settings_controller.g.dart';

@Riverpod(dependencies: [ActiveServerSession, areaRegistrySyncService])
class AreasSettingsController extends _$AreasSettingsController {
  @override
  FutureOr<void> build() {}

  Future<void> create(String name) {
    return _run((api) => api.areas.create(name: name.trim()));
  }

  Future<void> rename({required String areaId, required String name}) {
    return _run((api) => api.areas.rename(areaId: areaId, name: name.trim()));
  }

  Future<void> delete({required String areaId}) {
    return _run((api) => api.areas.delete(areaId: areaId));
  }

  Future<void> _run(
    Future<Object?> Function(HomeAssistantApi api) command,
  ) async {
    final keepAlive = ref.keepAlive();
    final session = ref.read(activeServerSessionProvider);
    try {
      if (session case OnlineServerSession(
        :final activeServer,
        :final connection,
      ) when activeServer.id != null) {
        state = const AsyncLoading();
        try {
          final refreshService = ref.read(areaRegistrySyncServiceProvider);
          final api = HomeAssistantApi.fromConnection(connection);
          await command(api);
          await refreshService.refresh(
            serverId: activeServer.id!,
            connection: connection,
          );
          if (ref.mounted) {
            state = const AsyncData(null);
          }
        } catch (error, stackTrace) {
          final failure = AreasSettingsCommandFailure(error);
          if (ref.mounted) {
            state = AsyncError(failure, stackTrace);
          }
          throw failure;
        }
        return;
      }

      const failure = AreasSettingsUnavailable();
      if (ref.mounted) {
        state = AsyncError(failure, StackTrace.current);
      }
      throw failure;
    } finally {
      keepAlive.close();
    }
  }
}
