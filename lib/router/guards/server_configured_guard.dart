import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_guards/go_router_guards.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Guard that ensures an active server is configured before allowing
/// navigation to protected routes.
///
/// This guard checks if an active server exists and redirects to the
/// discovery page if no server is configured or if the server state
/// is loading/error.
@Dependencies([ActiveServer])
class ServerConfiguredGuard extends RouteGuard {
  const ServerConfiguredGuard(this.ref);

  final Ref ref;

  @override
  FutureOr<void> onNavigation(
    NavigationResolver resolver,
    BuildContext context,
    GoRouterState state,
  ) {
    final activeServer = ref.read(activeServerProvider);

    // If server is loading or has error, stay on current page or redirect to startup
    if (activeServer.isLoading || activeServer.hasError) {
      resolver.redirect('/startup');
    } else {
      final serverId = activeServer.asData?.value?.id;

      // If no server is configured, redirect to discovery
      if (serverId == null) {
        resolver.redirect('/discovery');
      } else {
        // Server is configured, continue navigation
        resolver.next();
      }
    }
  }
}
