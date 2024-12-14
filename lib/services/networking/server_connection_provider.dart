import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';

part 'server_connection_provider.g.dart';

@Riverpod(keepAlive: true)
Future<HAConnection> serverConnection(Ref ref) async {
  final manager = ref.watch(serverConnectionManagerProvider.notifier);
  return await manager.getConnection();
}
