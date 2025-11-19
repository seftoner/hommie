# Flow Builder V2 - Quick Start Guide

## 5-Minute Tutorial

### Basic Concepts

A **Flow** is a sequence of steps that guide users through a task:
- **Steps** can be pages (navigation) or actions (background work)
- **Context** passes data between steps
- **Presentation** controls how the flow appears (fullscreen, card, etc.)

### Your First Flow

Let's create a simple 3-step user registration flow.

#### Step 1: Define the Flow

```dart
import 'package:hommie/core/flow_builder/flow_blueprint_v2.dart';

FlowBlueprintV2 registrationFlow() {
  return FlowBlueprintV2(
    id: 'registration',
    description: 'User registration flow',
    presentation: FlowPresentationStyle.card,
    steps: [
      // Step 1: Enter name
      FlowRouteStepV2(
        id: 'enter-name',
        label: 'Enter Name',
        pageBuilder: (context, flowContext) {
          return const EnterNamePage();
        },
      ),
      
      // Step 2: Enter email
      FlowRouteStepV2(
        id: 'enter-email',
        label: 'Enter Email',
        pageBuilder: (context, flowContext) {
          return const EnterEmailPage();
        },
      ),
      
      // Step 3: Create account (action with loading)
      FlowActionStepV2(
        id: 'create-account',
        label: 'Creating Account',
        showLoading: true,
        loadingMessage: 'Setting up your account...',
        action: (ctx) async {
          final name = ctx.expectValue<String>('name');
          final email = ctx.expectValue<String>('email');
          
          // Call your API
          await createUserAccount(name: name, email: email);
        },
      ),
    ],
    onFinish: (ctx) async {
      // Navigate to home when done
      final context = ctx.navigationContext;
      if (context != null) {
        HomeRoute().go(context);
      }
    },
  );
}
```

#### Step 2: Create Your Pages

```dart
class EnterNamePage extends ConsumerWidget {
  const EnterNamePage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Your Name')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'John Doe',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Complete step and pass name to next step
                ref.read(flowControllerV2Provider.notifier).completeStep(
                  output: {'name': controller.text},
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class EnterEmailPage extends ConsumerWidget {
  const EnterEmailPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Your Email')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'john@example.com',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Go back to previous step
                    ref.read(flowControllerV2Provider.notifier).back();
                  },
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Complete step and pass email
                    ref.read(flowControllerV2Provider.notifier).completeStep(
                      output: {'email': controller.text},
                    );
                  },
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

#### Step 3: Start the Flow

```dart
// In your button or initState
Future<void> startRegistration(WidgetRef ref) async {
  await ref
      .read(flowControllerV2Provider.notifier)
      .start(registrationFlow());
}
```

That's it! You now have a working 3-step flow with:
- ✅ Navigation between steps
- ✅ Data passing
- ✅ Back button support
- ✅ Loading indicator
- ✅ Automatic completion

## Common Patterns

### Pattern 1: Conditional Steps

Skip steps based on conditions:

```dart
FlowRouteStepV2(
  id: 'premium-features',
  label: 'Premium Features',
  canEnter: (ctx) async {
    // Only show this step to premium users
    final isPremium = ctx.readValue<bool>('isPremium') ?? false;
    return isPremium;
  },
  pageBuilder: (context, flowContext) {
    return const PremiumFeaturesPage();
  },
)
```

### Pattern 2: Validation Before Advancing

```dart
class InputPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          TextField(...),
          ElevatedButton(
            onPressed: () {
              // Validate before advancing
              if (isValid) {
                ref.read(flowControllerV2Provider.notifier).completeStep(
                  output: {'data': value},
                );
              } else {
                showError(context, 'Invalid input');
              }
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
```

### Pattern 3: Jump to Specific Step

```dart
// Jump directly to a step (useful for "Skip" buttons)
await ref.read(flowControllerV2Provider.notifier).jumpTo('final-step');
```

### Pattern 4: Cancel Flow

```dart
// Cancel button
IconButton(
  icon: const Icon(Icons.close),
  onPressed: () {
    ref.read(flowControllerV2Provider.notifier).cancel();
  },
)
```

### Pattern 5: Respond to Flow State

```dart
class MyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlowStateBuilder(
      onIdle: () => StartButton(),
      onActive: (snapshot, isLoading) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return FlowPage(snapshot: snapshot);
      },
      onCompleted: (blueprint) => SuccessPage(),
      onFailed: (error, stackTrace) => ErrorPage(error),
    );
  }
}
```

## Integration with Routes

### Option 1: Inline Pages (Simple)

Best when you don't need deep linking:

```dart
FlowRouteStepV2(
  id: 'settings',
  pageBuilder: (context, flowContext) {
    return const SettingsPage();
  },
)
```

**Pros:** No route duplication, simple
**Cons:** No deep linking to this step

### Option 2: Typed Routes (Advanced)

Best when you need deep linking:

```dart
// In routes.dart
@TypedGoRoute<SettingsFlowRoute>(path: '/flow/settings')
class SettingsFlowRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

