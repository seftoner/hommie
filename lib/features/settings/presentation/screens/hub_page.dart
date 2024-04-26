import 'package:flutter/material.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HubPage extends HookConsumerWidget {
  const HubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{Hubname}'),
      ),
      body: ListView(
        children: [
          ListTile(
            title:
                Text("Status", style: Theme.of(context).textTheme.titleSmall),
          ),
          const ListTile(
            title: Text('WebSocket'),
            trailing: Text('{websocket.isConnected}'),
          ),
          const Divider(),
          const ListTile(
            title: Text('Logged in as'),
            trailing: Text('{username}'),
          ),
          const Divider(),
          const ListTile(
            title: Text('Device name'),
            trailing: Text('{deviceName}'),
          ),
          const Divider(),
          $h24,
          ListTile(
            title:
                Text("Details", style: Theme.of(context).textTheme.titleSmall),
          ),
          ListTile(
            title: const Text('Hub name'),
            trailing: const Text('{Hubname}'),
            onTap: () => {/* Handle tap */},
          ),
          const Divider(),
          const ListTile(
            title: Text('Version'),
            trailing: Text('{version}'),
          ),
          const Divider(),
          const ListTile(
            title: Text('URL'),
            trailing: Text('{serverAddress}'),
          ),
          const Divider(),
          Align(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signOut();
                },
                child: const Text('Sign out'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
