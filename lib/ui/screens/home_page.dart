import 'package:flutter/material.dart';
import 'package:hommie/auth/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef watch) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your phenomenal app')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            const Text("There's nothing much you can do, here"),
            TextButton(
                onPressed: () {
                  watch.read(authControllerProvider.notifier).signOut();
                },
                child: const Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
