import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/reconnection_service.dart';
import 'package:hommie/services/networking/server_connection_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_controller.g.dart';

//TODO: Revise this
@riverpod
class AppController extends _$AppController {
  @override
  Future<void> build() async {
    final authRepository = ref.read(authRepositoryProvider);
    final connectionStateNotifier = ref.watch(connectionStateProvider.notifier);
    final reconnectionService = ref.watch(reconnectionServiceProvider.notifier);

    final isLoggedIn = await authRepository.isLoggedIn();

    if (isLoggedIn) {
      final connection = await ref.read(serverConnectionProvider.future);
    }

    return;
  }
}
