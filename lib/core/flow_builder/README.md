# Flow Builder

Declarative linear flow builder for Flutter with go_router and Riverpod integration.

## Overview

Flow Builder provides a type-safe, declarative way to create linear user flows in Flutter. Perfect for onboarding, multi-step forms, wizards, and authentication flows.

## Versions

### V1 (Current/Stable)
- **Files:** `flow_blueprint.dart`, `flow_controller.dart`, `flow_shell.dart`, `flow_navigation.dart`
- **Status:** Stable, in production use
- **Use for:** Existing flows that work fine
- **Documentation:** [flow_builder.md](../../../docs/flow_builder.md)

### V2 (New/Recommended)
- **Files:** `flow_blueprint_v2.dart`, `flow_controller_v2.dart`, `flow_shell_v2.dart`
- **Status:** Complete, tested, ready for adoption
- **Use for:** All new flows
- **Documentation:** 
  - [Complete Guide](../../../docs/flow_builder_v2.md)
  - [Quick Start](../../../docs/flow_builder_v2_quick_start.md)
  - [V1 vs V2 Comparison](../../../docs/flow_builder_v1_vs_v2_comparison.md)
  - [Summary](../../../docs/flow_builder_v2_summary.md)

## Quick Example (V2)

```dart
// Define flow
FlowBlueprintV2 onboardingFlow() {
  return FlowBlueprintV2(
    id: 'onboarding',
    presentation: FlowPresentationStyle.card,
    steps: [
      FlowRouteStepV2(
        id: 'welcome',
        label: 'Welcome',
        pageBuilder: (context, flowContext) => WelcomePage(),
      ),
      FlowActionStepV2(
        id: 'setup',
        label: 'Setting up...',
        showLoading: true,
        loadingMessage: 'Configuring your account...',
        action: (ctx) async => await setupAccount(ctx),
      ),
    ],
    onFinish: (ctx) async => HomeRoute().go(ctx.navigationContext!),
  );
}

// Start flow
Future<void> startOnboarding(WidgetRef ref) async {
  await ref.read(flowControllerV2Provider.notifier).start(onboardingFlow());
}

// In your page
ElevatedButton(
  onPressed: () {
    ref.read(flowControllerV2Provider.notifier).completeStep(
      output: {'userName': nameController.text},
    );
  },
  child: const Text('Next'),
)
```

## Why V2?

**56% less boilerplate:**
```dart
// V1: ~80 lines
FlowRoutePass + helpers + flow definition + start function

// V2: ~35 lines
Just flow definition + start function
```

**Better features:**
- ✅ No FlowRoutePass complexity
- ✅ No route duplication (inline pages)
- ✅ Built-in loading states
- ✅ Built-in progress tracking
- ✅ Clear navigation API (jumpTo, back)
- ✅ 4 presentation modes (fullscreen, card, sheet, inline)

**Same compatibility:**
- ✅ Works with go_router
- ✅ Works with Riverpod
- ✅ Type-safe
- ✅ Testable

## Key Concepts

### Flow
A sequence of steps that guide users through a task.

### Steps
- **RouteStep**: Navigate to a page
- **ActionStep**: Execute background work
- **BranchStep**: Conditional paths (V2 only)

### Context
Shared data between steps. Use `ctx.write()` to store and `ctx.readValue()` to retrieve.

### Presentation Styles (V2)
- **fullscreen**: Takes over entire screen
- **card**: Centered card (great for onboarding)
- **sheet**: Bottom sheet on mobile, card on desktop
- **inline**: Embedded in navigation hierarchy

## Common Patterns

### Pattern: Multi-step Form
```dart
FlowBlueprintV2(
  steps: [
    FlowRouteStepV2(id: 'step1', pageBuilder: ...), // Enter name
    FlowRouteStepV2(id: 'step2', pageBuilder: ...), // Enter email
    FlowRouteStepV2(id: 'step3', pageBuilder: ...), // Enter password
    FlowActionStepV2(id: 'submit', action: ...), // Create account
  ],
)
```

### Pattern: Conditional Step
```dart
FlowRouteStepV2(
  id: 'premium-only',
  canEnter: (ctx) async {
    return ctx.readValue<bool>('isPremium') ?? false;
  },
  pageBuilder: ...,
)
```

