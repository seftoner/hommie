import 'package:flutter/material.dart';
import 'package:hommie/features/servers/domain/models/server.dart';

class ServerListTile extends StatelessWidget {
  final Server server;
  final bool isActive;
  final VoidCallback? onTap;
  final VoidCallback? onSetActive;
  final VoidCallback? onDelete;

  const ServerListTile({
    super.key,
    required this.server,
    required this.isActive,
    this.onTap,
    this.onSetActive,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Icon(
            isActive ? Icons.cloud : Icons.cloud_outlined,
            color: isActive
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        title: Row(
          children: [
            Expanded(child: Text(server.name)),
            if (isActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(server.url),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color: _getStatusColor(context),
                ),
                const SizedBox(width: 4),
                Text(
                  _getStatusText(),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor(context),
                  ),
                ),
                if (server.version != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    'v${server.version}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onTap?.call();
                break;
              case 'activate':
                onSetActive?.call();
                break;
              case 'delete':
                onDelete?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                dense: true,
              ),
            ),
            if (onSetActive != null)
              const PopupMenuItem(
                value: 'activate',
                child: ListTile(
                  leading: Icon(Icons.radio_button_unchecked),
                  title: Text('Set Active'),
                  dense: true,
                ),
              ),
            if (onDelete != null)
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: Text(
                    'Delete',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  dense: true,
                ),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Color _getStatusColor(BuildContext context) {
    // TODO: Implement actual connection status checking
    // For now, show different states based on server properties
    if (isActive) {
      return Colors.green;
    }
    // Show orange for inactive servers to indicate unknown status
    return Colors.orange;
  }

  String _getStatusText() {
    // TODO: Implement actual connection status checking
    // For now, show different states based on server properties
    if (isActive) {
      return 'Connected';
    }
    // Show last connection time or other relevant info
    return 'Last connected: Unknown';
  }
}
