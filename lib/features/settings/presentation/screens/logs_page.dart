import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hommie/features/settings/application/logs_controller.dart';
import 'package:hommie/features/settings/application/logs_list_controller.dart';
import 'package:hommie/features/settings/domain/entities/logs.dart';
import 'package:hommie/features/settings/presentation/widgets/color_badge.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogsPage extends HookConsumerWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLogsState = ref.watch(logsListControllerProvider);

    final scrollController = useScrollController();

    // Detect when the user scrolls near the end of the list
    scrollController.addListener(() {
      final currentState = appLogsState.value;
      if (currentState != null &&
          !currentState.isLoadingMore &&
          !currentState.hasReachedEnd &&
          scrollController.position.pixels >
              scrollController.position.maxScrollExtent - 500) {
        ref
            .read(logsListControllerProvider.notifier)
            .loadMoreLogs(); // Fetch the next batch of logs
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
        actions: [
          IconButton(
            onPressed: () {
              final box = context.findRenderObject() as RenderBox?;
              final position = box!.localToGlobal(Offset.zero) & box.size;
              ref.read(logsControlerProvider.notifier).shareLogs(position);
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () => _showDeleteConfirmationDialog(context, ref),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: switch (appLogsState) {
        AsyncData(:final value) =>
          value.logs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 64,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No logs available',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: scrollController,
                  itemCount: value.logs.length,
                  itemBuilder: (context, index) {
                    final log = value.logs[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          titleAlignment: ListTileTitleAlignment.threeLine,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: ColorBadge(
                            color: _getLogLevelColor(log.level),
                            radius: 6,
                          ),
                          title: Text(
                            log.msg,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            log.time.toLocal().toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          // onTap: () => _showLogDetailsDialog(context, log),
                        ),
                        const Divider(height: 1, thickness: 1),
                      ],
                    );
                  },
                ),
        AsyncError(:final error) => Text(error.toString()),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Color _getLogLevelColor(LogLevel level) {
    switch (level) {
      case LogLevel.trace:
        return Colors.blueGrey;
      case LogLevel.debug:
        return Colors.black;
      case LogLevel.info:
        return Colors.blue;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.error:
        return Colors.red;
      case LogLevel.fatal:
        return Colors.purple;
    }
  }

  Future<void> _showDeleteConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Logs'),
        content: const Text(
          'Are you sure you want to delete all logs? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(logsControlerProvider.notifier).deleteLogs();
      // Refresh the logs list
      ref.invalidate(logsListControllerProvider);
    }
  }
}
