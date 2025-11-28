import 'package:flutter/material.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:material_symbols_icons/symbols.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final onErrorTextColor = Theme.of(context).colorScheme.onErrorContainer;
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 4,
        bottom: 4,
        left: 16,
        right: 16,
      ),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Row(
        children: [
          Icon(Symbols.wifi_home_rounded, size: 16, color: onErrorTextColor),
          $w8,
          Text(
            'Connection lost. Attempting to reconnect...',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: onErrorTextColor),
          ),
        ],
      ),
    );
  }
}
