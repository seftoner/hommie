import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  final String message;

  const OfflineBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Row(
        children: [
          Icon(
            Icons.warning_rounded,
            size: 24,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
          SizedBox(width: 8.0),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

  /* Text(
              "Not finding your screen?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ), */