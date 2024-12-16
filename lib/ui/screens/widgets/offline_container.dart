import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/ui/styles/spacings.dart';

class OfflineContainer extends ConsumerWidget {
  final Widget? child;

  const OfflineContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(connectionStateProvider);

    return Scaffold(
      body: Stack(
        children: [
          _buildMainContent(connectionState),
          if (_isConnectionDisrupted(connectionState))
            _buildDisconnectedBanner(context, connectionState),
        ],
      ),
    );
  }

  bool _isConnectionDisrupted(HAServerConnectionState state) {
    return state == HAServerConnectionState.disconnected ||
        state == HAServerConnectionState.reconnecting;
  }

  Widget _buildMainContent(HAServerConnectionState connectionState) {
    return Container(
      padding: EdgeInsets.only(
        top: _isConnectionDisrupted(connectionState) ? 20 : 0,
      ),
      child: child,
    );
  }

  Widget _buildDisconnectedBanner(
      BuildContext context, HAServerConnectionState connectionState) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 2,
          bottom: 2,
          left: 16,
          right: 16,
        ),
        color: Theme.of(context).colorScheme.errorContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
      ),
    );
  }
}
