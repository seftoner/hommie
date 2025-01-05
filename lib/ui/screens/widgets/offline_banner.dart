import 'package:flutter/material.dart';
import 'package:hommie/ui/styles/spacings.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 2,
        bottom: 2,
        left: 16,
        right: 16,
      ),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Row(
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: 16,
          ),
          $w8,
          Text(
            'Connection lost. Retrying in 5 seconds...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
