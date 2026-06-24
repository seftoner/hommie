import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/home/application/areas_for_server_provider.dart';
import 'package:hommie/features/settings/application/areas_settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_server_areas_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [ActiveServerSession, areasForServer])
Future<ActiveServerAreasState> activeServerAreas(Ref ref) async {
  final session = ref.watch(activeServerSessionProvider);
  final server = session.server;
  final serverId = server?.id;
  if (serverId == null) {
    return const ActiveServerAreasState(
      areas: [],
      canEdit: false,
      hasActiveServer: false,
    );
  }

  final areas = await ref.watch(areasForServerProvider(serverId).future);
  return ActiveServerAreasState(
    areas: [...areas]..sort((a, b) => a.name.compareTo(b.name)),
    canEdit: session is OnlineServerSession,
    hasActiveServer: true,
  );
}
