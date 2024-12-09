import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/core/utils/logger.dart';

part 'reconnection_service.g.dart';

@Riverpod(keepAlive: true)
class ReconnectionService extends _$ReconnectionService {
  Timer? _reconnectionTimer;

  @override
  void build() {
    ref.onDispose(() {
      _reconnectionTimer?.cancel();
    });
  }

  void startPeriodicReconnection(void Function() onReconnect) {
    _reconnectionTimer?.cancel();
    _reconnectionTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        logger.i("Attempting to reconnect...");
        onReconnect();
      },
    );
  }

  void stopReconnection() {
    _reconnectionTimer?.cancel();
    _reconnectionTimer = null;
  }
}
