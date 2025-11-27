import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
// Freezed no longer needed; replaced with enum
import 'package:hommie/features/auth/presentation/flows/add_server_flow.dart';
// riverpod_annotation no longer needed after removing controller

// part 'onboarding_flow.freezed.dart'; // removed: using enum

/// Steps that compose the onboarding flow.
enum OnboardingStep { welcomeOne, permissions, addServer }

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  late final FlowController<OnboardingStep> controller;

  @override
  void initState() {
    super.initState();
    controller = FlowController(OnboardingStep.welcomeOne);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<OnboardingStep>(
      controller: controller,
      onGeneratePages: (step, pages) => [
        MaterialPage<void>(
          child: _WelcomePage(
            onContinue: () {
              controller.update((_) => OnboardingStep.permissions);
            },
          ),
        ),
        if (step == OnboardingStep.permissions ||
            step == OnboardingStep.addServer)
          MaterialPage<void>(
            child: _PermissionsPage(
              onConnect: () {
                controller.update((_) => OnboardingStep.addServer);
              },
            ),
          ),

        if (step == OnboardingStep.addServer)
          const MaterialPage(
            child: PopScope(
              canPop: false,
              child: AddServerFlow(userCanCancel: false),
            ),
          ),
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
  final VoidCallback onConnect;

  const _PermissionsPage({required this.onConnect});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Enable Permissions', style: theme.textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            FilledButton(onPressed: onConnect, child: const Text('Connect')),
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
