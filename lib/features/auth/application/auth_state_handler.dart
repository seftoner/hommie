import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/router/routes.dart';

part 'auth_state_handler.g.dart';

@Riverpod(keepAlive: true)
class AuthStateHandler extends _$AuthStateHandler {
  @override
  FutureOr<void> build() async {
    ref.listen(authControllerProvider, (_, next) {
      if (next.value == null) return;

      final router = ref.read(goRouterProvider);

      switch (next.value) {
        case Initial():
          break;
        case Authenticated():
          router.go(HomeRouteData().location);
          break;
        case Unauthenticated():
          router.go(DicoveryRoute().location);
          break;
        case Failure():
          // _handleFailure(next.value as Failure);
          break;
        default:
          break;
      }
    });

    await ref.read(authControllerProvider.notifier).initialize();
  }

  // Future<void> _handleFailure(Failure failure) async {
  //   if (failure.failure.isTokenExpired) {
  //     await ref.read(authControllerProvider.notifier).signOut();
  //   }
  // }
}
