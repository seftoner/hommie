# Flow builder

This project now ships with a small flow-builder framework built on Riverpod and GoRouter. A *flow* is a linear set of steps that can mix navigation steps with side-effect steps while sharing a mutable context.

## Core pieces

- `FlowContext` wraps a `Ref`, a `FlowNavigator`, and a data map for passing values between steps.
- `FlowStep` has two concrete types:
  - `FlowRouteStep` navigates to a `GoRouteData` destination using either `go` or `push`.
  - `FlowActionStep` executes logic without navigation and, by default, auto-advances the flow.
- `FlowController` is a Riverpod `StateNotifier` that starts flows, moves between steps, and exposes lifecycle states (idle, active, completed, failed).
- `FlowNavigator` centralizes access to the GoRouter root navigator so flows can drive navigation without needing a `BuildContext`.

Use `flowNavigatorProvider` to share the root `FlowNavigator` instance and `flowControllerProvider` to control flows.

### Route passes & shells

- A `FlowRoutePass` describes which GoRouter paths should back each shared step
  (e.g. discovery vs. manual entry). A pass is stored inside the `FlowContext`
  when a flow starts so individual steps/widgets can resolve the correct route
  for the current pass.
- Onboarding and add-server flows each provide their own pass so their URLs live
  under `/onboarding/...` and `/settings/servers/add/...` while reusing the same
  UI widgets.
- The router declares lightweight `TypedShellRoute`s (`OnboardingFlowShellRoute`
  and `AddServerFlowShellRoute`) that wrap the flow pages in either a
  fullscreen or constrained `FlowShell`. The constrained shell keeps onboarding
  flows in a smaller card without hijacking the whole screen, whereas the add
  server flow uses the fullscreen shell to blend into the settings hierarchy.

## Server flows

`lib/features/auth/application/flows/server_flows.dart` defines two blueprints:

- `onboardingServerFlow` covers the initial authentication journey after install.
- `addServerFlow` reuses the same discovery + login steps but finishes on the settings/servers page so the newly-added server is visible.

Convenience helpers `startOnboardingServerFlow` and `startAddServerFlow` launch the respective flows with the shared navigator instance and install the correct route pass. Both flows expect the selected server address to be provided via `handleServerSelection` (wired into the discovery and manual entry screens).
