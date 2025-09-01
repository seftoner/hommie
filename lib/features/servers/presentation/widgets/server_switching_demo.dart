import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/areas/application/areas_controller.dart';
import 'package:hommie/features/home/application/home_data_controller.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

/// A widget that demonstrates server switching by showing server-specific data.
///
/// This widget updates automatically when the active server changes,
/// displaying different data for each server to show that switching works.
@Dependencies([
  ActiveServer,
  AreasController,
  HomeDataController,
  ServerConnectionState,
])
class ServerSwitchingDemo extends ConsumerWidget {
  const ServerSwitchingDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeServerAsync = ref.watch(activeServerProvider);
    final connectionState = ref.watch(serverConnectionStateProvider);
    final areasAsync = ref.watch(areasControllerProvider);
    final homeDataAsync = ref.watch(homeDataControllerProvider);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.dns, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Server Status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Active Server Info
            activeServerAsync.when(
              data: (server) => _buildServerInfo(context, server),
              loading: () => const _LoadingRow(label: 'Active Server'),
              error: (error, _) =>
                  _buildErrorRow('Server Error', error.toString()),
            ),

            const SizedBox(height: 8),

            // Connection State
            _buildConnectionState(context, connectionState),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Server-specific Data
            Text(
              'Server Data (Auto-updates on switch)',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Home Data
            homeDataAsync.when(
              data: (data) => _buildHomeData(context, data),
              loading: () => const _LoadingRow(label: 'Home Data'),
              error: (error, _) =>
                  _buildErrorRow('Data Error', error.toString()),
            ),

            const SizedBox(height: 12),

            // Areas Count
            areasAsync.when(
              data: (areas) => _buildDataRow(
                context,
                'Areas',
                '${areas.length} areas configured',
                Icons.room,
              ),
              loading: () => const _LoadingRow(label: 'Areas'),
              error: (error, _) =>
                  _buildErrorRow('Areas Error', error.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServerInfo(BuildContext context, server) {
    if (server == null) {
      return _buildErrorRow('No Server', 'No active server configured');
    }

    return _buildDataRow(
      context,
      'Active Server',
      '${server.name} (ID: ${server.id})',
      Icons.cloud,
    );
  }

  Widget _buildConnectionState(
    BuildContext context,
    HAServerConnectionState state,
  ) {
    final (icon, color, text) = switch (state) {
      HAServerConnectionState.connected => (
        Icons.cloud_done,
        Colors.green,
        'Connected',
      ),
      HAServerConnectionState.connecting => (
        Icons.cloud_sync,
        Colors.orange,
        'Connecting',
      ),
      HAServerConnectionState.reconnecting => (
        Icons.cloud_sync,
        Colors.orange,
        'Reconnecting',
      ),
      HAServerConnectionState.disconnected => (
        Icons.cloud_off,
        Colors.red,
        'Disconnected',
      ),
      HAServerConnectionState.authFailure => (
        Icons.error,
        Colors.red,
        'Auth Failed',
      ),
      HAServerConnectionState.unknown => (Icons.help, Colors.grey, 'Unknown'),
    };

    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text('Connection:', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHomeData(BuildContext context, Map<String, dynamic> data) {
    return Column(
      children: [
        _buildDataRow(
          context,
          'Location',
          data['location'] ?? 'Unknown',
          Icons.location_on,
        ),
        const SizedBox(height: 8),
        _buildDataRow(
          context,
          'Temperature',
          data['temperature'] ?? 'Unknown',
          Icons.thermostat,
        ),
        const SizedBox(height: 8),
        _buildDataRow(
          context,
          'Entities',
          '${data['entities_count'] ?? 0} entities',
          Icons.devices,
        ),
      ],
    );
  }

  Widget _buildDataRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Text('$label:', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorRow(String label, String error) {
    return Row(
      children: [
        const Icon(Icons.error, size: 20, color: Colors.red),
        const SizedBox(width: 8),
        Text('$label: '),
        Expanded(
          child: Text(
            error,
            style: const TextStyle(color: Colors.red),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _LoadingRow extends StatelessWidget {
  final String label;

  const _LoadingRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: 8),
        Text('$label: Loading...'),
      ],
    );
  }
}
