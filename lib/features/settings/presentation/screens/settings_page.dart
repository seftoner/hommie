import 'package:flutter/material.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: K.settingsPage,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            key: K.hubListItem,
            leading: const Icon(Icons.cloud),
            title: const Text('Hub name'),
            subtitle: const Text('Username'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {const HubRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            key: K.sensorsListItem,
            leading: const Icon(Icons.sensors),
            title: const Text('Sensors'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {const SensorsRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            key: K.nfsListItem,
            leading: const Icon(Icons.nfc_rounded),
            title: const Text('NFC'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {/* Handle  tap */},
          ),
          const Divider(),
          ListTile(
            key: K.logsListItem,
            leading: const Icon(Icons.bug_report_outlined),
            title: const Text('Logs'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {const LogsRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            key: K.aboutListItem,
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {const AboutRouteData().push(context)},
          ),
        ],
      ),
    );
  }
}
