import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/screens/widgets/offline_banner.dart';

class OfflineContainer extends ConsumerWidget {
  final Widget? child;

  const OfflineContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showBanner = ref.watch(
      serverConnectionStateProvider.select(_isConnectionDisrupted),
    );

    return Column(
      children: [
        ClipRect(
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            heightFactor: showBanner ? 1.0 : 0.0,
            child: OfflineBanner(key: K.common.offlineBanner),
          ),
        ),
        Expanded(child: child ?? const SizedBox.shrink()),
      ],
    );
  }

  static bool _isConnectionDisrupted(HAServerConnectionState state) {
    return state == HAServerConnectionState.disconnected ||
        state == HAServerConnectionState.reconnecting ||
        state == HAServerConnectionState.connecting;
  }
}
