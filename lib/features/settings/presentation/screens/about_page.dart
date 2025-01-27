import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutPage extends HookConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Git hub'),
            trailing: const Icon(Icons.open_in_new_rounded),
            onTap: () => {/* Handle  tap */},
          ),
          const Divider(),
          ListTile(
            title: const Text('Build number'),
            trailing: const Text('{111111}'),
            onTap: () => {/* Handle tap */},
          ),
        ],
      ),
    );
  }
}
