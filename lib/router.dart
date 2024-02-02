import 'package:go_router/go_router.dart';
import 'package:hommie/ui/screens/login_page/login_page.dart';

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
