import 'dart:math';

/// Defines interface for implementing backoff strategies.
/// Used for determining delays between reconnection attempts.
abstract class Backoff {
  /// Returns the next delay duration.
  Duration get next;

  /// Resets the backoff strategy to its initial state.
  void reset();
}

/// Implements a constant backoff strategy with a fixed delay.
class ConstantBackoff implements Backoff {
  final Duration delay;

  const ConstantBackoff(this.delay);

  @override
  Duration get next => delay;

  @override
  void reset() {}
}

/// Mobile-oriented reconnect strategy.
///
/// The first retry is immediate to recover from brief radio/socket churn. Later
/// attempts back off quickly and then cap, so foreground reconnects stay
/// responsive without keeping the device radio busy indefinitely.
class MobileReconnectBackoff implements Backoff {
  MobileReconnectBackoff({
    this.jitterFactor = 0.2,
    Random? random,
    List<Duration> delays = const [
      Duration.zero,
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 5),
      Duration(seconds: 10),
      Duration(seconds: 30),
    ],
  }) : _random = random ?? Random(),
       _delays = delays;

  final double jitterFactor;
  final Random _random;
  final List<Duration> _delays;

  int _index = 0;

  @override
  Duration get next {
    final base = _delays[min(_index, _delays.length - 1)];
    if (_index < _delays.length - 1) {
      _index += 1;
    }

    if (base == Duration.zero || jitterFactor <= 0) {
      return base;
    }

    final jitterRangeMs = (base.inMilliseconds * jitterFactor).round();
    final jitterMs = _random.nextInt(jitterRangeMs * 2 + 1) - jitterRangeMs;
    final nextMs = max(0, base.inMilliseconds + jitterMs);
    return Duration(milliseconds: nextMs);
  }

  @override
  void reset() {
    _index = 0;
  }
}

/// A binary exponential backoff strategy.
/// This backoff strategy will double the backoff duration on each attempt
/// until the maximum step is reached.
class BinaryExponentialBackoff implements Backoff {
  /// The initial backoff duration.
  final Duration initial;

  /// The maximum number of times the backoff duration is doubled.
  final int maximumStep;

  int _currentStep;
  Duration _current;

  BinaryExponentialBackoff({required this.initial, required this.maximumStep})
    : _currentStep = 1,
      _current = initial;

  @override
  Duration get next {
    final backoff = _current;
    if (maximumStep > _currentStep++) {
      _current = _current * 2;
    }
    return backoff;
  }

  @override
  void reset() {
    _currentStep = 1;
    _current = initial;
  }
}
