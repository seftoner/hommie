import 'dart:async';

import 'logger_interface.dart';

/// Represents a subscription to Home Assistant events.
/// Provides a stream of events and a way to unsubscribe.
class HassSubscription {
  late final StreamController<dynamic> _streamController;
  final HaLogger _logger;

  final Function() unsubscribe;
  Stream<dynamic> get stream => _streamController.stream;

  HassSubscription({required this.unsubscribe, required HaLogger logger})
    : _logger = logger {
    _streamController = StreamController.broadcast();
    _streamController.onListen = () {
      _logger.debug('New listener added to subscribtion stream!');
    };
    _streamController.onCancel = () {
      _logger.debug('Listener unsubscribed from subscribtion stream!');
    };
  }

  /// Emits an event to all subscribers of this subscription.
  void emit(dynamic event) {
    if (!_streamController.isClosed) {
      _streamController.add(event);
    }
  }

  /// Disposes of the subscription and its resources.
  Future<void> dispose() async {
    if (!_streamController.isClosed) {
      await _streamController.close();
    }
    await unsubscribe();
  }

  /// Whether this subscription has been disposed.
  bool get isDisposed => _streamController.isClosed;
}
