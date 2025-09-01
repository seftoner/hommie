import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/caching/cached_repository.dart';
import 'package:hommie/core/utils/logger.dart';

import '../../utils/tests_logger.dart';

void main() {
  logger = testLogger;
  group('CachedRepository', () {
    test(
      'should cache results and return cached data on subsequent calls',
      () async {
        var callCount = 0;
        final cache = CachedRepository<String>(
          fetchFunction: () async {
            callCount++;
            return 'data_$callCount';
          },
          cacheDuration: const Duration(seconds: 1),
          cacheKey: 'test',
        );

        // First call
        final result1 = await cache.getData();
        expect(result1, equals('data_1'));
        expect(callCount, equals(1));
        expect(cache.hasCache, isTrue);
        expect(cache.isCacheValid, isTrue);

        // Second call should use cache
        final result2 = await cache.getData();
        expect(result2, equals('data_1')); // Same data
        expect(callCount, equals(1)); // Function not called again
      },
    );

    test('should refresh cache when cache expires', () async {
      var callCount = 0;
      final cache = CachedRepository<String>(
        fetchFunction: () async {
          callCount++;
          return 'data_$callCount';
        },
        cacheDuration: const Duration(milliseconds: 50),
        cacheKey: 'test',
      );

      // First call
      final result1 = await cache.getData();
      expect(result1, equals('data_1'));
      expect(callCount, equals(1));

      // Wait for cache to expire
      await Future.delayed(const Duration(milliseconds: 100));

      // Second call should fetch fresh data
      final result2 = await cache.getData();
      expect(result2, equals('data_2'));
      expect(callCount, equals(2));
    });

    test('should force refresh cache', () async {
      var callCount = 0;
      final cache = CachedRepository<String>(
        fetchFunction: () async {
          callCount++;
          return 'data_$callCount';
        },
        cacheDuration: const Duration(minutes: 10), // Long duration
        cacheKey: 'test',
      );

      // First call
      await cache.getData();
      expect(callCount, equals(1));

      // Force refresh should fetch new data despite valid cache
      final result = await cache.refresh();
      expect(result, equals('data_2'));
      expect(callCount, equals(2));
    });

    test('should clear cache', () async {
      final cache = CachedRepository<String>(
        fetchFunction: () async => 'data',
        cacheDuration: const Duration(minutes: 10),
        cacheKey: 'test',
      );

      await cache.getData();
      expect(cache.hasCache, isTrue);

      cache.clearCache();
      expect(cache.hasCache, isFalse);
      expect(cache.isCacheValid, isFalse);
    });
  });
}
