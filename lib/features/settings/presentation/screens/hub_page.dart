import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
          Text("Status", style: Theme.of(context).textTheme.titleSmall),
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
          Text("Details", style: Theme.of(context).textTheme.titleSmall),
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
        ],
      ),
    );
  }
}
