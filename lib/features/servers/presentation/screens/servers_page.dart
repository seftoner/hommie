import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/features/servers/infrastructure/providers/servers_list_provider.dart';
import 'package:hommie/features/servers/presentation/widgets/server_list_tile.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([ActiveServer, ServersList])
class ServersPage extends ConsumerWidget {
  const ServersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeServerAsync = ref.watch(activeServerProvider);
    final serversAsync = ref.watch(serversListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Servers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/settings/servers/add/discovery'),
          ),
        ],
      ),
      body: serversAsync.when(
        data: (servers) {
          if (servers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cloud_off, size: 64),
                  const SizedBox(height: 16),
                  const Text('No servers configured'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push('/settings/servers/add/discovery'),
                    child: const Text('Add Server'),
                  ),
                ],
              ),
            );
          }

          return activeServerAsync.when(
            data: (activeServer) => RefreshIndicator(
              onRefresh: () => ref.read(serversListProvider.notifier).refresh(),
              child: ListView.builder(
                itemCount: servers.length,
                itemBuilder: (context, index) {
                  final server = servers[index];
                  final isActive = activeServer?.id == server.id;

                  return ServerListTile(
                    server: server,
                    isActive: isActive,
                    onTap: () => EditServerRouteData(server).push(context),
                    onSetActive: isActive
                        ? null
                        : () => _setActiveServer(ref, server.id!),
                    onDelete: servers.length > 1
                        ? () => _showDeleteDialog(context, ref, server)
                        : null,
                  );
                },
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) =>
                Center(child: Text('Error loading active server: $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              Text('Error loading servers: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(serversListProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setActiveServer(WidgetRef ref, int serverId) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 16),
              Text('Switching server...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      await ref.read(serverManagerProvider).activateServer(serverId);

      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).clearSnackBars();
        ScaffoldMessenger.of(ref.context).showSnackBar(
          const SnackBar(
            content: Text('Server switched successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).clearSnackBars();
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text('Failed to switch server: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    Server server,
  ) {
    final activeServerAsync = ref.read(activeServerProvider);
    final serversAsync = ref.read(serversListProvider);

    final isActive = activeServerAsync.value?.id == server.id;
    final serverCount = serversAsync.value?.length ?? 0;
    final willBecomeLastServer =
        serverCount == 2; // After deletion, 1 will remain

    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Theme.of(context).colorScheme.error),
            const SizedBox(width: 8),
            const Text('Delete Server'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete "${server.name}"?',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('This will:'),
            const SizedBox(height: 8),
            const Text('• Remove all server configuration'),
            const Text('• Sign out and clear stored credentials'),
            const Text('• Revoke authentication tokens'),
            if (isActive || willBecomeLastServer) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      size: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        willBecomeLastServer
                            ? 'The remaining server will automatically become active.'
                            : 'You will be automatically switched to another server.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            const Text(
              'This action cannot be undone.',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await _deleteServer(context, ref, server);
            },
            child: const Text('Delete Server'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteServer(
    BuildContext context,
    WidgetRef ref,
    Server server,
  ) async {
    try {
      // Show loading indicator
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 16),
                Text('Deleting "${server.name}"...'),
              ],
            ),
            duration: const Duration(
              seconds: 10,
            ), // Longer duration for deletion
          ),
        );
      }

      await ref.read(serversListProvider.notifier).removeServer(server.id!);

      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Server "${server.name}" deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        String errorMessage = 'Failed to delete server: ';

        if (e.toString().contains('Cannot delete the last server')) {
          errorMessage =
              'Cannot delete the last server. At least one server must be configured.';
        } else {
          errorMessage += e.toString();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }
}
