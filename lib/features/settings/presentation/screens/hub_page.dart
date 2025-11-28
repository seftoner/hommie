import 'package:flutter/material.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/settings/application/hub_status_provider.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/auth/domain/entities/ha_version.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class HubPage extends HookConsumerWidget {
  const HubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hubStatus = ref.watch(hubStatusProvider);

    return Scaffold(
      key: K.hub.page,
      appBar: AppBar(title: const Text('Hub')),
      body: hubStatus.when(
        data: (status) => status.server == null
            ? const _EmptyHubStatusView()
            : _HubStatusContent(status: status),
        error: (error, _) => _HubStatusError(message: error.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _HubStatusContent extends StatelessWidget {
  const _HubStatusContent({required this.status});

  final HubStatusState status;

  @override
  Widget build(BuildContext context) {
    final server = status.server!;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      children: [
        _SectionCard(
          title: 'Status',
          children: [
            _HubInfoTile(
              title: 'Connected via',
              value: _connectionRoute(server),
              subtitle: _connectionDescription(status.connectionState),
            ),
            _HubInfoTile(
              title: 'Version',
              value: _versionLabel(server.version),
            ),
            _HubInfoTile(
              title: 'WebSocket',
              value: _connectionLabel(status.connectionState),
            ),
            _HubInfoTile(
              title: 'Logged in as',
              value: _authLabel(status.authState),
            ),
          ],
        ),
        $h24,
        _SectionCard(
          title: 'Details',
          children: [
            _HubInfoTile(title: 'Name', value: server.name),
            _HubInfoTile(title: 'Device Name', value: status.deviceName),
            _HubInfoTile(
              title: 'Internal URL',
              value: _urlLabel(server.internalUrl ?? server.baseUrl),
            ),
            _HubInfoTile(
              title: 'External URL',
              value: _urlLabel(server.externalUrl),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              title.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _HubInfoTile extends StatelessWidget {
  const _HubInfoTile({required this.title, required this.value, this.subtitle});

  final String title;
  final String value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null
          ? Text(subtitle!, style: theme.textTheme.bodySmall)
          : null,
      trailing: Text(
        value,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        textAlign: TextAlign.right,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}

class _HubStatusError extends StatelessWidget {
  const _HubStatusError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Symbols.error_outline_rounded, color: theme.colorScheme.error),
            const SizedBox(height: 12),
            Text(
              'Failed to load hub details',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHubStatusView extends StatelessWidget {
  const _EmptyHubStatusView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Symbols.home_rounded,
              size: 56,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text('No active server', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Add or select a server to view its status.',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

String _connectionLabel(HAServerConnectionState state) {
  switch (state) {
    case HAServerConnectionState.connected:
      return 'Connected';
    case HAServerConnectionState.connecting:
      return 'Connecting';
    case HAServerConnectionState.reconnecting:
      return 'Reconnecting';
    case HAServerConnectionState.authFailure:
      return 'Auth failure';
    case HAServerConnectionState.disconnected:
      return 'Disconnected';
    case HAServerConnectionState.unknown:
      return 'Unknown';
  }
}

String _connectionDescription(HAServerConnectionState state) {
  switch (state) {
    case HAServerConnectionState.connected:
      return 'Connected to Home Assistant';
    case HAServerConnectionState.connecting:
      return 'Connecting to server...';
    case HAServerConnectionState.reconnecting:
      return 'Connection lost, attempting to reconnect';
    case HAServerConnectionState.authFailure:
      return 'Authentication required';
    case HAServerConnectionState.disconnected:
      return 'Not connected to server';
    case HAServerConnectionState.unknown:
      return 'Connection status unknown';
  }
}

String _authLabel(AuthState state) {
  return state.map(
    initial: (_) => 'Checking credentials...',
    unauthenticated: (_) => 'Not authenticated',
    authenticating: (_) => 'Authenticating...',
    authenticated: (_) => 'Authenticated',
    refreshing: (_) => 'Refreshing session',
    revoked: (_) => 'Session revoked',
    failure: (value) => 'Auth failed: ${value.failure}',
  );
}

String _versionLabel(HaVersion? version) {
  if (version == null) return 'Unknown';
  final patch = version.patch != null ? '.${version.patch}' : '';
  return '${version.major}.${version.minor}$patch';
}

String _urlLabel(String? url) => url ?? 'Not configured';

String _connectionRoute(Server server) {
  if (server.internalUrl != null) return 'Internal URL';
  if (server.externalUrl != null) return 'External URL';
  if (server.baseUrl != null) return 'Base URL';
  return 'Not configured';
}
