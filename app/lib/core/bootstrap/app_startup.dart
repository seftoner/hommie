import 'package:flutter/material.dart';
import 'package:hommie/ui/styles/spacings.dart';

class AppStartup extends StatelessWidget {
  const AppStartup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            $h24,
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
