import 'package:hommie/core/caching/caching.dart';
import 'package:hommie/features/auth/domain/entities/ha_server.dart';
import 'package:hommie/features/auth/domain/repository/i_ha_servers_repository.dart';

/// A cached wrapper for IHAServersRepository that provides caching and retry functionality
class CachedHAServersRepository implements IHAServersRepository {
  final CachedRepository<List<HaServer>> _cache;

  CachedHAServersRepository({
    required IHAServersRepository baseRepository,
    Duration cacheDuration = const Duration(seconds: 15),
    RetryConfig retryConfig = RetryConfig.networkConfig,
  }) : _cache = CachedRepository<List<HaServer>>(
         fetchFunction: () => RetryableOperation<List<HaServer>>(
           operation: () => baseRepository.getAvailableServers(),
           operationName: 'HA Server Discovery',
           config: retryConfig,
         ).execute(),
         cacheDuration: cacheDuration,
         cacheKey: 'ha_servers',
       );

  @override
  Future<List<HaServer>> getAvailableServers() {
    return _cache.getData();
  }

  /// Forces a cache refresh by clearing cache and fetching new data
  Future<List<HaServer>> forceRefresh() {
    return _cache.refresh();
  }

  /// Clears the cached data
  void clearCache() {
    _cache.clearCache();
  }
}
