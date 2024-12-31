import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/backoff.dart';

abstract class ReconnectionManagerDelegate {
  void reconnectionManagerWantsReconnect();
  void reconnectionManagerWantsDisconnect(dynamic error);
}

class ReconnectionManager {
  final ReconnectionManagerDelegate _delegate;
  final Backoff _backoff;
  bool _closeRequested = false;
  bool _reconnectScheduled = false;

  ReconnectionManager(this._delegate, [Backoff? backoff])
      : _backoff = backoff ?? const ConstantBackoff(Duration(seconds: 5));

  void didStartInitialConnect() {
    _closeRequested = false;
    _reconnectScheduled = false;
    _backoff.reset();
  }

  void didFinishConnect() {
    _reconnectScheduled = false;
    _closeRequested = false;
    _backoff.reset();
  }

  void didDisconnectPermanently() {
    _closeRequested = true;
    _reconnectScheduled = false;
    _backoff.reset();
  }

  void reconnect() {
    if (_closeRequested || _reconnectScheduled) {
      return;
    }

    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_reconnectScheduled) {
      return;
    }
    _reconnectScheduled = true;

    final delay = _backoff.next;
    logger.i('Scheduling reconnection in ${delay.inSeconds} seconds');

    Future.delayed(delay, () {
      _reconnectScheduled = false;
      if (!_closeRequested) {
        _delegate.reconnectionManagerWantsReconnect();
      }
    });
  }
}
