# Flow Builder V1 vs V2 Comparison

## Side-by-Side Comparison

### Problem 1: Route Duplication

#### V1 Approach ❌
```dart
// Need separate route classes for same UI in different shells
@TypedGoRoute<OnboardingDiscoveryRouteData>(path: '/onboarding/discovery')
class OnboardingDiscoveryRouteData extends GoRouteData {
  const OnboardingDiscoveryRouteData();
  
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ServerDiscoveryPage(); // Same page
  }
}

@TypedGoRoute<AddServerDiscoveryRouteData>(path: '/settings/servers/add/discovery')
class AddServerDiscoveryRouteData extends GoRouteData {
  const AddServerDiscoveryRouteData();
  
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ServerDiscoveryPage(); // Same page, different route!
  }
}

// Need FlowRoutePass to map flows to routes
final FlowRoutePass _onboardingRoutePass = FlowRoutePass(
  discoveryRoute: (_) => const OnboardingDiscoveryRouteData(),
  manualEntryRoute: (_) => const OnboardingManualEntryRouteData(),
);

final FlowRoutePass _addServerRoutePass = FlowRoutePass(
  discoveryRoute: (_) => const AddServerDiscoveryRouteData(),
  manualEntryRoute: (_) => const AddServerManualEntryRouteData(),
);
```

**Issues:**
- ❌ Duplication: 4 route classes for 2 pages
- ❌ Complexity: Manual route pass management
- ❌ Error-prone: Easy to forget updating route passes
- ❌ Maintenance burden: More boilerplate

#### V2 Solution ✅
```dart
// Option 1: Use typed routes when you need them
FlowBlueprintV2(
  id: 'onboarding',
  shellPath: '/onboarding', // Scopes routes automatically
  steps: [
    FlowRouteStepV2(
      id: 'discovery',
      routeBuilder: (ctx) => const OnboardingDiscoveryRouteData(),
    ),
  ],
)

// Option 2: Use inline pages to avoid duplication
FlowBlueprintV2(
  id: 'onboarding',
  steps: [
    FlowRouteStepV2(
      id: 'discovery',
      pageBuilder: (context, flowContext) {
        return const ServerDiscoveryPage(); // Direct page reference!
      },
    ),
  ],
)
```

**Benefits:**
- ✅ No duplication: One page definition
- ✅ Simpler: No route pass needed
- ✅ Flexible: Choose typed routes OR inline pages
- ✅ Less boilerplate

### Problem 2: Unclear Navigation

#### V1 Approach ❌
```dart
// How do I navigate from discovery to manual entry?
// Not clear from the API

// In server_flows.dart:
GoRouteData manualEntryRouteForContext(FlowContext context) =>
    _requirePass(context).manualEntryRoute(context);

// User has to understand FlowRoutePass internals
```

**Issues:**
- ❌ Not obvious how to navigate between steps
- ❌ No built-in back navigation
- ❌ No jump-to-step support
- ❌ Requires understanding FlowRoutePass

#### V2 Solution ✅
```dart
// Clear API for navigation
final controller = ref.read(flowControllerV2Provider.notifier);

// Navigate to specific step
await controller.jumpTo('manual-entry');

// Go back
await controller.back();

// Complete current step and advance
await controller.completeStep(output: {'data': value});

// Cancel flow
await controller.cancel();
```

**Benefits:**
- ✅ Clear, discoverable API
- ✅ Built-in back navigation
- ✅ Jump to any step
- ✅ Intuitive method names

### Problem 3: No Loading States

#### V1 Approach ❌
```dart
FlowActionStep(
  id: 'login',
  action: (ctx) async {
    // Long-running operation
    // No built-in way to show loading
    await ctx.read(authFlowControllerProvider.notifier).login(address);
  },
)

// User sees nothing while action runs
```

**Issues:**
- ❌ No loading indicators
- ❌ Poor UX for long operations
- ❌ Manual overlay management needed

#### V2 Solution ✅
```dart
FlowActionStepV2(
  id: 'login',
  showLoading: true,
  loadingMessage: 'Connecting to your Home Assistant...',
  action: (ctx) async {
    await ctx.read(authFlowControllerProvider.notifier).login(address);
  },
)
```

**Benefits:**
- ✅ Built-in loading overlay
- ✅ Custom loading messages
- ✅ Better UX
- ✅ No manual management

### Problem 4: Limited Presentation Options

#### V1 Approach ❌
```dart
enum FlowShellSize {
  fullscreen,
  constrainedCard,
}

// Only 2 options, no flexibility
```

**Issues:**
- ❌ Only 2 presentation modes
- ❌ No responsive design (sheet on mobile, card on desktop)
- ❌ No inline option

#### V2 Solution ✅
```dart
enum FlowPresentationStyle {
  fullscreen,  // Full takeover
  card,        // Centered card
  sheet,       // Bottom sheet on mobile, card on desktop
  inline,      // Embedded in navigation hierarchy
}

FlowBlueprintV2(
  id: 'onboarding',
  presentation: FlowPresentationStyle.card,
  steps: [...],
)
```

**Benefits:**
- ✅ 4 presentation modes
- ✅ Responsive design
- ✅ Inspired by iOS UIModalPresentationStyle
- ✅ More flexibility

### Problem 5: No Progress Tracking

#### V1 Approach ❌
```dart
// No built-in progress tracking
// User has to implement manually
```

**Issues:**
- ❌ No progress indicators
- ❌ User doesn't know where they are
- ❌ Poor UX for multi-step flows

#### V2 Solution ✅
```dart
FlowShellV2(
  showProgress: true,
  child: navigator,
)

// Automatically shows:
// [=====>      ] 2/5
// "Authenticate"
```

