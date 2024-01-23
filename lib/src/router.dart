import 'package:go_router/go_router.dart';

import 'screens/login_page/LoginPage.dart';

class ScreenPaths {
  static String login = "/login";
}

final appRouter = GoRouter(initialLocation: ScreenPaths.login, routes: [
  GoRoute(
      path: ScreenPaths.login,
      builder: (context, state) {
        return const LoginPage();
      }),
]);