// In flow
FlowRouteStepV2(
  id: 'settings',
  routeBuilder: (ctx) => const SettingsFlowRoute(),
)
```

**Pros:** Deep linking, browser back button support
**Cons:** More boilerplate

## Shell Integration

Wrap your flow routes in a shell for consistent presentation:

```dart
@TypedShellRoute<RegistrationFlowShellRoute>(
  routes: [
    TypedGoRoute<EnterNameRoute>(path: '/registration/name'),
    TypedGoRoute<EnterEmailRoute>(path: '/registration/email'),
  ],
)
class RegistrationFlowShellRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget child) {
    return FlowShellV2(
      presentation: FlowPresentationStyle.card,
      showProgress: true,
      showBackButton: true,
      onBackPressed: () {
        final container = ProviderScope.containerOf(context);
        container.read(flowControllerV2Provider.notifier).back();
      },
      child: child,
    );
  }
}
```

## Best Practices

### ✅ DO

1. **Use clear step IDs**: `'enter-name'`, not `'step1'`
2. **Add labels**: Helps with progress tracking
3. **Validate before advancing**: Check data before calling `completeStep()`
4. **Use loading states**: For any operation > 1 second
5. **Handle errors**: Add try-catch in action steps
6. **Pass minimal data**: Only what the next step needs

### ❌ DON'T

1. **Don't skip error handling**: Always handle errors in actions
2. **Don't mutate context directly**: Use `write()` and `writeAll()`
3. **Don't forget to complete steps**: Route steps need manual completion
4. **Don't use complex data**: Keep context data serializable
5. **Don't nest flows**: Keep flows linear (use branching if needed)

## Debugging

### Check Flow State

```dart
final flowState = ref.watch(flowControllerV2Provider);
print('Flow state: $flowState');

if (flowState is FlowActiveV2) {
  print('Current step: ${flowState.snapshot.step.id}');
  print('Progress: ${flowState.snapshot.progress * 100}%');
}
```

### Inspect Context Data

```dart
FlowActionStepV2(
  id: 'debug',
  action: (ctx) async {
    print('Context data: ${ctx.data}');
  },
)
```

### Log Lifecycle

```dart
FlowRouteStepV2(
  id: 'my-step',
  onEnter: (ctx) async {
    print('Entering my-step');
  },
  onExit: (ctx) async {
    print('Exiting my-step');
  },
  pageBuilder: ...,
)
```

## Testing

```dart
test('flow completes successfully', () async {
  final container = ProviderContainer();
  final controller = container.read(flowControllerV2Provider.notifier);
  
  // Start flow
  await controller.start(registrationFlow());
  
  // Complete steps
  await controller.completeStep(output: {'name': 'John'});
  await controller.completeStep(output: {'email': 'john@example.com'});
  
  // Verify completion
  final state = container.read(flowControllerV2Provider);
  expect(state, isA<FlowCompletedV2>());
});
```

## Next Steps

- 📖 Read the [full documentation](flow_builder_v2.md)
- 🆚 Compare with [V1 vs V2](flow_builder_v1_vs_v2_comparison.md)
- 💡 Check out [server_flows_v2.dart](../lib/features/auth/application/flows/server_flows_v2.dart) for real examples

## Quick Reference

```dart
// Start flow
await ref.read(flowControllerV2Provider.notifier).start(myFlow());

// Start from specific step
await ref.read(flowControllerV2Provider.notifier).start(
  myFlow(),
  startAtStep: 'step-id',
);

// Complete current step
await ref.read(flowControllerV2Provider.notifier).completeStep(
  output: {'key': 'value'},
);

// Navigate
await ref.read(flowControllerV2Provider.notifier).jumpTo('step-id');
await ref.read(flowControllerV2Provider.notifier).back();

// Cancel
await ref.read(flowControllerV2Provider.notifier).cancel();

// Read flow state
final state = ref.watch(flowControllerV2Provider);
```

Happy flowing! 🎉
