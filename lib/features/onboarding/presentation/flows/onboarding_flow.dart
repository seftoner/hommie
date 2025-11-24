import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/auth_state_provider.dart';
import 'package:hommie/features/auth/presentation/flows/add_server_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_flow.freezed.dart';
part 'onboarding_flow.g.dart';

/// Steps that compose the onboarding flow.
@freezed
sealed class OnboardingStep with _$OnboardingStep {
  const factory OnboardingStep.welcomeOne() = WelcomeOne;
  const factory OnboardingStep.permissions() = Permissions;
  const factory OnboardingStep.addServer() = AddServer;
}

@riverpod
class OnboardingFlowController extends _$OnboardingFlowController {
  @override
  OnboardingStep build() {
    return const OnboardingStep.welcomeOne();
  }

  void next() {
    state = switch (state) {
      WelcomeOne() => const OnboardingStep.permissions(),
      Permissions() => const OnboardingStep.addServer(),
      AddServer() => state,
    };
  }

  void back() {
    state = switch (state) {
      WelcomeOne() => state,
      Permissions() => const OnboardingStep.welcomeOne(),
      AddServer() => const OnboardingStep.permissions(),
    };
  }
}

/* List<Page<dynamic>> _onGenerateOnboardingPages(
  OnboardingStep step,
  List<Page<dynamic>> pages,
) {
  return [
    const MaterialPage<void>(child: _WelcomeOnePage()),
    if (step is WelcomeTwo) const MaterialPage<void>(child: _WelcomeTwoPage()),
  ];
  /* 
  return switch (step) {
    WelcomeOne() => const [MaterialPage<void>(child: _WelcomeOnePage())],
    WelcomeTwo() => const [
      MaterialPage<void>(child: _WelcomeOnePage()),
      MaterialPage<void>(child: _WelcomeTwoPage()),
    ],
  }; */
} */

class OnboardingFlow extends HookConsumerWidget {
  const OnboardingFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowControllerState = ref.watch(onboardingFlowControllerProvider);

    /*  final controller = useMemoized(
      () => FlowController(const OnboardingStep.welcomeOne()),
    );
    useEffect(() {
      return controller.dispose;
    }, [controller]); */

    /*  ref.listen<AsyncValue<AuthState>>(authStateProvider, (previous, next) {
      next.whenData((state) {
        switch (state) {
          case Authenticated():
          case Refreshing():
            controller.complete();
          default:
            break;
        }
      });
    }); */

    return FlowBuilder<OnboardingStep>(
      // controller: controller,
      state: flowControllerState,
      onGeneratePages: (step, pages) => [
        MaterialPage<void>(
          child: _WelcomePage(
            onContinue: () {
              ref.read(onboardingFlowControllerProvider.notifier).next();
            },
          ),
        ),
        if (step is Permissions)
          MaterialPage<void>(
            child: _PermissionsPage(
              onBack: () {
                ref.read(onboardingFlowControllerProvider.notifier).back();
              },
            ),
          ),

        if (step is AddServer) const MaterialPage<void>(child: AddServerFlow()),
      ],
    );
  }
}

class _WelcomePage extends StatelessWidget {
  final VoidCallback onContinue;

  const _WelcomePage({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Welcome to Hommie', style: theme.textTheme.headlineLarge),
            const SizedBox(height: 16),
            Text(
              'Control your Home Assistant setup faster with offline-aware widgets and automations.',
              style: theme.textTheme.bodyLarge,
            ),
            const Spacer(),
            FilledButton(onPressed: onContinue, child: const Text('Continue')),
          ],
        ),
      ),
    );
  }
}

class _PermissionsPage extends StatelessWidget {
  final VoidCallback onBack;

  const _PermissionsPage({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: onBack)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Enable Permissions', style: theme.textTheme.headlineLarge),
            const SizedBox(height: 24),
            const _PermissionTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              description: 'Get alerts from your smart home devices',
            ),
            const SizedBox(height: 16),
            const _PermissionTile(
              icon: Icons.location_on_outlined,
              title: 'Location',
              description: 'Enable presence detection and automations',
            ),
            const SizedBox(height: 16),
            const _PermissionTile(
              icon: Icons.wifi_outlined,
              title: 'Network Access',
              description: 'Connect to your Home Assistant server',
            ),
            const Spacer(),
            Text(
              'You can change these settings later in the app.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const AddServerFlow(),
                  ),
                );
              },
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _PermissionTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: theme.colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
