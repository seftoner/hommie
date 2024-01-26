import 'package:flutter/material.dart';
import 'package:hommie/ui/screens/widgets/loading_spinner.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Splash Page'),
            SizedBox(height: 16),
            LoadingSpinner(),
          ],
        ),
      ),
    );
  }
}
