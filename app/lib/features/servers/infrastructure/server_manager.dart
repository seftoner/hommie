import 'dart:async';

import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/domain/repositories/i_server_repository.dart';

class ServerManager implements IServerManager {
  final _controller = StreamController<Server?>.broadcast();
  final IServerRepository _serverRepository;
  bool _isClosed = false;

  ServerManager(this._serverRepository) {
    _refreshActiveServer();
  }

  @override
  Future<Server> addServer(Server config) async {
    final savedServer = await _serverRepository.save(config);
    return savedServer;
  }

  @override
  Future<Server?> getActiveServer() {
    return _serverRepository.getActiveServer();
  }

  @override
  Stream<Server?> watchActiveServer() => _controller.stream;

  @override
  Future<Server?> activateServer(int id) async {
    final activeServer = await _setActiveServer(id);
    if (activeServer == null) {
      logger.i('Attempted to activate server $id, but it was not found');
    } else {
      logger.i(
        'Active server set to: ${activeServer.name} (ID: ${activeServer.id})',
      );
    }
    return activeServer;
  }

  @override
  Future<Server?> activateNextServer({int? excludingId}) async {
    final servers = await getServers();
    final availableServers = servers
        .where((server) => server.id != excludingId)
        .toList();

    if (availableServers.isEmpty) {
      logger.i('No servers available to activate');
      return _setActiveServer(null);
    }

    final nextServer = availableServers.first;

    if (nextServer.id == null) {
      logger.w('Next server ${nextServer.name} is missing an ID');
      return null;
    }

    logger.i(
      'Activating next server: ${nextServer.name} (ID: ${nextServer.id})',
    );
    return activateServer(nextServer.id!);
  }

  @override
  Future<List<Server>> getServers() {
    return _serverRepository.getAll();
  }

  @override
  Future<void> removeServer(int id, {bool allowRemovingLast = false}) async {
    final allServers = await getServers();
    final isLastServer = allServers.length <= 1;
    final activeServer = await getActiveServer();
    final removedWasActive = activeServer?.id == id;

    if (isLastServer && !allowRemovingLast) {
      throw Exception(
        'Cannot delete the last server. At least one server must be configured.',
      );
    }

    await _serverRepository.delete(id);
    logger.i('Successfully removed server $id');

    if (removedWasActive || activeServer == null) {
      await activateNextServer(excludingId: id);
    } else {
      await _refreshActiveServer(value: activeServer);
    }
  }

  Future<Server?> _setActiveServer(int? id) async {
    final activeServer = await _serverRepository.setActiveServer(id);
    await _refreshActiveServer(value: activeServer, fetchWhenNull: false);
    return activeServer;
  }

  Future<void> _refreshActiveServer({
    Server? value,
    bool fetchWhenNull = true,
  }) async {
    if (_isClosed) {
      return;
    }
    var server = value;
    if (server == null && fetchWhenNull) {
      server = await _serverRepository.getActiveServer();
    }
    _controller.add(server);
  }

  void dispose() {
    _isClosed = true;
    _controller.close();
  }
}
