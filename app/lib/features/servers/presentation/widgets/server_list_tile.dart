import 'package:flutter/material.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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
            Symbols.cloud_rounded,
            fill: isActive ? 1 : 0,
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
        subtitle: Text(server.url),
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
                leading: Icon(Symbols.edit_rounded),
                title: Text('Edit'),
                dense: true,
              ),
            ),
            if (onSetActive != null)
              const PopupMenuItem(
                value: 'activate',
                child: ListTile(
                  leading: Icon(Symbols.radio_button_unchecked_rounded),
                  title: Text('Set Active'),
                  dense: true,
                ),
              ),
            if (onDelete != null)
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(
                    Symbols.delete_rounded,
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
}
