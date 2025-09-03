import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/application/server_auth_controller.dart';
import 'package:hommie/features/servers/infrastructure/providers/servers_list_provider.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_management_controller.g.dart';

enum ServerTestStatus { idle, testing, success, error }

class ServerTestResult {
  final ServerTestStatus status;
  final String? message;
  final String? version;

  const ServerTestResult({required this.status, this.message, this.version});

  ServerTestResult.idle() : this(status: ServerTestStatus.idle);
  ServerTestResult.testing() : this(status: ServerTestStatus.testing);
  ServerTestResult.success({String? version})
    : this(status: ServerTestStatus.success, version: version);
  ServerTestResult.error(String message)
    : this(status: ServerTestStatus.error, message: message);
}

@Riverpod(dependencies: [ServersList, ServerAuthController, ActiveServer])
class ServerManagementController extends _$ServerManagementController {
  @override
  ServerTestResult build() {
    return ServerTestResult.idle();
  }

  /// Test connection to a Home Assistant server
  Future<void> testConnection({required String url, String? token}) async {
    state = ServerTestResult.testing();

    try {
      // Validate URL format first
      if (!_isValidUrl(url)) {
        state = ServerTestResult.error('Invalid URL format');
        return;
      }

      // For now, simulate a test since we don't have HTTP client here
      // TODO: Inject HTTP client and implement real connection test to /api/
      await Future.delayed(const Duration(seconds: 1));

      // Simulate different scenarios based on URL
      if (url.contains('invalid')) {
        state = ServerTestResult.error('Connection refused');
        return;
      }

      if (url.contains('timeout')) {
        state = ServerTestResult.error('Connection timeout');
        return;
      }

      // Simulate success
      state = ServerTestResult.success(version: '2024.1.0');
    } catch (e) {
      logger.e('Server connection test failed: $e');
      state = ServerTestResult.error('Connection failed: $e');
    }
  }

  /// Add a new server
  Future<Server?> addServer({
    required String name,
    required String url,
    String? externalUrl,
  }) async {
    try {
      final serverManager = ref.read(serverManagerProvider);

      final server = Server(name: name, baseUrl: url, externalUrl: externalUrl);

      final savedServer = await serverManager.addServer(server);
      logger.i('Added new server: ${savedServer.name}');

      // Invalidate the servers list to refresh the UI
      ref.invalidate(serversListProvider);

      return savedServer;
    } catch (e) {
      logger.e('Failed to add server: $e');
      rethrow;
    }
  }

  /// Update an existing server
  Future<Server?> updateServer({
    required int serverId,
    required String name,
    required String url,
    String? externalUrl,
  }) async {
    try {
      final serverManager = ref.read(serverManagerProvider);

      // Get the existing server
      final servers = await serverManager.getAvailableServers();
      final existingServer = servers.firstWhere((s) => s.id == serverId);

      final updatedServer = existingServer.copyWith(
        name: name,
        url: url,
        externalUrl: externalUrl,
      );

      final savedServer = await serverManager.addServer(updatedServer);
      logger.i('Updated server: ${savedServer.name}');

      // Invalidate the servers list to refresh the UI
      ref.invalidate(serversListProvider);

      return savedServer;
    } catch (e) {
      logger.e('Failed to update server: $e');
      rethrow;
    }
  }

  /// Authenticate with a server using OAuth
  Future<void> authenticateServer(int serverId, String serverUrl) async {
    try {
      // Use the existing auth controller for OAuth flow
      await ref.read(serverAuthControllerProvider.notifier).login(serverUrl);
      logger.i('Authentication completed for server ID: $serverId');
    } catch (e) {
      logger.e('Authentication failed for server ID: $serverId, error: $e');
      rethrow;
    }
  }

  /// Set a server as active
  Future<void> setActiveServer(int serverId) async {
    try {
      await ref.read(activeServerProvider.notifier).setActive(serverId);
      logger.i('Set server $serverId as active');
    } catch (e) {
      logger.e('Failed to set active server: $e');
      rethrow;
    }
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  void resetTestResult() {
    state = ServerTestResult.idle();
  }
}
