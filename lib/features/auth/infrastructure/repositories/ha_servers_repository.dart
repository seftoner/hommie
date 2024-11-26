import 'dart:async';

import 'package:hommie/features/auth/domain/entities/ha_server.dart';
import 'package:hommie/features/auth/domain/repository/i_ha_servers_repository.dart';
import 'package:hommie/utils/logger.dart';
import 'package:multicast_dns/multicast_dns.dart';

class HAServersRepository implements IHAServersRepository {
  static const String _serviceName = '_home-assistant._tcp';

  @override
  Future<List<HaServer>> getAvailableServers() async {
    final client = MDnsClient();
    final results = <HaServer>{};

    await client.start();

    try {
      await _discoverWithTimeout(client, results);
    } finally {
      client.stop();
    }

    return results.toList();
  }

  Future<void> _discoverWithTimeout(
      MDnsClient client, Set<HaServer> results) async {
    try {
      await Future.any([
        _performDiscovery(client, results),
        Future.delayed(Duration(seconds: 30),
            () => throw TimeoutException("Discovery timed out")),
      ]);
    } catch (e, _) {
      logger.e("Error during discovery: $e");
      rethrow; // Re-throw to propagate the error if needed
    }
  }

  Future<void> _performDiscovery(
      MDnsClient client, Set<HaServer> results) async {
    await for (final ptr in _lookupPtrRecords(client)) {
      await for (final srv in _lookupSrvRecords(client, ptr)) {
        await _lookupIpRecords(client, srv, ptr, results);
      }
    }
  }

  Stream<PtrResourceRecord> _lookupPtrRecords(MDnsClient client) {
    return client.lookup<PtrResourceRecord>(
      ResourceRecordQuery.serverPointer(_serviceName),
    );
  }

  Stream<SrvResourceRecord> _lookupSrvRecords(
      MDnsClient client, PtrResourceRecord ptr) {
    return client.lookup<SrvResourceRecord>(
      ResourceRecordQuery.service(ptr.domainName),
    );
  }

  Future<void> _lookupIpRecords(
    MDnsClient client,
    SrvResourceRecord srv,
    PtrResourceRecord ptr,
    Set<HaServer> results,
  ) async {
    await for (final ip in client.lookup<IPAddressResourceRecord>(
        ResourceRecordQuery.addressIPv4(srv.target))) {
      final serverName = ptr.domainName.split('.').first;

      final server = HaServer(
        name: serverName,
        uri: Uri.http('${ip.address.address}:${srv.port}'),
      );

      logger.i(
        'HomeAssistant instance found at ${server.uri} for "$serverName".',
      );

      results.add(server);
    }
  }
}
