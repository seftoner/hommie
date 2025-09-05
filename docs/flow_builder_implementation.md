# Flow Builder Implementation Summary

## Overview

The Flow Builder system has been successfully implemented as a declarative linear flow builder on top of go_router + go_router_builder and Riverpod 3. The system allows creating linear user flows with typed route integration, deep linking support, and comprehensive error handling.

## Core Components

### 1. Flow Definition (`lib/core/flow/flow_definition.dart`)

**Key Classes:**
- `FlowContext`: Provides access to Riverpod providers and flow data storage
- `RouteStep<T>`: Typed step that builds GoRouteData with optional lifecycle hooks
- `FlowDefinition`: Container for flow name and steps
- `FlowState`: Sealed class hierarchy representing flow states (Idle, InStep, Done, Error)

**Features:**
- Type-safe route generation using go_router_builder
- Optional `canProceed` validation before navigation
- Optional `onEnter` lifecycle hook for step initialization
- Context data passing between steps

### 2. Flow Runner (`lib/core/flow/flow_runner.dart`)

**Implementation:** `FlowRunnerNotifier` extends `_$FlowRunnerNotifier` (generated)

**Key Methods:**
- `start(FlowDefinition, {String? startAt})`: Begins flow execution with optional deep linking
- `next()`: Advances to next step with validation
- `back()`: Returns to previous step
- `cancel()`: Terminates flow and returns to idle state

**Features:**
- Automatic error handling with toast notifications
- Deep linking support via `startAt` parameter
- State persistence during flow execution
- Integration with GoRouter for navigation

### 3. Toast Service (`lib/core/flow/toast_service.dart`)

**Interface:** `ToastService` with `show(String message)` method

**Implementations:**
- `ScaffoldToastService`: Production implementation using ScaffoldMessenger
- `DebugToastService`: Debug implementation using debugPrint

**Features:**
- Abstracted user messaging system
- Easy testing with fake implementations
- Integration with existing Flutter messaging patterns

### 4. Flow Providers (`lib/core/flow/flow_providers.dart`)

**Generated Providers:**
- `flowRunnerProvider`: Access to FlowRunner instance (uses DI)
- `flowStateProvider`: Access to current flow state (uses DI)
- `toastServiceProvider`: Access to toast service

**Features:**
- Automatic router injection via `goRouterProvider`
- Clean API without manual parameter passing
- Riverpod 3 codegen integration
- Easy dependency injection and testing

### 5. Usage Example (`lib/core/flow/flow_example.dart`)

Demonstrates real-world usage with existing project routes:
- `FlowExample.addServerFlow`: Complete flow using DicoveryRoute → EnterAddressRoute → AddServerRouteData
- `FlowExamplePage`: UI integration example
- `FlowAwarePage`: Shows flow state awareness

## Testing Strategy

### Unit Tests (`test/core/flow/flow_definition_test.dart`)

**Comprehensive coverage of:**
- FlowDefinition creation and step management
- FlowState hierarchy and equality
- RouteStep configuration and callbacks
- Toast service implementations

**Testing Approach:**
- Isolated component testing
- Minimal dependencies
- Focus on core logic validation

### Provider Tests (`test/core/flow/flow_providers_test.dart`)

**Coverage of:**
- Provider creation and dependency injection
- Toast service overrides for testing
- Router-scoped provider instances

## Integration with Existing Project

### Router Integration

The flow builder integrates seamlessly with the existing typed route system using the correct go_router_builder pattern:

```dart
// Existing routes with proper go_router_builder pattern using mixins
@TypedGoRoute<DicoveryRoute>(path: '/discovery')
class DicoveryRoute extends GoRouteData with $DicoveryRoute { ... }

// Sample flow routes following the same pattern
@TypedGoRoute<ChooseModeRoute>(path: '/choose')
class ChooseModeRoute extends GoRouteData with $ChooseModeRoute { ... }

// Flow definition using existing routes
final addServerFlow = FlowDefinition(
  name: 'addServer',
  steps: [
    RouteStep<DicoveryRoute>(
      id: 'discovery',
      toRoute: (ctx) => const DicoveryRoute(),
    ),
    // ... more steps
  ],
);
```

### State Management

Follows project patterns with Riverpod 3:
- Uses `@riverpod` codegen annotations
- Extends generated notifier classes
- Integrates with existing provider ecosystem

### Error Handling

Leverages existing ScaffoldMessenger system:
- Consistent with project's user messaging approach
- Easy to test with service abstraction
- Graceful error recovery with toast notifications

## Key Benefits

1. **Type Safety**: Full type safety through go_router_builder integration
2. **Deep Linking**: Built-in support for starting flows at any step
3. **Linear Flows**: Enforced linear progression with validation
4. **Error Handling**: Comprehensive error handling with user feedback
5. **Testing**: Fully testable with provider overrides and fake services
6. **Scalability**: Router-scoped instances allow multiple concurrent flows
7. **Integration**: Seamless integration with existing project architecture

## Usage Patterns

### Basic Flow Creation

```dart
final myFlow = FlowDefinition(
  name: 'myFlow',
  steps: [
    RouteStep<Step1Route>(
      id: 'step1',
      toRoute: (ctx) => Step1Route(),
      onEnter: (ctx) async {
        // Initialize step
      },
    ),
    RouteStep<Step2Route>(
      id: 'step2',
      toRoute: (ctx) => Step2Route(
        data: ctx.get<String>('step1Data'),
      ),
      canProceed: (ctx) {
        return ctx.get<bool>('isValid') ?? false;
      },
    ),
  ],
);
```

### Starting a Flow

```dart
// Start from beginning
await ref.read(flowRunnerProvider).start(myFlow);

// Start from specific step (deep linking)
await ref.read(flowRunnerProvider).start(myFlow, startAt: 'step2');
```

### Flow State Monitoring

```dart
final flowState = ref.watch(flowStateProvider);
switch (flowState) {
  case FlowIdle():
    return StartFlowButton();
  case FlowInStep(stepId: final stepId):
    return FlowProgressIndicator(stepId);
  case FlowDone():
    return FlowCompletionMessage();
  case FlowError(error: final error):
    return ErrorMessage(error.toString());
}
```

## Development Notes

- **Build Runner**: Generated code requires `dart run build_runner build` after changes
- **Testing**: Use provider overrides for toast service in tests
- **Error Handling**: All errors are caught and converted to FlowError state with toast notification
- **Memory**: In-memory state only - flows reset on app restart (by design)
- **Router Scope**: Each GoRouter instance gets its own flow state

## Implementation Status

✅ **Complete Implementation**
- Core flow definition types and interfaces
- FlowRunner with full lifecycle management
- Toast service with ScaffoldMessenger integration
- Riverpod provider setup with codegen and DI
- Comprehensive unit tests
- Usage examples with existing routes
- Code generation successful
- Integration ready

## API Improvements

The flow builder API has been optimized to use proper Riverpod dependency injection:

**Previous API (verbose):**
```dart
final router = ref.watch(goRouterProvider);
final runner = ref.read(flowRunnerProvider(router));
final flowState = ref.watch(flowStateProvider(router));
```

**Current API (clean):**
```dart
final runner = ref.read(flowRunnerProvider);
final flowState = ref.watch(flowStateProvider);
```

**Benefits:**
- Cleaner, more intuitive API
- Proper Riverpod dependency injection
- Consistent with project patterns
- Easier testing with provider overrides
- Reduced boilerplate code

This implementation provides a solid foundation for building linear user flows in the Flutter application while maintaining type safety, testability, and integration with the existing architecture.
