# Router Boot Flow & Navigation Architecture

## Overview

This document explains how Hommie handles app initialization, router mounting, and navigation guards to avoid timing issues while ensuring the correct route is displayed based on app state.

## The Problem

**`RouterNotMountedException`** occurs when navigation guards try to access the router before it's mounted in the Flutter widget tree. This is a common issue with complex boot sequences where:
- Guards need to check async state (servers, auth)
- Router initialization happens before async boot completes
- Guards execute during router creation (not after mounting)

## The Solution

### 1. Boot-First Approach

**Key Principle**: Complete all async initialization *before* guards evaluate conditions.

```dart
@Riverpod(keepAlive: true, dependencies: [ActiveServer])
class BootStatusController extends _$BootStatusController {
  @override
  Future<BootStatus> build() async {
    // Warm up all state needed by guards
    await serverManager.getAvailableServers();
    await ref.read(activeServerProvider.future);
    return const BootStatus.ready();
  }
}
```

**Why this works**: By the time guards run (triggered by router refresh), all state is available synchronously.

### 2. Excluded Initial Route

**Key Principle**: Start at a "safe" route that bypasses guards.

```dart
GoRouter(
  initialLocation: const StartupRoute().location,
  redirect: ConditionalGuard(
    guard: guardAll([...]),
    excludedPaths: [
      const StartupRoute().location,
      const DiscoveryRoute().location,
      const EnterAddressRoute().location,
    ],
  ).toRedirect(),
)
```

**Why this works**: Initial navigation to `/startup` doesn't trigger guards, avoiding the "router not mounted" error.

### 3. Reactive Router Refresh

**Key Principle**: Listen to state changes and trigger guard re-evaluation.

```dart
ref
  ..listen<AsyncValue<BootStatus>>(
    bootStatusControllerProvider,
    refreshRouter,
  )
  ..listen<AsyncValue<Server?>>(activeServerProvider, refreshRouter)
  ..listen<AsyncValue<AuthState>>(activeAuthStateProvider, refreshRouter);
```

**Why this works**: When boot completes or state changes, guards re-evaluate and redirect to the correct location.

## Navigation Flow States

### State 1: Initial Load
```
/startup → AppStartup (loading) → Boot process runs
```
- **Guards**: Skipped (excluded path)
- **User sees**: Loading spinner
- **Duration**: ~1-2 seconds

### State 2: Boot Complete, No Server
```
BootStatus.ready() → Router refresh → ServerConfiguredGuard fails → /discovery
```
- **Guards**: Run synchronously (state is ready)
- **User sees**: Server discovery page
- **Next**: User adds server → navigate to auth flow

### State 3: Boot Complete, Server Configured, Not Authenticated
```
BootStatus.ready() → Router refresh → AuthGuard fails → /discovery
```
- **Guards**: BootReady ✅, Server ✅, Auth ❌
- **User sees**: Auth flow (discovery/OAuth)
- **Next**: User authenticates → navigate to /home

### State 4: Boot Complete, Fully Configured
```
BootStatus.ready() → Router refresh → All guards pass → /home
```
- **Guards**: All pass ✅
- **User sees**: Home page (or last location)
- **Next**: Normal app navigation

## Guard Architecture

### BootReadyGuard

**Purpose**: Ensure boot process completed before accessing protected routes.

```dart
class BootReadyGuard extends RouteGuard {
  @override
  FutureOr<void> onNavigation(...) {
    final bootStatus = ref.read(bootStatusControllerProvider);
    
    if (bootStatus is AsyncData && bootStatus.value is BootReady) {
      resolver.next();
    } else {
      resolver.redirect('/startup');
    }
  }
}
```

**Triggers redirect when**:
- Boot is loading
- Boot failed
- Boot not started

### ServerConfiguredGuard

**Purpose**: Ensure an active server is selected before accessing HA-dependent features.

```dart
class ServerConfiguredGuard extends RouteGuard {
  @override
  FutureOr<void> onNavigation(...) {
    final activeServer = ref.read(activeServerProvider);
    
    if (activeServer is AsyncData && activeServer.value?.id != null) {
      resolver.next();
    } else {
      resolver.redirect('/discovery');
    }
  }
}
```

