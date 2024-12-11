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
