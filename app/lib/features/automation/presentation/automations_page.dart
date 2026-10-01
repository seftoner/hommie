import 'package:material_ui/material_ui.dart';

class AutomationsPage extends StatelessWidget {
  const AutomationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text('🚀 Coming Soon! 🚀',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text(
                'We\'re crafting something amazing\nfor home automation',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
