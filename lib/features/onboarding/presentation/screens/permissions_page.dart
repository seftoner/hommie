import 'package:flutter/material.dart';

class PermissionsPage extends StatelessWidget {
  final VoidCallback onConnect;

  const PermissionsPage({super.key, required this.onConnect});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Enable Permissions', style: theme.textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _PermissionTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              description: 'Get alerts from your smart home devices',
            ),
            const SizedBox(height: 16),
            const _PermissionTile(
              icon: Icons.location_on_outlined,
              title: 'Location',
              description: 'Enable presence detection and automations',
            ),
            const SizedBox(height: 16),
            const _PermissionTile(
              icon: Icons.wifi_outlined,
              title: 'Network Access',
              description: 'Connect to your Home Assistant server',
            ),
            const Spacer(),
            Text(
              'You can change these settings later in the app.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onConnect, child: const Text('Connect')),
          ],
        ),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _PermissionTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: theme.colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
