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

  BinaryExponentialBackoff({
    required this.initial,
    required this.maximumStep,
  })  : _currentStep = 1,
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
