import 'package:flutter/material.dart';
import 'package:hommie/ui/styles/spacings.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Hommie!'),
            $h24,
            Text(
                'If you see this page, you may have lost connection to your Home Assistant server.'),
          ],
        ),
      ),
    );
  }
}
