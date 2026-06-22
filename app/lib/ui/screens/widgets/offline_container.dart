import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/screens/widgets/offline_banner.dart';

class OfflineContainer extends ConsumerWidget {
  final Widget? child;

  const OfflineContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showBanner = ref.watch(
      activeServerSessionProvider.select(_isConnectionDisrupted),
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

  static bool _isConnectionDisrupted(ActiveServerSessionState state) {
    return state is OfflineServerSession || state is ConnectingServerSession;
  }
}
