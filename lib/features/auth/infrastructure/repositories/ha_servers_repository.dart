import 'dart:async';

import 'package:hommie/features/auth/domain/entities/ha_server.dart';
import 'package:hommie/features/auth/domain/repository/i_ha_servers_repository.dart';
import 'package:hommie/utils/logger.dart';
import 'package:multicast_dns/multicast_dns.dart';

class HAServersRepository implements IHAServersRepository {
  @override
  Future<List<HaServer>> getAvailableServers() async {
    const serviceName = '_home-assistant._tcp.local';
    final client = MDnsClient();
    final results = <HaServer>{};

    await client.start();

    try {
      await for (final ptr in client.lookup<PtrResourceRecord>(
          ResourceRecordQuery.serverPointer(serviceName))) {
        await for (final srv in client.lookup<SrvResourceRecord>(
            ResourceRecordQuery.service(ptr.domainName))) {
          final target = srv.target;

          await for (final ip in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv4(target))) {
            final serverName =
                ptr.domainName.split('.').first; // Extract server name

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
    } finally {
      client.stop();
    }

    return results.toList();
  }
}