**Triggers redirect when**:
- No server configured
- Server state is loading/error

### AuthGuard

**Purpose**: Ensure user is authenticated with Home Assistant.

```dart
class AuthGuard extends RouteGuard {
  @override
  FutureOr<void> onNavigation(...) {
    final authState = ref.read(activeAuthStateProvider);
    
    switch (authState.asData?.value) {
      case Authenticated():
      case Refreshing():
        resolver.next();
      case Unauthenticated():
      case Revoked():
        resolver.redirect('/discovery');
      case Initial():
      case Authenticating():
        resolver.redirect('/startup');
    }
  }
}
```

**Triggers redirect when**:
- User not authenticated
- Auth token revoked
- Auth is in progress

## Best Practices

### ✅ Do

1. **Complete async work in boot**: Load all required state before declaring boot ready
2. **Use excluded paths**: Routes that don't need guards should be excluded
3. **Listen to state changes**: Use router refresh to re-evaluate guards
4. **Read state synchronously in guards**: Don't use `await` in guards - state should be ready
5. **Show loading UI**: Display appropriate feedback during boot/transitions

### ❌ Don't

1. **Run async operations in guards**: Guards should be synchronous checks
2. **Access router context too early**: Let the boot process complete first
3. **Assume initial state is ready**: Always start at a safe route like `/startup`
4. **Forget to exclude setup routes**: Discovery, manual entry, etc. should bypass guards
5. **Block forever**: Provide retry mechanisms for boot failures

## Testing Considerations

### Unit Tests

Test guards independently:

```dart
test('BootReadyGuard redirects when boot not ready', () async {
  final container = ProviderContainer(
    overrides: [
      bootStatusControllerProvider.overrideWith((_) => const AsyncLoading()),
    ],
  );
  
  final guard = BootReadyGuard(container);
  // ... test redirect behavior
});
```

### Integration Tests

Test full flows:

```dart
testWidgets('App navigates to discovery when no server', (tester) async {
  // Given: No server configured
  // When: App launches and boot completes
  // Then: Should navigate to /discovery
});
```

## Debugging Tips

### Router Not Mounting

**Symptom**: `RouterNotMountedException` in logs

**Check**:
1. Is initial location an excluded path?
2. Are guards trying to access router during initialization?
3. Is `MaterialApp.router` properly configured?

### Infinite Redirect Loop

**Symptom**: Rapid navigation between routes, stack overflow

**Check**:
1. Do guards have consistent logic?
2. Is state properly initialized before guards run?
3. Are excluded paths configured correctly?

### Guards Not Running

**Symptom**: Routes accessible when they shouldn't be

**Check**:
1. Is router refresh triggered on state changes?
2. Are listeners properly configured?
3. Is `ConditionalGuard` with `guardAll` used?

### State Not Ready

**Symptom**: Guards fail even when state should be ready

**Check**:
1. Is boot process awaiting all necessary futures?
2. Are providers using `keepAlive: true`?
3. Is state hydrated before `BootStatus.ready()`?

## Future Enhancements

### 1. Deep Link Handling

Preserve intended destination during boot/auth flow:

```dart
// Save intended location
final intendedLocation = state.matchedLocation;

// After auth completes, navigate to intended location
context.go(intendedLocation);
```

### 2. Progressive Boot

Show partial UI while loading non-critical data:

```dart
class BootStatus {
  const factory BootStatus.partial({
    required bool serversReady,
    required bool authReady,
  }) = BootPartial;
}
```

### 3. Error Recovery

More granular error handling per boot step:

```dart
class BootFailure {
  final BootStep failedStep;
  final Object error;
  
  bool get canRetry => failedStep.isRetryable;
}
```

### 4. Performance Monitoring

Track boot performance metrics:

```dart
final bootDuration = stopwatch.elapsed;
analytics.log('boot_completed', duration: bootDuration);
```

## Related Documentation

- [Router Guards Guide](./router_guards_guide.md)
- [Development Workflow](./development_workflow.md)
- [Flutter Riverpod Architecture](./flutter_riverpod_architecture_plan.md)
