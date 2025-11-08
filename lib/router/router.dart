import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/app/boot/boot_status.dart';
import 'package:hommie/app/boot/boot_status_provider.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/active_auth_state_provider.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/router/routes.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [BootStatusController, ActiveServer, activeAuthState],
)
GoRouter goRouter(Ref ref) {
  final router = GoRouter(
    navigatorKey: rootKey,
    initialLocation: const StartupRoute().location,
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final startupLocation = const StartupRoute().location;
      final discoveryLocation = const DiscoveryRoute().location;
      final manualAddressLocation = const EnterAddressRoute().location;
      final onboardingLocations = {discoveryLocation, manualAddressLocation};

      final bootStatus = ref.read(bootStatusControllerProvider);

      // Use pattern matching for boot status
      final bootValue = switch (bootStatus) {
        AsyncData(:final value) => value,
        AsyncLoading() || AsyncError() => null,
      };

      if (bootValue == null || bootValue is! BootReady) {
        return location == startupLocation ? null : startupLocation;
      }

      final activeServer = ref.read(activeServerProvider);
      if (activeServer.isLoading) {
        return location == startupLocation ? null : startupLocation;
      }

      if (activeServer.hasError) {
        return location == startupLocation ? null : startupLocation;
      }

      final serverId = activeServer.asData?.value?.id;
      if (serverId == null) {
        if (onboardingLocations.contains(location)) {
          return null;
        }
        return discoveryLocation;
      }

      final authState = ref.read(activeAuthStateProvider);
      if (authState.isLoading) {
        return location == startupLocation ? null : startupLocation;
      }

      if (authState.hasError) {
        return onboardingLocations.contains(location)
            ? null
            : discoveryLocation;
      }

      final authValue = authState.asData?.value;
      if (authValue == null) {
        return location == startupLocation ? null : startupLocation;
      }

      return authValue.when<String?>(
        initial: () => location == startupLocation ? null : startupLocation,
        unauthenticated: () =>
            onboardingLocations.contains(location) ? null : discoveryLocation,
        authenticating: () =>
            location == startupLocation ? null : startupLocation,
        authenticated: (_) {
          if (location == startupLocation ||
              onboardingLocations.contains(location)) {
            return const HomeRouteData().location;
          }
          return null;
        },
        refreshing: (_) => null,
        revoked: (_) =>
            onboardingLocations.contains(location) ? null : discoveryLocation,
        failure: (_) =>
            onboardingLocations.contains(location) ? null : discoveryLocation,
      );
    },
  );

  var disposed = false;

  void refreshRouter(_, __) {
    if (!disposed) {
      router.refresh();
    }
  }

  ref
    ..onDispose(() {
      disposed = true;
      router.dispose();
    })
    ..listen<AsyncValue<BootStatus>>(
      bootStatusControllerProvider,
      refreshRouter,
    )
    ..listen<AsyncValue<Server?>>(activeServerProvider, refreshRouter)
    ..listen<AsyncValue<AuthState>>(activeAuthStateProvider, refreshRouter);

  return router;
}
