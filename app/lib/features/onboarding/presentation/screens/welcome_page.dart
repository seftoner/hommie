import 'package:flutter/material.dart';
import 'package:hommie/ui/keys.dart';

class WelcomePage extends StatelessWidget {
  final VoidCallback onContinue;

  const WelcomePage({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: K.onboarding.welcomePage,
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
            FilledButton(
              key: K.onboarding.welcomeContinueButton,
              onPressed: onContinue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
