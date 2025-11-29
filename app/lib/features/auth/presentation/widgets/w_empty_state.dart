import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String text;
  final VoidCallback onRefresh;

  const EmptyState({
    super.key,
    required this.text,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => onRefresh(),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
