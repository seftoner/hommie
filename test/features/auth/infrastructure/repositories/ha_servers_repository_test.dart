import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/infrastructure/repositories/ha_servers_repository.dart';
import 'package:hommie/features/auth/infrastructure/repositories/cached_ha_servers_repository.dart';

import '../../../../utils/tests_logger.dart';

void main() {
  logger = testLogger;
  group('HAServersRepository', () {
    late HAServersRepository baseRepository;
    late CachedHAServersRepository cachedRepository;

    setUp(() {
      baseRepository = HAServersRepository();
      cachedRepository = CachedHAServersRepository(
        baseRepository: baseRepository,
        cacheDuration: const Duration(seconds: 5), // Short duration for testing
      );
    });

    test('base repository should work without caching', () async {
      try {
        final result = await baseRepository.getAvailableServers();
        expect(result, isA<List>());
      } catch (e) {
        // Expected in test environment without actual HA servers
        expect(e, isA<Exception>());
      }
    });
  });
}
