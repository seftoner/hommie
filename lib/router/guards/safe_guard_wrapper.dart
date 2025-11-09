import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_guards/go_router_guards.dart';

/// A wrapper that safely executes redirect logic only when the router
/// is mounted in the widget tree.
///
/// This prevents [FlutterError] during cold start when [GoRouter.of(context)]
/// is called before the router widget is attached to the tree.
///
/// Usage:
/// ```dart
/// GoRouter(
///   redirect: safeRedirect((context, state) {
///     // Your redirect logic here
///     return '/some-path';
///   }),
/// )
/// ```
GoRouterRedirect safeRedirect(GoRouterRedirect redirectFn) {
  return (BuildContext context, GoRouterState state) {
    // Check if router is mounted by attempting to access it
    // If not mounted, allow navigation to continue (return null)
    try {
      GoRouter.of(context);
      // Router is mounted, execute the redirect logic
      return redirectFn(context, state);
      // ignore: avoid_catching_errors
    } on FlutterError catch (_) {
      // Router not yet mounted - allow navigation to initial location
      // The redirect will run again after router mounts via router.refresh()
      return null;
    } on RouterNotMountedException catch (_) {
      return null;
    }
  };
}
