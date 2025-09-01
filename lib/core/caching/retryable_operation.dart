import 'dart:async';
import 'dart:math';

import 'package:hommie/core/utils/logger.dart';

/// Configuration for retry behavior
class RetryConfig {
  final int maxRetries;
  final Duration baseDelay;
  final Duration? maxDelay;
  final double backoffMultiplier;
  final bool useJitter;

  const RetryConfig({
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 1),
    this.maxDelay,
    this.backoffMultiplier = 2.0,
    this.useJitter = true,
  });

  static const RetryConfig defaultConfig = RetryConfig();

  static const RetryConfig networkConfig = RetryConfig(
    maxRetries: 3,
    baseDelay: Duration(seconds: 2),
    maxDelay: Duration(seconds: 30),
    backoffMultiplier: 2.0,
    useJitter: true,
  );
}

/// A generic retry mechanism that can wrap any async operation
class RetryableOperation<T> {
  final Future<T> Function() _operation;
  final RetryConfig _config;
  final String _operationName;
  final Random _random = Random();

  RetryableOperation({
    required Future<T> Function() operation,
    required String operationName,
    RetryConfig config = RetryConfig.defaultConfig,
  }) : _operation = operation,
       _config = config,
       _operationName = operationName;

  /// Executes the operation with retry logic
  Future<T> execute() async {
    for (int attempt = 1; attempt <= _config.maxRetries; attempt++) {
      try {
        logger.d(
          'RetryableOperation[$_operationName]: Attempt $attempt/${_config.maxRetries}',
        );
        return await _operation();
      } catch (e) {
        logger.w(
          'RetryableOperation[$_operationName]: Attempt $attempt failed: $e',
        );

        if (attempt == _config.maxRetries) {
          logger.e(
            'RetryableOperation[$_operationName]: All attempts failed, throwing last error',
          );
          rethrow;
        }

        final delay = _calculateDelay(attempt);
        logger.d(
          'RetryableOperation[$_operationName]: Retrying in ${delay.inMilliseconds}ms...',
        );
        await Future.delayed(delay);
      }
    }

    // This should never be reached
    throw StateError('Unexpected end of retry loop for $_operationName');
  }

  Duration _calculateDelay(int attempt) {
    // Calculate exponential backoff in milliseconds
    var delayMs =
        _config.baseDelay.inMilliseconds *
        pow(_config.backoffMultiplier, attempt - 1);

    // Apply max delay if configured
    if (_config.maxDelay != null &&
        delayMs > _config.maxDelay!.inMilliseconds) {
      delayMs = _config.maxDelay!.inMilliseconds.toDouble();
    }

    // Add jitter if enabled (±25% randomization)
    if (_config.useJitter) {
      final jitterRange = delayMs * 0.25;
      final jitter = (_random.nextDouble() - 0.5) * 2 * jitterRange;
      delayMs += jitter;
    }

    return Duration(milliseconds: delayMs.round());
  }
}

/// Extension to make any Future retryable
extension RetryableFuture<T> on Future<T> Function() {
  /// Wraps this function with retry logic
  RetryableOperation<T> withRetry({
    required String operationName,
    RetryConfig config = RetryConfig.defaultConfig,
  }) {
    return RetryableOperation<T>(
      operation: this,
      operationName: operationName,
      config: config,
    );
  }
}
