# Flow Builder V2 - Enhanced API

## Overview

Flow Builder V2 is an enhanced declarative API for building linear user flows in Flutter, inspired by iOS/Android navigation patterns. It provides excellent DX with better type safety, flexible presentation modes, and seamless integration with go_router and Riverpod.

## Key Improvements Over V1

### 1. **No Route Pass Complexity**
- ❌ V1: Required `FlowRoutePass` to map steps to different routes
- ✅ V2: Steps directly reference routes OR use inline page builders

### 2. **Better Navigation Control**
- ❌ V1: Unclear how to navigate between steps within a flow
- ✅ V2: Built-in `jumpTo()`, `back()`, and navigation within flow context

### 3. **Flexible Presentation**
- ❌ V1: Limited to `FlowShellSize.fullscreen` or `FlowShellSize.constrainedCard`
- ✅ V2: Multiple presentation styles (fullscreen, card, sheet, inline)

### 4. **Loading States**
- ❌ V1: No built-in loading indicators for actions
- ✅ V2: `FlowActionStepV2` supports `showLoading` and `loadingMessage`

### 5. **Progress Tracking**
- ❌ V1: No built-in progress tracking
- ✅ V2: Built-in progress indicators with step labels

### 6. **Better DX**
- ❌ V1: Verbose API with manual route pass management
- ✅ V2: Clean, declarative API with sensible defaults

## Core Concepts

### Presentation Styles

Inspired by iOS `UIModalPresentationStyle`:

```dart
enum FlowPresentationStyle {
  fullscreen,  // Takes over entire screen (like UIModalPresentationStyleFullScreen)
  card,        // Centered card on desktop/tablet (like UIModalPresentationStyleFormSheet)
  sheet,       // Bottom sheet on mobile, card on desktop (like UIModalPresentationStylePageSheet)
  inline,      // Embedded in existing navigation hierarchy
}
```

### Navigation Modes

```dart
enum RouteNavigationMode {
  replace,  // Replaces current route (go_router's go)
  push,     // Pushes onto stack (go_router's push)
}
```

## Step Types

### 1. FlowRouteStepV2 - Navigation Steps

Navigate to a page using either typed routes or inline page builders:

```dart
// Using typed route (recommended for type safety)
FlowRouteStepV2(
  id: 'discovery',
  label: 'Discover Server',
  routeBuilder: (ctx) => const OnboardingDiscoveryRouteData(),
  mode: RouteNavigationMode.replace,
)

// Using inline page builder (avoids route duplication)
FlowRouteStepV2(
  id: 'discovery',
  label: 'Discover Server',
  pageBuilder: (context, flowContext) {
    return const ServerDiscoveryPage();
  },
)
```

**When to use each approach:**

- **routeBuilder**: Use when you want deep linking, browser back button support, and type-safe routes
- **pageBuilder**: Use when the same page is used in multiple flows and you want to avoid route duplication

### 2. FlowActionStepV2 - Background Actions

Execute actions with optional loading indicators:

```dart
FlowActionStepV2(
  id: 'login',
  label: 'Authenticating',
  showLoading: true,
  loadingMessage: 'Connecting to your Home Assistant...',
  autoComplete: true,  // Automatically advance when done
  action: (ctx) async {
    final address = ctx.expectValue<String>('serverAddress');
    await ctx.read(authFlowControllerProvider.notifier).login(address);
  },
)
```

### 3. FlowBranchStepV2 - Conditional Paths

Create branching logic based on runtime conditions:

```dart
FlowBranchStepV2(
  id: 'setup-branch',
  label: 'Setup',
  selector: (ctx) {
    final method = ctx.readValue<String>('setupMethod');
    return method ?? 'discovery';
  },
  branches: {
    'discovery': [
      FlowRouteStepV2(id: 'discovery', ...),
    ],
    'manual': [
      FlowRouteStepV2(id: 'manual-entry', ...),
    ],
  },
)
```

## Complete Example: Server Onboarding Flow

