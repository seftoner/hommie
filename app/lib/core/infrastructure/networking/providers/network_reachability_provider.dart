import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hommie/core/domain/repositories/i_network_reachability_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_reachability_provider.g.dart';

final class ConnectivityNetworkReachabilityRepository
    implements INetworkReachabilityRepository {
  ConnectivityNetworkReachabilityRepository({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool> get isAvailable async {
    return _hasNetwork(await _connectivity.checkConnectivity());
  }

  @override
  Stream<bool> get availability {
    return _connectivity.onConnectivityChanged.map(_hasNetwork).distinct();
  }

  static bool _hasNetwork(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}

@Riverpod(keepAlive: true)
INetworkReachabilityRepository networkReachability(Ref ref) {
  return ConnectivityNetworkReachabilityRepository();
}
