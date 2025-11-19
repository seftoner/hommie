import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/router/routes.dart';

/// Thin wrapper around GoRouter navigation that defers to the root navigator.
class FlowNavigator {
  FlowNavigator({GlobalKey<NavigatorState>? navigatorKey})
      : navigatorKey = navigatorKey ?? rootKey;

  final GlobalKey<NavigatorState> navigatorKey;

  /// Current navigation context if available.
  BuildContext? get context => navigatorKey.currentContext;

  /// Navigate to a route using `go`, replacing the current location.
  Future<void> goTo(GoRouteData route) async {
    final ctx = context;
    if (ctx == null) return;
    route.go(ctx);
  }

  /// Push a route onto the navigator stack (useful for optional detours inside a flow).
  Future<void> push(GoRouteData route) async {
    final ctx = context;
    if (ctx == null) return;
    await route.push<void>(ctx);
  }
}
