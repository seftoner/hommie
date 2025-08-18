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

/// Implements an exponential backoff strategy with optional jitter.
class ExponentialBackoff implements Backoff {
  final Duration initialDelay;
  final Duration maxDelay;
  final double multiplier;
  final bool jitter;
  
  int _attemptCount = 0;

  ExponentialBackoff({
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(minutes: 5),
    this.multiplier = 2.0,
    this.jitter = true,
  });

  @override
  Duration get next {
    final delay = _calculateDelay();
    _attemptCount++;
    return delay;
  }

  @override
  void reset() {
    _attemptCount = 0;
  }

  Duration _calculateDelay() {
    var delayMs = initialDelay.inMilliseconds * 
        (multiplier * _attemptCount).round();
    
    if (delayMs > maxDelay.inMilliseconds) {
      delayMs = maxDelay.inMilliseconds;
    }

    if (jitter) {
      // Add ±25% jitter to prevent thundering herd
      final jitterRange = (delayMs * 0.25).round();
      final jitterOffset = (DateTime.now().millisecondsSinceEpoch % (jitterRange * 2)) - jitterRange;
      delayMs += jitterOffset;
    }

    return Duration(milliseconds: delayMs.clamp(0, maxDelay.inMilliseconds));
  }
}
