import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_guards/go_router_guards.dart';
import 'package:hommie/features/auth/application/active_auth_state_provider.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Guard that ensures the user is authenticated before allowing
/// navigation to protected routes.
///
/// This guard checks the authentication state and redirects based on:
/// - Unauthenticated/Revoked/Failure → `/discovery`
/// - Initial/Authenticating → `/startup`
/// - Authenticated/Refreshing → Allow navigation
@Dependencies([activeAuthState])
class AuthGuard extends RouteGuard {
  const AuthGuard(this.ref);

  final Ref ref;

  @override
  FutureOr<void> onNavigation(
    NavigationResolver resolver,
    BuildContext context,
    GoRouterState state,
  ) {
    final authState = ref.read(activeAuthStateProvider);
    final location = state.matchedLocation;

    // If auth state is loading, redirect to startup
    if (authState.isLoading) {
      resolver.redirect('/startup');
    } else if (authState.hasError) {
      // If auth state has error, redirect to discovery
      resolver.redirect('/discovery');
    } else {
      final authValue = authState.asData?.value;

      // If auth value is null, redirect to startup
      if (authValue == null) {
        resolver.redirect('/startup');
      } else {
        // Check auth state and redirect accordingly using pattern matching
        switch (authValue) {
          case Initial():
          case Authenticating():
            resolver.redirect('/startup');
          case Unauthenticated():
          case Revoked():
          case Failure():
            resolver.redirect('/discovery');
          case Authenticated():
          case Refreshing():
            // If authenticated but on startup/onboarding pages, redirect to home
            if (location == '/startup' ||
                location == '/discovery' ||
                location == '/manualAddres') {
              resolver.redirect('/home');
            } else {
              resolver.next();
            }
        }
      }
    }
  }
}
