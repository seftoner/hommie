abstract interface class INetworkReachabilityRepository {
  Future<bool> get isAvailable;
  Stream<bool> get availability;
}
