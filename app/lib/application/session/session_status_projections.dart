import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_status_projections.g.dart';

@Riverpod(dependencies: [ActiveServerSession])
bool offlineBannerVisibility(Ref ref) {
  final session = ref.watch(activeServerSessionProvider);
  return session is OfflineServerSession || session is ConnectingServerSession;
}

@Riverpod(dependencies: [ActiveServerSession])
bool homeConnectionLoading(Ref ref) {
  final session = ref.watch(activeServerSessionProvider);
  return session is ConnectingServerSession ||
      session is ResolvingServerSession;
}
