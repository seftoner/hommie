import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_guards/go_router_guards.dart';
import 'package:hommie/app/boot/boot_status.dart';
import 'package:hommie/app/boot/boot_status_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Guard that ensures the application has completed its boot sequence
/// before allowing navigation to protected routes.
///
/// This guard checks the [BootStatus] and redirects to the startup screen
/// if the boot process is not complete or has failed.
@Dependencies([BootStatusController])
class BootReadyGuard extends RouteGuard {
  const BootReadyGuard(this.ref);

  final Ref ref;

  @override
  FutureOr<void> onNavigation(
    NavigationResolver resolver,
    BuildContext context,
    GoRouterState state,
  ) {
    final bootStatus = ref.read(bootStatusControllerProvider);

    final bootValue = switch (bootStatus) {
      AsyncData(:final value) => value,
      AsyncLoading() || AsyncError() => null,
    };

    // If boot is not ready, redirect to startup
    if (bootValue == null || bootValue is! BootReady) {
      resolver.redirect('/startup');
    } else {
      // Boot is ready, continue navigation
      resolver.next();
    }
  }
}
