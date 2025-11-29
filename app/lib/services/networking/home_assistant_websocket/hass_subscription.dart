import 'dart:async';

import 'package:hommie/core/infrastructure/logging/logger.dart';

/// Represents a subscription to Home Assistant events.
/// Provides a stream of events and a way to unsubscribe.
class HassSubscription {
  late final StreamController<dynamic> _streamController;

  final Function() unsubscribe;
  Stream<dynamic> get stream => _streamController.stream;

  HassSubscription({required this.unsubscribe}) {
    _streamController = StreamController.broadcast();
    _streamController.onListen = () {
      logger.d('New listener added to subscribtion stream!');
    };
    _streamController.onCancel = () {
      logger.d('Listener unsubscribed from subscribtion stream!');
    };
  }

  /// Emits an event to all subscribers of this subscription.
  void emit(dynamic event) {
    if (!_streamController.isClosed) {
      _streamController.add(event);
    }
  }

  /// Disposes of the subscription and its resources.
  void dispose() {
    if (!_streamController.isClosed) {
      _streamController.close();
    }
    unsubscribe();
  }

  /// Whether this subscription has been disposed.
  bool get isDisposed => _streamController.isClosed;
}
