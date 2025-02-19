import 'dart:async';
import 'package:hommie/services/networking/home_assitant_websocket/home_assistant_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';

part 'server_connection_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [ServerConnectionManager])
Future<HAConnection> serverConnection(Ref ref, int serverId) async {
  final manager = ref.watch(serverConnectionManagerProvider.notifier);
  return manager.getConnection(serverId);
}
