import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/screens/widgets/offline_banner.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([ServerConnectionState])
class OfflineContainer extends ConsumerWidget {
  final Widget? child;

  const OfflineContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(serverConnectionStateProvider);

    return Scaffold(
      body: Stack(
        children: [
          _buildMainContent(connectionState),
          if (_isConnectionDisrupted(connectionState))
            _buildDisconnectedBanner(context),
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

  Widget _buildDisconnectedBanner(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: OfflineBanner(key: K.common.offlineBanner),
    );
  }
}
