import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class AboutPage extends HookConsumerWidget {
  const AboutPage({super.key});

  Future<void> _launchGithub() async {
    final Uri url = Uri.parse('https://github.com/seftoner/hommie');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Symbols.code_rounded),
            title: const Text('Git hub'),
            trailing: const Icon(Symbols.open_in_new_rounded),
            onTap: _launchGithub,
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
