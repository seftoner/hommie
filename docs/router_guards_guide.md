# Route Guards Documentation

## Overview

Hommie uses `go_router_guards` to manage navigation rules through a composable, testable guard system. Guards encapsulate routing logic and determine whether navigation should proceed, redirect, or block.

## Architecture

### Guard Hierarchy

```
AppGuard (Composed)
├── BootReadyGuard
├── ServerConfiguredGuard
└── AuthGuard
```

All three guards must pass for navigation to protected routes to succeed. Guards are evaluated sequentially, and the first failing guard determines the redirect destination.

## Available Guards

### BootReadyGuard

Ensures the application has completed its boot sequence.

```dart
class BootReadyGuard extends RouteGuard {
  const BootReadyGuard(this.ref);
  final Ref ref;
  
  // Redirects to /startup if boot not ready
}
```

**Checks:**
- Boot status is `BootReady`
- Not in loading or error state

**Redirects:**
- → `/startup` if boot incomplete

### ServerConfiguredGuard

Ensures an active server is configured.

```dart
class ServerConfiguredGuard extends RouteGuard {
  const ServerConfiguredGuard(this.ref);
  final Ref ref;
  
  // Redirects to /discovery if no server
}
```

**Checks:**
- Active server exists
- Server ID is not null
- Not in loading or error state

**Redirects:**
- → `/startup` if loading/error
- → `/discovery` if no server

### AuthGuard

Ensures the user is authenticated.

```dart
class AuthGuard extends RouteGuard {
  const AuthGuard(this.ref);
  final Ref ref;
  
  // Redirects based on auth state
}
```

**Checks:**
- Authentication state
- Special handling for authenticated users on onboarding pages

**Redirects:**
- → `/startup` if initial/authenticating
- → `/discovery` if unauthenticated/revoked/failure
- → `/home` if authenticated but on onboarding pages

### AppGuard (Composed)

Combines all guards using `guardAll`.

```dart
class AppGuard extends RouteGuard {
  AppGuard(this.ref)
      : _composedGuard = guardAll([
          BootReadyGuard(ref),
          ServerConfiguredGuard(ref),
          AuthGuard(ref),
        ]);
}
```

## Router Configuration

The router uses `ConditionalGuard` to apply guards to all routes except public ones:

```dart
GoRouter(
  routes: $appRoutes,
  redirect: ConditionalGuard(
    guard: AppGuard(ref),
    excludedPaths: [
      '/startup',
      '/discovery',
      '/manualAddres',
    ],
  ).toRedirect(),
)
```

## Public Routes (Excluded from Guards)

These routes are accessible without passing guard checks:

- `/startup` - Boot/initialization screen
- `/discovery` - Server discovery
- `/manualAddres` - Manual server entry

## Creating New Guards

### Basic Guard Structure

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_guards/go_router_guards.dart';

class MyCustomGuard extends RouteGuard {
  const MyCustomGuard(this.ref);
  
  final Ref ref;

  @override
  FutureOr<void> onNavigation(
    NavigationResolver resolver,
    BuildContext context,
    GoRouterState state,
  ) {
    // Read state from providers
    final someState = ref.read(someProvider);
    
    // Check condition
    if (someState.isValid) {
      resolver.next(); // Allow navigation
    } else {
      resolver.redirect('/fallback'); // Redirect
    }
  }
}
```

### Guard Actions

Guards use `NavigationResolver` to control navigation:

```dart
// Allow navigation to proceed
resolver.next();

// Redirect to a different route
resolver.redirect('/other-route');

// Block navigation (rare, not currently used)
resolver.block();
```

### Adding a Guard to the Chain

1. Create your guard in `lib/router/guards/`
2. Add it to `AppGuard`:

```dart
class AppGuard extends RouteGuard {
  AppGuard(this.ref)
      : _composedGuard = guardAll([
          BootReadyGuard(ref),
          ServerConfiguredGuard(ref),
          AuthGuard(ref),
          MyCustomGuard(ref), // Add here
        ]);
}
```

## Guard Composition

### All Guards Must Pass (AND)

```dart
final strictGuard = guardAll([
  Guard1(ref),
  Guard2(ref),
  Guard3(ref),
]);
```

All guards must call `resolver.next()` for navigation to proceed.

### At Least One Guard Must Pass (OR)

```dart
final flexibleGuard = guardAnyOf([
  PremiumUserGuard(ref),
  AdminGuard(ref),
], fallbackRedirect: '/upgrade');
```

If all guards fail, redirects to `fallbackRedirect`.

### Exactly One Guard Must Pass (XOR)

```dart
final exclusiveGuard = guardOneOf([
  DevelopmentModeGuard(ref),
  ProductionAccessGuard(ref),
], fallbackRedirect: '/error');
```

## Testing Guards

### Unit Test Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('BootReadyGuard', () {
    late Ref mockRef;
    late BootReadyGuard guard;
    
    setUp(() {
      mockRef = MockRef();
      guard = BootReadyGuard(mockRef);
    });
    
    test('redirects to /startup when boot not ready', () async {
      // Arrange
      when(mockRef.read(bootStatusControllerProvider))
          .thenReturn(const AsyncLoading());
      
      final resolver = MockNavigationResolver();
      final context = MockBuildContext();
      final state = MockGoRouterState();
      
      // Act
      await guard.onNavigation(resolver, context, state);
      
      // Assert
      verify(resolver.redirect('/startup')).called(1);
    });
    
    test('allows navigation when boot ready', () async {
      // Arrange
      when(mockRef.read(bootStatusControllerProvider))
          .thenReturn(const AsyncData(BootReady()));
      
      final resolver = MockNavigationResolver();
      final context = MockBuildContext();
      final state = MockGoRouterState();
      
      // Act
      await guard.onNavigation(resolver, context, state);
      
      // Assert
      verify(resolver.next()).called(1);
    });
  });
}
```

## Best Practices

### 1. Single Responsibility
Each guard should check one concern (boot, server, auth, etc.).

### 2. Early Returns
Structure guards to handle failure cases first, then success.

```dart
if (!isValid) {
  resolver.redirect('/error');
} else {
  resolver.next();
}
```

### 3. Error Handling
Handle async errors gracefully:

```dart
try {
  final result = await checkSomething();
  result ? resolver.next() : resolver.redirect('/error');
} catch (error) {
  resolver.redirect('/error');
}
```

### 4. State Access
Always use `ref.read()` in guards, never `ref.watch()`.

```dart
// ✅ Correct
final state = ref.read(myProvider);

// ❌ Wrong - don't use watch in guards
final state = ref.watch(myProvider);
```

### 5. Avoid Side Effects
Guards should only read state and make navigation decisions. Don't modify state in guards.

## Debugging

### Enable Router Logging

```dart
GoRouter(
  debugLogDiagnostics: true, // Shows guard execution in console
  routes: $appRoutes,
  redirect: ConditionalGuard(...).toRedirect(),
)
```

### Common Issues

**Guards not executing:**
- Check if route is in `excludedPaths`
- Verify guard is added to composition

**Infinite redirects:**
- Ensure redirect targets are in `excludedPaths`
- Check for circular redirect logic

**Guards executing multiple times:**
- Normal behavior when providers change
- Use `ref.listen()` in router provider for reactivity

## References

- [go_router_guards Documentation](https://guards.aquiles.dev/)
- [Project Router Code](../lib/router/router.dart)
- [Guard Implementations](../lib/router/guards/)
