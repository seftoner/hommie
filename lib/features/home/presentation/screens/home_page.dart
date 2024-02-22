import 'package:flutter/material.dart';
import 'package:hommie/features/areas/application/areas_controller.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/services/networking/provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_websockets_connection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var areas = ref.watch(areasControllerProvider);

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
                  ref.read(authControllerProvider.notifier).signOut();
                },
                child: const Text('Sign out')),
            // ListView(
            //   children: [
            //     for (final areaname in ["test", "sdsdsd"]) Text(areaname)
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