```dart
FlowBlueprintV2 onboardingServerFlow() {
  return FlowBlueprintV2(
    id: 'onboarding-server',
    description: 'Initial authentication experience',
    
    // Card presentation for focused, non-intrusive experience
    presentation: FlowPresentationStyle.card,
    
    // Optional shell path for route scoping
    shellPath: '/onboarding',
    
    steps: [
      // Step 1: Discovery page
      FlowRouteStepV2(
        id: 'discovery',
        label: 'Discover Server',
        routeBuilder: (ctx) => const OnboardingDiscoveryRouteData(),
      ),
      
      // Step 2: Manual entry (if user chooses)
      FlowRouteStepV2(
        id: 'manual-entry',
        label: 'Enter Address',
        routeBuilder: (ctx) => const OnboardingManualEntryRouteData(),
      ),
      
      // Step 3: Login action with loading
      FlowActionStepV2(
        id: 'login',
        label: 'Authenticating',
        showLoading: true,
        loadingMessage: 'Connecting to your Home Assistant...',
        action: (ctx) async {
          final address = ctx.expectValue<String>('serverAddress');
          await ctx.read(authFlowControllerProvider.notifier).login(address);
        },
      ),
    ],
    
    // Navigate to home on success
    onFinish: (ctx) async {
      final context = ctx.navigationContext;
      if (context != null) {
        const HomeRouteData().go(context);
      }
    },
    
    // Handle cancellation
    onCancel: (ctx) async {
      // Cleanup logic
    },
  );
}
```

## Flow Control

### Starting a Flow

```dart
Future<void> startOnboardingFlow(WidgetRef ref) async {
  await ref
      .read(flowControllerV2Provider.notifier)
      .start(onboardingServerFlow());
}

// Start from a specific step (deep linking)
Future<void> resumeOnboarding(WidgetRef ref) async {
  await ref
      .read(flowControllerV2Provider.notifier)
      .start(
        onboardingServerFlow(),
        startAtStep: 'manual-entry',
        initialData: {'previousAttempt': true},
      );
}
```

### Completing Steps

```dart
// From within a page in the flow
Future<void> onServerSelected(WidgetRef ref, String address) async {
  final flowState = ref.read(flowControllerV2Provider);
  
  if (flowState is FlowActiveV2) {
    // Complete current step and pass data to next step
    await ref.read(flowControllerV2Provider.notifier)
        .completeStep(output: {'serverAddress': address});
  }
}
```

### Navigation Within Flow

```dart
// Jump to a specific step
await ref.read(flowControllerV2Provider.notifier).jumpTo('manual-entry');

// Go back to previous step
await ref.read(flowControllerV2Provider.notifier).back();

// Cancel the flow
await ref.read(flowControllerV2Provider.notifier).cancel();
```

## UI Integration

### Using FlowShellV2

```dart
@TypedShellRoute<OnboardingFlowShellRouteData>(
  routes: [
    TypedGoRoute<OnboardingDiscoveryRouteData>(path: '/onboarding/discovery'),
    TypedGoRoute<OnboardingManualEntryRouteData>(path: '/onboarding/manual-entry'),
  ],
)
class OnboardingFlowShellRouteData extends ShellRouteData {
  const OnboardingFlowShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return FlowShellV2(
      presentation: FlowPresentationStyle.card,
      showProgress: true,
      showBackButton: true,
      onBackPressed: () {
        // Handle back navigation
        final container = ProviderScope.containerOf(context);
        container.read(flowControllerV2Provider.notifier).back();
      },
      child: navigator,
    );
  }
}
```

### Responding to Flow State

```dart
class MyFlowAwarePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlowStateBuilder(
      onIdle: () => StartFlowButton(),
      onActive: (snapshot, isLoading) {
        if (isLoading) {
          return LoadingIndicator();
        }
        return FlowContent(snapshot: snapshot);
      },
      onCompleted: (blueprint) => SuccessMessage(),
      onFailed: (error, stackTrace) => ErrorMessage(error),
    );
  }
}
```

## Comparison with iOS/Android Patterns

### iOS UINavigationController Equivalent

```dart
// iOS: Push view controller
navigationController.pushViewController(vc, animated: true)

// Flutter Flow V2: Push route step
FlowRouteStepV2(
  id: 'details',
  routeBuilder: (ctx) => const DetailsRoute(),
  mode: RouteNavigationMode.push,
)
```

### iOS UIModalPresentationStyle Equivalent

```dart
// iOS: Present modally
vc.modalPresentationStyle = .formSheet
present(vc, animated: true)

// Flutter Flow V2: Card presentation
FlowBlueprintV2(
  presentation: FlowPresentationStyle.card,
  ...
)
```

### Android Navigation Component Equivalent

```dart
// Android: Navigate with data
findNavController().navigate(
  R.id.detailsFragment,
  bundleOf("itemId" to itemId)
)

// Flutter Flow V2: Complete step with data
flowController.completeStep(output: {'itemId': itemId})
```

## Advanced Patterns

### Conditional Step Entry

```dart
FlowRouteStepV2(
  id: 'premium-features',
  label: 'Premium Features',
  routeBuilder: (ctx) => const PremiumRoute(),
  canEnter: (ctx) {
    final isPremium = ctx.readValue<bool>('isPremium') ?? false;
    return isPremium;
  },
)
```