### Pattern: Loading Action
```dart
FlowActionStepV2(
  id: 'sync',
  showLoading: true,
  loadingMessage: 'Syncing data...',
  action: (ctx) async {
    await syncWithServer();
  },
)
```

### Pattern: Branching (V2)
```dart
FlowBranchStepV2(
  id: 'choose-path',
  selector: (ctx) => ctx.readValue<String>('mode') ?? 'auto',
  branches: {
    'auto': [FlowRouteStepV2(id: 'auto-setup', ...)],
    'manual': [FlowRouteStepV2(id: 'manual-setup', ...)],
  },
)
```

## Navigation API (V2)

```dart
final controller = ref.read(flowControllerV2Provider.notifier);

// Start flow
await controller.start(myFlow());

// Start from specific step (deep linking)
await controller.start(myFlow(), startAtStep: 'step2');

// Complete current step
await controller.completeStep(output: {'key': 'value'});

// Navigate
await controller.jumpTo('step-id');
await controller.back();

// Cancel
await controller.cancel();
```

## Testing

```dart
test('flow completes successfully', () async {
  final container = ProviderContainer();
  final controller = container.read(flowControllerV2Provider.notifier);
  
  await controller.start(testFlow());
  await controller.completeStep(output: {'data': 'test'});
  
  final state = container.read(flowControllerV2Provider);
  expect(state, isA<FlowCompletedV2>());
});
```

## Migration from V1

V1 and V2 coexist peacefully. No need to migrate everything:

1. **Keep V1** where it works
2. **Use V2** for new flows
3. **Migrate V1** flows when you modify them (optional)

See [V1 vs V2 Comparison](../../../docs/flow_builder_v1_vs_v2_comparison.md) for details.

## File Structure

```
flow_builder/
├── README.md                   # This file
├── flow_navigation.dart        # Shared navigation wrapper
├── flow_blueprint.dart         # V1 core types
├── flow_controller.dart        # V1 state management
├── flow_shell.dart             # V1 UI components
├── flow_blueprint_v2.dart      # V2 core types
├── flow_controller_v2.dart     # V2 state management
└── flow_shell_v2.dart          # V2 UI components
```

## Examples

### Real-world V2 Examples
- [Server Flows V2](../../../lib/features/auth/application/flows/server_flows_v2.dart)
  - Onboarding flow (card presentation)
  - Add server flow (fullscreen presentation)
  - Inline page builder example
  - Branching example

### Real-world V1 Examples
- [Server Flows V1](../../../lib/features/auth/application/flows/server_flows.dart)
  - Current production flows

## Documentation

### V2 (Recommended)
- 📖 [Complete Guide](../../../docs/flow_builder_v2.md) - Comprehensive reference
- 🚀 [Quick Start](../../../docs/flow_builder_v2_quick_start.md) - 5-minute tutorial
- 🆚 [V1 vs V2](../../../docs/flow_builder_v1_vs_v2_comparison.md) - Detailed comparison
- 📊 [Summary](../../../docs/flow_builder_v2_summary.md) - Implementation overview

### V1 (Current)
- 📖 [Flow Builder](../../../docs/flow_builder.md) - Original documentation
- 📖 [Implementation](../../../docs/flow_builder_implementation.md) - V1 details

## Best Practices

### ✅ DO
- Use V2 for new flows
- Add step labels for progress tracking
- Use loading states for operations > 1 second
- Validate data before `completeStep()`
- Handle errors in action steps
- Keep flows linear (use branching sparingly)

### ❌ DON'T
- Don't nest flows
- Don't forget error handling
- Don't skip validation
- Don't mutate context directly (use `write()`)
- Don't use complex non-serializable data in context

## Help & Support

**Having issues?**
1. Check the [Quick Start Guide](../../../docs/flow_builder_v2_quick_start.md)
2. Review [Examples](../../../lib/features/auth/application/flows/server_flows_v2.dart)
3. See [Common Patterns](../../../docs/flow_builder_v2.md#advanced-patterns)

**Want to contribute?**
See the main [Development Workflow](../../../docs/development_workflow.md)

## License

Part of the Hommie project - GPL-3.0 License
