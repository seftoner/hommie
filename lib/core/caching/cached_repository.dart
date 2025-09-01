import 'dart:async';

import 'package:hommie/core/utils/logger.dart';

/// A generic caching wrapper for repositories that provides automatic caching
/// with configurable TTL and cache invalidation.
class CachedRepository<T> {
  final Future<T> Function() _fetchFunction;
  final Duration _cacheDuration;
  final String _cacheKey;

  T? _cachedData;
  DateTime? _cacheTimestamp;

  CachedRepository({
    required Future<T> Function() fetchFunction,
    required Duration cacheDuration,
    required String cacheKey,
  }) : _fetchFunction = fetchFunction,
       _cacheDuration = cacheDuration,
       _cacheKey = cacheKey;

  /// Gets data from cache if valid, otherwise fetches fresh data
  Future<T> getData() async {
    if (_isCacheValid()) {
      logger.d('CachedRepository[$_cacheKey]: Returning cached data');
      return _cachedData!;
    }

    logger.d(
      'CachedRepository[$_cacheKey]: Cache invalid, fetching fresh data',
    );
    final data = await _fetchFunction();

    _cachedData = data;
    _cacheTimestamp = DateTime.now();

    return data;
  }

  /// Forces a cache refresh by clearing cache and fetching new data
  Future<T> refresh() async {
    logger.d('CachedRepository[$_cacheKey]: Force refreshing cache');
    clearCache();
    return getData();
  }

  /// Clears the cached data
  void clearCache() {
    logger.d('CachedRepository[$_cacheKey]: Clearing cache');
    _cachedData = null;
    _cacheTimestamp = null;
  }

  /// Checks if the current cache is still valid
  bool _isCacheValid() {
    if (_cachedData == null || _cacheTimestamp == null) {
      return false;
    }

    final cacheAge = DateTime.now().difference(_cacheTimestamp!);
    return cacheAge < _cacheDuration;
  }

  /// Gets the age of the current cache, or null if no cache exists
  Duration? get cacheAge {
    if (_cacheTimestamp == null) {
      return null;
    }
    return DateTime.now().difference(_cacheTimestamp!);
  }

  /// Returns true if cache exists and is valid
  bool get isCacheValid => _isCacheValid();

  /// Returns true if cache exists (regardless of validity)
  bool get hasCache {
    return _cachedData != null && _cacheTimestamp != null;
  }
}