### Step Lifecycle Hooks

```dart
FlowRouteStepV2(
  id: 'settings',
  routeBuilder: (ctx) => const SettingsRoute(),
  onEnter: (ctx) async {
    // Initialize step
    print('Entering settings step');
  },
  onExit: (ctx) async {
    // Cleanup
    print('Exiting settings step');
  },
)
```

### Complex Data Flow

```dart
FlowBlueprintV2(
  steps: [
    FlowRouteStepV2(
      id: 'input',
      routeBuilder: (ctx) => const InputRoute(),
    ),
    FlowActionStepV2(
      id: 'process',
      action: (ctx) async {
        // Read data from previous step
        final input = ctx.expectValue<String>('userInput');
        
        // Process it
        final result = await processData(input);
        
        // Store for next step
        ctx.write('processedResult', result);
      },
    ),
    FlowRouteStepV2(
      id: 'result',
      routeBuilder: (ctx) {
        // Use processed data in route
        final result = ctx.expectValue<String>('processedResult');
        return ResultRoute(data: result);
      },
    ),
  ],
)
```

## Migration from V1

### Before (V1)
```dart
final FlowRoutePass _onboardingRoutePass = FlowRoutePass(
  discoveryRoute: (_) => const OnboardingDiscoveryRouteData(),
  manualEntryRoute: (_) => const OnboardingManualEntryRouteData(),
);

FlowBlueprint onboardingFlow(FlowNavigator navigator) {
  return FlowBlueprint(
    id: 'onboarding',
    steps: [
      const FlowRouteStep(
        id: 'discover-or-enter',
        routeBuilder: _discoverRoute,
      ),
      // ...
    ],
  );
}

Future<void> startFlow(WidgetRef ref) async {
  final navigator = ref.read(flowNavigatorProvider);
  await ref.read(flowControllerProvider.notifier).start(
    onboardingFlow(navigator),
    initialData: {_routePassKey: _onboardingRoutePass},
  );
}
```

### After (V2)
```dart
FlowBlueprintV2 onboardingFlow() {
  return FlowBlueprintV2(
    id: 'onboarding',
    presentation: FlowPresentationStyle.card,
    steps: [
      FlowRouteStepV2(
        id: 'discovery',
        label: 'Discover Server',
        routeBuilder: (ctx) => const OnboardingDiscoveryRouteData(),
      ),
      // ...
    ],
  );
}

Future<void> startFlow(WidgetRef ref) async {
  await ref
      .read(flowControllerV2Provider.notifier)
      .start(onboardingFlow());
}
```

## Best Practices

1. **Use `routeBuilder` for main paths**: When you need deep linking and type safety
2. **Use `pageBuilder` to avoid duplication**: When the same UI is used in multiple flows
3. **Add labels to steps**: Enables progress tracking and better UX
4. **Use loading states**: For actions that take time (API calls, etc.)
5. **Handle errors gracefully**: Use `onCancel` and error states appropriately
6. **Keep flows linear**: Use `FlowBranchStepV2` sparingly
7. **Test with deep linking**: Start flows at different steps during development

## Benefits

### Developer Experience
- ✅ Clear, declarative API
- ✅ No route pass complexity
- ✅ Type-safe with Riverpod annotations
- ✅ Built-in navigation within flows
- ✅ Easy to understand and maintain

### User Experience
- ✅ Smooth transitions between steps
- ✅ Built-in progress tracking
- ✅ Loading states for long operations
- ✅ Flexible presentation modes
- ✅ Native-feeling navigation

### Compatibility
- ✅ Works with go_router and go_router_builder
- ✅ Integrates with Riverpod codegen
- ✅ Supports deep linking
- ✅ Compatible with browser navigation

## Testing

```dart
test('flow completes successfully', () async {
  final container = ProviderContainer();
  
  final controller = container.read(flowControllerV2Provider.notifier);
  
  // Start flow
  await controller.start(testFlow());
  
  // Verify first step is active
  final state1 = container.read(flowControllerV2Provider);
  expect(state1, isA<FlowActiveV2>());
  expect((state1 as FlowActiveV2).snapshot.step.id, 'step1');
  
  // Complete step
  await controller.completeStep(output: {'data': 'test'});
  
  // Verify flow progressed
  final state2 = container.read(flowControllerV2Provider);
  expect((state2 as FlowActiveV2).snapshot.step.id, 'step2');
});
```

## Summary

Flow Builder V2 provides a bulletproof, flexible solution for linear flows in Flutter apps, inspired by battle-tested iOS and Android patterns. It offers excellent DX, works seamlessly with go_router and Riverpod, and supports multiple presentation modes for different use cases.
