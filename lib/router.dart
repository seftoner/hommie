import 'package:go_router/go_router.dart';
import 'package:hommie/features/auth/presentation/screens/login_page.dart';

class ScreenPaths {
  static String login = "/login";
}

final appRouter = GoRouter(initialLocation: ScreenPaths.login, routes: [
  GoRoute(
      path: ScreenPaths.login,
      builder: (context, state) {
        return LoginPage();
      }),
]);
