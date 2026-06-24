import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/settings/application/active_server_areas_provider.dart';
import 'package:hommie/features/settings/application/areas_settings_controller.dart';
import 'package:hommie/features/settings/application/areas_settings_state.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class AreasPage extends ConsumerWidget {
  const AreasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areasState = ref.watch(activeServerAreasProvider);
    final controllerState = ref.watch(areasSettingsControllerProvider);
    final isBusy = controllerState.isLoading;
    final canEdit = switch (areasState) {
      AsyncData(value: final state) when state.canEdit => !isBusy,
      _ => false,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Areas'),
        actions: [
          IconButton(
            tooltip: 'Create area',
            icon: const Icon(Symbols.add_rounded),
            onPressed: canEdit ? () => _showCreateDialog(context, ref) : null,
          ),
        ],
      ),
      body: SafeArea(
        child: areasState.when(
          data: (state) => _AreasBody(state: state, isBusy: isBusy),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) {
    return _showAreaNameDialog(
      context: context,
      title: 'Create area',
      actionLabel: 'Create',
      onSave: (name) =>
          ref.read(areasSettingsControllerProvider.notifier).create(name),
    );
  }
}

class _AreasBody extends ConsumerWidget {
  const _AreasBody({required this.state, required this.isBusy});

  final ActiveServerAreasState state;
  final bool isBusy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!state.hasActiveServer) {
      return const Center(child: Text('No active server'));
    }

    final editable = state.canEdit && !isBusy;
    final list = state.areas.isEmpty
        ? const Center(child: Text('No areas yet'))
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.areas.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) =>
                _AreaTile(area: state.areas[index], editable: editable),
          );

    if (state.canEdit) {
      return list;
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Connect to Home Assistant to edit areas'),
        ),
        Expanded(child: list),
      ],
    );
  }
}

class _AreaTile extends ConsumerWidget {
  const _AreaTile({required this.area, required this.editable});

  final Area area;
  final bool editable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(area.name),
      trailing: PopupMenuButton<_AreaAction>(
        enabled: editable,
        icon: const Icon(Symbols.more_vert_rounded),
        onSelected: (action) {
          switch (action) {
            case _AreaAction.rename:
              _showRenameDialog(context, ref, area);
            case _AreaAction.delete:
              _showDeleteDialog(context, ref, area);
          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: _AreaAction.rename, child: Text('Rename')),
          PopupMenuItem(value: _AreaAction.delete, child: Text('Delete')),
        ],
      ),
    );
  }

  Future<void> _showRenameDialog(
    BuildContext context,
    WidgetRef ref,
    Area area,
  ) {
    return _showAreaNameDialog(
      context: context,
      title: 'Rename area',
      actionLabel: 'Save',
      initialName: area.name,
      onSave: (name) => ref
          .read(areasSettingsControllerProvider.notifier)
          .rename(areaId: area.id, name: name),
    );
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    Area area,
  ) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => _DeleteAreaDialog(
        area: area,
        onDelete: () => ref
            .read(areasSettingsControllerProvider.notifier)
            .delete(areaId: area.id),
      ),
    );
  }
}

enum _AreaAction { rename, delete }

class _DeleteAreaDialog extends StatefulWidget {
  const _DeleteAreaDialog({required this.area, required this.onDelete});

  final Area area;
  final Future<void> Function() onDelete;

  @override
  State<_DeleteAreaDialog> createState() => _DeleteAreaDialogState();
}

class _DeleteAreaDialogState extends State<_DeleteAreaDialog> {
  bool _deleting = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete area'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delete area "${widget.area.name}"? Devices and entities will not be deleted.',
          ),
          if (_errorText != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _deleting ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _deleting ? null : _delete,
          child: _deleting
              ? const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Delete'),
        ),
      ],
    );
  }

  Future<void> _delete() async {
    setState(() {
      _deleting = true;
      _errorText = null;
    });
    try {
      await widget.onDelete();
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _deleting = false;
          _errorText = error.toString();
        });
      }
    }
  }
}

Future<void> _showAreaNameDialog({
  required BuildContext context,
  required String title,
  required String actionLabel,
  required Future<void> Function(String name) onSave,
  String initialName = '',
}) {
  final controller = TextEditingController(text: initialName);
  var currentName = initialName;
  var isSubmitting = false;
  String? errorText;

  return showDialog<void>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) {
        final trimmed = currentName.trim();
        final canSave =
            !isSubmitting &&
            trimmed.isNotEmpty &&
            trimmed != initialName.trim();

        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => setState(() {
                  currentName = value;
                  errorText = null;
                }),
                onSubmitted: canSave
                    ? (_) => _submitAreaName(
                        dialogContext: dialogContext,
                        setState: setState,
                        updateSubmitting: (value) => isSubmitting = value,
                        updateError: (value) => errorText = value,
                        name: trimmed,
                        onSave: onSave,
                      )
                    : null,
              ),
              if (errorText != null) ...[
                const SizedBox(height: 12),
                Text(
                  errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: isSubmitting
                  ? null
                  : () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: canSave
                  ? () => _submitAreaName(
                      dialogContext: dialogContext,
                      setState: setState,
                      updateSubmitting: (value) => isSubmitting = value,
                      updateError: (value) => errorText = value,
                      name: trimmed,
                      onSave: onSave,
                    )
                  : null,
              child: Text(actionLabel),
            ),
          ],
        );
      },
    ),
  ).whenComplete(controller.dispose);
}

Future<void> _submitAreaName({
  required BuildContext dialogContext,
  required StateSetter setState,
  required ValueChanged<bool> updateSubmitting,
  required ValueChanged<String?> updateError,
  required String name,
  required Future<void> Function(String name) onSave,
}) async {
  setState(() {
    updateSubmitting(true);
    updateError(null);
  });
  try {
    await onSave(name);
    if (dialogContext.mounted) {
      Navigator.of(dialogContext).pop();
    }
  } catch (error) {
    if (dialogContext.mounted) {
      setState(() {
        updateError(error.toString());
        updateSubmitting(false);
      });
    }
  }
}
