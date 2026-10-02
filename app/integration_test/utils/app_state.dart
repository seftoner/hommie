import 'dart:async';
import 'package:drift/drift.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/core/infrastructure/database/database_provider.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/settings/infrastructure/providers/server_settings_provider.dart';
import 'package:oauth2/oauth2.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
import 'package:hommie/features/home/infrastructure/providers/home_tile_override_repository_provider.dart';

class E2eAppState {
  final ProviderContainer container;
  final FlutterSecureStorage storage;
  E2eAppState({
    ProviderContainer? container,
    this.storage = const FlutterSecureStorage(),
  }) : container = container ?? ProviderContainer(retry: (_, _) => null);
  Future<void> reset() async {
    final db = container.read(databaseConnectionProvider);
    await db.transaction(() async {
      await db.delete(db.serverEntities).go();
    });
    final keys = await storage.readAll();
    for (final key in keys.keys.toList()) {
      if (key == 'server_url' || key.startsWith('oauthCredentialsForServer:')) {
        await storage.delete(key: key);
      }
    }
    container.invalidate(credentialRepositoryProvider);
    container.invalidate(serverSettingsProvider);
    container.invalidate(serverManagerProvider);
  }

  Future<void> seedSession({
    required Uri serverUrl,
    required String accessToken,
  }) async {
    final manager = container.read(serverManagerProvider);
    final server = await manager.addServer(
      Server(name: 'E2E home', baseUrl: ServerUrl(serverUrl.toString())),
    );
    await container
        .read(credentialRepositoryProvider)
        .save(
          server.id!,
          Credentials(
            accessToken,
            tokenEndpoint: serverUrl.resolve('/auth/token'),
          ),
        );
    await container
        .read(serverSettingsProvider)
        .saveServerUrl(serverUrl.toString());
    await manager.activateServer(server.id!);
  }

  Future<void> waitForCachedEntity(String entityId) async {
    final db = container.read(databaseConnectionProvider);
    final end = DateTime.now().add(const Duration(seconds: 30));
    while (true) {
      final found = await (db.select(
        db.entities,
      )..where((row) => row.entityId.equals(entityId))).get();
      if (found.isNotEmpty) return;
      if (DateTime.now().isAfter(end)) {
        throw TimeoutException(
          'Entity $entityId was not persisted',
          const Duration(seconds: 30),
        );
      }
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }

  Future<void> selectHomeEntity(String entityId) async {
    await waitForCachedEntity(entityId);
    final db = container.read(databaseConnectionProvider);
    final server = await container.read(serverManagerProvider).getActiveServer();
    if (server == null) throw StateError('No active server');
    final entity = await (db.select(db.entities)..where((row) =>
      row.entityId.equals(entityId) & row.serverId.equals(server.id!))).getSingle();
    await container.read(homeTileOverrideRepositoryProvider).upsert(
      serverId: server.id!,
      override: HomeTileOverride(kind: HomeTileKind.entity, targetId: entity.registryId, order: 0),
    );
  }

  Future<void> close() async {
    final db = container.read(databaseConnectionProvider);
    container.dispose();
    await db.close();
  }
}
