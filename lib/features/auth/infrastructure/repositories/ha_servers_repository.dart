import 'dart:async';

import 'package:hommie/features/auth/domain/entities/ha_server.dart';
import 'package:hommie/features/auth/domain/entities/ha_version.dart';
import 'package:hommie/features/auth/domain/repository/i_ha_servers_repository.dart';
import 'package:hommie/core/utils/logger.dart';
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
        Future.delayed(const Duration(seconds: 30),
            () => throw TimeoutException('Discovery timed out')),
      ]);
    } catch (e, _) {
      logger.e('Error during discovery: $e');
      rethrow; // Re-throw to propagate the error if needed
    }
  }

  Future<void> _performDiscovery(
      MDnsClient client, Set<HaServer> results) async {
    await for (final ptr in _lookupPtrRecords(client)) {
      await for (final TxtResourceRecord txt
          in client.lookup<TxtResourceRecord>(
              ResourceRecordQuery.text(ptr.domainName))) {
        final server = _fromTxtRecord(txt);

        logger.i(
          'HomeAssistant instance found at ${server.uri} with name ${server.name}.',
        );

        results.add(server);
      }
    }
  }

  Stream<PtrResourceRecord> _lookupPtrRecords(MDnsClient client) {
    return client.lookup<PtrResourceRecord>(
      ResourceRecordQuery.serverPointer(_serviceName),
    );
  }

  HaServer _fromTxtRecord(TxtResourceRecord txtRec) {
    final txtPairs = txtRec.text.split(RegExp(r'\n'));
    final Map<String, String> resultMap = {};

    // Iterate over the pairs and split them by '=' to separate keys and values
    for (var pair in txtPairs) {
      final keyValue = pair.split('=');
      if (keyValue.length == 2) {
        resultMap[keyValue[0]] = keyValue[1];
      }
    }

    final uuid = resultMap['uuid'];
    final versionStr = resultMap['version'] ?? '0.0';
    final name = resultMap['location_name'] ?? 'Home';
    final internalUrl = resultMap['internal_url'];
    final externalUrl = resultMap['external_url'];
    final baseUrl = resultMap['base_url'];

    // Use `base_url` for compatibility if `internal_url` and `external_url` are absent
    final effectiveInternalOrExternalUrl =
        internalUrl ?? externalUrl ?? baseUrl;

    if (effectiveInternalOrExternalUrl == null) {
      throw const FormatException('No valid URL found in TXT record.');
    }

    return HaServer(
      uuid: uuid,
      name: name,
      uri: Uri.parse(effectiveInternalOrExternalUrl),
      version: HaVersion.fromString(versionStr),
      internalUrl: internalUrl != null ? Uri.parse(internalUrl) : null,
      externalUrl: externalUrl != null ? Uri.parse(externalUrl) : null,
    );
  }
}
