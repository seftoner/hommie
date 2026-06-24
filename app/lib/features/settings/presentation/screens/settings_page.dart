import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([serverLifecycleController])
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
            leading: const Icon(Symbols.cloud_rounded),
            title: const Text('Hub name'),
            subtitle: const Text('Username'),
            trailing: const Icon(Symbols.chevron_right_rounded),
            onTap: () => {const HubRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Symbols.dns_rounded),
            title: const Text('Servers'),
            subtitle: const Text('Manage your Home Assistant servers'),
            trailing: const Icon(Symbols.chevron_right_rounded),
            onTap: () => {const ServersRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Symbols.home_work_rounded),
            title: const Text('Areas'),
            trailing: const Icon(Symbols.chevron_right_rounded),
            onTap: () => const AreasRouteData().push(context),
          ),
          const Divider(),
          ListTile(
            key: K.settings.sensorsItem,
            leading: const Icon(Symbols.sensors_rounded),
            title: const Text('Sensors'),
            trailing: const Icon(Symbols.chevron_right_rounded),
            onTap: () => {const SensorsRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            key: K.settings.nfcItem,
            leading: const Icon(Symbols.nfc_rounded),
            title: const Text('NFC'),
            trailing: const Icon(Symbols.chevron_right_rounded),
            onTap: () => {/* Handle  tap */},
          ),
          const Divider(),
          ListTile(
            key: K.settings.logsItem,
            leading: const Icon(Symbols.bug_report_rounded),
            title: const Text('Logs'),
            trailing: const Icon(Symbols.chevron_right_rounded),
            onTap: () => {const LogsRouteData().push(context)},
          ),
          const Divider(),
          ListTile(
            key: K.settings.aboutItem,
            leading: const Icon(Symbols.info_rounded),
            title: const Text('About'),
            trailing: const Icon(Symbols.chevron_right_rounded),
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
                  foregroundColor: Theme.of(
                    context,
                  ).colorScheme.onErrorContainer,
                ),
                onPressed: () => _showSignOutDialog(context, ref),
                child: const Text('Sign Out'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showSignOutDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        key: K.hub.signOutAlert,
        title: const Text('Sign Out'),
        content: const Text(
          'Are you sure you want to sign out? You will need to authenticate again to access your Home Assistant.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            key: K.hub.signOutButton,
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await _signOut(context, ref);
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(serverLifecycleControllerProvider).signOutActiveServer();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign out: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }
}