**Benefits:**
- ✅ Built-in progress bar
- ✅ Step counter
- ✅ Current step label
- ✅ Automatic calculation

### Problem 6: Verbose API

#### V1 Complete Example ❌
```dart
// Define route pass
final FlowRoutePass _onboardingRoutePass = FlowRoutePass(
  discoveryRoute: (_) => const OnboardingDiscoveryRouteData(),
  manualEntryRoute: (_) => const OnboardingManualEntryRouteData(),
);

// Define helper
FlowRoutePass _requirePass(FlowContext context) =>
    context.expectValue<FlowRoutePass>(_routePassKey);

// Define route builder
GoRouteData _discoverRoute(FlowContext context) =>
    _requirePass(context).discoveryRoute(context);

// Define flow with navigator parameter
@Dependencies([AuthFlowController])
FlowBlueprint onboardingServerFlow(FlowNavigator navigator) {
  return FlowBlueprint(
    id: 'onboarding-server',
    steps: [
      const FlowRouteStep(
        id: 'discover-or-enter',
        routeBuilder: _discoverRoute,
      ),
      // ...
    ],
  );
}

// Start flow with manual setup
@Dependencies([AuthFlowController])
Future<void> startOnboardingServerFlow(WidgetRef ref) async {
  final navigator = ref.read(flowNavigatorProvider);
  await ref.read(flowControllerProvider.notifier).start(
    onboardingServerFlow(navigator),
    initialData: {_routePassKey: _onboardingRoutePass},
  );
}
```

**Lines of code: ~40**

#### V2 Complete Example ✅
```dart
@Dependencies([AuthFlowController])
FlowBlueprintV2 onboardingServerFlow() {
  return FlowBlueprintV2(
    id: 'onboarding-server',
    presentation: FlowPresentationStyle.card,
    steps: [
      FlowRouteStepV2(
        id: 'discovery',
        label: 'Discover Server',
        routeBuilder: (ctx) => const OnboardingDiscoveryRouteData(),
      ),
      FlowActionStepV2(
        id: 'login',
        label: 'Authenticating',
        showLoading: true,
        loadingMessage: 'Connecting...',
        action: (ctx) async {
          final address = ctx.expectValue<String>('serverAddress');
          await ctx.read(authFlowControllerProvider.notifier).login(address);
        },
      ),
    ],
  );
}

@Dependencies([AuthFlowController])
Future<void> startOnboardingServerFlow(WidgetRef ref) async {
  await ref
      .read(flowControllerV2Provider.notifier)
      .start(onboardingServerFlow());
}
```

**Lines of code: ~25 (37.5% reduction)**

**Benefits:**
- ✅ 37.5% less code
- ✅ No manual route pass
- ✅ No navigator parameter
- ✅ Clearer intent
- ✅ Less to maintain

## Feature Comparison Table

| Feature | V1 | V2 |
|---------|----|----|
| Route duplication | ❌ Yes | ✅ Optional |
| Route pass needed | ❌ Yes | ✅ No |
| Loading states | ❌ Manual | ✅ Built-in |
| Progress tracking | ❌ Manual | ✅ Built-in |
| Back navigation | ❌ Manual | ✅ Built-in |
| Jump to step | ❌ No | ✅ Yes |
| Deep linking | ✅ Yes | ✅ Yes |
| Presentation modes | 2 | 4 |
| Step labels | ❌ No | ✅ Yes |
| Lifecycle hooks | Partial | ✅ Full (onEnter, onExit, canEnter) |
| Branching | ❌ No | ✅ Yes |
| Inline pages | ❌ No | ✅ Yes |
| Type safety | ✅ Yes | ✅ Yes |
| Riverpod integration | ✅ Yes | ✅ Yes |
| go_router integration | ✅ Yes | ✅ Yes |

## When to Use Each

### Use V1 When:
- ✅ You have existing flows and don't need new features
- ✅ You're comfortable with the current API
- ✅ You don't need loading states or progress tracking

### Use V2 When:
- ✅ Starting a new flow
- ✅ Need loading indicators
- ✅ Want progress tracking
- ✅ Need better navigation control
- ✅ Want to avoid route duplication
- ✅ Prefer cleaner, more declarative API

## Migration Path

V1 and V2 can coexist! No need to migrate everything at once.

### Step 1: Use V2 for new flows
```dart
// New flows use V2
FlowBlueprintV2 newFlow() { ... }
```

### Step 2: Gradually migrate existing flows
```dart
// When you need to modify an existing flow,
// consider upgrading it to V2
```

### Step 3: Keep V1 where it works
```dart
// If a V1 flow works fine, leave it alone
// V1 will continue to be supported
```

## API Compatibility

Both versions use the same underlying navigation system, so they're fully compatible:

```dart
// V1 and V2 can coexist
final v1Controller = ref.read(flowControllerProvider);
final v2Controller = ref.read(flowControllerV2Provider);

// Both work with the same navigator
final navigator = ref.read(flowNavigatorProvider);
```

## Summary

**V2 Advantages:**
- ✅ **37.5% less boilerplate**
- ✅ **No route duplication**
- ✅ **Better UX** (loading, progress)
- ✅ **Better DX** (clear navigation API)
- ✅ **More flexible** (4 presentation modes)
- ✅ **More powerful** (branching, jump to step)

**Migration Strategy:**
- ✅ **Non-breaking** - V1 continues to work
- ✅ **Gradual** - Migrate flows one at a time
- ✅ **Optional** - No pressure to migrate if V1 works for you

**Recommendation:**
Use V2 for all new flows. Consider migrating V1 flows when you need to modify them, but there's no urgency.
