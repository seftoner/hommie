import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: K.settings.page,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            key: K.settings.hubItem,
            leading: const Icon(Icons.cloud),
            title: const Text('Hub name'),
            subtitle: const Text('Username'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {const HubRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            key: K.settings.sensorsItem,
            leading: const Icon(Icons.sensors),
            title: const Text('Sensors'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {const SensorsRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            key: K.settings.nfsItem,
            leading: const Icon(Icons.nfc_rounded),
            title: const Text('NFC'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {/* Handle  tap */},
          ),
          const Divider(),
          ListTile(
            key: K.settings.logsItem,
            leading: const Icon(Icons.bug_report_outlined),
            title: const Text('Logs'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {const LogsRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            key: K.settings.aboutItem,
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {const AboutRouteData().push(context)},
          ),
          const Divider(),
          Align(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.tonal(
                key: K.hub.signOutButton,
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onErrorContainer,
                ),
                onPressed: () => _showSignOutDialog(context, ref),
                child: const Text('Sign Out'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showSignOutDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        key: K.hub.signOutAlert,
        title: const Text('Sign Out'),
        content: const Text(
          'Are you sure you want to sign out? You will need to authenticate again to access your Home Assistant.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            key: K.hub.signOutButton,
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authControllerProvider.notifier).signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
